# Copyright 2019-2026 ETH Zurich and the DaCe authors. All rights reserved.
from unittest import mock

import numpy as np

import dace
from dace.sdfg import nodes, propagation
from dace.sdfg.state import SDFGState


def _make_sdfg(name: str, nested: bool = False) -> dace.SDFG:
    """An SDFG whose array shapes and map ranges are symbolic, with an optional nested SDFG."""
    sdfg = dace.SDFG(name)
    N = dace.symbol("N")
    for array in "ab":
        sdfg.add_array(array, shape=(N, 10), dtype=dace.float64, transient=False)
    state = sdfg.add_state(is_start_block=True)
    state.add_mapped_tasklet(
        "comp",
        map_ranges={
            "__i": "0:N",
            "__j": "0:10"
        },
        inputs={"__in": dace.Memlet("a[__i, __j]")},
        outputs={"__out": dace.Memlet("b[__i, __j]")},
        code="__out = __in + 1.0",
        external_edges=True,
    )
    if nested:
        inner = _make_sdfg(name + "_inner")
        inner_state = sdfg.add_state_after(state)
        nsdfg = inner_state.add_nested_sdfg(inner, {"a"}, {"b"}, symbol_mapping={"N": "N"})
        inner_state.add_edge(inner_state.add_access("a"), None, nsdfg, "a", dace.Memlet("a[0:N, 0:10]"))
        inner_state.add_edge(nsdfg, "b", inner_state.add_access("b"), None, dace.Memlet("b[0:N, 0:10]"))
    sdfg.validate()
    return sdfg


def test_sdfg_wide_symbols_gives_the_same_result():
    sdfg = _make_sdfg("same_result")
    state = sdfg.states()[0]
    sdfg_wide = state.sdfg_wide_symbols()

    for node in state.nodes():
        expected = state.symbols_defined_at(node)
        assert state.symbols_defined_at(node, sdfg_wide_symbols=sdfg_wide) == expected
        assert list(state.symbols_defined_at(node, sdfg_wide_symbols=sdfg_wide)) == list(expected)

    map_entry = next(n for n in state.nodes() if isinstance(n, nodes.MapEntry))
    tasklet = next(n for n in state.nodes() if isinstance(n, nodes.Tasklet))
    assert "N" in sdfg_wide
    # The map parameters are what the node adds to the SDFG-wide symbols, inside the map only.
    assert set(state.symbols_defined_at(tasklet)) - set(sdfg_wide) == set(map_entry.map.params)
    assert set(state.symbols_defined_at(map_entry)) == set(sdfg_wide)


def test_propagation_resolves_the_sdfg_wide_symbols_once_per_sdfg():
    sdfg = _make_sdfg("resolve_once", nested=True)
    n_sdfgs = len(list(sdfg.all_sdfgs_recursive()))

    with mock.patch.object(SDFGState, "sdfg_wide_symbols", autospec=True,
                           side_effect=SDFGState.sdfg_wide_symbols) as spy:
        propagation.propagate_memlets_sdfg(sdfg)

    assert spy.call_count == n_sdfgs


def test_propagation_is_unchanged():
    sdfg = _make_sdfg("unchanged")
    state = sdfg.states()[0]
    map_entry = next(n for n in state.nodes() if isinstance(n, nodes.MapEntry))
    for edge in state.in_edges(map_entry):
        edge.data = dace.Memlet("a[0, 0]")

    propagation.propagate_memlets_sdfg(sdfg)

    assert str(state.in_edges(map_entry)[0].data.subset) == "0:N, 0:10"

    a = np.random.rand(16, 10)
    b = np.zeros_like(a)
    sdfg(a=a, b=b, N=16)
    assert np.allclose(b, a + 1.0)


if __name__ == "__main__":
    test_sdfg_wide_symbols_gives_the_same_result()
    test_propagation_resolves_the_sdfg_wide_symbols_once_per_sdfg()
    test_propagation_is_unchanged()

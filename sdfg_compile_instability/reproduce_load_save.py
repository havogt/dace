"""
Script to reproduce SDFG load-save instability.

Loads the original SDFG, saves it, and repeats for multiple cycles.
Reports differences between each cycle to identify when the SDFG stabilizes.
"""

import difflib
import json
import os
import sys
import tempfile

# Ensure local dace is used
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import dace  # noqa: E402

ORIGINAL_SDFG = os.path.join(
    os.path.dirname(__file__), "data", "Original", "program.sdfg"
)
NUM_CYCLES = 4


def load_save_cycle(input_path: str, output_path: str) -> None:
    """Load an SDFG from input_path and save it to output_path."""
    sdfg = dace.SDFG.from_file(input_path)
    sdfg.save(output_path)


def json_diff(file_a: str, file_b: str) -> list[str]:
    """Return a unified diff between two JSON files (pretty-printed)."""
    with open(file_a) as f:
        content_a = json.dumps(json.load(f), indent=2).splitlines(keepends=True)
    with open(file_b) as f:
        content_b = json.dumps(json.load(f), indent=2).splitlines(keepends=True)

    return list(
        difflib.unified_diff(content_a, content_b, fromfile=file_a, tofile=file_b)
    )


def main():
    if not os.path.exists(ORIGINAL_SDFG):
        print(f"Error: Original SDFG not found at {ORIGINAL_SDFG}")
        sys.exit(1)

    with tempfile.TemporaryDirectory(prefix="sdfg_stability_") as tmpdir:
        paths = [ORIGINAL_SDFG]

        for i in range(NUM_CYCLES):
            output_path = os.path.join(tmpdir, f"cycle_{i}.sdfg")
            load_save_cycle(paths[-1], output_path)
            paths.append(output_path)

        # Compare each consecutive pair
        print(f"Performed {NUM_CYCLES} load-save cycles.\n")
        all_stable = True
        for i in range(len(paths) - 1):
            label_a = "Original" if i == 0 else f"Cycle {i}"
            label_b = f"Cycle {i + 1}"

            diff_lines = json_diff(paths[i], paths[i + 1])
            if diff_lines:
                all_stable = False
                print(f"=== DIFF: {label_a} -> {label_b} ===")
                # Print summary stats
                added = sum(1 for l in diff_lines if l.startswith("+") and not l.startswith("+++"))
                removed = sum(1 for l in diff_lines if l.startswith("-") and not l.startswith("---"))
                print(f"  Lines added: {added}, Lines removed: {removed}")

                # Categorize changes
                schedule_changes = 0
                sympy_changes = 0
                hash_changes = 0
                version_changes = 0
                other_changes = 0

                for line in diff_lines:
                    if not (line.startswith("+") or line.startswith("-")):
                        continue
                    if line.startswith("+++") or line.startswith("---"):
                        continue
                    if '"schedule"' in line:
                        schedule_changes += 1
                    elif '"hash"' in line:
                        hash_changes += 1
                    elif '"dace_version"' in line:
                        version_changes += 1
                    elif "volume" in line or "num_accesses" in line:
                        sympy_changes += 1
                    else:
                        other_changes += 1

                print(f"  Breakdown:")
                if schedule_changes:
                    print(f"    - schedule property changes: {schedule_changes}")
                if sympy_changes:
                    print(f"    - sympy expression changes (volume/num_accesses): {sympy_changes}")
                if hash_changes:
                    print(f"    - hash changes: {hash_changes}")
                if version_changes:
                    print(f"    - dace_version changes: {version_changes}")
                if other_changes:
                    print(f"    - other changes: {other_changes}")

                print()
                # Print actual diff (limited)
                print("  Full diff (first 60 lines):")
                for line in diff_lines[:60]:
                    print(f"  {line}", end="")
                if len(diff_lines) > 60:
                    print(f"\n  ... ({len(diff_lines) - 60} more lines)")
                print()
            else:
                print(f"=== {label_a} -> {label_b}: IDENTICAL (stable) ===")

        if all_stable:
            print("\nAll cycles produced identical output. The SDFG is stable.")
        else:
            print("\nInstability detected! The SDFG changes on load-save.")


if __name__ == "__main__":
    main()

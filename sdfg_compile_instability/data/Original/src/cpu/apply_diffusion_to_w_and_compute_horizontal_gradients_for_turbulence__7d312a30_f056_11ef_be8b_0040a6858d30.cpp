/* DaCe AUTO-GENERATED FILE. DO NOT MODIFY */
#include <dace/dace.h>
#include "../../include/hash.h"

struct apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t {
    dace::cuda::Context *gpu_context;
    double * __restrict__ __0_lambda_2___tmp5;
};

DACE_EXPORTED void __dace_runkernel_map_1_fieldop_0_0_25(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ geofac_n2s, double * __restrict__ lambda_2___tmp5, const double * __restrict__ w_old, int __connectivity_C2E2CO_stride_0, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __w_old_1_range_0, int __w_old_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start);
DACE_EXPORTED void __dace_runkernel_map_8_fieldop_0_0_58(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state, const double * __restrict__ area, const int * __restrict__ cell, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ diff_multfac_n2w, double * __restrict__ dwdx, double * __restrict__ dwdy, const double * __restrict__ geofac_grg_x, const double * __restrict__ geofac_grg_y, const double * __restrict__ geofac_n2s, const int * __restrict__ k, const double * __restrict__ lambda_2___tmp5, double * __restrict__ w, const double * __restrict__ w_old, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, const double diff_multfac_w, const int halo_idx, int horizontal_end, int horizontal_start, const int interior_idx, const int nrdmax, int vertical_end, int vertical_start);
void __program_apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_internal(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t*__state, double * __restrict__ area, int * __restrict__ cell, int * __restrict__ connectivity_C2E2CO, double * __restrict__ diff_multfac_n2w, double * __restrict__ dwdx, double * __restrict__ dwdy, double * __restrict__ geofac_grg_x, double * __restrict__ geofac_grg_y, double * __restrict__ geofac_n2s, int * __restrict__ k, double * __restrict__ w, double * __restrict__ w_old, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, double diff_multfac_w, int halo_idx, int horizontal_end, int horizontal_start, int interior_idx, int nrdmax, int type_shear, int vertical_end, int vertical_start)
{

    {

        __dace_runkernel_map_1_fieldop_0_0_25(__state, connectivity_C2E2CO, geofac_n2s, __state->__0_lambda_2___tmp5, w_old, __connectivity_C2E2CO_stride_0, __geofac_n2s_0_range_0, __geofac_n2s_stride_1, __w_old_1_range_0, __w_old_stride_1, horizontal_end, horizontal_start, vertical_end, vertical_start);
        cudaEventRecord(__state->gpu_context->events[18], __state->gpu_context->streams[5]);
        cudaStreamWaitEvent(__state->gpu_context->streams[0], __state->gpu_context->events[18], 0);
        __dace_runkernel_map_8_fieldop_0_0_58(__state, area, cell, connectivity_C2E2CO, diff_multfac_n2w, dwdx, dwdy, geofac_grg_x, geofac_grg_y, geofac_n2s, k, __state->__0_lambda_2___tmp5, w, w_old, __area_0_range_0, __cell_0_range_0, __connectivity_C2E2CO_stride_0, __diff_multfac_n2w_0_range_0, __dwdx_0_range_0, __dwdx_1_range_0, __dwdx_stride_1, __dwdy_0_range_0, __dwdy_1_range_0, __dwdy_stride_1, __geofac_grg_x_0_range_0, __geofac_grg_x_stride_1, __geofac_grg_y_0_range_0, __geofac_grg_y_stride_1, __geofac_n2s_0_range_0, __geofac_n2s_stride_1, __k_0_range_0, __w_0_range_0, __w_1_range_0, __w_old_0_range_0, __w_old_1_range_0, __w_old_stride_1, __w_stride_1, diff_multfac_w, halo_idx, horizontal_end, horizontal_start, interior_idx, nrdmax, vertical_end, vertical_start);
        DACE_GPU_CHECK(cudaStreamSynchronize(__state->gpu_context->streams[0]));


    }
}

DACE_EXPORTED void __program_apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state, double * __restrict__ area, int * __restrict__ cell, int * __restrict__ connectivity_C2E2CO, double * __restrict__ diff_multfac_n2w, double * __restrict__ dwdx, double * __restrict__ dwdy, double * __restrict__ geofac_grg_x, double * __restrict__ geofac_grg_y, double * __restrict__ geofac_n2s, int * __restrict__ k, double * __restrict__ w, double * __restrict__ w_old, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, double diff_multfac_w, int halo_idx, int horizontal_end, int horizontal_start, int interior_idx, int nrdmax, int type_shear, int vertical_end, int vertical_start)
{
    __program_apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_internal(__state, area, cell, connectivity_C2E2CO, diff_multfac_n2w, dwdx, dwdy, geofac_grg_x, geofac_grg_y, geofac_n2s, k, w, w_old, __area_0_range_0, __cell_0_range_0, __connectivity_C2E2CO_stride_0, __diff_multfac_n2w_0_range_0, __dwdx_0_range_0, __dwdx_1_range_0, __dwdx_stride_1, __dwdy_0_range_0, __dwdy_1_range_0, __dwdy_stride_1, __geofac_grg_x_0_range_0, __geofac_grg_x_stride_1, __geofac_grg_y_0_range_0, __geofac_grg_y_stride_1, __geofac_n2s_0_range_0, __geofac_n2s_stride_1, __k_0_range_0, __w_0_range_0, __w_1_range_0, __w_old_0_range_0, __w_old_1_range_0, __w_old_stride_1, __w_stride_1, diff_multfac_w, halo_idx, horizontal_end, horizontal_start, interior_idx, nrdmax, type_shear, vertical_end, vertical_start);
}
DACE_EXPORTED int __dace_init_cuda(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start);
DACE_EXPORTED int __dace_exit_cuda(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state);

DACE_EXPORTED apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__dace_init_apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30(int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start)
{
    int __result = 0;
    apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state = new apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t;


    __result |= __dace_init_cuda(__state, __area_0_range_0, __cell_0_range_0, __connectivity_C2E2CO_stride_0, __diff_multfac_n2w_0_range_0, __dwdx_0_range_0, __dwdx_1_range_0, __dwdx_stride_1, __dwdy_0_range_0, __dwdy_1_range_0, __dwdy_stride_1, __geofac_grg_x_0_range_0, __geofac_grg_x_stride_1, __geofac_grg_y_0_range_0, __geofac_grg_y_stride_1, __geofac_n2s_0_range_0, __geofac_n2s_stride_1, __k_0_range_0, __w_0_range_0, __w_1_range_0, __w_old_0_range_0, __w_old_1_range_0, __w_old_stride_1, __w_stride_1, horizontal_end, horizontal_start, vertical_end, vertical_start);
    DACE_GPU_CHECK(cudaMalloc((void**)&__state->__0_lambda_2___tmp5, ((vertical_end - vertical_start) * (Max(283876, horizontal_end) - Min(0, horizontal_start))) * sizeof(double)));

    if (__result) {
        delete __state;
        return nullptr;
    }
    return __state;
}

DACE_EXPORTED int __dace_exit_apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30(apply_diffusion_to_w_and_compute_horizontal_gradients_for_turbulence__7d312a30_f056_11ef_be8b_0040a6858d30_state_t *__state)
{
    int __err = 0;
    DACE_GPU_CHECK(cudaFree(__state->__0_lambda_2___tmp5));

    int __err_cuda = __dace_exit_cuda(__state);
    if (__err_cuda) {
        __err = __err_cuda;
    }
    delete __state;
    return __err;
}

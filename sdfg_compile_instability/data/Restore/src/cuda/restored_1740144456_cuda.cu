
#include <cuda_runtime.h>
#include <dace/dace.h>


struct restored_1740144456_state_t {
    dace::cuda::Context *gpu_context;
    double * __restrict__ __0_lambda_2___tmp5;
};



DACE_EXPORTED int __dace_init_cuda(restored_1740144456_state_t *__state, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start);
DACE_EXPORTED int __dace_exit_cuda(restored_1740144456_state_t *__state);

DACE_DFI void reduce_0_0_105(double* __restrict__ _in, double* __restrict__ _out) {

    {

        {
            for (auto _o0 = 0; _o0 < 1; _o0 += 1) {
                {
                    double __out;

                    ///////////////////
                    // Tasklet code (reduce_init)
                    __out = 0;
                    ///////////////////

                    _out[_o0] = __out;
                }
            }
        }

    }
    {

        {
            for (auto _i0 = 0; _i0 < 4; _i0 += 1) {
                {
                    double __inp = _in[_i0];
                    double __out;

                    ///////////////////
                    // Tasklet code (identity)
                    __out = __inp;
                    ///////////////////

                    dace::wcr_fixed<dace::ReductionType::Sum, double>::reduce(_out, __out);
                }
            }
        }

    }
}

DACE_DFI void if_stmt_0_0_0_48(const double&  __arg1, const double&  __arg2, const bool&  __cond, double&  __output) {

    if (__cond) {
        {


            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
            &__arg1, &__output, 1);

        }
    } else if ((! __cond)) {
        {


            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
            &__arg2, &__output, 1);

        }
    }
}

DACE_DFI void if_stmt_1_0_0_19(const double&  __arg1__, const double&  __arg2, const bool&  __cond, double&  __output) {

    if (__cond) {
        {


            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
            &__arg1__, &__output, 1);

        }
    } else if ((! __cond)) {
        {


            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
            &__arg2, &__output, 1);

        }
    }
}

DACE_DFI void if_stmt_0_0_0_62(const double&  __arg1, const double&  __arg2, const bool&  __cond, double&  __output) {

    if (__cond) {
        {


            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
            &__arg1, &__output, 1);

        }
    } else if ((! __cond)) {
        {


            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
            &__arg2, &__output, 1);

        }
    }
}



int __dace_init_cuda(restored_1740144456_state_t *__state, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start) {
    int count;

    // Check that we are able to run cuda code
    if (cudaGetDeviceCount(&count) != cudaSuccess)
    {
        printf("ERROR: GPU drivers are not configured or cuda-capable device "
               "not found\n");
        return 1;
    }
    if (count == 0)
    {
        printf("ERROR: No cuda-capable devices found\n");
        return 2;
    }

    // Initialize cuda before we run the application
    float *dev_X;
    DACE_GPU_CHECK(cudaMalloc((void **) &dev_X, 1));
    DACE_GPU_CHECK(cudaFree(dev_X));

    

    __state->gpu_context = new dace::cuda::Context(8, 30);

    // Create cuda streams and events
    for(int i = 0; i < 8; ++i) {
        DACE_GPU_CHECK(cudaStreamCreateWithFlags(&__state->gpu_context->internal_streams[i], cudaStreamNonBlocking));
        __state->gpu_context->streams[i] = __state->gpu_context->internal_streams[i]; // Allow for externals to modify streams
    }
    for(int i = 0; i < 30; ++i) {
        DACE_GPU_CHECK(cudaEventCreateWithFlags(&__state->gpu_context->events[i], cudaEventDisableTiming));
    }

    

    return 0;
}

int __dace_exit_cuda(restored_1740144456_state_t *__state) {
    

    // Synchronize and check for CUDA errors
    int __err = static_cast<int>(__state->gpu_context->lasterror);
    if (__err == 0)
        __err = static_cast<int>(cudaDeviceSynchronize());

    // Destroy cuda streams and events
    for(int i = 0; i < 8; ++i) {
        DACE_GPU_CHECK(cudaStreamDestroy(__state->gpu_context->internal_streams[i]));
    }
    for(int i = 0; i < 30; ++i) {
        DACE_GPU_CHECK(cudaEventDestroy(__state->gpu_context->events[i]));
    }

    delete __state->gpu_context;
    return __err;
}

DACE_EXPORTED bool __dace_gpu_set_stream(restored_1740144456_state_t *__state, int streamid, gpuStream_t stream)
{
    if (streamid < 0 || streamid >= 8)
        return false;

    __state->gpu_context->streams[streamid] = stream;

    return true;
}

DACE_EXPORTED void __dace_gpu_set_all_streams(restored_1740144456_state_t *__state, gpuStream_t stream)
{
    for (int i = 0; i < 8; ++i)
        __state->gpu_context->streams[i] = stream;
}

__global__ void __launch_bounds__(256) map_1_fieldop_0_0_25(const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ geofac_n2s, double * __restrict__ lambda_2___tmp5, const double * __restrict__ w_old, int __connectivity_C2E2CO_stride_0, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __w_old_1_range_0, int __w_old_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start) {
    {
        {
            int i_Cell_gtx_horizontal = ((blockIdx.x * 32 + threadIdx.x) + 9364);
            int __coarse_i_K_gtx_vertical = (blockIdx.y * 8 + threadIdx.y);
            if (i_Cell_gtx_horizontal >= 9364 && i_Cell_gtx_horizontal < 283876) {
                if (__coarse_i_K_gtx_vertical < int_ceil((vertical_end - vertical_start), 10)) {
                    {
                        for (auto i_K_gtx_vertical = ((10 * __coarse_i_K_gtx_vertical) + vertical_start); i_K_gtx_vertical < Min(vertical_end, (((10 * __coarse_i_K_gtx_vertical) + vertical_start) + 10)); i_K_gtx_vertical += 1) {
                            double lambda_2___tmp4;
                            double __s0_n54OUT___tmp3_n55None[4]  DACE_ALIGN(64);
                            {
                                for (auto i_C2E2CO_gtx_localdim = 0; i_C2E2CO_gtx_localdim < 4; i_C2E2CO_gtx_localdim += 1) {
                                    double __s0_n30OUT___tmp0_n27None;
                                    {
                                        int __index = connectivity_C2E2CO[((__connectivity_C2E2CO_stride_0 * i_Cell_gtx_horizontal) + i_C2E2CO_gtx_localdim)];
                                        const double* __field = &w_old[(__w_old_stride_1 * ((- __w_old_1_range_0) + i_K_gtx_vertical))];
                                        double __val;

                                        ///////////////////
                                        // Tasklet code (tlet_1_C2E2CO_neighbors)
                                        __val = __field[__index];
                                        ///////////////////

                                        __s0_n30OUT___tmp0_n27None = __val;
                                    }
                                    {
                                        double __arg0 = __s0_n30OUT___tmp0_n27None;
                                        double __arg1 = geofac_n2s[(((- __geofac_n2s_0_range_0) + (__geofac_n2s_stride_1 * i_C2E2CO_gtx_localdim)) + i_Cell_gtx_horizontal)];
                                        double __out;

                                        ///////////////////
                                        // Tasklet code (tlet_2_map)
                                        __out = (__arg0 * __arg1);
                                        ///////////////////

                                        __s0_n54OUT___tmp3_n55None[i_C2E2CO_gtx_localdim] = __out;
                                    }
                                }
                            }
                            reduce_0_0_105(&__s0_n54OUT___tmp3_n55None[0], &lambda_2___tmp4);

                            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                            &lambda_2___tmp4, lambda_2___tmp5 + ((i_Cell_gtx_horizontal + ((i_K_gtx_vertical - vertical_start) * (Max(283876, horizontal_end) - Min(0, horizontal_start)))) - Min(0, horizontal_start)), 1);
                        }
                    }
                }
            }
        }
    }
}


DACE_EXPORTED void __dace_runkernel_map_1_fieldop_0_0_25(restored_1740144456_state_t *__state, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ geofac_n2s, double * __restrict__ lambda_2___tmp5, const double * __restrict__ w_old, int __connectivity_C2E2CO_stride_0, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __w_old_1_range_0, int __w_old_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start);
void __dace_runkernel_map_1_fieldop_0_0_25(restored_1740144456_state_t *__state, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ geofac_n2s, double * __restrict__ lambda_2___tmp5, const double * __restrict__ w_old, int __connectivity_C2E2CO_stride_0, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __w_old_1_range_0, int __w_old_stride_1, int horizontal_end, int horizontal_start, int vertical_end, int vertical_start)
{

    if ((int_ceil(int_ceil(int_ceil((vertical_end - vertical_start), 10), 1), 8)) == 0) {

        return;
    }

    void  *map_1_fieldop_0_0_25_args[] = { (void *)&connectivity_C2E2CO, (void *)&geofac_n2s, (void *)&lambda_2___tmp5, (void *)&w_old, (void *)&__connectivity_C2E2CO_stride_0, (void *)&__geofac_n2s_0_range_0, (void *)&__geofac_n2s_stride_1, (void *)&__w_old_1_range_0, (void *)&__w_old_stride_1, (void *)&horizontal_end, (void *)&horizontal_start, (void *)&vertical_end, (void *)&vertical_start };
    gpuError_t __err = cudaLaunchKernel((void*)map_1_fieldop_0_0_25, dim3(8579, int_ceil(int_ceil(int_ceil((vertical_end - vertical_start), 10), 1), 8), 1), dim3(32, 8, 1), map_1_fieldop_0_0_25_args, 0, __state->gpu_context->streams[7]);
    DACE_KERNEL_LAUNCH_CHECK(__err, "map_1_fieldop_0_0_25", 8579, int_ceil(int_ceil(int_ceil((vertical_end - vertical_start), 10), 1), 8), 1, 32, 8, 1);
}
__global__ void __launch_bounds__(256) map_8_fieldop_0_0_58(const double * __restrict__ area, const int * __restrict__ cell, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ diff_multfac_n2w, double * __restrict__ dwdx, double * __restrict__ dwdy, const double * __restrict__ geofac_grg_x, const double * __restrict__ geofac_grg_y, const double * __restrict__ geofac_n2s, const int * __restrict__ k, const double * __restrict__ lambda_2___tmp5, double * __restrict__ w, const double * __restrict__ w_old, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, const double diff_multfac_w, const int halo_idx, int horizontal_end, int horizontal_start, const int interior_idx, const int nrdmax, int vertical_end, int vertical_start) {
    {
        {
            int i_Cell_gtx_horizontal = ((blockIdx.x * 32 + threadIdx.x) + horizontal_start);
            int __coarse_i_K_gtx_vertical = (blockIdx.y * 8 + threadIdx.y);
            bool __s0_n62OUT___tmp1_n63None;
            bool __s0_n65OUT___tmp3_n66None;
            bool __s0_n65OUT___tmp5_n66None;
            double __s0_n69OUT___tmp7_n70None;
            double __s0_n70OUT___tmp9_n71None;
            bool __s0_n91OUT___tmp8_n92None;
            bool __s0_n93OUT___tmp12_n94None;
            double __s0_n93OUT___tmp16_n94None;
            int lambda_0___tmp0_0;
            int lambda_1___tmp0_1;
            if (i_Cell_gtx_horizontal >= horizontal_start && i_Cell_gtx_horizontal < horizontal_end) {
                if (__coarse_i_K_gtx_vertical < int_ceil((vertical_end - vertical_start), 10)) {
                    {
                        int __out;

                        ///////////////////
                        // Tasklet code (tlet_1_get_value__clone_799759e4_f056_11ef_be8b_0040a6858d30)
                        __out = 0;
                        ///////////////////

                        lambda_0___tmp0_0 = __out;
                    }
                    {
                        int __out;

                        ///////////////////
                        // Tasklet code (tlet_1_get_value__clone_79980704_f056_11ef_be8b_0040a6858d30)
                        __out = 0;
                        ///////////////////

                        lambda_1___tmp0_1 = __out;
                    }
                    {
                        double __arg0 = area[((- __area_0_range_0) + i_Cell_gtx_horizontal)];
                        double __arg1 = area[((- __area_0_range_0) + i_Cell_gtx_horizontal)];
                        double result;

                        ///////////////////
                        // Tasklet code (tlet_4_multiplies)
                        result = (__arg0 * __arg1);
                        ///////////////////

                        __s0_n69OUT___tmp7_n70None = result;
                    }
                    {
                        double __arg1 = __s0_n69OUT___tmp7_n70None;
                        double __arg0 = diff_multfac_w;
                        double result;

                        ///////////////////
                        // Tasklet code (tlet_5_multiplies)
                        result = (__arg0 * __arg1);
                        ///////////////////

                        __s0_n70OUT___tmp9_n71None = result;
                    }

                    dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                    area + ((- __area_0_range_0) + i_Cell_gtx_horizontal), &__s0_n93OUT___tmp16_n94None, 1);
                    {
                        int __arg0 = cell[((- __cell_0_range_0) + i_Cell_gtx_horizontal)];
                        int __arg1 = halo_idx;
                        bool result;

                        ///////////////////
                        // Tasklet code (tlet_2_less)
                        result = (__arg0 < __arg1);
                        ///////////////////

                        __s0_n65OUT___tmp3_n66None = result;
                    }
                    {
                        int __arg0 = cell[((- __cell_0_range_0) + i_Cell_gtx_horizontal)];
                        int __arg1 = halo_idx;
                        bool result;

                        ///////////////////
                        // Tasklet code (tlet_7_less)
                        result = (__arg0 < __arg1);
                        ///////////////////

                        __s0_n93OUT___tmp12_n94None = result;
                    }
                    {
                        int __arg1 = cell[((- __cell_0_range_0) + i_Cell_gtx_horizontal)];
                        int __arg0 = interior_idx;
                        bool result;

                        ///////////////////
                        // Tasklet code (tlet_1_less_equal)
                        result = (__arg0 <= __arg1);
                        ///////////////////

                        __s0_n62OUT___tmp1_n63None = result;
                    }
                    {
                        bool __arg0 = __s0_n62OUT___tmp1_n63None;
                        bool __arg1 = __s0_n65OUT___tmp3_n66None;
                        bool result;

                        ///////////////////
                        // Tasklet code (tlet_3_and_)
                        result = (__arg0 && __arg1);
                        ///////////////////

                        __s0_n65OUT___tmp5_n66None = result;
                    }
                    {
                        int __arg1 = cell[((- __cell_0_range_0) + i_Cell_gtx_horizontal)];
                        int __arg0 = interior_idx;
                        bool result;

                        ///////////////////
                        // Tasklet code (tlet_5_less_equal)
                        result = (__arg0 <= __arg1);
                        ///////////////////

                        __s0_n91OUT___tmp8_n92None = result;
                    }
                    {
                        for (auto i_K_gtx_vertical = ((10 * __coarse_i_K_gtx_vertical) + vertical_start); i_K_gtx_vertical < Min(vertical_end, (((10 * __coarse_i_K_gtx_vertical) + vertical_start) + 10)); i_K_gtx_vertical += 1) {
                            double __tmp12[4]  DACE_ALIGN(64);
                            double __tmp14;
                            double __tmp23;
                            double lambda_1___tmp4_0;
                            double lambda_1___tmp6_0;
                            double lambda_1___tmp10_0[4]  DACE_ALIGN(64);
                            double lambda_1___tmp12_0;
                            double lambda_1___tmp14_0;
                            int __s0_n3OUT___tmp1_n4None;
                            bool __s0_n7OUT___tmp2_n8None;
                            double __s0_n20OUT___tmp3_n21None[4]  DACE_ALIGN(64);
                            double __s0_n81OUT___tmp17_n82None;
                            double __s0_n82OUT___tmp19_n83None;
                            double __s0_n83OUT___tmp21_n84None;
                            bool __s0_n89OUT___tmp4_n90None;
                            bool __s0_n89OUT___tmp2_n86None;
                            bool __s0_n89OUT___tmp6_n90None;
                            bool __s0_n91OUT___tmp10_n92None;
                            bool __s0_n21OUT___tmp14_n91None;
                            double __s0_n94OUT___tmp18_n95None;
                            double __s0_n95OUT___tmp20_n96None;
                            double __s0_n95OUT___tmp22_n96None;
                            double __inner_double_buffer_for_dwdy;
                            double __inner_double_buffer_for_dwdx;
                            {
                                double __arg1 = __s0_n93OUT___tmp16_n94None;
                                double __arg0 = diff_multfac_n2w[((- __diff_multfac_n2w_0_range_0) + i_K_gtx_vertical)];
                                double result;

                                ///////////////////
                                // Tasklet code (tlet_10_multiplies)
                                result = (__arg0 * __arg1);
                                ///////////////////

                                __s0_n94OUT___tmp18_n95None = result;
                            }
                            {
                                double __arg0 = __s0_n94OUT___tmp18_n95None;
                                double __arg1 = lambda_2___tmp5[((i_Cell_gtx_horizontal + ((i_K_gtx_vertical - vertical_start) * (Max(283876, horizontal_end) - Min(0, horizontal_start)))) - Min(0, horizontal_start))];
                                double result;

                                ///////////////////
                                // Tasklet code (tlet_11_multiplies)
                                result = (__arg0 * __arg1);
                                ///////////////////

                                __s0_n95OUT___tmp20_n96None = result;
                            }
                            {
                                for (auto i_C2E2CO_gtx_localdim = 0; i_C2E2CO_gtx_localdim < 4; i_C2E2CO_gtx_localdim += 1) {
                                    double __s0_n8OUT___tmp0_n5None;
                                    double __s0_n18OUT___tmp8_n15None;
                                    double __s0_n49OUT___tmp10_n85None;
                                    {
                                        int __index = connectivity_C2E2CO[((__connectivity_C2E2CO_stride_0 * i_Cell_gtx_horizontal) + i_C2E2CO_gtx_localdim)];
                                        const double* __field = &w_old[(__w_old_stride_1 * ((- __w_old_1_range_0) + i_K_gtx_vertical))];
                                        double __val;

                                        ///////////////////
                                        // Tasklet code (tlet_1_C2E2CO_neighbors)
                                        __val = __field[__index];
                                        ///////////////////

                                        __s0_n8OUT___tmp0_n5None = __val;
                                    }
                                    {
                                        double __arg1 = __s0_n8OUT___tmp0_n5None;
                                        double __arg0 = geofac_grg_x[(((- __geofac_grg_x_0_range_0) + (__geofac_grg_x_stride_1 * i_C2E2CO_gtx_localdim)) + i_Cell_gtx_horizontal)];
                                        double __out;

                                        ///////////////////
                                        // Tasklet code (tlet_2_map)
                                        __out = (__arg0 * __arg1);
                                        ///////////////////

                                        __s0_n20OUT___tmp3_n21None[i_C2E2CO_gtx_localdim] = __out;
                                    }
                                    {
                                        int __index = connectivity_C2E2CO[((__connectivity_C2E2CO_stride_0 * i_Cell_gtx_horizontal) + i_C2E2CO_gtx_localdim)];
                                        const double* __field = &w_old[(__w_old_stride_1 * ((- __w_old_1_range_0) + i_K_gtx_vertical))];
                                        double __val;

                                        ///////////////////
                                        // Tasklet code (tlet_3_C2E2CO_neighbors)
                                        __val = __field[__index];
                                        ///////////////////

                                        __s0_n18OUT___tmp8_n15None = __val;
                                    }
                                    {
                                        double __arg1 = __s0_n18OUT___tmp8_n15None;
                                        double __arg0 = geofac_grg_y[(((- __geofac_grg_y_0_range_0) + (__geofac_grg_y_stride_1 * i_C2E2CO_gtx_localdim)) + i_Cell_gtx_horizontal)];
                                        double __out;

                                        ///////////////////
                                        // Tasklet code (tlet_4_map)
                                        __out = (__arg0 * __arg1);
                                        ///////////////////

                                        lambda_1___tmp10_0[i_C2E2CO_gtx_localdim] = __out;
                                    }
                                    {
                                        int __index = connectivity_C2E2CO[((__connectivity_C2E2CO_stride_0 * i_Cell_gtx_horizontal) + i_C2E2CO_gtx_localdim)];
                                        const double * __field = &lambda_2___tmp5[((i_K_gtx_vertical - vertical_start) * (Max(283876, horizontal_end) - Min(0, horizontal_start)))];
                                        double __val;

                                        ///////////////////
                                        // Tasklet code (tlet_6_C2E2CO_neighbors)
                                        __val = __field[__index];
                                        ///////////////////

                                        __s0_n49OUT___tmp10_n85None = __val;
                                    }
                                    {
                                        double __arg0 = __s0_n49OUT___tmp10_n85None;
                                        double __arg1 = geofac_n2s[(((- __geofac_n2s_0_range_0) + (__geofac_n2s_stride_1 * i_C2E2CO_gtx_localdim)) + i_Cell_gtx_horizontal)];
                                        double __out;

                                        ///////////////////
                                        // Tasklet code (tlet_7_map)
                                        __out = (__arg0 * __arg1);
                                        ///////////////////

                                        __tmp12[i_C2E2CO_gtx_localdim] = __out;
                                    }
                                }
                            }
                            reduce_0_0_105(&lambda_1___tmp10_0[0], &lambda_1___tmp12_0);
                            reduce_0_0_105(&__tmp12[0], &__tmp14);
                            {
                                double __arg1 = __tmp14;
                                double __arg0 = __s0_n70OUT___tmp9_n71None;
                                double result;

                                ///////////////////
                                // Tasklet code (tlet_8_multiplies)
                                result = (__arg0 * __arg1);
                                ///////////////////

                                __s0_n81OUT___tmp17_n82None = result;
                            }
                            {
                                double __arg1 = __s0_n81OUT___tmp17_n82None;
                                double __arg0 = w_old[(((- __w_old_0_range_0) + (__w_old_stride_1 * ((- __w_old_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal)];
                                double result;

                                ///////////////////
                                // Tasklet code (tlet_9_minus)
                                result = (__arg0 - __arg1);
                                ///////////////////

                                __s0_n82OUT___tmp19_n83None = result;
                            }
                            if_stmt_0_0_0_48(__s0_n82OUT___tmp19_n83None, w_old[(((- __w_old_0_range_0) + (__w_old_stride_1 * ((- __w_old_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal)], __s0_n65OUT___tmp5_n66None, __s0_n83OUT___tmp21_n84None);
                            {
                                double __arg0 = __s0_n83OUT___tmp21_n84None;
                                double __arg1 = __s0_n95OUT___tmp20_n96None;
                                double result;

                                ///////////////////
                                // Tasklet code (tlet_12_plus)
                                result = (__arg0 + __arg1);
                                ///////////////////

                                __s0_n95OUT___tmp22_n96None = result;
                            }
                            reduce_0_0_105(&__s0_n20OUT___tmp3_n21None[0], &lambda_1___tmp4_0);

                            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                            dwdx + (((- __dwdx_0_range_0) + (__dwdx_stride_1 * ((- __dwdx_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal), &__inner_double_buffer_for_dwdx, 1);

                            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                            dwdy + (((- __dwdy_0_range_0) + (__dwdy_stride_1 * ((- __dwdy_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal), &__inner_double_buffer_for_dwdy, 1);

                            dace::CopyND<int, 1, false, 1>::template ConstDst<1>::Copy(
                            k + ((- __k_0_range_0) + i_K_gtx_vertical), &__s0_n3OUT___tmp1_n4None, 1);
                            {
                                int __arg0 = __s0_n3OUT___tmp1_n4None;
                                int __arg1 = nrdmax;
                                bool result;

                                ///////////////////
                                // Tasklet code (tlet_3_less)
                                result = (__arg0 < __arg1);
                                ///////////////////

                                __s0_n89OUT___tmp4_n90None = result;
                            }
                            {
                                int __arg1 = __s0_n3OUT___tmp1_n4None;
                                int __arg0 = lambda_0___tmp0_0;
                                bool result;

                                ///////////////////
                                // Tasklet code (tlet_2_less)
                                result = (__arg0 < __arg1);
                                ///////////////////

                                __s0_n7OUT___tmp2_n8None = result;
                            }
                            if_stmt_1_0_0_19(lambda_1___tmp12_0, __inner_double_buffer_for_dwdy, __s0_n7OUT___tmp2_n8None, lambda_1___tmp14_0);

                            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                            &lambda_1___tmp14_0, dwdy + (((- __dwdy_0_range_0) + (__dwdy_stride_1 * ((- __dwdy_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal), 1);
                            if_stmt_1_0_0_19(lambda_1___tmp4_0, __inner_double_buffer_for_dwdx, __s0_n7OUT___tmp2_n8None, lambda_1___tmp6_0);

                            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                            &lambda_1___tmp6_0, dwdx + (((- __dwdx_0_range_0) + (__dwdx_stride_1 * ((- __dwdx_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal), 1);
                            {
                                int __arg1 = __s0_n3OUT___tmp1_n4None;
                                int __arg0 = lambda_1___tmp0_1;
                                bool result;

                                ///////////////////
                                // Tasklet code (tlet_2_less)
                                result = (__arg0 < __arg1);
                                ///////////////////

                                __s0_n89OUT___tmp2_n86None = result;
                            }
                            {
                                bool __arg0 = __s0_n89OUT___tmp2_n86None;
                                bool __arg1 = __s0_n89OUT___tmp4_n90None;
                                bool result;

                                ///////////////////
                                // Tasklet code (tlet_4_and_)
                                result = (__arg0 && __arg1);
                                ///////////////////

                                __s0_n89OUT___tmp6_n90None = result;
                            }
                            {
                                bool __arg0 = __s0_n89OUT___tmp6_n90None;
                                bool __arg1 = __s0_n91OUT___tmp8_n92None;
                                bool result;

                                ///////////////////
                                // Tasklet code (tlet_6_and_)
                                result = (__arg0 && __arg1);
                                ///////////////////

                                __s0_n91OUT___tmp10_n92None = result;
                            }
                            {
                                bool __arg0 = __s0_n91OUT___tmp10_n92None;
                                bool __arg1 = __s0_n93OUT___tmp12_n94None;
                                bool result;

                                ///////////////////
                                // Tasklet code (tlet_8_and_)
                                result = (__arg0 && __arg1);
                                ///////////////////

                                __s0_n21OUT___tmp14_n91None = result;
                            }
                            if_stmt_0_0_0_62(__s0_n95OUT___tmp22_n96None, __s0_n83OUT___tmp21_n84None, __s0_n21OUT___tmp14_n91None, __tmp23);

                            dace::CopyND<double, 1, false, 1>::template ConstDst<1>::Copy(
                            &__tmp23, w + (((- __w_0_range_0) + (__w_stride_1 * ((- __w_1_range_0) + i_K_gtx_vertical))) + i_Cell_gtx_horizontal), 1);
                        }
                    }
                }
            }
        }
    }
}


DACE_EXPORTED void __dace_runkernel_map_8_fieldop_0_0_58(restored_1740144456_state_t *__state, const double * __restrict__ area, const int * __restrict__ cell, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ diff_multfac_n2w, double * __restrict__ dwdx, double * __restrict__ dwdy, const double * __restrict__ geofac_grg_x, const double * __restrict__ geofac_grg_y, const double * __restrict__ geofac_n2s, const int * __restrict__ k, const double * __restrict__ lambda_2___tmp5, double * __restrict__ w, const double * __restrict__ w_old, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, const double diff_multfac_w, const int halo_idx, int horizontal_end, int horizontal_start, const int interior_idx, const int nrdmax, int vertical_end, int vertical_start);
void __dace_runkernel_map_8_fieldop_0_0_58(restored_1740144456_state_t *__state, const double * __restrict__ area, const int * __restrict__ cell, const int * __restrict__ connectivity_C2E2CO, const double * __restrict__ diff_multfac_n2w, double * __restrict__ dwdx, double * __restrict__ dwdy, const double * __restrict__ geofac_grg_x, const double * __restrict__ geofac_grg_y, const double * __restrict__ geofac_n2s, const int * __restrict__ k, const double * __restrict__ lambda_2___tmp5, double * __restrict__ w, const double * __restrict__ w_old, int __area_0_range_0, int __cell_0_range_0, int __connectivity_C2E2CO_stride_0, int __diff_multfac_n2w_0_range_0, int __dwdx_0_range_0, int __dwdx_1_range_0, int __dwdx_stride_1, int __dwdy_0_range_0, int __dwdy_1_range_0, int __dwdy_stride_1, int __geofac_grg_x_0_range_0, int __geofac_grg_x_stride_1, int __geofac_grg_y_0_range_0, int __geofac_grg_y_stride_1, int __geofac_n2s_0_range_0, int __geofac_n2s_stride_1, int __k_0_range_0, int __w_0_range_0, int __w_1_range_0, int __w_old_0_range_0, int __w_old_1_range_0, int __w_old_stride_1, int __w_stride_1, const double diff_multfac_w, const int halo_idx, int horizontal_end, int horizontal_start, const int interior_idx, const int nrdmax, int vertical_end, int vertical_start)
{

    if ((int_ceil(int_ceil((horizontal_end - horizontal_start), 1), 32)) == 0 || (int_ceil(int_ceil(int_ceil((vertical_end - vertical_start), 10), 1), 8)) == 0) {

        return;
    }

    void  *map_8_fieldop_0_0_58_args[] = { (void *)&area, (void *)&cell, (void *)&connectivity_C2E2CO, (void *)&diff_multfac_n2w, (void *)&dwdx, (void *)&dwdy, (void *)&geofac_grg_x, (void *)&geofac_grg_y, (void *)&geofac_n2s, (void *)&k, (void *)&lambda_2___tmp5, (void *)&w, (void *)&w_old, (void *)&__area_0_range_0, (void *)&__cell_0_range_0, (void *)&__connectivity_C2E2CO_stride_0, (void *)&__diff_multfac_n2w_0_range_0, (void *)&__dwdx_0_range_0, (void *)&__dwdx_1_range_0, (void *)&__dwdx_stride_1, (void *)&__dwdy_0_range_0, (void *)&__dwdy_1_range_0, (void *)&__dwdy_stride_1, (void *)&__geofac_grg_x_0_range_0, (void *)&__geofac_grg_x_stride_1, (void *)&__geofac_grg_y_0_range_0, (void *)&__geofac_grg_y_stride_1, (void *)&__geofac_n2s_0_range_0, (void *)&__geofac_n2s_stride_1, (void *)&__k_0_range_0, (void *)&__w_0_range_0, (void *)&__w_1_range_0, (void *)&__w_old_0_range_0, (void *)&__w_old_1_range_0, (void *)&__w_old_stride_1, (void *)&__w_stride_1, (void *)&diff_multfac_w, (void *)&halo_idx, (void *)&horizontal_end, (void *)&horizontal_start, (void *)&interior_idx, (void *)&nrdmax, (void *)&vertical_end, (void *)&vertical_start };
    gpuError_t __err = cudaLaunchKernel((void*)map_8_fieldop_0_0_58, dim3(int_ceil(int_ceil((horizontal_end - horizontal_start), 1), 32), int_ceil(int_ceil(int_ceil((vertical_end - vertical_start), 10), 1), 8), 1), dim3(32, 8, 1), map_8_fieldop_0_0_58_args, 0, __state->gpu_context->streams[0]);
    DACE_KERNEL_LAUNCH_CHECK(__err, "map_8_fieldop_0_0_58", int_ceil(int_ceil((horizontal_end - horizontal_start), 1), 32), int_ceil(int_ceil(int_ceil((vertical_end - vertical_start), 10), 1), 8), 1, 32, 8, 1);
}


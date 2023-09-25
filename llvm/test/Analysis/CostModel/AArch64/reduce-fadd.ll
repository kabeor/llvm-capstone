; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes='print<cost-model>' 2>&1 -disable-output -mtriple=aarch64--linux-gnu < %s | FileCheck %s
; RUN: opt -passes='print<cost-model>' 2>&1 -disable-output -mtriple=aarch64--linux-gnu -mattr=+fullfp16 < %s | FileCheck %s --check-prefix=FP16
; RUN: opt -passes='print<cost-model>' 2>&1 -disable-output -mtriple=aarch64--linux-gnu -mattr=+bf16 < %s | FileCheck %s --check-prefix=BF16

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define void @strict_fp_reductions() {
; CHECK-LABEL: 'strict_fp_reductions'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 21 for instruction: %fadd_v4f16 = call half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 45 for instruction: %fadd_v8f16 = call half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %fadd_v4f32 = call float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %fadd_v8f32 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %fadd_v2f64 = call double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %fadd_v4f64 = call double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v4f8 = call bfloat @llvm.vector.reduce.fadd.v4bf16(bfloat 0xR0000, <4 x bfloat> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %fadd_v4f128 = call fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; FP16-LABEL: 'strict_fp_reductions'
; FP16-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %fadd_v4f16 = call half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 37 for instruction: %fadd_v8f16 = call half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %fadd_v4f32 = call float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %fadd_v8f32 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %fadd_v2f64 = call double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %fadd_v4f64 = call double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v4f8 = call bfloat @llvm.vector.reduce.fadd.v4bf16(bfloat 0xR0000, <4 x bfloat> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %fadd_v4f128 = call fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; BF16-LABEL: 'strict_fp_reductions'
; BF16-NEXT:  Cost Model: Found an estimated cost of 21 for instruction: %fadd_v4f16 = call half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 45 for instruction: %fadd_v8f16 = call half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %fadd_v4f32 = call float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %fadd_v8f32 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %fadd_v2f64 = call double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %fadd_v4f64 = call double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %fadd_v4f8 = call bfloat @llvm.vector.reduce.fadd.v4bf16(bfloat 0xR0000, <4 x bfloat> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %fadd_v4f128 = call fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %fadd_v4f16 = call half @llvm.vector.reduce.fadd.v4f16(half 0.0, <4 x half> undef)
  %fadd_v8f16 = call half @llvm.vector.reduce.fadd.v8f16(half 0.0, <8 x half> undef)
  %fadd_v4f32 = call float @llvm.vector.reduce.fadd.v4f32(float 0.0, <4 x float> undef)
  %fadd_v8f32 = call float @llvm.vector.reduce.fadd.v8f32(float 0.0, <8 x float> undef)
  %fadd_v2f64 = call double @llvm.vector.reduce.fadd.v2f64(double 0.0, <2 x double> undef)
  %fadd_v4f64 = call double @llvm.vector.reduce.fadd.v4f64(double 0.0, <4 x double> undef)
  %fadd_v4f8 = call bfloat @llvm.vector.reduce.fadd.v4f8(bfloat 0.0, <4 x bfloat> undef)
  %fadd_v4f128 = call fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)

  ret void
}


define void @fast_fp_reductions() {
; CHECK-LABEL: 'fast_fp_reductions'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %fadd_v4f16_fast = call fast half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %fadd_v4f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 30 for instruction: %fadd_v8f16 = call fast half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 30 for instruction: %fadd_v8f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 46 for instruction: %fadd_v11f16 = call fast half @llvm.vector.reduce.fadd.v11f16(half 0xH0000, <11 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 52 for instruction: %fadd_v13f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v13f16(half 0xH0000, <13 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f32 = call fast float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f32 = call fast float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 46 for instruction: %fadd_v13f32 = call fast float @llvm.vector.reduce.fadd.v13f32(float 0.000000e+00, <13 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v5f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v5f32(float 0.000000e+00, <5 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %fadd_v2f64 = call fast double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %fadd_v2f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %fadd_v4f64 = call fast double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %fadd_v4f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %fadd_v7f64 = call fast double @llvm.vector.reduce.fadd.v7f64(double 0.000000e+00, <7 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 23 for instruction: %fadd_v9f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v9f64(double 0.000000e+00, <9 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %fadd_v4f8 = call reassoc bfloat @llvm.vector.reduce.fadd.v4bf16(bfloat 0xR8000, <4 x bfloat> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v4f128 = call reassoc fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; FP16-LABEL: 'fast_fp_reductions'
; FP16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f16_fast = call fast half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f16 = call fast half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 43 for instruction: %fadd_v11f16 = call fast half @llvm.vector.reduce.fadd.v11f16(half 0xH0000, <11 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 49 for instruction: %fadd_v13f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v13f16(half 0xH0000, <13 x half> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f32 = call fast float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f32 = call fast float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 46 for instruction: %fadd_v13f32 = call fast float @llvm.vector.reduce.fadd.v13f32(float 0.000000e+00, <13 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v5f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v5f32(float 0.000000e+00, <5 x float> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %fadd_v2f64 = call fast double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %fadd_v2f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %fadd_v4f64 = call fast double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %fadd_v4f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %fadd_v7f64 = call fast double @llvm.vector.reduce.fadd.v7f64(double 0.000000e+00, <7 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 23 for instruction: %fadd_v9f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v9f64(double 0.000000e+00, <9 x double> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %fadd_v4f8 = call reassoc bfloat @llvm.vector.reduce.fadd.v4bf16(bfloat 0xR8000, <4 x bfloat> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v4f128 = call reassoc fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)
; FP16-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; BF16-LABEL: 'fast_fp_reductions'
; BF16-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %fadd_v4f16_fast = call fast half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %fadd_v4f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 30 for instruction: %fadd_v8f16 = call fast half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 30 for instruction: %fadd_v8f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 46 for instruction: %fadd_v11f16 = call fast half @llvm.vector.reduce.fadd.v11f16(half 0xH0000, <11 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 52 for instruction: %fadd_v13f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v13f16(half 0xH0000, <13 x half> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f32 = call fast float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f32 = call fast float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 27 for instruction: %fadd_v8f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 46 for instruction: %fadd_v13f32 = call fast float @llvm.vector.reduce.fadd.v13f32(float 0.000000e+00, <13 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v5f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v5f32(float 0.000000e+00, <5 x float> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %fadd_v2f64 = call fast double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %fadd_v2f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %fadd_v4f64 = call fast double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %fadd_v4f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v4f64(double 0.000000e+00, <4 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 15 for instruction: %fadd_v7f64 = call fast double @llvm.vector.reduce.fadd.v7f64(double 0.000000e+00, <7 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 23 for instruction: %fadd_v9f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v9f64(double 0.000000e+00, <9 x double> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %fadd_v4f8 = call reassoc bfloat @llvm.vector.reduce.fadd.v4bf16(bfloat 0xR8000, <4 x bfloat> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %fadd_v4f128 = call reassoc fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)
; BF16-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %fadd_v4f16_fast = call fast half @llvm.vector.reduce.fadd.v4f16(half 0.0, <4 x half> undef)
  %fadd_v4f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v4f16(half 0.0, <4 x half> undef)

  %fadd_v8f16 = call fast half @llvm.vector.reduce.fadd.v8f16(half 0.0, <8 x half> undef)
  %fadd_v8f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v8f16(half 0.0, <8 x half> undef)

  %fadd_v11f16 = call fast half @llvm.vector.reduce.fadd.v11f16(half 0.0, <11 x half> undef)
  %fadd_v13f16_reassoc = call reassoc half @llvm.vector.reduce.fadd.v13f16(half 0.0, <13 x half> undef)

  %fadd_v4f32 = call fast float @llvm.vector.reduce.fadd.v4f32(float 0.0, <4 x float> undef)
  %fadd_v4f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v4f32(float 0.0, <4 x float> undef)

  %fadd_v8f32 = call fast float @llvm.vector.reduce.fadd.v8f32(float 0.0, <8 x float> undef)
  %fadd_v8f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v8f32(float 0.0, <8 x float> undef)

  %fadd_v13f32 = call fast float @llvm.vector.reduce.fadd.v13f32(float 0.0, <13 x float> undef)
  %fadd_v5f32_reassoc = call reassoc float @llvm.vector.reduce.fadd.v5f32(float 0.0, <5 x float> undef)

  %fadd_v2f64 = call fast double @llvm.vector.reduce.fadd.v2f64(double 0.0, <2 x double> undef)
  %fadd_v2f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v2f64(double 0.0, <2 x double> undef)

  %fadd_v4f64 = call fast double @llvm.vector.reduce.fadd.v4f64(double 0.0, <4 x double> undef)
  %fadd_v4f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v4f64(double 0.0, <4 x double> undef)

  %fadd_v7f64 = call fast double @llvm.vector.reduce.fadd.v7f64(double 0.0, <7 x double> undef)
  %fadd_v9f64_reassoc = call reassoc double @llvm.vector.reduce.fadd.v9f64(double 0.0, <9 x double> undef)

  %fadd_v4f8 = call reassoc bfloat @llvm.vector.reduce.fadd.v4f8(bfloat -0.0, <4 x bfloat> undef)
  %fadd_v4f128 = call reassoc fp128 @llvm.vector.reduce.fadd.v4f128(fp128 undef, <4 x fp128> undef)

  ret void
}

declare bfloat @llvm.vector.reduce.fadd.v4f8(bfloat, <4 x bfloat>)
declare fp128 @llvm.vector.reduce.fadd.v4f128(fp128, <4 x fp128>)

declare half @llvm.vector.reduce.fadd.v4f16(half, <4 x half>)
declare half @llvm.vector.reduce.fadd.v8f16(half, <8 x half>)
declare half @llvm.vector.reduce.fadd.v11f16(half, <11 x half>)
declare half @llvm.vector.reduce.fadd.v13f16(half, <13 x half>)

declare float @llvm.vector.reduce.fadd.v4f32(float, <4 x float>)
declare float @llvm.vector.reduce.fadd.v8f32(float, <8 x float>)
declare float @llvm.vector.reduce.fadd.v13f32(float, <13 x float>)
declare float @llvm.vector.reduce.fadd.v5f32(float, <5 x float>)

declare double @llvm.vector.reduce.fadd.v2f64(double, <2 x double>)
declare double @llvm.vector.reduce.fadd.v4f64(double, <4 x double>)
declare double @llvm.vector.reduce.fadd.v7f64(double, <7 x double>)
declare double @llvm.vector.reduce.fadd.v9f64(double, <9 x double>)

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --filter-out "(\.v?save|push|pop)"

; No FP16/BF16
; RUN: llc -mtriple=arm-none-eabi -float-abi=soft -mattr=+armv8.2-a,+fp-armv8,-fullfp16,-bf16,-neon %s -o - | FileCheck %s --check-prefixes=NO-FP16-SOFT
; RUN: llc -mtriple=thumb-none-eabi -float-abi=soft -mattr=+armv8.2-a,+fp-armv8,-fullfp16,-bf16,-neon %s -o - | FileCheck %s --check-prefixes=NO-FP16-SOFT
; RUN: llc -mtriple=arm-none-eabi -mattr=+armv8.2-a,+fp-armv8,-fullfp16,-bf16,-neon %s -o - | FileCheck %s --check-prefixes=NO-FP16-SOFT
; RUN: llc -mtriple=thumb-none-eabi -mattr=+armv8.2-a,+fp-armv8,-fullfp16,-bf16,-neon %s -o - | FileCheck %s --check-prefixes=NO-FP16-SOFT
; RUN: llc -mtriple=arm-none-eabihf -mattr=+armv8.2-a,+fp-armv8,-fullfp16,-bf16,-neon %s -o - | FileCheck %s --check-prefixes=NO-FP16-HARD
; RUN: llc -mtriple=thumb-none-eabihf -mattr=+armv8.2-a,+fp-armv8,-fullfp16,-bf16,-neon %s -o - | FileCheck %s --check-prefixes=NO-FP16-HARD

; FP16/BF16
; RUN: llc -mtriple=arm-none-eabi -float-abi=soft -mattr=+armv8.2-a,+fp-armv8,+fullfp16,+bf16,-neon %s -o - | FileCheck %s --check-prefixes=FP16-SOFT
; RUN: llc -mtriple=thumb-none-eabi -float-abi=soft -mattr=+armv8.2-a,+fp-armv8,+fullfp16,+bf16,-neon %s -o - | FileCheck %s --check-prefixes=FP16-SOFT
; RUN: llc -mtriple=arm-none-eabi -mattr=+armv8.2-a,+fp-armv8,+fullfp16,+bf16,-neon %s -o - | FileCheck %s --check-prefixes=FP16-SOFT
; RUN: llc -mtriple=thumb-none-eabi -mattr=+armv8.2-a,+fp-armv8,+fullfp16,+bf16,-neon %s -o - | FileCheck %s --check-prefixes=FP16-SOFT
; RUN: llc -mtriple=arm-none-eabihf -mattr=+armv8.2-a,+fp-armv8,+fullfp16,+bf16,-neon %s -o - | FileCheck %s --check-prefixes=FP16-HARD
; RUN: llc -mtriple=thumb-none-eabihf -mattr=+armv8.2-a,+fp-armv8,+fullfp16,+bf16,-neon %s -o - | FileCheck %s --check-prefixes=FP16-HARD

; PR60510 showed a bug where the return from `*_inner` was getting "lost" by an
; optimisation, and a garbage value was being left in `s0`.

declare dso_local float @other(float) nounwind
declare dso_local void @fp16_sink(half) nounwind
declare dso_local void @bf16_sink(bfloat) nounwind

declare dso_local half @fp16_inner() nounwind
declare dso_local bfloat @bf_inner() nounwind

define half @fp16_out_call_oneuse(float %arg) nounwind {
; NO-FP16-SOFT-LABEL: fp16_out_call_oneuse:
; NO-FP16-SOFT:  @ %bb.0:
; NO-FP16-SOFT:    mov r4, r0
; NO-FP16-SOFT:    bl fp16_inner
; NO-FP16-SOFT:    mov r5, r0
; NO-FP16-SOFT:    mov r0, r4
; NO-FP16-SOFT:    bl other
; NO-FP16-SOFT:    mov r0, r5
;
; NO-FP16-HARD-LABEL: fp16_out_call_oneuse:
; NO-FP16-HARD:  @ %bb.0:
; NO-FP16-HARD:    vmov.f32 s16, s0
; NO-FP16-HARD:    bl fp16_inner
; NO-FP16-HARD:    vmov.f32 s18, s0
; NO-FP16-HARD:    vmov.f32 s0, s16
; NO-FP16-HARD:    bl other
; NO-FP16-HARD:    vmov.f32 s0, s18
;
; FP16-SOFT-LABEL: fp16_out_call_oneuse:
; FP16-SOFT:  @ %bb.0:
; FP16-SOFT:    mov r4, r0
; FP16-SOFT:    bl fp16_inner
; FP16-SOFT:    mov r5, r0
; FP16-SOFT:    mov r0, r4
; FP16-SOFT:    bl other
; FP16-SOFT:    vmov.f16 s0, r5
; FP16-SOFT:    vmov r0, s0
;
; FP16-HARD-LABEL: fp16_out_call_oneuse:
; FP16-HARD:  @ %bb.0:
; FP16-HARD:    vmov.f32 s16, s0
; FP16-HARD:    bl fp16_inner
; FP16-HARD:    vmov.f32 s18, s0
; FP16-HARD:    vmov.f32 s0, s16
; FP16-HARD:    bl other
; FP16-HARD:    vmov.f32 s0, s18
  %call = call half @fp16_inner()
  %call1 = call float @other(float %arg)
  ret half %call
}

define half @fp16_out_call_multiuse(float %arg) nounwind {
; NO-FP16-SOFT-LABEL: fp16_out_call_multiuse:
; NO-FP16-SOFT:  @ %bb.0:
; NO-FP16-SOFT:    mov r4, r0
; NO-FP16-SOFT:    bl fp16_inner
; NO-FP16-SOFT:    mov r5, r0
; NO-FP16-SOFT:    mov r0, r4
; NO-FP16-SOFT:    bl other
; NO-FP16-SOFT:    mov r0, r5
; NO-FP16-SOFT:    bl fp16_sink
; NO-FP16-SOFT:    mov r0, r5
;
; NO-FP16-HARD-LABEL: fp16_out_call_multiuse:
; NO-FP16-HARD:  @ %bb.0:
; NO-FP16-HARD:    vmov.f32 s16, s0
; NO-FP16-HARD:    bl fp16_inner
; NO-FP16-HARD:    vmov.f32 s18, s0
; NO-FP16-HARD:    vmov.f32 s0, s16
; NO-FP16-HARD:    bl other
; NO-FP16-HARD:    vmov.f32 s0, s18
; NO-FP16-HARD:    bl fp16_sink
; NO-FP16-HARD:    vmov.f32 s0, s18
;
; FP16-SOFT-LABEL: fp16_out_call_multiuse:
; FP16-SOFT:  @ %bb.0:
; FP16-SOFT:    mov r4, r0
; FP16-SOFT:    bl fp16_inner
; FP16-SOFT:    mov r5, r0
; FP16-SOFT:    mov r0, r4
; FP16-SOFT:    bl other
; FP16-SOFT:    vmov.f16 s16, r5
; FP16-SOFT:    vmov.f16 r0, s16
; FP16-SOFT:    bl fp16_sink
; FP16-SOFT:    vmov r0, s16
;
; FP16-HARD-LABEL: fp16_out_call_multiuse:
; FP16-HARD:  @ %bb.0:
; FP16-HARD:    vmov.f32 s16, s0
; FP16-HARD:    bl fp16_inner
; FP16-HARD:    vmov.f32 s18, s0
; FP16-HARD:    vmov.f32 s0, s16
; FP16-HARD:    bl other
; FP16-HARD:    vmov.f16 r0, s18
; FP16-HARD:    vmov s0, r0
; FP16-HARD:    bl fp16_sink
; FP16-HARD:    vmov.f32 s0, s18
  %call = call half @fp16_inner()
  %call1 = call float @other(float %arg)
  call void @fp16_sink(half %call)
  ret half %call
}

define bfloat @bf_out_call_oneuse(float %arg) nounwind {
; NO-FP16-SOFT-LABEL: bf_out_call_oneuse:
; NO-FP16-SOFT:  @ %bb.0:
; NO-FP16-SOFT:    mov r4, r0
; NO-FP16-SOFT:    bl bf_inner
; NO-FP16-SOFT:    mov r5, r0
; NO-FP16-SOFT:    mov r0, r4
; NO-FP16-SOFT:    bl other
; NO-FP16-SOFT:    mov r0, r5
;
; NO-FP16-HARD-LABEL: bf_out_call_oneuse:
; NO-FP16-HARD:  @ %bb.0:
; NO-FP16-HARD:    vmov.f32 s16, s0
; NO-FP16-HARD:    bl bf_inner
; NO-FP16-HARD:    vmov.f32 s18, s0
; NO-FP16-HARD:    vmov.f32 s0, s16
; NO-FP16-HARD:    bl other
; NO-FP16-HARD:    vmov.f32 s0, s18
;
; FP16-SOFT-LABEL: bf_out_call_oneuse:
; FP16-SOFT:  @ %bb.0:
; FP16-SOFT:    mov r4, r0
; FP16-SOFT:    bl bf_inner
; FP16-SOFT:    mov r5, r0
; FP16-SOFT:    mov r0, r4
; FP16-SOFT:    bl other
; FP16-SOFT:    mov r0, r5
;
; FP16-HARD-LABEL: bf_out_call_oneuse:
; FP16-HARD:  @ %bb.0:
; FP16-HARD:    vmov.f32 s16, s0
; FP16-HARD:    bl bf_inner
; FP16-HARD:    vmov.f32 s18, s0
; FP16-HARD:    vmov.f32 s0, s16
; FP16-HARD:    bl other
; FP16-HARD:    vmov.f32 s0, s18
  %call = call bfloat @bf_inner()
  %call1 = call float @other(float %arg)
  ret bfloat %call
}

define bfloat @bf_out_call_multiuse(float %arg) nounwind {
; NO-FP16-SOFT-LABEL: bf_out_call_multiuse:
; NO-FP16-SOFT:  @ %bb.0:
; NO-FP16-SOFT:    mov r4, r0
; NO-FP16-SOFT:    bl bf_inner
; NO-FP16-SOFT:    mov r5, r0
; NO-FP16-SOFT:    mov r0, r4
; NO-FP16-SOFT:    bl other
; NO-FP16-SOFT:    mov r0, r5
; NO-FP16-SOFT:    bl bf16_sink
; NO-FP16-SOFT:    mov r0, r5
;
; NO-FP16-HARD-LABEL: bf_out_call_multiuse:
; NO-FP16-HARD:  @ %bb.0:
; NO-FP16-HARD:    vmov.f32 s16, s0
; NO-FP16-HARD:    bl bf_inner
; NO-FP16-HARD:    vmov.f32 s18, s0
; NO-FP16-HARD:    vmov.f32 s0, s16
; NO-FP16-HARD:    bl other
; NO-FP16-HARD:    vmov.f32 s0, s18
; NO-FP16-HARD:    bl bf16_sink
; NO-FP16-HARD:    vmov.f32 s0, s18
;
; FP16-SOFT-LABEL: bf_out_call_multiuse:
; FP16-SOFT:  @ %bb.0:
; FP16-SOFT:    mov r4, r0
; FP16-SOFT:    bl bf_inner
; FP16-SOFT:    mov r5, r0
; FP16-SOFT:    mov r0, r4
; FP16-SOFT:    bl other
; FP16-SOFT:    mov r0, r5
; FP16-SOFT:    bl bf16_sink
; FP16-SOFT:    mov r0, r5
;
; FP16-HARD-LABEL: bf_out_call_multiuse:
; FP16-HARD:  @ %bb.0:
; FP16-HARD:    vmov.f32 s16, s0
; FP16-HARD:    bl bf_inner
; FP16-HARD:    vmov.f32 s18, s0
; FP16-HARD:    vmov.f32 s0, s16
; FP16-HARD:    bl other
; FP16-HARD:    vmov.f32 s0, s18
; FP16-HARD:    bl bf16_sink
; FP16-HARD:    vmov.f32 s0, s18
  %call = call bfloat @bf_inner()
  %call1 = call float @other(float %arg)
  call void @bf16_sink(bfloat %call)
  ret bfloat %call
}

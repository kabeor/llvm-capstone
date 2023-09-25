; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=s390x-linux-gnu -mcpu=z15 < %s | FileCheck %s --check-prefixes=CHECK,Z15
; RUN: llc -mtriple=s390x-linux-gnu -mcpu=z13 < %s | FileCheck %s --check-prefixes=CHECK,Z13
;
; Test inline assembly where the operand is bitcasted.

define signext i32 @int_and_f(i32 signext %cc_dep1) {
; CHECK-LABEL: int_and_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlvgf %v0, %r2, 0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vlgvf %r0, %v0, 0
; CHECK-NEXT:    lgfr %r2, %r0
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call i32 asm sideeffect "", "={f0},0"(i32 %cc_dep1)
  ret i32 %0
}

define i64 @long_and_f(i64 %cc_dep1) {
; CHECK-LABEL: long_and_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ldgr %f1, %r2
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lgdr %r2, %f1
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call i64 asm sideeffect "", "={f1},0"(i64 %cc_dep1)
  ret i64 %0
}

define void @__int128_and_f(ptr noalias nocapture writeonly sret(i128) align 8 %agg.result, ptr %0) {
; Z15-LABEL: __int128_and_f:
; Z15:       # %bb.0: # %entry
; Z15-NEXT:    vl %v0, 0(%r3), 3
; Z15-NEXT:    vrepg %v6, %v0, 1
; Z15-NEXT:    vlr %v4, %v0
; Z15-NEXT:    #APP
; Z15-NEXT:    #NO_APP
; Z15-NEXT:    vmrhg %v0, %v4, %v6
; Z15-NEXT:    vst %v0, 0(%r2), 3
; Z15-NEXT:    br %r14
;
; Z13-LABEL: __int128_and_f:
; Z13:       # %bb.0: # %entry
; Z13-NEXT:    ld %f4, 0(%r3)
; Z13-NEXT:    ld %f6, 8(%r3)
; Z13-NEXT:    #APP
; Z13-NEXT:    #NO_APP
; Z13-NEXT:    std %f4, 0(%r2)
; Z13-NEXT:    std %f6, 8(%r2)
; Z13-NEXT:    br %r14
entry:
  %cc_dep1 = load i128, ptr %0, align 8
  %1 = tail call i128 asm sideeffect "", "={f4},0"(i128 %cc_dep1)
  store i128 %1, ptr %agg.result, align 8
  ret void
}

define signext i32 @int_and_v(i32 signext %cc_dep1) {
; CHECK-LABEL: int_and_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlvgf %v0, %r2, 0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vlgvf %r0, %v0, 0
; CHECK-NEXT:    lgfr %r2, %r0
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call i32 asm sideeffect "", "={v0},0"(i32 %cc_dep1)
  ret i32 %0
}

define i64 @long_and_v(i64 %cc_dep1) {
; CHECK-LABEL: long_and_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ldgr %f1, %r2
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lgdr %r2, %f1
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call i64 asm sideeffect "", "={v1},0"(i64 %cc_dep1)
  ret i64 %0
}

define void @__int128_and_v(ptr noalias nocapture writeonly sret(i128) align 8 %agg.result, ptr %0) {
; CHECK-LABEL: __int128_and_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v2, 0(%r3), 3
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vst %v2, 0(%r2), 3
; CHECK-NEXT:    br %r14
entry:
  %cc_dep1 = load i128, ptr %0, align 8
  %1 = tail call i128 asm sideeffect "", "={v2},0"(i128 %cc_dep1)
  store i128 %1, ptr %agg.result, align 8
  ret void
}

define float @float_and_r(float %cc_dep1) {
; CHECK-LABEL: float_and_r:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlgvf %r0, %v0, 0
; CHECK-NEXT:    # kill: def $r0l killed $r0l killed $r0d
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vlvgf %v0, %r0, 0
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call float asm sideeffect "", "={r0},0"(float %cc_dep1)
  ret float %0
}

define double @double_and_r(double %cc_dep1) {
; CHECK-LABEL: double_and_r:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lgdr %r1, %f0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ldgr %f0, %r1
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call double asm sideeffect "", "={r1},0"(double %cc_dep1)
  ret double %0
}

define void @longdouble_and_r(ptr noalias nocapture writeonly sret(fp128) align 8 %agg.result, ptr %0) {
; CHECK-LABEL: longdouble_and_r:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lg %r5, 8(%r3)
; CHECK-NEXT:    lg %r4, 0(%r3)
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    stg %r5, 8(%r2)
; CHECK-NEXT:    stg %r4, 0(%r2)
; CHECK-NEXT:    br %r14
entry:
  %cc_dep1 = load fp128, ptr %0, align 8
  %1 = tail call fp128 asm sideeffect "", "={r4},0"(fp128 %cc_dep1)
  store fp128 %1, ptr %agg.result, align 8
  ret void
}

define float @float_and_v(float %cc_dep1) {
; CHECK-LABEL: float_and_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ldr %f3, %f0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ldr %f0, %f3
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call float asm sideeffect "", "={v3},0"(float %cc_dep1)
  ret float %0
}

define double @double_and_v(double %cc_dep1) {
; CHECK-LABEL: double_and_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ldr %f4, %f0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ldr %f0, %f4
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call double asm sideeffect "", "={v4},0"(double %cc_dep1)
  ret double %0
}

define void @longdouble_and_v(ptr noalias nocapture writeonly sret(fp128) align 8 %agg.result, ptr %0) {
; CHECK-LABEL: longdouble_and_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v5, 0(%r3), 3
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vst %v5, 0(%r2), 3
; CHECK-NEXT:    br %r14
entry:
  %cc_dep1 = load fp128, ptr %0, align 8
  %1 = tail call fp128 asm sideeffect "", "={v5},0"(fp128 %cc_dep1)
  store fp128 %1, ptr %agg.result, align 8
  ret void
}

define <2 x i16> @vec32_and_r(<2 x i16> %cc_dep1) {
; CHECK-LABEL: vec32_and_r:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlgvf %r5, %v24, 0
; CHECK-NEXT:    # kill: def $r5l killed $r5l killed $r5d
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vlvgf %v24, %r5, 0
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call <2 x i16> asm sideeffect "", "={r5},0"(<2 x i16> %cc_dep1)
  ret <2 x i16> %0
}

define <2 x i32> @vec64_and_r(<2 x i32> %cc_dep1) {
; CHECK-LABEL: vec64_and_r:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlgvg %r4, %v24, 0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vlvgg %v24, %r4, 0
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call <2 x i32> asm sideeffect "", "={r4},0"(<2 x i32> %cc_dep1)
  ret <2 x i32> %0
}

define <4 x i32> @vec128_and_r(<4 x i32> %cc_dep1) {
; CHECK-LABEL: vec128_and_r:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlgvg %r3, %v24, 1
; CHECK-NEXT:    vlgvg %r2, %v24, 0
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vlvgp %v24, %r2, %r3
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call <4 x i32> asm sideeffect "", "={r2},0"(<4 x i32> %cc_dep1)
  ret <4 x i32> %0
}

define <2 x i16> @vec32_and_f(<2 x i16> %cc_dep1) {
; CHECK-LABEL: vec32_and_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlr %v4, %v24
; CHECK-NEXT:    # kill: def $f4s killed $f4s killed $v4
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    # kill: def $f4s killed $f4s def $v4
; CHECK-NEXT:    vlr %v24, %v4
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call <2 x i16> asm sideeffect "", "={f4},0"(<2 x i16> %cc_dep1)
  ret <2 x i16> %0
}

define <2 x i32> @vec64_and_f(<2 x i32> %cc_dep1) {
; CHECK-LABEL: vec64_and_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vlr %v5, %v24
; CHECK-NEXT:    # kill: def $f5d killed $f5d killed $v5
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    # kill: def $f5d killed $f5d def $v5
; CHECK-NEXT:    vlr %v24, %v5
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call <2 x i32> asm sideeffect "", "={f5},0"(<2 x i32> %cc_dep1)
  ret <2 x i32> %0
}

define <4 x i32> @vec128_and_f(<4 x i32> %cc_dep1) {
; CHECK-LABEL: vec128_and_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrepg %v3, %v24, 1
; CHECK-NEXT:    vlr %v1, %v24
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vmrhg %v24, %v1, %v3
; CHECK-NEXT:    br %r14
entry:
  %0 = tail call <4 x i32> asm sideeffect "", "={f1},0"(<4 x i32> %cc_dep1)
  ret <4 x i32> %0
}


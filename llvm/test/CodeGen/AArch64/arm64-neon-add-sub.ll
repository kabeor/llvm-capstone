; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -verify-machineinstrs -mtriple=arm64-none-linux-gnu -mattr=+neon -aarch64-enable-simd-scalar| FileCheck %s

define <8 x i8> @add8xi8(<8 x i8> %A, <8 x i8> %B) {
; CHECK-LABEL: add8xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
	%tmp3 = add <8 x i8> %A, %B;
	ret <8 x i8> %tmp3
}

define <16 x i8> @add16xi8(<16 x i8> %A, <16 x i8> %B) {
; CHECK-LABEL: add16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
	%tmp3 = add <16 x i8> %A, %B;
	ret <16 x i8> %tmp3
}

define <4 x i16> @add4xi16(<4 x i16> %A, <4 x i16> %B) {
; CHECK-LABEL: add4xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
	%tmp3 = add <4 x i16> %A, %B;
	ret <4 x i16> %tmp3
}

define <8 x i16> @add8xi16(<8 x i16> %A, <8 x i16> %B) {
; CHECK-LABEL: add8xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
	%tmp3 = add <8 x i16> %A, %B;
	ret <8 x i16> %tmp3
}

define <2 x i32> @add2xi32(<2 x i32> %A, <2 x i32> %B) {
; CHECK-LABEL: add2xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
	%tmp3 = add <2 x i32> %A, %B;
	ret <2 x i32> %tmp3
}

define <4 x i32> @add4x32(<4 x i32> %A, <4 x i32> %B) {
; CHECK-LABEL: add4x32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
	%tmp3 = add <4 x i32> %A, %B;
	ret <4 x i32> %tmp3
}

define <2 x i64> @add2xi64(<2 x i64> %A, <2 x i64> %B) {
; CHECK-LABEL: add2xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
	%tmp3 = add <2 x i64> %A, %B;
	ret <2 x i64> %tmp3
}

define <2 x float> @add2xfloat(<2 x float> %A, <2 x float> %B) {
; CHECK-LABEL: add2xfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
	%tmp3 = fadd <2 x float> %A, %B;
	ret <2 x float> %tmp3
}

define <4 x float> @add4xfloat(<4 x float> %A, <4 x float> %B) {
; CHECK-LABEL: add4xfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
	%tmp3 = fadd <4 x float> %A, %B;
	ret <4 x float> %tmp3
}
define <2 x double> @add2xdouble(<2 x double> %A, <2 x double> %B) {
; CHECK-LABEL: add2xdouble:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
	%tmp3 = fadd <2 x double> %A, %B;
	ret <2 x double> %tmp3
}

define <8 x i8> @sub8xi8(<8 x i8> %A, <8 x i8> %B) {
; CHECK-LABEL: sub8xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
	%tmp3 = sub <8 x i8> %A, %B;
	ret <8 x i8> %tmp3
}

define <16 x i8> @sub16xi8(<16 x i8> %A, <16 x i8> %B) {
; CHECK-LABEL: sub16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
	%tmp3 = sub <16 x i8> %A, %B;
	ret <16 x i8> %tmp3
}

define <4 x i16> @sub4xi16(<4 x i16> %A, <4 x i16> %B) {
; CHECK-LABEL: sub4xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
	%tmp3 = sub <4 x i16> %A, %B;
	ret <4 x i16> %tmp3
}

define <8 x i16> @sub8xi16(<8 x i16> %A, <8 x i16> %B) {
; CHECK-LABEL: sub8xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
	%tmp3 = sub <8 x i16> %A, %B;
	ret <8 x i16> %tmp3
}

define <2 x i32> @sub2xi32(<2 x i32> %A, <2 x i32> %B) {
; CHECK-LABEL: sub2xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
	%tmp3 = sub <2 x i32> %A, %B;
	ret <2 x i32> %tmp3
}

define <4 x i32> @sub4x32(<4 x i32> %A, <4 x i32> %B) {
; CHECK-LABEL: sub4x32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
	%tmp3 = sub <4 x i32> %A, %B;
	ret <4 x i32> %tmp3
}

define <2 x i64> @sub2xi64(<2 x i64> %A, <2 x i64> %B) {
; CHECK-LABEL: sub2xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
	%tmp3 = sub <2 x i64> %A, %B;
	ret <2 x i64> %tmp3
}

define <2 x float> @sub2xfloat(<2 x float> %A, <2 x float> %B) {
; CHECK-LABEL: sub2xfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsub v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
	%tmp3 = fsub <2 x float> %A, %B;
	ret <2 x float> %tmp3
}

define <4 x float> @sub4xfloat(<4 x float> %A, <4 x float> %B) {
; CHECK-LABEL: sub4xfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
	%tmp3 = fsub <4 x float> %A, %B;
	ret <4 x float> %tmp3
}
define <2 x double> @sub2xdouble(<2 x double> %A, <2 x double> %B) {
; CHECK-LABEL: sub2xdouble:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsub v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
	%tmp3 = fsub <2 x double> %A, %B;
	ret <2 x double> %tmp3
}

define <1 x double> @test_vadd_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vadd_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd d0, d0, d1
; CHECK-NEXT:    ret
  %1 = fadd <1 x double> %a, %b
  ret <1 x double> %1
}

define <1 x double> @test_vmul_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vmul_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %1 = fmul <1 x double> %a, %b
  ret <1 x double> %1
}

define <1 x double> @test_vdiv_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vdiv_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fdiv d0, d0, d1
; CHECK-NEXT:    ret
  %1 = fdiv <1 x double> %a, %b
  ret <1 x double> %1
}

define <1 x double> @test_vmla_f64(<1 x double> %a, <1 x double> %b, <1 x double> %c) {
; CHECK-LABEL: test_vmla_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmul d1, d1, d2
; CHECK-NEXT:    fadd d0, d1, d0
; CHECK-NEXT:    ret
  %1 = fmul <1 x double> %b, %c
  %2 = fadd <1 x double> %1, %a
  ret <1 x double> %2
}

define <1 x double> @test_vmls_f64(<1 x double> %a, <1 x double> %b, <1 x double> %c) {
; CHECK-LABEL: test_vmls_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmul d1, d1, d2
; CHECK-NEXT:    fsub d0, d0, d1
; CHECK-NEXT:    ret
  %1 = fmul <1 x double> %b, %c
  %2 = fsub <1 x double> %a, %1
  ret <1 x double> %2
}

define <1 x double> @test_vfms_f64(<1 x double> %a, <1 x double> %b, <1 x double> %c) {
; CHECK-LABEL: test_vfms_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmsub d0, d1, d2, d0
; CHECK-NEXT:    ret
  %1 = fsub <1 x double> <double -0.000000e+00>, %b
  %2 = tail call <1 x double> @llvm.fma.v1f64(<1 x double> %1, <1 x double> %c, <1 x double> %a)
  ret <1 x double> %2
}

define <1 x double> @test_vfma_f64(<1 x double> %a, <1 x double> %b, <1 x double> %c) {
; CHECK-LABEL: test_vfma_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmadd d0, d1, d2, d0
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.fma.v1f64(<1 x double> %b, <1 x double> %c, <1 x double> %a)
  ret <1 x double> %1
}

define <1 x double> @test_vsub_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vsub_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsub d0, d0, d1
; CHECK-NEXT:    ret
  %1 = fsub <1 x double> %a, %b
  ret <1 x double> %1
}

define <1 x double> @test_vabd_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vabd_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fabd d0, d0, d1
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.aarch64.neon.fabd.v1f64(<1 x double> %a, <1 x double> %b)
  ret <1 x double> %1
}

define <1 x double> @test_vmax_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vmax_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmax d0, d0, d1
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.aarch64.neon.fmax.v1f64(<1 x double> %a, <1 x double> %b)
  ret <1 x double> %1
}

define <1 x double> @test_vmin_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vmin_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmin d0, d0, d1
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.aarch64.neon.fmin.v1f64(<1 x double> %a, <1 x double> %b)
  ret <1 x double> %1
}

define <1 x double> @test_vmaxnm_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vmaxnm_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.aarch64.neon.fmaxnm.v1f64(<1 x double> %a, <1 x double> %b)
  ret <1 x double> %1
}

define <1 x double> @test_vminnm_f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: test_vminnm_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.aarch64.neon.fminnm.v1f64(<1 x double> %a, <1 x double> %b)
  ret <1 x double> %1
}

define <1 x double> @test_vabs_f64(<1 x double> %a) {
; CHECK-LABEL: test_vabs_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fabs d0, d0
; CHECK-NEXT:    ret
  %1 = tail call <1 x double> @llvm.fabs.v1f64(<1 x double> %a)
  ret <1 x double> %1
}

define <1 x double> @test_vneg_f64(<1 x double> %a) {
; CHECK-LABEL: test_vneg_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fneg d0, d0
; CHECK-NEXT:    ret
  %1 = fsub <1 x double> <double -0.000000e+00>, %a
  ret <1 x double> %1
}

declare <1 x double> @llvm.fabs.v1f64(<1 x double>)
declare <1 x double> @llvm.aarch64.neon.fminnm.v1f64(<1 x double>, <1 x double>)
declare <1 x double> @llvm.aarch64.neon.fmaxnm.v1f64(<1 x double>, <1 x double>)
declare <1 x double> @llvm.aarch64.neon.fmin.v1f64(<1 x double>, <1 x double>)
declare <1 x double> @llvm.aarch64.neon.fmax.v1f64(<1 x double>, <1 x double>)
declare <1 x double> @llvm.aarch64.neon.fabd.v1f64(<1 x double>, <1 x double>)
declare <1 x double> @llvm.fma.v1f64(<1 x double>, <1 x double>, <1 x double>)

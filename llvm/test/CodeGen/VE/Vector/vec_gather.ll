; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu | FileCheck %s

declare <256 x double> @llvm.masked.gather.v256f64.v256p0(<256 x ptr> %0, i32 immarg %1, <256 x i1> %2, <256 x double> %3) #0

; Function Attrs: nounwind
define fastcc <256 x double> @vec_mgather_v256f64(<256 x ptr> %P, <256 x i1> %M) {
; CHECK-LABEL: vec_mgather_v256f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgt %v0, %v0, 0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x double> @llvm.masked.gather.v256f64.v256p0(<256 x ptr> %P, i32 4, <256 x i1> %M, <256 x double> undef)
  ret <256 x double> %r
}

; Function Attrs: nounwind
define fastcc <256 x double> @vec_mgather_pt_v256f64(<256 x ptr> %P, <256 x double> %PT, <256 x i1> %M) {
; CHECK-LABEL: vec_mgather_pt_v256f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgt %v2, %v0, 0, 0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmrg %v0, %v1, %v2, %vm0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x double> @llvm.masked.gather.v256f64.v256p0(<256 x ptr> %P, i32 4, <256 x i1> %M, <256 x double> %PT)
  ret <256 x double> %r
}


declare <256 x float> @llvm.masked.gather.v256f32.v256p0(<256 x ptr> %0, i32 immarg %1, <256 x i1> %2, <256 x float> %3) #0

; Function Attrs: nounwind
define fastcc <256 x float> @vec_mgather_v256f32(<256 x ptr> %P, <256 x i1> %M) {
; CHECK-LABEL: vec_mgather_v256f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgtu %v0, %v0, 0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x float> @llvm.masked.gather.v256f32.v256p0(<256 x ptr> %P, i32 4, <256 x i1> %M, <256 x float> undef)
  ret <256 x float> %r
}

; Function Attrs: nounwind
define fastcc <256 x float> @vec_mgather_pt_v256f32(<256 x ptr> %P, <256 x float> %PT, <256 x i1> %M) {
; CHECK-LABEL: vec_mgather_pt_v256f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgtu %v2, %v0, 0, 0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmrg %v0, %v1, %v2, %vm0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x float> @llvm.masked.gather.v256f32.v256p0(<256 x ptr> %P, i32 4, <256 x i1> %M, <256 x float> %PT)
  ret <256 x float> %r
}


declare <256 x i32> @llvm.masked.gather.v256i32.v256p0(<256 x ptr> %0, i32 immarg %1, <256 x i1> %2, <256 x i32> %3) #0

; Function Attrs: nounwind
define fastcc <256 x i32> @vec_mgather_v256i32(<256 x ptr> %P, <256 x i1> %M) {
; CHECK-LABEL: vec_mgather_v256i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgtl.zx %v0, %v0, 0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x i32> @llvm.masked.gather.v256i32.v256p0(<256 x ptr> %P, i32 4, <256 x i1> %M, <256 x i32> undef)
  ret <256 x i32> %r
}

; Function Attrs: nounwind
define fastcc <256 x i32> @vec_mgather_pt_v256i32(<256 x ptr> %P, <256 x i32> %PT, <256 x i1> %M) {
; CHECK-LABEL: vec_mgather_pt_v256i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgtl.zx %v2, %v0, 0, 0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmrg %v0, %v1, %v2, %vm0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x i32> @llvm.masked.gather.v256i32.v256p0(<256 x ptr> %P, i32 4, <256 x i1> %M, <256 x i32> %PT)
  ret <256 x i32> %r
}

attributes #0 = { argmemonly nounwind readonly willreturn }

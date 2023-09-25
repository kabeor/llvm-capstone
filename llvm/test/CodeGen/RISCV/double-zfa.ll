; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi ilp32d -mattr=+experimental-zfa,+d < %s \
; RUN:     | FileCheck --check-prefixes=CHECK,RV32IDZFA %s
; RUN: llc -mtriple=riscv64 -target-abi lp64d -mattr=+experimental-zfa,+d < %s \
; RUN:     | FileCheck --check-prefixes=CHECK,RV64DZFA %s

define double @loadfpimm1() {
; CHECK-LABEL: loadfpimm1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, 0.0625
; CHECK-NEXT:    ret
  ret double 0.0625
}

define double @loadfpimm2() {
; CHECK-LABEL: loadfpimm2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, 0.75
; CHECK-NEXT:    ret
  ret double 0.75
}

define double @loadfpimm3() {
; CHECK-LABEL: loadfpimm3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, 1.25
; CHECK-NEXT:    ret
  ret double 1.25
}

define double @loadfpimm4() {
; CHECK-LABEL: loadfpimm4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, 3.0
; CHECK-NEXT:    ret
  ret double 3.0
}

define double @loadfpimm5() {
; CHECK-LABEL: loadfpimm5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, 256.0
; CHECK-NEXT:    ret
  ret double 256.0
}

define double @loadfpimm6() {
; CHECK-LABEL: loadfpimm6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, inf
; CHECK-NEXT:    ret
  ret double 0x7FF0000000000000
}

define double @loadfpimm7() {
; CHECK-LABEL: loadfpimm7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, nan
; CHECK-NEXT:    ret
  ret double 0x7FF8000000000000
}

define double @loadfpimm8() {
; CHECK-LABEL: loadfpimm8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fli.d fa0, min
; CHECK-NEXT:    ret
  ret double 0x0010000000000000
}

define double @loadfpimm9() {
; CHECK-LABEL: loadfpimm9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI8_0)
; CHECK-NEXT:    fld fa0, %lo(.LCPI8_0)(a0)
; CHECK-NEXT:    ret
  ret double 255.0
}

; Negative test. This is 1 * 2^256.
define double @loadfpimm10() {
; CHECK-LABEL: loadfpimm10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI9_0)
; CHECK-NEXT:    fld fa0, %lo(.LCPI9_0)(a0)
; CHECK-NEXT:    ret
  ret double 0x1000000000000000
}

; Negative test. This is a qnan with payload of 1.
define double @loadfpimm11() {
; CHECK-LABEL: loadfpimm11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI10_0)
; CHECK-NEXT:    fld fa0, %lo(.LCPI10_0)(a0)
; CHECK-NEXT:    ret
  ret double 0x7ff8000000000001
}

; Negative test. This is an snan with payload of 1.
define double @loadfpimm12() {
; CHECK-LABEL: loadfpimm12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI11_0)
; CHECK-NEXT:    fld fa0, %lo(.LCPI11_0)(a0)
; CHECK-NEXT:    ret
  ret double 0x7ff0000000000001
}

; Negative test. This is the smallest denormal.
define double @loadfpimm13() {
; RV32IDZFA-LABEL: loadfpimm13:
; RV32IDZFA:       # %bb.0:
; RV32IDZFA-NEXT:    lui a0, %hi(.LCPI12_0)
; RV32IDZFA-NEXT:    fld fa0, %lo(.LCPI12_0)(a0)
; RV32IDZFA-NEXT:    ret
;
; RV64DZFA-LABEL: loadfpimm13:
; RV64DZFA:       # %bb.0:
; RV64DZFA-NEXT:    li a0, 1
; RV64DZFA-NEXT:    fmv.d.x fa0, a0
; RV64DZFA-NEXT:    ret
  ret double 0x0000000000000001
}

; Negative test. This is 2^-1023, a denormal.
define double @loadfpimm15() {
; CHECK-LABEL: loadfpimm15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI13_0)
; CHECK-NEXT:    fld fa0, %lo(.LCPI13_0)(a0)
; CHECK-NEXT:    ret
  ret double 0x0008000000000000
}

declare double @llvm.minimum.f64(double, double)

define double @fminm_d(double %a, double %b) nounwind {
; CHECK-LABEL: fminm_d:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fminm.d fa0, fa0, fa1
; CHECK-NEXT:    ret
  %1 = call double @llvm.minimum.f64(double %a, double %b)
  ret double %1
}

declare double @llvm.maximum.f64(double, double)

define double @fmaxm_d(double %a, double %b) nounwind {
; CHECK-LABEL: fmaxm_d:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmaxm.d fa0, fa0, fa1
; CHECK-NEXT:    ret
  %1 = call double @llvm.maximum.f64(double %a, double %b)
  ret double %1
}

define double @fround_d_1(double %a) nounwind {
; CHECK-LABEL: fround_d_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.d fa0, fa0, rmm
; CHECK-NEXT:    ret
  %call = tail call double @round(double %a) nounwind readnone
  ret double %call
}

declare double @round(double) nounwind readnone


define double @fround_d_2(double %a) nounwind {
; CHECK-LABEL: fround_d_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.d fa0, fa0, rdn
; CHECK-NEXT:    ret
  %call = tail call double @floor(double %a) nounwind readnone
  ret double %call
}

declare double @floor(double) nounwind readnone


define double @fround_d_3(double %a) nounwind {
; CHECK-LABEL: fround_d_3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.d fa0, fa0, rup
; CHECK-NEXT:    ret
  %call = tail call double @ceil(double %a) nounwind readnone
  ret double %call
}

declare double @ceil(double) nounwind readnone


define double @fround_d_4(double %a) nounwind {
; CHECK-LABEL: fround_d_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.d fa0, fa0, rtz
; CHECK-NEXT:    ret
  %call = tail call double @trunc(double %a) nounwind readnone
  ret double %call
}

declare double @trunc(double) nounwind readnone


define double @fround_d_5(double %a) nounwind {
; CHECK-LABEL: fround_d_5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.d fa0, fa0
; CHECK-NEXT:    ret
  %call = tail call double @nearbyint(double %a) nounwind readnone
  ret double %call
}

declare double @nearbyint(double) nounwind readnone


define double @froundnx_d(double %a) nounwind {
; CHECK-LABEL: froundnx_d:
; CHECK:       # %bb.0:
; CHECK-NEXT:    froundnx.d fa0, fa0
; CHECK-NEXT:    ret
  %call = tail call double @rint(double %a) nounwind readnone
  ret double %call
}

declare double @rint(double) nounwind readnone

declare i1 @llvm.experimental.constrained.fcmp.f64(double, double, metadata, metadata)

define i32 @fcmp_olt_q(double %a, double %b) nounwind strictfp {
; CHECK-LABEL: fcmp_olt_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fltq.d a0, fa0, fa1
; CHECK-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"olt", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ole_q(double %a, double %b) nounwind strictfp {
; CHECK-LABEL: fcmp_ole_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fleq.d a0, fa0, fa1
; CHECK-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"ole", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_one_q(double %a, double %b) nounwind strictfp {
; CHECK-LABEL: fcmp_one_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fltq.d a0, fa0, fa1
; CHECK-NEXT:    fltq.d a1, fa1, fa0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"one", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ueq_q(double %a, double %b) nounwind strictfp {
; CHECK-LABEL: fcmp_ueq_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fltq.d a0, fa0, fa1
; CHECK-NEXT:    fltq.d a1, fa1, fa0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    xori a0, a0, 1
; CHECK-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"ueq", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i64 @fmvh_x_d(double %fa) {
; RV32IDZFA-LABEL: fmvh_x_d:
; RV32IDZFA:       # %bb.0:
; RV32IDZFA-NEXT:    fmv.x.w a0, fa0
; RV32IDZFA-NEXT:    fmvh.x.d a1, fa0
; RV32IDZFA-NEXT:    ret
;
; RV64DZFA-LABEL: fmvh_x_d:
; RV64DZFA:       # %bb.0:
; RV64DZFA-NEXT:    fmv.x.d a0, fa0
; RV64DZFA-NEXT:    ret
  %i = bitcast double %fa to i64
  ret i64 %i
}

define double @fmvp_d_x(i64 %a) {
; RV32IDZFA-LABEL: fmvp_d_x:
; RV32IDZFA:       # %bb.0:
; RV32IDZFA-NEXT:    fmvp.d.x fa0, a0, a1
; RV32IDZFA-NEXT:    ret
;
; RV64DZFA-LABEL: fmvp_d_x:
; RV64DZFA:       # %bb.0:
; RV64DZFA-NEXT:    fmv.d.x fa0, a0
; RV64DZFA-NEXT:    ret
  %or = bitcast i64 %a to double
  ret double %or
}

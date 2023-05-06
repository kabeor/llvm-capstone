; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs \
; RUN:   -disable-strictnode-mutation -target-abi ilp32f < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -disable-strictnode-mutation -target-abi lp64f < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -disable-strictnode-mutation -target-abi ilp32f < %s \
; RUN:   | FileCheck -check-prefix=CHECK-ZFHMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -disable-strictnode-mutation -target-abi lp64f < %s \
; RUN:  | FileCheck -check-prefix=CHECK-ZFHMIN %s

; FIXME: We can't test without Zfh because soft promote legalization isn't
; implemented in SelectionDAG for STRICT nodes.

define half @fadd_h(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fadd_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.h fa0, fa0, fa1
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fadd_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa0
; CHECK-ZFHMIN-NEXT:    fadd.s ft0, ft1, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.fadd.f16(half %a, half %b, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.fadd.f16(half, half, metadata, metadata)

define half @fsub_h(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fsub_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.h fa0, fa0, fa1
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fsub_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa0
; CHECK-ZFHMIN-NEXT:    fsub.s ft0, ft1, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.fsub.f16(half %a, half %b, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.fsub.f16(half, half, metadata, metadata)

define half @fmul_h(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fmul_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.h fa0, fa0, fa1
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fmul_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa0
; CHECK-ZFHMIN-NEXT:    fmul.s ft0, ft1, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.fmul.f16(half %a, half %b, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.fmul.f16(half, half, metadata, metadata)

define half @fdiv_h(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fdiv_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.h fa0, fa0, fa1
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fdiv_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa0
; CHECK-ZFHMIN-NEXT:    fdiv.s ft0, ft1, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.fdiv.f16(half %a, half %b, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.fdiv.f16(half, half, metadata, metadata)

define half @fsqrt_h(half %a) nounwind strictfp {
; CHECK-LABEL: fsqrt_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsqrt.h fa0, fa0
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fsqrt_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa0
; CHECK-ZFHMIN-NEXT:    fsqrt.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.sqrt.f16(half %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.sqrt.f16(half, metadata, metadata)

; FIXME: fminnum/fmaxnum need libcalls to handle SNaN, but we don't have f16
; libcalls and don't support promotion yet.
;define half @fmin_h(half %a, half %b) nounwind strictfp {
;  %1 = call half @llvm.experimental.constrained.minnum.f16(half %a, half %b, metadata !"fpexcept.strict") strictfp
;  ret half %1
;}
;declare half @llvm.experimental.constrained.minnum.f16(half, half, metadata) strictfp
;
;define half @fmax_h(half %a, half %b) nounwind strictfp {
;  %1 = call half @llvm.experimental.constrained.maxnum.f16(half %a, half %b, metadata !"fpexcept.strict") strictfp
;  ret half %1
;}
;declare half @llvm.experimental.constrained.maxnum.f16(half, half, metadata) strictfp

define half @fmadd_h(half %a, half %b, half %c) nounwind strictfp {
; CHECK-LABEL: fmadd_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmadd.h fa0, fa0, fa1, fa2
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fmadd_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa2
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa0
; CHECK-ZFHMIN-NEXT:    fmadd.s ft0, ft2, ft1, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.fma.f16(half %a, half %b, half %c, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.fma.f16(half, half, half, metadata, metadata) strictfp

define half @fmsub_h(half %a, half %b, half %c) nounwind strictfp {
; CHECK-LABEL: fmsub_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x ft0, zero
; CHECK-NEXT:    fadd.h ft0, fa2, ft0
; CHECK-NEXT:    fmsub.h fa0, fa0, fa1, ft0
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fmsub_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa2
; CHECK-ZFHMIN-NEXT:    fmv.w.x ft1, zero
; CHECK-ZFHMIN-NEXT:    fadd.s ft0, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fneg.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa0
; CHECK-ZFHMIN-NEXT:    fmadd.s ft0, ft2, ft1, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %c_ = fadd half 0.0, %c ; avoid negation using xor
  %negc = fneg half %c_
  %1 = call half @llvm.experimental.constrained.fma.f16(half %a, half %b, half %negc, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @fnmadd_h(half %a, half %b, half %c) nounwind strictfp {
; CHECK-LABEL: fnmadd_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x ft0, zero
; CHECK-NEXT:    fadd.h ft1, fa0, ft0
; CHECK-NEXT:    fadd.h ft0, fa2, ft0
; CHECK-NEXT:    fnmadd.h fa0, ft1, fa1, ft0
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fnmadd_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa0
; CHECK-ZFHMIN-NEXT:    fmv.w.x ft1, zero
; CHECK-ZFHMIN-NEXT:    fadd.s ft0, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa2
; CHECK-ZFHMIN-NEXT:    fadd.s ft1, ft2, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fneg.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, ft1
; CHECK-ZFHMIN-NEXT:    fneg.s ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa1
; CHECK-ZFHMIN-NEXT:    fmadd.s ft0, ft0, ft2, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %a_ = fadd half 0.0, %a
  %c_ = fadd half 0.0, %c
  %nega = fneg half %a_
  %negc = fneg half %c_
  %1 = call half @llvm.experimental.constrained.fma.f16(half %nega, half %b, half %negc, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @fnmadd_h_2(half %a, half %b, half %c) nounwind strictfp {
; CHECK-LABEL: fnmadd_h_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x ft0, zero
; CHECK-NEXT:    fadd.h ft1, fa1, ft0
; CHECK-NEXT:    fadd.h ft0, fa2, ft0
; CHECK-NEXT:    fnmadd.h fa0, ft1, fa0, ft0
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fnmadd_h_2:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa1
; CHECK-ZFHMIN-NEXT:    fmv.w.x ft1, zero
; CHECK-ZFHMIN-NEXT:    fadd.s ft0, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa2
; CHECK-ZFHMIN-NEXT:    fadd.s ft1, ft2, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fneg.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, ft1
; CHECK-ZFHMIN-NEXT:    fneg.s ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa0
; CHECK-ZFHMIN-NEXT:    fmadd.s ft0, ft2, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %b_ = fadd half 0.0, %b
  %c_ = fadd half 0.0, %c
  %negb = fneg half %b_
  %negc = fneg half %c_
  %1 = call half @llvm.experimental.constrained.fma.f16(half %a, half %negb, half %negc, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @fnmsub_h(half %a, half %b, half %c) nounwind strictfp {
; CHECK-LABEL: fnmsub_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x ft0, zero
; CHECK-NEXT:    fadd.h ft0, fa0, ft0
; CHECK-NEXT:    fnmsub.h fa0, ft0, fa1, fa2
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fnmsub_h:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa0
; CHECK-ZFHMIN-NEXT:    fmv.w.x ft1, zero
; CHECK-ZFHMIN-NEXT:    fadd.s ft0, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fneg.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa2
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa1
; CHECK-ZFHMIN-NEXT:    fmadd.s ft0, ft0, ft2, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %a_ = fadd half 0.0, %a
  %nega = fneg half %a_
  %1 = call half @llvm.experimental.constrained.fma.f16(half %nega, half %b, half %c, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @fnmsub_h_2(half %a, half %b, half %c) nounwind strictfp {
; CHECK-LABEL: fnmsub_h_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x ft0, zero
; CHECK-NEXT:    fadd.h ft0, fa1, ft0
; CHECK-NEXT:    fnmsub.h fa0, ft0, fa0, fa2
; CHECK-NEXT:    ret
;
; CHECK-ZFHMIN-LABEL: fnmsub_h_2:
; CHECK-ZFHMIN:       # %bb.0:
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, fa1
; CHECK-ZFHMIN-NEXT:    fmv.w.x ft1, zero
; CHECK-ZFHMIN-NEXT:    fadd.s ft0, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fneg.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.h.s ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft0, ft0
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft1, fa2
; CHECK-ZFHMIN-NEXT:    fcvt.s.h ft2, fa0
; CHECK-ZFHMIN-NEXT:    fmadd.s ft0, ft2, ft0, ft1
; CHECK-ZFHMIN-NEXT:    fcvt.h.s fa0, ft0
; CHECK-ZFHMIN-NEXT:    ret
  %b_ = fadd half 0.0, %b
  %negb = fneg half %b_
  %1 = call half @llvm.experimental.constrained.fma.f16(half %a, half %negb, half %c, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

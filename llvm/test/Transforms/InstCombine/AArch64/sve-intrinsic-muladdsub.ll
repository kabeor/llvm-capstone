; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

define <vscale x 8 x half> @combine_fmla(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @combine_fmla(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call fast <vscale x 8 x half> @llvm.aarch64.sve.fmla.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[C:%.*]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
;
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %c, <vscale x 8 x half> %2)
  ret <vscale x 8 x half> %3
}

define <vscale x 16 x i8> @combine_mla_i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) #0 {
; CHECK-LABEL: @combine_mla_i8(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.mla.nxv16i8(<vscale x 16 x i1> [[P:%.*]], <vscale x 16 x i8> [[C:%.*]], <vscale x 16 x i8> [[A:%.*]], <vscale x 16 x i8> [[B:%.*]])
; CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
;
  %1 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
  %2 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %c, <vscale x 16 x i8> %1)
  ret <vscale x 16 x i8> %2
}

define <vscale x 8 x half> @combine_fmad(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @combine_fmad(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call fast <vscale x 8 x half> @llvm.aarch64.sve.fmad.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]], <vscale x 8 x half> [[C:%.*]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
;
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %2, <vscale x 8 x half> %c)
  ret <vscale x 8 x half> %3
}

define <vscale x 16 x i8> @combine_mad_i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) #0 {
; CHECK-LABEL: @combine_mad_i8(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.mad.nxv16i8(<vscale x 16 x i1> [[P:%.*]], <vscale x 16 x i8> [[A:%.*]], <vscale x 16 x i8> [[B:%.*]], <vscale x 16 x i8> [[C:%.*]])
; CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
;
  %1 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
  %2 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %1, <vscale x 16 x i8> %c)
  ret <vscale x 16 x i8> %2
}

define <vscale x 8 x half> @combine_fmls(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @combine_fmls(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call fast <vscale x 8 x half> @llvm.aarch64.sve.fmls.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[C:%.*]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
;
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fsub.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %c, <vscale x 8 x half> %2)
  ret <vscale x 8 x half> %3
}

define <vscale x 16 x i8> @combine_mls_i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) #0 {
; CHECK-LABEL: @combine_mls_i8(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.mls.nxv16i8(<vscale x 16 x i1> [[P:%.*]], <vscale x 16 x i8> [[C:%.*]], <vscale x 16 x i8> [[A:%.*]], <vscale x 16 x i8> [[B:%.*]])
; CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
;
  %1 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
  %2 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %c, <vscale x 16 x i8> %1)
  ret <vscale x 16 x i8> %2
}

define <vscale x 8 x half> @combine_fnmsb(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @combine_fnmsb(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call fast <vscale x 8 x half> @llvm.aarch64.sve.fnmsb.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]], <vscale x 8 x half> [[C:%.*]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
;
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fsub.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %2, <vscale x 8 x half> %c)
  ret <vscale x 8 x half> %3
}

; No integer variant of fnmsb exists; Do not combine
define <vscale x 16 x i8> @neg_combine_nmsb_i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) #0 {
; CHECK-LABEL: @neg_combine_nmsb_i8(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<vscale x 16 x i1> [[P:%.*]], <vscale x 16 x i8> [[A:%.*]], <vscale x 16 x i8> [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<vscale x 16 x i1> [[P]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[C:%.*]])
; CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
;
  %1 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
  %2 = tail call <vscale x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<vscale x 16 x i1> %p, <vscale x 16 x i8> %1, <vscale x 16 x i8> %c)
  ret <vscale x 16 x i8> %2
}

define <vscale x 8 x half> @combine_fmla_contract_flag_only(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @combine_fmla_contract_flag_only(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call contract <vscale x 8 x half> @llvm.aarch64.sve.fmla.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[C:%.*]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
;
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call contract <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call contract <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %c, <vscale x 8 x half> %2)
  ret <vscale x 8 x half> %3
}

define <vscale x 8 x half> @neg_combine_fmla_no_flags(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @neg_combine_fmla_no_flags(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[C:%.*]], <vscale x 8 x half> [[TMP2]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP3]]
;
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %c, <vscale x 8 x half> %2)
  ret <vscale x 8 x half> %3
}

define <vscale x 8 x half> @neg_combine_fmla_neq_pred(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @neg_combine_fmla_neq_pred(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 5)
; CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]])
; CHECK-NEXT:    [[TMP5:%.*]] = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> [[TMP3]], <vscale x 8 x half> [[C:%.*]], <vscale x 8 x half> [[TMP4]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP5]]
;
; ret <vscale x 8 x half> %9
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 5)
  %3 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %2)
  %4 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %5 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %3, <vscale x 8 x half> %c, <vscale x 8 x half> %4)
  ret <vscale x 8 x half> %5
}

define <vscale x 8 x half> @neg_combine_fmla_two_fmul_uses(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @neg_combine_fmla_two_fmul_uses(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[B:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[C:%.*]], <vscale x 8 x half> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[TMP3]], <vscale x 8 x half> [[TMP2]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP4]]
;
; ret <vscale x 8 x half> %8
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %b)
  %3 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %c, <vscale x 8 x half> %2)
  %4 = tail call fast <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %3, <vscale x 8 x half> %2)
  ret <vscale x 8 x half> %4
}

define <vscale x 8 x half> @neg_combine_fmla_neq_flags(<vscale x 16 x i1> %p, <vscale x 8 x half> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c) #0 {
; CHECK-LABEL: @neg_combine_fmla_neq_flags(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[P:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call reassoc nnan contract <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[B:%.*]], <vscale x 8 x half> [[C:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = tail call reassoc contract <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[A:%.*]], <vscale x 8 x half> [[TMP2]])
; CHECK-NEXT:    ret <vscale x 8 x half> [[TMP3]]
;
; ret <vscale x 8 x half> %7
  %1 = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %p)
  %2 = tail call reassoc nnan contract <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %b, <vscale x 8 x half> %c)
  %3 = tail call reassoc contract <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1> %1, <vscale x 8 x half> %a, <vscale x 8 x half> %2)
  ret <vscale x 8 x half> %3
}

declare <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1>)
declare <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1>)
declare <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1>)
declare <vscale x 8 x half> @llvm.aarch64.sve.fmul.nxv8f16(<vscale x 8 x i1>, <vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 8 x half> @llvm.aarch64.sve.fadd.nxv8f16(<vscale x 8 x i1>, <vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 8 x half> @llvm.aarch64.sve.fsub.nxv8f16(<vscale x 8 x i1>, <vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)

attributes #0 = { "target-features"="+sve" }

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I

define i8 @sext_i1_to_i8(i1 %a) nounwind {
; RV32I-LABEL: sext_i1_to_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 31
; RV32I-NEXT:    srai a0, a0, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i1_to_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 63
; RV64I-NEXT:    srai a0, a0, 63
; RV64I-NEXT:    ret
  %1 = sext i1 %a to i8
  ret i8 %1
}

define i16 @sext_i1_to_i16(i1 %a) nounwind {
; RV32I-LABEL: sext_i1_to_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 31
; RV32I-NEXT:    srai a0, a0, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i1_to_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 63
; RV64I-NEXT:    srai a0, a0, 63
; RV64I-NEXT:    ret
  %1 = sext i1 %a to i16
  ret i16 %1
}

define i32 @sext_i1_to_i32(i1 %a) nounwind {
; RV32I-LABEL: sext_i1_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 31
; RV32I-NEXT:    srai a0, a0, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i1_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 63
; RV64I-NEXT:    srai a0, a0, 63
; RV64I-NEXT:    ret
  %1 = sext i1 %a to i32
  ret i32 %1
}

define i64 @sext_i1_to_i64(i1 %a) nounwind {
; RV32I-LABEL: sext_i1_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 31
; RV32I-NEXT:    srai a0, a0, 31
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i1_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 63
; RV64I-NEXT:    srai a0, a0, 63
; RV64I-NEXT:    ret
  %1 = sext i1 %a to i64
  ret i64 %1
}

define i16 @sext_i8_to_i16(i8 %a) nounwind {
; RV32I-LABEL: sext_i8_to_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i8_to_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    ret
  %1 = sext i8 %a to i16
  ret i16 %1
}

define i32 @sext_i8_to_i32(i8 %a) nounwind {
; RV32I-LABEL: sext_i8_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i8_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    ret
  %1 = sext i8 %a to i32
  ret i32 %1
}

define i64 @sext_i8_to_i64(i8 %a) nounwind {
; RV32I-LABEL: sext_i8_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srai a0, a1, 24
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i8_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    ret
  %1 = sext i8 %a to i64
  ret i64 %1
}

define i32 @sext_i16_to_i32(i16 %a) nounwind {
; RV32I-LABEL: sext_i16_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i16_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    ret
  %1 = sext i16 %a to i32
  ret i32 %1
}

define i64 @sext_i16_to_i64(i16 %a) nounwind {
; RV32I-LABEL: sext_i16_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    srai a0, a1, 16
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i16_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    ret
  %1 = sext i16 %a to i64
  ret i64 %1
}

define i64 @sext_i32_to_i64(i32 %a) nounwind {
; RV32I-LABEL: sext_i32_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_i32_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    ret
  %1 = sext i32 %a to i64
  ret i64 %1
}

define i8 @zext_i1_to_i8(i1 %a) nounwind {
; RV32I-LABEL: zext_i1_to_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i1_to_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %1 = zext i1 %a to i8
  ret i8 %1
}

define i16 @zext_i1_to_i16(i1 %a) nounwind {
; RV32I-LABEL: zext_i1_to_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i1_to_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %1 = zext i1 %a to i16
  ret i16 %1
}

define i32 @zext_i1_to_i32(i1 %a) nounwind {
; RV32I-LABEL: zext_i1_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i1_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %1 = zext i1 %a to i32
  ret i32 %1
}

define i64 @zext_i1_to_i64(i1 %a) nounwind {
; RV32I-LABEL: zext_i1_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i1_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %1 = zext i1 %a to i64
  ret i64 %1
}

define i16 @zext_i8_to_i16(i8 %a) nounwind {
; RV32I-LABEL: zext_i8_to_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i8_to_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    ret
  %1 = zext i8 %a to i16
  ret i16 %1
}

define i32 @zext_i8_to_i32(i8 %a) nounwind {
; RV32I-LABEL: zext_i8_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i8_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    ret
  %1 = zext i8 %a to i32
  ret i32 %1
}

define i64 @zext_i8_to_i64(i8 %a) nounwind {
; RV32I-LABEL: zext_i8_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i8_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    ret
  %1 = zext i8 %a to i64
  ret i64 %1
}

define i32 @zext_i16_to_i32(i16 %a) nounwind {
; RV32I-LABEL: zext_i16_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a0, a0, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i16_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:    ret
  %1 = zext i16 %a to i32
  ret i32 %1
}

define i64 @zext_i16_to_i64(i16 %a) nounwind {
; RV32I-LABEL: zext_i16_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a0, a0, 16
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i16_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:    ret
  %1 = zext i16 %a to i64
  ret i64 %1
}

define i64 @zext_i32_to_i64(i32 %a) nounwind {
; RV32I-LABEL: zext_i32_to_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: zext_i32_to_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    ret
  %1 = zext i32 %a to i64
  ret i64 %1
}

define i1 @trunc_i8_to_i1(i8 %a) nounwind {
; RV32I-LABEL: trunc_i8_to_i1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i8_to_i1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i8 %a to i1
  ret i1 %1
}

define i1 @trunc_i16_to_i1(i16 %a) nounwind {
; RV32I-LABEL: trunc_i16_to_i1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i16_to_i1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i16 %a to i1
  ret i1 %1
}

define i1 @trunc_i32_to_i1(i32 %a) nounwind {
; RV32I-LABEL: trunc_i32_to_i1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i32_to_i1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i32 %a to i1
  ret i1 %1
}

define i1 @trunc_i64_to_i1(i64 %a) nounwind {
; RV32I-LABEL: trunc_i64_to_i1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i64_to_i1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i64 %a to i1
  ret i1 %1
}

define i8 @trunc_i16_to_i8(i16 %a) nounwind {
; RV32I-LABEL: trunc_i16_to_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i16_to_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i16 %a to i8
  ret i8 %1
}

define i8 @trunc_i32_to_i8(i32 %a) nounwind {
; RV32I-LABEL: trunc_i32_to_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i32_to_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i32 %a to i8
  ret i8 %1
}

define i8 @trunc_i64_to_i8(i64 %a) nounwind {
; RV32I-LABEL: trunc_i64_to_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i64_to_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i64 %a to i8
  ret i8 %1
}

define i16 @trunc_i32_to_i16(i32 %a) nounwind {
; RV32I-LABEL: trunc_i32_to_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i32_to_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i32 %a to i16
  ret i16 %1
}

define i16 @trunc_i64_to_i16(i64 %a) nounwind {
; RV32I-LABEL: trunc_i64_to_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i64_to_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i64 %a to i16
  ret i16 %1
}

define i32 @trunc_i64_to_i32(i64 %a) nounwind {
; RV32I-LABEL: trunc_i64_to_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_i64_to_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ret
  %1 = trunc i64 %a to i32
  ret i32 %1
}

;; fold (sext (not x)) -> (add (zext x) -1)
define i32 @sext_of_not_i32(i1 %x) {
; RV32I-LABEL: sext_of_not_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_of_not_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret
  %xor = xor i1 %x, 1
  %sext = sext i1 %xor to i32
  ret i32 %sext
}

define i64 @sext_of_not_i64(i1 %x) {
; RV32I-LABEL: sext_of_not_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_of_not_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret
  %xor = xor i1 %x, 1
  %sext = sext i1 %xor to i64
  ret i64 %sext
}

;; fold (sext (not (setcc a, b, cc))) -> (sext (setcc a, b, !cc))
define i32 @sext_of_not_cmp_i32(i32 %x) {
; RV32I-LABEL: sext_of_not_cmp_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -7
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_of_not_cmp_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    addi a0, a0, -7
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret
  %cmp = icmp eq i32 %x, 7
  %xor = xor i1 %cmp, 1
  %sext = sext i1 %xor to i32
  ret i32 %sext
}

define i64 @sext_of_not_cmp_i64(i64 %x) {
; RV32I-LABEL: sext_of_not_cmp_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, 7
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sext_of_not_cmp_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -7
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret
  %cmp = icmp eq i64 %x, 7
  %xor = xor i1 %cmp, 1
  %sext = sext i1 %xor to i64
  ret i64 %sext
}

;; TODO: fold (add (zext (setcc a, b, cc)), -1) -> (sext (setcc a, b, !cc))
define i32 @dec_of_zexted_cmp_i32(i32 %x) {
; RV32I-LABEL: dec_of_zexted_cmp_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -7
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: dec_of_zexted_cmp_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    addi a0, a0, -7
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret
  %cmp = icmp eq i32 %x, 7
  %zext = zext i1 %cmp to i32
  %dec = sub i32 %zext, 1
  ret i32 %dec
}

define i64 @dec_of_zexted_cmp_i64(i64 %x) {
; RV32I-LABEL: dec_of_zexted_cmp_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, 7
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: dec_of_zexted_cmp_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -7
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret
  %cmp = icmp eq i64 %x, 7
  %zext = zext i1 %cmp to i64
  %dec = sub i64 %zext, 1
  ret i64 %dec
}

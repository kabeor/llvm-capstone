; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=s390x-linux-gnu | FileCheck %s

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i16 @llvm.fshl.i16(i16, i16, i16)
declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i64 @llvm.fshl.i64(i64, i64, i64)
declare i128 @llvm.fshl.i128(i128, i128, i128)

;
; Variable Funnel Shift
;

define i8 @var_shift_i8(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: var_shift_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $r3l killed $r3l def $r3d
; CHECK-NEXT:    # kill: def $r2l killed $r2l def $r2d
; CHECK-NEXT:    sll %r2, 8
; CHECK-NEXT:    rosbg %r2, %r3, 56, 63, 0
; CHECK-NEXT:    nill %r4, 7
; CHECK-NEXT:    sll %r2, 0(%r4)
; CHECK-NEXT:    srl %r2, 8
; CHECK-NEXT:    # kill: def $r2l killed $r2l killed $r2d
; CHECK-NEXT:    br %r14
  %tmp = tail call i8 @llvm.fshl.i8(i8 %x, i8 %y, i8 %z)
  ret i8 %tmp
}

define i16 @var_shift_i16(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: var_shift_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $r3l killed $r3l def $r3d
; CHECK-NEXT:    # kill: def $r2l killed $r2l def $r2d
; CHECK-NEXT:    sll %r2, 16
; CHECK-NEXT:    rosbg %r2, %r3, 48, 63, 0
; CHECK-NEXT:    nill %r4, 15
; CHECK-NEXT:    sll %r2, 0(%r4)
; CHECK-NEXT:    srl %r2, 16
; CHECK-NEXT:    # kill: def $r2l killed $r2l killed $r2d
; CHECK-NEXT:    br %r14
  %tmp = tail call i16 @llvm.fshl.i16(i16 %x, i16 %y, i16 %z)
  ret i16 %tmp
}

define i32 @var_shift_i32(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: var_shift_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lr %r1, %r4
; CHECK-NEXT:    nill %r1, 31
; CHECK-NEXT:    sll %r2, 0(%r1)
; CHECK-NEXT:    srl %r3, 1
; CHECK-NEXT:    xilf %r4, 4294967295
; CHECK-NEXT:    nill %r4, 31
; CHECK-NEXT:    srl %r3, 0(%r4)
; CHECK-NEXT:    or %r2, %r3
; CHECK-NEXT:    br %r14
  %tmp = tail call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 %z)
  ret i32 %tmp
}

define i64 @var_shift_i64(i64 %x, i64 %y, i64 %z) {
; CHECK-LABEL: var_shift_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sllg %r0, %r2, 0(%r4)
; CHECK-NEXT:    srlg %r1, %r3, 1
; CHECK-NEXT:    xilf %r4, 4294967295
; CHECK-NEXT:    srlg %r2, %r1, 0(%r4)
; CHECK-NEXT:    ogr %r2, %r0
; CHECK-NEXT:    br %r14
  %tmp = tail call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 %z)
  ret i64 %tmp
}

define i128 @var_shift_i128(i128 %x, i128 %y, i128 %z) {
; CHECK-LABEL: var_shift_i128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    stmg %r13, %r15, 104(%r15)
; CHECK-NEXT:    .cfi_offset %r13, -56
; CHECK-NEXT:    .cfi_offset %r14, -48
; CHECK-NEXT:    .cfi_offset %r15, -40
; CHECK-NEXT:    lg %r1, 8(%r5)
; CHECK-NEXT:    lg %r0, 0(%r4)
; CHECK-NEXT:    lg %r14, 8(%r3)
; CHECK-NEXT:    tmll %r1, 64
; CHECK-NEXT:    lgr %r13, %r0
; CHECK-NEXT:    jne .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    lgr %r13, %r14
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    sllg %r5, %r13, 0(%r1)
; CHECK-NEXT:    je .LBB4_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    lg %r0, 8(%r4)
; CHECK-NEXT:    j .LBB4_5
; CHECK-NEXT:  .LBB4_4:
; CHECK-NEXT:    lg %r14, 0(%r3)
; CHECK-NEXT:  .LBB4_5:
; CHECK-NEXT:    sllg %r3, %r14, 0(%r1)
; CHECK-NEXT:    srlg %r4, %r13, 1
; CHECK-NEXT:    xilf %r1, 4294967295
; CHECK-NEXT:    srlg %r4, %r4, 0(%r1)
; CHECK-NEXT:    ogr %r4, %r3
; CHECK-NEXT:    srlg %r0, %r0, 1
; CHECK-NEXT:    srlg %r0, %r0, 0(%r1)
; CHECK-NEXT:    ogr %r5, %r0
; CHECK-NEXT:    stg %r5, 8(%r2)
; CHECK-NEXT:    stg %r4, 0(%r2)
; CHECK-NEXT:    lmg %r13, %r15, 104(%r15)
; CHECK-NEXT:    br %r14
  %tmp = tail call i128 @llvm.fshl.i128(i128 %x, i128 %y, i128 %z)
  ret i128 %tmp
}

;
; Const Funnel Shift
;

define i8 @const_shift_i8(i8 %x, i8 %y) {
; CHECK-LABEL: const_shift_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $r3l killed $r3l def $r3d
; CHECK-NEXT:    # kill: def $r2l killed $r2l def $r2d
; CHECK-NEXT:    sll %r2, 7
; CHECK-NEXT:    rosbg %r2, %r3, 57, 63, 63
; CHECK-NEXT:    # kill: def $r2l killed $r2l killed $r2d
; CHECK-NEXT:    br %r14
  %tmp = tail call i8 @llvm.fshl.i8(i8 %x, i8 %y, i8 7)
  ret i8 %tmp
}

define i16 @const_shift_i16(i16 %x, i16 %y) {
; CHECK-LABEL: const_shift_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $r3l killed $r3l def $r3d
; CHECK-NEXT:    # kill: def $r2l killed $r2l def $r2d
; CHECK-NEXT:    sll %r2, 7
; CHECK-NEXT:    rosbg %r2, %r3, 57, 63, 55
; CHECK-NEXT:    # kill: def $r2l killed $r2l killed $r2d
; CHECK-NEXT:    br %r14
  %tmp = tail call i16 @llvm.fshl.i16(i16 %x, i16 %y, i16 7)
  ret i16 %tmp
}

define i32 @const_shift_i32(i32 %x, i32 %y) {
; CHECK-LABEL: const_shift_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $r3l killed $r3l def $r3d
; CHECK-NEXT:    # kill: def $r2l killed $r2l def $r2d
; CHECK-NEXT:    sll %r2, 7
; CHECK-NEXT:    rosbg %r2, %r3, 57, 63, 39
; CHECK-NEXT:    # kill: def $r2l killed $r2l killed $r2d
; CHECK-NEXT:    br %r14
  %tmp = tail call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 7)
  ret i32 %tmp
}

define i64 @const_shift_i64(i64 %x, i64 %y) {
; CHECK-LABEL: const_shift_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sllg %r2, %r2, 7
; CHECK-NEXT:    rosbg %r2, %r3, 57, 63, 7
; CHECK-NEXT:    br %r14
  %tmp = tail call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 7)
  ret i64 %tmp
}

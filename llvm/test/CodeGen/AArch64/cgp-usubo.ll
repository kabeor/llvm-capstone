; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

; CodeGenPrepare is expected to form overflow intrinsics to improve DAG/isel.

define i1 @usubo_ult_i64(i64 %x, i64 %y, ptr %p) nounwind {
; CHECK-LABEL: usubo_ult_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x0, x1
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    str x8, [x2]
; CHECK-NEXT:    ret
  %s = sub i64 %x, %y
  store i64 %s, ptr %p
  %ov = icmp ult i64 %x, %y
  ret i1 %ov
}

; Verify insertion point for single-BB. Toggle predicate.

define i1 @usubo_ugt_i32(i32 %x, i32 %y, ptr %p) nounwind {
; CHECK-LABEL: usubo_ugt_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w0, w1
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    str w8, [x2]
; CHECK-NEXT:    ret
  %ov = icmp ugt i32 %y, %x
  %s = sub i32 %x, %y
  store i32 %s, ptr %p
  ret i1 %ov
}

; Constant operand should match.

define i1 @usubo_ugt_constant_op0_i8(i8 %x, ptr %p) nounwind {
; CHECK-LABEL: usubo_ugt_constant_op0_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    mov w9, #42
; CHECK-NEXT:    cmp w8, #42
; CHECK-NEXT:    sub w9, w9, w0
; CHECK-NEXT:    cset w8, hi
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    strb w9, [x1]
; CHECK-NEXT:    ret
  %s = sub i8 42, %x
  %ov = icmp ugt i8 %x, 42
  store i8 %s, ptr %p
  ret i1 %ov
}

; Compare with constant operand 0 is canonicalized by commuting, but verify match for non-canonical form.

define i1 @usubo_ult_constant_op0_i16(i16 %x, ptr %p) nounwind {
; CHECK-LABEL: usubo_ult_constant_op0_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    mov w9, #43
; CHECK-NEXT:    cmp w8, #43
; CHECK-NEXT:    sub w9, w9, w0
; CHECK-NEXT:    cset w8, hi
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    strh w9, [x1]
; CHECK-NEXT:    ret
  %s = sub i16 43, %x
  %ov = icmp ult i16 43, %x
  store i16 %s, ptr %p
  ret i1 %ov
}

; Subtract with constant operand 1 is canonicalized to add.

define i1 @usubo_ult_constant_op1_i16(i16 %x, ptr %p) nounwind {
; CHECK-LABEL: usubo_ult_constant_op1_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w9, w0, #44
; CHECK-NEXT:    cmp w8, #44
; CHECK-NEXT:    cset w8, lo
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    strh w9, [x1]
; CHECK-NEXT:    ret
  %s = add i16 %x, -44
  %ov = icmp ult i16 %x, 44
  store i16 %s, ptr %p
  ret i1 %ov
}

define i1 @usubo_ugt_constant_op1_i8(i8 %x, ptr %p) nounwind {
; CHECK-LABEL: usubo_ugt_constant_op1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    sub w9, w0, #45
; CHECK-NEXT:    cmp w8, #45
; CHECK-NEXT:    cset w8, lo
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    strb w9, [x1]
; CHECK-NEXT:    ret
  %ov = icmp ugt i8 45, %x
  %s = add i8 %x, -45
  store i8 %s, ptr %p
  ret i1 %ov
}

; Special-case: subtract 1 changes the compare predicate and constant.

define i1 @usubo_eq_constant1_op1_i32(i32 %x, ptr %p) nounwind {
; CHECK-LABEL: usubo_eq_constant1_op1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0
; CHECK-NEXT:    sub w9, w0, #1
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    str w9, [x1]
; CHECK-NEXT:    ret
  %s = add i32 %x, -1
  %ov = icmp eq i32 %x, 0
  store i32 %s, ptr %p
  ret i1 %ov
}

; Verify insertion point for multi-BB.

declare void @call(i1)

define i1 @usubo_ult_sub_dominates_i64(i64 %x, i64 %y, ptr %p, i1 %cond) nounwind {
; CHECK-LABEL: usubo_ult_sub_dominates_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    tbz w3, #0, .LBB7_2
; CHECK-NEXT:  // %bb.1: // %t
; CHECK-NEXT:    subs x8, x0, x1
; CHECK-NEXT:    cset w3, lo
; CHECK-NEXT:    str x8, [x2]
; CHECK-NEXT:  .LBB7_2: // %common.ret
; CHECK-NEXT:    and w0, w3, #0x1
; CHECK-NEXT:    ret
entry:
  br i1 %cond, label %t, label %f

t:
  %s = sub i64 %x, %y
  store i64 %s, ptr %p
  br i1 %cond, label %end, label %f

f:
  ret i1 %cond

end:
  %ov = icmp ult i64 %x, %y
  ret i1 %ov
}

define i1 @usubo_ult_cmp_dominates_i64(i64 %x, i64 %y, ptr %p, i1 %cond) nounwind {
; CHECK-LABEL: usubo_ult_cmp_dominates_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp x30, x23, [sp, #-48]! // 16-byte Folded Spill
; CHECK-NEXT:    stp x20, x19, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    mov w19, w3
; CHECK-NEXT:    stp x22, x21, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    tbz w3, #0, .LBB8_3
; CHECK-NEXT:  // %bb.1: // %t
; CHECK-NEXT:    cmp x0, x1
; CHECK-NEXT:    mov x23, x0
; CHECK-NEXT:    cset w21, lo
; CHECK-NEXT:    mov x20, x2
; CHECK-NEXT:    mov w0, w21
; CHECK-NEXT:    mov x22, x1
; CHECK-NEXT:    bl call
; CHECK-NEXT:    subs x8, x23, x22
; CHECK-NEXT:    b.hs .LBB8_3
; CHECK-NEXT:  // %bb.2: // %end
; CHECK-NEXT:    mov w19, w21
; CHECK-NEXT:    str x8, [x20]
; CHECK-NEXT:  .LBB8_3: // %common.ret
; CHECK-NEXT:    and w0, w19, #0x1
; CHECK-NEXT:    ldp x20, x19, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x22, x21, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x30, x23, [sp], #48 // 16-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  br i1 %cond, label %t, label %f

t:
  %ov = icmp ult i64 %x, %y
  call void @call(i1 %ov)
  br i1 %ov, label %end, label %f

f:
  ret i1 %cond

end:
  %s = sub i64 %x, %y
  store i64 %s, ptr %p
  ret i1 %ov
}


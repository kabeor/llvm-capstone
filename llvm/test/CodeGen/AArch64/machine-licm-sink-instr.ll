; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 -sink-insts-to-avoid-spills | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

@A = external dso_local global [100 x i32], align 4

define i32 @sink_load_and_copy(i32 %n) {
; CHECK-LABEL: sink_load_and_copy:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp x30, x21, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    stp x20, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w20, -16
; CHECK-NEXT:    .cfi_offset w21, -24
; CHECK-NEXT:    .cfi_offset w30, -32
; CHECK-NEXT:    mov w19, w0
; CHECK-NEXT:    cmp w0, #1
; CHECK-NEXT:    b.lt .LBB0_3
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    adrp x8, A
; CHECK-NEXT:    mov w20, w19
; CHECK-NEXT:    ldr w21, [x8, :lo12:A]
; CHECK-NEXT:  .LBB0_2: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mov w0, w21
; CHECK-NEXT:    bl _Z3usei
; CHECK-NEXT:    sdiv w20, w20, w0
; CHECK-NEXT:    subs w19, w19, #1
; CHECK-NEXT:    b.ne .LBB0_2
; CHECK-NEXT:    b .LBB0_4
; CHECK-NEXT:  .LBB0_3:
; CHECK-NEXT:    mov w20, w19
; CHECK-NEXT:  .LBB0_4: // %for.cond.cleanup
; CHECK-NEXT:    mov w0, w20
; CHECK-NEXT:    ldp x20, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x30, x21, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %cmp63 = icmp sgt i32 %n, 0
  br i1 %cmp63, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %0 = load i32, ptr @A, align 4
  br label %for.body

for.cond.cleanup:
  %sum.0.lcssa = phi i32 [ %n, %entry ], [ %div, %for.body ]
  ret i32 %sum.0.lcssa

for.body:
  %lsr.iv = phi i32 [ %n, %for.body.preheader ], [ %lsr.iv.next, %for.body ]
  %sum.065 = phi i32 [ %div, %for.body ], [ %n, %for.body.preheader ]
  %call = tail call i32 @_Z3usei(i32 %0)
  %div = sdiv i32 %sum.065, %call
  %lsr.iv.next = add i32 %lsr.iv, -1
  %exitcond.not = icmp eq i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define i32 @cant_sink_successive_call(i32 %n) {
; CHECK-LABEL: cant_sink_successive_call:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp x30, x21, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    stp x20, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w20, -16
; CHECK-NEXT:    .cfi_offset w21, -24
; CHECK-NEXT:    .cfi_offset w30, -32
; CHECK-NEXT:    mov w19, w0
; CHECK-NEXT:    cmp w0, #1
; CHECK-NEXT:    b.lt .LBB1_3
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    adrp x8, A
; CHECK-NEXT:    mov w0, w19
; CHECK-NEXT:    ldr w20, [x8, :lo12:A]
; CHECK-NEXT:    bl _Z3usei
; CHECK-NEXT:    mov w21, w19
; CHECK-NEXT:  .LBB1_2: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mov w0, w20
; CHECK-NEXT:    bl _Z3usei
; CHECK-NEXT:    sdiv w21, w21, w0
; CHECK-NEXT:    subs w19, w19, #1
; CHECK-NEXT:    b.ne .LBB1_2
; CHECK-NEXT:    b .LBB1_4
; CHECK-NEXT:  .LBB1_3:
; CHECK-NEXT:    mov w21, w19
; CHECK-NEXT:  .LBB1_4: // %for.cond.cleanup
; CHECK-NEXT:    ldp x20, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    mov w0, w21
; CHECK-NEXT:    ldp x30, x21, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %cmp63 = icmp sgt i32 %n, 0
  br i1 %cmp63, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %0 = load i32, ptr @A, align 4
  %call0 = tail call i32 @_Z3usei(i32 %n)
  br label %for.body

for.cond.cleanup:
  %sum.0.lcssa = phi i32 [ %n, %entry ], [ %div, %for.body ]
  ret i32 %sum.0.lcssa

for.body:
  %lsr.iv = phi i32 [ %n, %for.body.preheader ], [ %lsr.iv.next, %for.body ]
  %sum.065 = phi i32 [ %div, %for.body ], [ %n, %for.body.preheader ]
  %call = tail call i32 @_Z3usei(i32 %0)
  %div = sdiv i32 %sum.065, %call
  %lsr.iv.next = add i32 %lsr.iv, -1
  %exitcond.not = icmp eq i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define i32 @cant_sink_successive_store(ptr nocapture readnone %store, i32 %n) {
; CHECK-LABEL: cant_sink_successive_store:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp x30, x21, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    stp x20, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w20, -16
; CHECK-NEXT:    .cfi_offset w21, -24
; CHECK-NEXT:    .cfi_offset w30, -32
; CHECK-NEXT:    mov w19, w1
; CHECK-NEXT:    cmp w1, #1
; CHECK-NEXT:    b.lt .LBB2_3
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    adrp x8, A
; CHECK-NEXT:    mov w9, #42
; CHECK-NEXT:    mov w20, w19
; CHECK-NEXT:    ldr w21, [x8, :lo12:A]
; CHECK-NEXT:    str w9, [x0]
; CHECK-NEXT:  .LBB2_2: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mov w0, w21
; CHECK-NEXT:    bl _Z3usei
; CHECK-NEXT:    sdiv w20, w20, w0
; CHECK-NEXT:    subs w19, w19, #1
; CHECK-NEXT:    b.ne .LBB2_2
; CHECK-NEXT:    b .LBB2_4
; CHECK-NEXT:  .LBB2_3:
; CHECK-NEXT:    mov w20, w19
; CHECK-NEXT:  .LBB2_4: // %for.cond.cleanup
; CHECK-NEXT:    mov w0, w20
; CHECK-NEXT:    ldp x20, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x30, x21, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %cmp63 = icmp sgt i32 %n, 0
  br i1 %cmp63, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %0 = load i32, ptr @A, align 4
  store i32 42, ptr %store, align 4
  br label %for.body

for.cond.cleanup:
  %sum.0.lcssa = phi i32 [ %n, %entry ], [ %div, %for.body ]
  ret i32 %sum.0.lcssa

for.body:
  %lsr.iv = phi i32 [ %n, %for.body.preheader ], [ %lsr.iv.next, %for.body ]
  %sum.065 = phi i32 [ %div, %for.body ], [ %n, %for.body.preheader ]
  %call = tail call i32 @_Z3usei(i32 %0)
  %div = sdiv i32 %sum.065, %call
  %lsr.iv.next = add i32 %lsr.iv, -1
  %exitcond.not = icmp eq i32 %lsr.iv.next, 0
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

declare i32 @_Z3usei(i32)

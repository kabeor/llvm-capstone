; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-linux-gnu -mattr=-neon | FileCheck %s --check-prefixes=ALL,GPR
; RUN: llc < %s -mtriple=aarch64-unknown-linux-gnu -mattr=neon  | FileCheck %s --check-prefixes=ALL,NEON

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
declare void @llvm.memset.inline.p0.i64(ptr nocapture, i8, i64, i1) nounwind

; /////////////////////////////////////////////////////////////////////////////

define void @memset_1(ptr %a, i8 %value) nounwind {
; ALL-LABEL: memset_1:
; ALL:       // %bb.0:
; ALL-NEXT:    strb w1, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 1, i1 0)
  ret void
}

define void @memset_2(ptr %a, i8 %value) nounwind {
; ALL-LABEL: memset_2:
; ALL:       // %bb.0:
; ALL-NEXT:    bfi w1, w1, #8, #24
; ALL-NEXT:    strh w1, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 2, i1 0)
  ret void
}

define void @memset_4(ptr %a, i8 %value) nounwind {
; ALL-LABEL: memset_4:
; ALL:       // %bb.0:
; ALL-NEXT:    mov w8, #16843009
; ALL-NEXT:    and w9, w1, #0xff
; ALL-NEXT:    mul w8, w9, w8
; ALL-NEXT:    str w8, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 4, i1 0)
  ret void
}

define void @memset_8(ptr %a, i8 %value) nounwind {
; ALL-LABEL: memset_8:
; ALL:       // %bb.0:
; ALL-NEXT:    // kill: def $w1 killed $w1 def $x1
; ALL-NEXT:    mov x8, #72340172838076673
; ALL-NEXT:    and x9, x1, #0xff
; ALL-NEXT:    mul x8, x9, x8
; ALL-NEXT:    str x8, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 8, i1 0)
  ret void
}

define void @memset_16(ptr %a, i8 %value) nounwind {
; ALL-LABEL: memset_16:
; ALL:       // %bb.0:
; ALL-NEXT:    // kill: def $w1 killed $w1 def $x1
; ALL-NEXT:    mov x8, #72340172838076673
; ALL-NEXT:    and x9, x1, #0xff
; ALL-NEXT:    mul x8, x9, x8
; ALL-NEXT:    stp x8, x8, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 16, i1 0)
  ret void
}

define void @memset_32(ptr %a, i8 %value) nounwind {
; GPR-LABEL: memset_32:
; GPR:       // %bb.0:
; GPR-NEXT:    // kill: def $w1 killed $w1 def $x1
; GPR-NEXT:    mov x8, #72340172838076673
; GPR-NEXT:    and x9, x1, #0xff
; GPR-NEXT:    mul x8, x9, x8
; GPR-NEXT:    stp x8, x8, [x0, #16]
; GPR-NEXT:    stp x8, x8, [x0]
; GPR-NEXT:    ret
;
; NEON-LABEL: memset_32:
; NEON:       // %bb.0:
; NEON-NEXT:    dup v0.16b, w1
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 32, i1 0)
  ret void
}

define void @memset_64(ptr %a, i8 %value) nounwind {
; GPR-LABEL: memset_64:
; GPR:       // %bb.0:
; GPR-NEXT:    // kill: def $w1 killed $w1 def $x1
; GPR-NEXT:    mov x8, #72340172838076673
; GPR-NEXT:    and x9, x1, #0xff
; GPR-NEXT:    mul x8, x9, x8
; GPR-NEXT:    stp x8, x8, [x0, #48]
; GPR-NEXT:    stp x8, x8, [x0, #32]
; GPR-NEXT:    stp x8, x8, [x0, #16]
; GPR-NEXT:    stp x8, x8, [x0]
; GPR-NEXT:    ret
;
; NEON-LABEL: memset_64:
; NEON:       // %bb.0:
; NEON-NEXT:    dup v0.16b, w1
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    stp q0, q0, [x0, #32]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @aligned_memset_16(ptr align 16 %a, i8 %value) nounwind {
; ALL-LABEL: aligned_memset_16:
; ALL:       // %bb.0:
; ALL-NEXT:    // kill: def $w1 killed $w1 def $x1
; ALL-NEXT:    mov x8, #72340172838076673
; ALL-NEXT:    and x9, x1, #0xff
; ALL-NEXT:    mul x8, x9, x8
; ALL-NEXT:    stp x8, x8, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 16 %a, i8 %value, i64 16, i1 0)
  ret void
}

define void @aligned_memset_32(ptr align 32 %a, i8 %value) nounwind {
; GPR-LABEL: aligned_memset_32:
; GPR:       // %bb.0:
; GPR-NEXT:    // kill: def $w1 killed $w1 def $x1
; GPR-NEXT:    mov x8, #72340172838076673
; GPR-NEXT:    and x9, x1, #0xff
; GPR-NEXT:    mul x8, x9, x8
; GPR-NEXT:    stp x8, x8, [x0, #16]
; GPR-NEXT:    stp x8, x8, [x0]
; GPR-NEXT:    ret
;
; NEON-LABEL: aligned_memset_32:
; NEON:       // %bb.0:
; NEON-NEXT:    dup v0.16b, w1
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 32 %a, i8 %value, i64 32, i1 0)
  ret void
}

define void @aligned_memset_64(ptr align 64 %a, i8 %value) nounwind {
; GPR-LABEL: aligned_memset_64:
; GPR:       // %bb.0:
; GPR-NEXT:    // kill: def $w1 killed $w1 def $x1
; GPR-NEXT:    mov x8, #72340172838076673
; GPR-NEXT:    and x9, x1, #0xff
; GPR-NEXT:    mul x8, x9, x8
; GPR-NEXT:    stp x8, x8, [x0, #48]
; GPR-NEXT:    stp x8, x8, [x0, #32]
; GPR-NEXT:    stp x8, x8, [x0, #16]
; GPR-NEXT:    stp x8, x8, [x0]
; GPR-NEXT:    ret
;
; NEON-LABEL: aligned_memset_64:
; NEON:       // %bb.0:
; NEON-NEXT:    dup v0.16b, w1
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    stp q0, q0, [x0, #32]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 %value, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @bzero_1(ptr %a) nounwind {
; ALL-LABEL: bzero_1:
; ALL:       // %bb.0:
; ALL-NEXT:    strb wzr, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 1, i1 0)
  ret void
}

define void @bzero_2(ptr %a) nounwind {
; ALL-LABEL: bzero_2:
; ALL:       // %bb.0:
; ALL-NEXT:    strh wzr, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 2, i1 0)
  ret void
}

define void @bzero_4(ptr %a) nounwind {
; ALL-LABEL: bzero_4:
; ALL:       // %bb.0:
; ALL-NEXT:    str wzr, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 4, i1 0)
  ret void
}

define void @bzero_8(ptr %a) nounwind {
; ALL-LABEL: bzero_8:
; ALL:       // %bb.0:
; ALL-NEXT:    str xzr, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 8, i1 0)
  ret void
}

define void @bzero_16(ptr %a) nounwind {
; ALL-LABEL: bzero_16:
; ALL:       // %bb.0:
; ALL-NEXT:    stp xzr, xzr, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 16, i1 0)
  ret void
}

define void @bzero_32(ptr %a) nounwind {
; GPR-LABEL: bzero_32:
; GPR:       // %bb.0:
; GPR-NEXT:    adrp x8, .LCPI15_0
; GPR-NEXT:    ldr q0, [x8, :lo12:.LCPI15_0]
; GPR-NEXT:    stp q0, q0, [x0]
; GPR-NEXT:    ret
;
; NEON-LABEL: bzero_32:
; NEON:       // %bb.0:
; NEON-NEXT:    movi v0.2d, #0000000000000000
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 32, i1 0)
  ret void
}

define void @bzero_64(ptr %a) nounwind {
; GPR-LABEL: bzero_64:
; GPR:       // %bb.0:
; GPR-NEXT:    adrp x8, .LCPI16_0
; GPR-NEXT:    ldr q0, [x8, :lo12:.LCPI16_0]
; GPR-NEXT:    stp q0, q0, [x0]
; GPR-NEXT:    stp q0, q0, [x0, #32]
; GPR-NEXT:    ret
;
; NEON-LABEL: bzero_64:
; NEON:       // %bb.0:
; NEON-NEXT:    movi v0.2d, #0000000000000000
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    stp q0, q0, [x0, #32]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @aligned_bzero_16(ptr %a) nounwind {
; ALL-LABEL: aligned_bzero_16:
; ALL:       // %bb.0:
; ALL-NEXT:    stp xzr, xzr, [x0]
; ALL-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 16 %a, i8 0, i64 16, i1 0)
  ret void
}

define void @aligned_bzero_32(ptr %a) nounwind {
; GPR-LABEL: aligned_bzero_32:
; GPR:       // %bb.0:
; GPR-NEXT:    adrp x8, .LCPI18_0
; GPR-NEXT:    ldr q0, [x8, :lo12:.LCPI18_0]
; GPR-NEXT:    stp q0, q0, [x0]
; GPR-NEXT:    ret
;
; NEON-LABEL: aligned_bzero_32:
; NEON:       // %bb.0:
; NEON-NEXT:    movi v0.2d, #0000000000000000
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 32 %a, i8 0, i64 32, i1 0)
  ret void
}

define void @aligned_bzero_64(ptr %a) nounwind {
; GPR-LABEL: aligned_bzero_64:
; GPR:       // %bb.0:
; GPR-NEXT:    adrp x8, .LCPI19_0
; GPR-NEXT:    ldr q0, [x8, :lo12:.LCPI19_0]
; GPR-NEXT:    stp q0, q0, [x0]
; GPR-NEXT:    stp q0, q0, [x0, #32]
; GPR-NEXT:    ret
;
; NEON-LABEL: aligned_bzero_64:
; NEON:       // %bb.0:
; NEON-NEXT:    movi v0.2d, #0000000000000000
; NEON-NEXT:    stp q0, q0, [x0]
; NEON-NEXT:    stp q0, q0, [x0, #32]
; NEON-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 0, i64 64, i1 0)
  ret void
}

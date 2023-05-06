; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-eabi | FileCheck %s

define void @vld2(ptr nocapture readonly %pSrc, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: vld2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB0_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld2 { v0.4s, v1.4s }, [x0], #32
; CHECK-NEXT:    fmul v2.4s, v0.4s, v0.4s
; CHECK-NEXT:    fmla v2.4s, v1.4s, v1.4s
; CHECK-NEXT:    str q2, [x1, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #1, lsl #12 // =4096
; CHECK-NEXT:    b.ne .LBB0_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %next.gep19 = getelementptr float, ptr %pDst, i64 %index
  %wide.vec = load <8 x float>, ptr %next.gep, align 4
  %1 = fmul fast <8 x float> %wide.vec, %wide.vec
  %2 = shufflevector <8 x float> %1, <8 x float> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %3 = fmul fast <8 x float> %wide.vec, %wide.vec
  %4 = shufflevector <8 x float> %3, <8 x float> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %5 = fadd fast <4 x float> %4, %2
  store <4 x float> %5, ptr %next.gep19, align 4
  %index.next = add i64 %index, 4
  %6 = icmp eq i64 %index.next, 1024
  br i1 %6, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

define void @vld3(ptr nocapture readonly %pSrc, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: vld3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB1_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld3 { v0.4s, v1.4s, v2.4s }, [x0], #48
; CHECK-NEXT:    fmul v3.4s, v0.4s, v0.4s
; CHECK-NEXT:    fmla v3.4s, v1.4s, v1.4s
; CHECK-NEXT:    fmla v3.4s, v2.4s, v2.4s
; CHECK-NEXT:    str q3, [x1, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #1, lsl #12 // =4096
; CHECK-NEXT:    b.ne .LBB1_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 3
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %next.gep23 = getelementptr float, ptr %pDst, i64 %index
  %wide.vec = load <12 x float>, ptr %next.gep, align 4
  %1 = fmul fast <12 x float> %wide.vec, %wide.vec
  %2 = shufflevector <12 x float> %1, <12 x float> undef, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %3 = fmul fast <12 x float> %wide.vec, %wide.vec
  %4 = shufflevector <12 x float> %3, <12 x float> undef, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %5 = fadd fast <4 x float> %4, %2
  %6 = fmul fast <12 x float> %wide.vec, %wide.vec
  %7 = shufflevector <12 x float> %6, <12 x float> undef, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  %8 = fadd fast <4 x float> %5, %7
  store <4 x float> %8, ptr %next.gep23, align 4
  %index.next = add i64 %index, 4
  %9 = icmp eq i64 %index.next, 1024
  br i1 %9, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

define void @vld4(ptr nocapture readonly %pSrc, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: vld4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB2_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld4 { v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
; CHECK-NEXT:    fmul v4.4s, v0.4s, v0.4s
; CHECK-NEXT:    add x9, x1, x8
; CHECK-NEXT:    add x8, x8, #32
; CHECK-NEXT:    cmp x8, #2, lsl #12 // =8192
; CHECK-NEXT:    fmla v4.4s, v1.4s, v1.4s
; CHECK-NEXT:    fmul v5.4s, v2.4s, v2.4s
; CHECK-NEXT:    fmla v5.4s, v3.4s, v3.4s
; CHECK-NEXT:    st2 { v4.4s, v5.4s }, [x9]
; CHECK-NEXT:    b.ne .LBB2_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 2
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %1 = shl i64 %index, 1
  %wide.vec = load <16 x float>, ptr %next.gep, align 4
  %2 = fmul fast <16 x float> %wide.vec, %wide.vec
  %3 = shufflevector <16 x float> %2, <16 x float> undef, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %4 = fmul fast <16 x float> %wide.vec, %wide.vec
  %5 = shufflevector <16 x float> %4, <16 x float> undef, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %6 = fadd fast <4 x float> %5, %3
  %7 = fmul fast <16 x float> %wide.vec, %wide.vec
  %8 = shufflevector <16 x float> %7, <16 x float> undef, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %9 = fmul fast <16 x float> %wide.vec, %wide.vec
  %10 = shufflevector <16 x float> %9, <16 x float> undef, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  %11 = fadd fast <4 x float> %10, %8
  %12 = getelementptr inbounds float, ptr %pDst, i64 %1
  %interleaved.vec = shufflevector <4 x float> %6, <4 x float> %11, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  store <8 x float> %interleaved.vec, ptr %12, align 4
  %index.next = add i64 %index, 4
  %13 = icmp eq i64 %index.next, 1024
  br i1 %13, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

define void @twosrc(ptr nocapture readonly %pSrc, ptr nocapture readonly %pSrc2, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: twosrc:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB3_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add x9, x0, x8
; CHECK-NEXT:    ld2 { v0.4s, v1.4s }, [x9]
; CHECK-NEXT:    add x9, x1, x8
; CHECK-NEXT:    add x8, x8, #32
; CHECK-NEXT:    cmp x8, #2, lsl #12 // =8192
; CHECK-NEXT:    ld2 { v2.4s, v3.4s }, [x9]
; CHECK-NEXT:    fmul v4.4s, v2.4s, v0.4s
; CHECK-NEXT:    fmla v4.4s, v1.4s, v3.4s
; CHECK-NEXT:    str q4, [x2], #16
; CHECK-NEXT:    b.ne .LBB3_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %1 = shl i64 %index, 1
  %next.gep23 = getelementptr float, ptr %pSrc2, i64 %1
  %next.gep24 = getelementptr float, ptr %pDst, i64 %index
  %wide.vec = load <8 x float>, ptr %next.gep, align 4
  %wide.vec26 = load <8 x float>, ptr %next.gep23, align 4
  %2 = fmul fast <8 x float> %wide.vec26, %wide.vec
  %3 = shufflevector <8 x float> %2, <8 x float> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %4 = fmul fast <8 x float> %wide.vec26, %wide.vec
  %5 = shufflevector <8 x float> %4, <8 x float> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %6 = fadd fast <4 x float> %5, %3
  store <4 x float> %6, ptr %next.gep24, align 4
  %index.next = add i64 %index, 4
  %7 = icmp eq i64 %index.next, 1024
  br i1 %7, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

define void @vld2_multiuse(ptr nocapture readonly %pSrc, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: vld2_multiuse:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB4_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld2 { v0.4s, v1.4s }, [x0], #32
; CHECK-NEXT:    fmul v2.4s, v0.4s, v0.4s
; CHECK-NEXT:    fmla v2.4s, v1.4s, v1.4s
; CHECK-NEXT:    str q2, [x1, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #1, lsl #12 // =4096
; CHECK-NEXT:    b.ne .LBB4_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 1
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %next.gep19 = getelementptr float, ptr %pDst, i64 %index
  %wide.vec = load <8 x float>, ptr %next.gep, align 4
  %1 = fmul fast <8 x float> %wide.vec, %wide.vec
  %2 = shufflevector <8 x float> %1, <8 x float> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %3 = shufflevector <8 x float> %1, <8 x float> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %4 = fadd fast <4 x float> %3, %2
  store <4 x float> %4, ptr %next.gep19, align 4
  %index.next = add i64 %index, 4
  %5 = icmp eq i64 %index.next, 1024
  br i1 %5, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

define void @vld3_multiuse(ptr nocapture readonly %pSrc, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: vld3_multiuse:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB5_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld3 { v0.4s, v1.4s, v2.4s }, [x0], #48
; CHECK-NEXT:    fmul v3.4s, v0.4s, v0.4s
; CHECK-NEXT:    fmla v3.4s, v1.4s, v1.4s
; CHECK-NEXT:    fmla v3.4s, v2.4s, v2.4s
; CHECK-NEXT:    str q3, [x1, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #1, lsl #12 // =4096
; CHECK-NEXT:    b.ne .LBB5_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = mul i64 %index, 3
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %next.gep23 = getelementptr float, ptr %pDst, i64 %index
  %wide.vec = load <12 x float>, ptr %next.gep, align 4
  %1 = fmul fast <12 x float> %wide.vec, %wide.vec
  %2 = shufflevector <12 x float> %1, <12 x float> undef, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %3 = shufflevector <12 x float> %1, <12 x float> undef, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %4 = fadd fast <4 x float> %3, %2
  %5 = shufflevector <12 x float> %1, <12 x float> undef, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  %6 = fadd fast <4 x float> %4, %5
  store <4 x float> %6, ptr %next.gep23, align 4
  %index.next = add i64 %index, 4
  %7 = icmp eq i64 %index.next, 1024
  br i1 %7, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

define void @vld4_multiuse(ptr nocapture readonly %pSrc, ptr noalias nocapture %pDst, i32 %numSamples) {
; CHECK-LABEL: vld4_multiuse:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB6_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld4 { v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
; CHECK-NEXT:    fmul v4.4s, v0.4s, v0.4s
; CHECK-NEXT:    add x9, x1, x8
; CHECK-NEXT:    add x8, x8, #32
; CHECK-NEXT:    cmp x8, #2, lsl #12 // =8192
; CHECK-NEXT:    fmla v4.4s, v1.4s, v1.4s
; CHECK-NEXT:    fmul v5.4s, v2.4s, v2.4s
; CHECK-NEXT:    fmla v5.4s, v3.4s, v3.4s
; CHECK-NEXT:    st2 { v4.4s, v5.4s }, [x9]
; CHECK-NEXT:    b.ne .LBB6_1
; CHECK-NEXT:  // %bb.2: // %while.end
; CHECK-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = shl i64 %index, 2
  %next.gep = getelementptr float, ptr %pSrc, i64 %0
  %1 = shl i64 %index, 1
  %wide.vec = load <16 x float>, ptr %next.gep, align 4
  %2 = fmul fast <16 x float> %wide.vec, %wide.vec
  %3 = shufflevector <16 x float> %2, <16 x float> undef, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %4 = shufflevector <16 x float> %2, <16 x float> undef, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %5 = fadd fast <4 x float> %4, %3
  %6 = shufflevector <16 x float> %2, <16 x float> undef, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %7 = shufflevector <16 x float> %2, <16 x float> undef, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  %8 = fadd fast <4 x float> %7, %6
  %9 = getelementptr inbounds float, ptr %pDst, i64 %1
  %interleaved.vec = shufflevector <4 x float> %5, <4 x float> %8, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  store <8 x float> %interleaved.vec, ptr %9, align 4
  %index.next = add i64 %index, 4
  %10 = icmp eq i64 %index.next, 1024
  br i1 %10, label %while.end, label %vector.body

while.end:                                        ; preds = %vector.body
  ret void
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc64le-unknown-linux-gnu -verify-machineinstrs\
; RUN:       -mcpu=pwr9 --ppc-enable-pipeliner --pipeliner-force-ii=15 2>&1 | FileCheck %s

define void @phi2(i32, i32, ptr) local_unnamed_addr {
; CHECK-LABEL: phi2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    divw 8, 3, 4
; CHECK-NEXT:    li 5, 55
; CHECK-NEXT:    li 6, 48
; CHECK-NEXT:    mtctr 3
; CHECK-NEXT:    bdz .LBB0_4
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    divw 9, 8, 4
; CHECK-NEXT:    mullw 7, 8, 4
; CHECK-NEXT:    sub 3, 3, 7
; CHECK-NEXT:    cmplwi 3, 10
; CHECK-NEXT:    isellt 7, 6, 5
; CHECK-NEXT:    add 3, 7, 3
; CHECK-NEXT:    stbu 3, -1(7)
; CHECK-NEXT:    mr 3, 8
; CHECK-NEXT:    bdz .LBB0_3
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_2:
; CHECK-NEXT:    mr 3, 9
; CHECK-NEXT:    mullw 9, 9, 4
; CHECK-NEXT:    divw 10, 3, 4
; CHECK-NEXT:    sub 8, 8, 9
; CHECK-NEXT:    cmplwi 8, 10
; CHECK-NEXT:    isellt 9, 6, 5
; CHECK-NEXT:    add 8, 9, 8
; CHECK-NEXT:    mr 9, 10
; CHECK-NEXT:    stbu 8, -1(7)
; CHECK-NEXT:    mr 8, 3
; CHECK-NEXT:    bdnz .LBB0_2
; CHECK-NEXT:  .LBB0_3:
; CHECK-NEXT:    mr 8, 9
; CHECK-NEXT:    b .LBB0_5
; CHECK-NEXT:  .LBB0_4:
; CHECK-NEXT:    # implicit-def: $x7
; CHECK-NEXT:  .LBB0_5:
; CHECK-NEXT:    mullw 4, 8, 4
; CHECK-NEXT:    sub 3, 3, 4
; CHECK-NEXT:    cmplwi 3, 10
; CHECK-NEXT:    isellt 4, 6, 5
; CHECK-NEXT:    add 3, 4, 3
; CHECK-NEXT:    stbu 3, -1(7)
; CHECK-NEXT:    blr
  br label %4

4:                                                ; preds = %4, %3
  %5 = phi i64 [ %7, %4 ], [ undef, %3 ]
  %6 = phi i32 [ %8, %4 ], [ %0, %3 ]
  %7 = add nsw i64 %5, -1
  %8 = sdiv i32 %6, %1
  %9 = mul nsw i32 %8, %1
  %10 = sub nsw i32 %6, %9
  %11 = icmp ult i32 %10, 10
  %12 = trunc i32 %10 to i8
  %13 = select i1 %11, i8 48, i8 55
  %14 = add i8 %13, %12
  %15 = getelementptr inbounds i8, ptr %2, i64 %7
  store i8 %14, ptr %15, align 1
  %16 = icmp sgt i64 %5, 1
  br i1 %16, label %4, label %17

17:                                               ; preds = %4
  ret void
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

@g = external global i32

define i1 @smin(i32 %other) {
; CHECK-LABEL: @smin(
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt i32 [[OTHER:%.*]], 0
; CHECK-NEXT:    ret i1 [[TEST]]
;
  %positive = load i32, ptr @g, !range !{i32 1, i32 2048}
  %cmp = icmp slt i32 %positive, %other
  %sel = select i1 %cmp, i32 %positive, i32 %other
  %test = icmp sgt i32 %sel, 0
  ret i1 %test
}

define i1 @smin_int(i32 %other) {
; CHECK-LABEL: @smin_int(
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt i32 [[OTHER:%.*]], 0
; CHECK-NEXT:    ret i1 [[TEST]]
;
  %positive = load i32, ptr @g, !range !{i32 1, i32 2048}
  %smin = call i32 @llvm.smin.i32(i32 %positive, i32 %other)
  %test = icmp sgt i32 %smin, 0
  ret i1 %test
}
declare i32 @llvm.smin.i32(i32, i32)

; Range metadata doesn't work for vectors, so find another way to trigger isKnownPositive().

define <2 x i1> @smin_vec(<2 x i32> %x, <2 x i32> %other) {
; CHECK-LABEL: @smin_vec(
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt <2 x i32> [[OTHER:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[TEST]]
;
  %notneg = and <2 x i32> %x, <i32 7, i32 7>
  %positive = or <2 x i32> %notneg, <i32 1, i32 1>
  %cmp = icmp slt <2 x i32> %positive, %other
  %sel = select <2 x i1> %cmp, <2 x i32> %positive, <2 x i32> %other
  %test = icmp sgt <2 x i32> %sel, zeroinitializer
  ret <2 x i1> %test
}

define i1 @smin_commute(i32 %other) {
; CHECK-LABEL: @smin_commute(
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt i32 [[OTHER:%.*]], 0
; CHECK-NEXT:    ret i1 [[TEST]]
;
  %positive = load i32, ptr @g, !range !{i32 1, i32 2048}
  %cmp = icmp slt i32 %other, %positive
  %sel = select i1 %cmp, i32 %other, i32 %positive
  %test = icmp sgt i32 %sel, 0
  ret i1 %test
}

define <2 x i1> @smin_commute_vec(<2 x i32> %x, <2 x i32> %other) {
; CHECK-LABEL: @smin_commute_vec(
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt <2 x i32> [[OTHER:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[TEST]]
;
  %notneg = and <2 x i32> %x, <i32 7, i32 7>
  %positive = or <2 x i32> %notneg, <i32 1, i32 1>
  %cmp = icmp slt <2 x i32> %other, %positive
  %sel = select <2 x i1> %cmp, <2 x i32> %other, <2 x i32> %positive
  %test = icmp sgt <2 x i32> %sel, zeroinitializer
  ret <2 x i1> %test
}

define <2 x i1> @smin_commute_vec_undef_elts(<2 x i32> %x, <2 x i32> %other) {
; CHECK-LABEL: @smin_commute_vec_undef_elts(
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt <2 x i32> [[OTHER:%.*]], <i32 0, i32 undef>
; CHECK-NEXT:    ret <2 x i1> [[TEST]]
;
  %notneg = and <2 x i32> %x, <i32 7, i32 7>
  %positive = or <2 x i32> %notneg, <i32 1, i32 1>
  %cmp = icmp slt <2 x i32> %other, %positive
  %sel = select <2 x i1> %cmp, <2 x i32> %other, <2 x i32> %positive
  %test = icmp sgt <2 x i32> %sel, <i32 0, i32 undef>
  ret <2 x i1> %test
}
; %positive might be zero

define i1 @maybe_not_positive(i32 %other) {
; CHECK-LABEL: @maybe_not_positive(
; CHECK-NEXT:    [[POSITIVE:%.*]] = load i32, ptr @g, align 4, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.smin.i32(i32 [[POSITIVE]], i32 [[OTHER:%.*]])
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TEST]]
;
  %positive = load i32, ptr @g, !range !{i32 0, i32 2048}
  %cmp = icmp slt i32 %positive, %other
  %sel = select i1 %cmp, i32 %positive, i32 %other
  %test = icmp sgt i32 %sel, 0
  ret i1 %test
}

define <2 x i1> @maybe_not_positive_vec(<2 x i32> %x, <2 x i32> %other) {
; CHECK-LABEL: @maybe_not_positive_vec(
; CHECK-NEXT:    [[NOTNEG:%.*]] = and <2 x i32> [[X:%.*]], <i32 7, i32 7>
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i32> @llvm.smin.v2i32(<2 x i32> [[NOTNEG]], <2 x i32> [[OTHER:%.*]])
; CHECK-NEXT:    [[TEST:%.*]] = icmp sgt <2 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[TEST]]
;
  %notneg = and <2 x i32> %x, <i32 7, i32 7>
  %cmp = icmp slt <2 x i32> %notneg, %other
  %sel = select <2 x i1> %cmp, <2 x i32> %notneg, <2 x i32> %other
  %test = icmp sgt <2 x i32> %sel, zeroinitializer
  ret <2 x i1> %test
}


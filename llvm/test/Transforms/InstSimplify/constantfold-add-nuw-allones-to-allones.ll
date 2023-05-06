; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

; %ret = add nuw i8 %x, C
; nuw means no unsigned wrap, from -1 to 0.
; So if C is -1, %x can only be 0, and the result is always -1.

define i8 @add_nuw (i8 %x) {
; CHECK-LABEL: @add_nuw(
; CHECK-NEXT:    ret i8 -1
;
  %ret = add nuw i8 %x, -1
  ; nuw here means that %x can only be 0
  ret i8 %ret
}

define i8 @add_nuw_nsw (i8 %x) {
; CHECK-LABEL: @add_nuw_nsw(
; CHECK-NEXT:    ret i8 -1
;
  %ret = add nuw nsw i8 %x, -1
  ; nuw here means that %x can only be 0
  ret i8 %ret
}

define i8 @add_nuw_commute (i8 %x) {
; CHECK-LABEL: @add_nuw_commute(
; CHECK-NEXT:    ret i8 -1
;
  %ret = add nuw i8 -1, %x ; swapped
  ; nuw here means that %x can only be 0
  ret i8 %ret
}

; ============================================================================ ;
; Positive tests with value range known
; ============================================================================ ;

declare void @llvm.assume(i1 %cond);

define i8 @knownbits_allones(i8 %x, i8 %y) {
; CHECK-LABEL: @knownbits_allones(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[Y:%.*]], -2
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[RET:%.*]] = add nuw i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    ret i8 [[RET]]
;
  %cmp = icmp slt i8 %y, 254
  tail call void @llvm.assume(i1 %cmp)
  %ret = add nuw i8 %x, %y
  ret i8 %ret
}

; ============================================================================ ;
; Vectors
; ============================================================================ ;

define <2 x i8> @add_vec(<2 x i8> %x) {
; CHECK-LABEL: @add_vec(
; CHECK-NEXT:    ret <2 x i8> <i8 -1, i8 -1>
;
  %ret = add nuw <2 x i8> %x, <i8 -1, i8 -1>
  ret <2 x i8> %ret
}

define <3 x i8> @add_vec_undef(<3 x i8> %x) {
; CHECK-LABEL: @add_vec_undef(
; CHECK-NEXT:    ret <3 x i8> <i8 -1, i8 undef, i8 -1>
;
  %ret = add nuw <3 x i8> %x, <i8 -1, i8 undef, i8 -1>
  ret <3 x i8> %ret
}

; ============================================================================ ;
; Negative tests. Should not be folded.
; ============================================================================ ;

define i8 @bad_add (i8 %x) {
; CHECK-LABEL: @bad_add(
; CHECK-NEXT:    [[RET:%.*]] = add i8 [[X:%.*]], -1
; CHECK-NEXT:    ret i8 [[RET]]
;
  %ret = add i8 %x, -1 ; need nuw
  ret i8 %ret
}

define i8 @bad_add_nsw (i8 %x) {
; CHECK-LABEL: @bad_add_nsw(
; CHECK-NEXT:    [[RET:%.*]] = add nsw i8 [[X:%.*]], -1
; CHECK-NEXT:    ret i8 [[RET]]
;
  %ret = add nsw i8 %x, -1 ; need nuw
  ret i8 %ret
}

; Second `add` operand is not `-1` constant

define i8 @bad_add0(i8 %x, i8 %addop2) {
; CHECK-LABEL: @bad_add0(
; CHECK-NEXT:    [[RET:%.*]] = add nuw i8 [[X:%.*]], [[ADDOP2:%.*]]
; CHECK-NEXT:    ret i8 [[RET]]
;
  %ret = add nuw i8 %x, %addop2
  ret i8 %ret
}

; Bad constant

define i8 @bad_add1(i8 %x) {
; CHECK-LABEL: @bad_add1(
; CHECK-NEXT:    [[RET:%.*]] = add nuw i8 [[X:%.*]], 1
; CHECK-NEXT:    ret i8 [[RET]]
;
  %ret = add nuw i8 %x, 1 ; not -1
  ret i8 %ret
}

define <2 x i8> @bad_add_vec_nonsplat(<2 x i8> %x) {
; CHECK-LABEL: @bad_add_vec_nonsplat(
; CHECK-NEXT:    [[RET:%.*]] = add nuw <2 x i8> [[X:%.*]], <i8 -1, i8 1>
; CHECK-NEXT:    ret <2 x i8> [[RET]]
;
  %ret = add nuw <2 x i8> %x, <i8 -1, i8 1>
  ret <2 x i8> %ret
}

; Bad known bits

define i8 @bad_knownbits(i8 %x, i8 %y) {
; CHECK-LABEL: @bad_knownbits(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[X:%.*]], -3
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[RET:%.*]] = add nuw i8 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[RET]]
;
  %cmp = icmp slt i8 %x, 253
  tail call void @llvm.assume(i1 %cmp)
  %ret = add nuw i8 %x, %y
  ret i8 %ret
}

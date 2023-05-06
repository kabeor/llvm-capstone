; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

define i1 @f(i1 %x) {
; CHECK-LABEL: @f(
; CHECK-NEXT:    ret i1 false
;
  %b = and i1 %x, icmp eq (ptr inttoptr (i32 1 to ptr), ptr inttoptr (i32 2 to ptr))
  ret i1 %b
}

define i1 @f_logical(i1 %x) {
; CHECK-LABEL: @f_logical(
; CHECK-NEXT:    ret i1 false
;
  %b = select i1 %x, i1 icmp eq (ptr inttoptr (i32 1 to ptr), ptr inttoptr (i32 2 to ptr)), i1 false
  ret i1 %b
}

define i32 @g(i32 %x) {
; CHECK-LABEL: @g(
; CHECK-NEXT:    ret i32 [[X:%.*]]
;
  %b = add i32 %x, zext (i1 icmp eq (ptr inttoptr (i32 1000000 to ptr), ptr inttoptr (i32 2000000 to ptr)) to i32)
  ret i32 %b
}

define i32 @h(i1 %A, i32 %B) {
; CHECK-LABEL: @h(
; CHECK-NEXT:  EntryBlock:
; CHECK-NEXT:    [[B_OP:%.*]] = add i32 [[B:%.*]], 2
; CHECK-NEXT:    [[OP:%.*]] = select i1 [[A:%.*]], i32 3, i32 [[B_OP]]
; CHECK-NEXT:    ret i32 [[OP]]
;
EntryBlock:
  %cf = select i1 %A, i32 1, i32 %B
  %op = add i32 2, %cf
  ret i32 %op
}

define <4 x float> @h1(i1 %A, <4 x i32> %B) {
; CHECK-LABEL: @h1(
; CHECK-NEXT:  EntryBlock:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <4 x i32> [[B:%.*]] to <4 x float>
; CHECK-NEXT:    [[BC:%.*]] = select i1 [[A:%.*]], <4 x float> <float 0x36A0000000000000, float 0x36A0000000000000, float 0x36A0000000000000, float 0x36A0000000000000>, <4 x float> [[TMP0]]
; CHECK-NEXT:    ret <4 x float> [[BC]]
;
EntryBlock:
  %cf = select i1 %A, <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32> %B
  %bc = bitcast <4 x i32> %cf to <4 x float>
  ret <4 x float> %bc
}

define <vscale x 4 x float> @h2(i1 %A, <vscale x 4 x i32> %B) {
; CHECK-LABEL: @h2(
; CHECK-NEXT:  EntryBlock:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 4 x i32> [[B:%.*]] to <vscale x 4 x float>
; CHECK-NEXT:    [[BC:%.*]] = select i1 [[A:%.*]], <vscale x 4 x float> zeroinitializer, <vscale x 4 x float> [[TMP0]]
; CHECK-NEXT:    ret <vscale x 4 x float> [[BC]]
;
EntryBlock:
  %cf = select i1 %A, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %B
  %bc = bitcast <vscale x 4 x i32> %cf to <vscale x 4 x float>
  ret <vscale x 4 x float> %bc
}

define <vscale x 2 x i64> @h3(i1 %A, <vscale x 4 x i32> %B) {
; CHECK-LABEL: @h3(
; CHECK-NEXT:  EntryBlock:
; CHECK-NEXT:    [[CF:%.*]] = select i1 [[A:%.*]], <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> [[B:%.*]]
; CHECK-NEXT:    [[BC:%.*]] = bitcast <vscale x 4 x i32> [[CF]] to <vscale x 2 x i64>
; CHECK-NEXT:    ret <vscale x 2 x i64> [[BC]]
;
EntryBlock:
  %cf = select i1 %A, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %B
  %bc = bitcast <vscale x 4 x i32> %cf to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %bc

}


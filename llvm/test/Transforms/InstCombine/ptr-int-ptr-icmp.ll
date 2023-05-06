; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S -disable-i2p-p2i-opt < %s | FileCheck %s

target datalayout = "e-p:64:64-p1:16:16-p2:32:32:32-p3:64:64:64"
target triple = "x86_64-unknown-linux-gnu"

; icmp (inttoptr (ptrtoint p1)), p2 --> icmp p1, p2.

define i1 @func(ptr %X, ptr %Y) {
; CHECK-LABEL: @func(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %i = ptrtoint ptr %X to i64
  %p = inttoptr i64 %i to ptr
  %cmp = icmp eq ptr %p, %Y
  ret i1 %cmp
}

define <2 x i1> @func_vec(<2 x ptr> %X, <2 x ptr> %Y) {
; CHECK-LABEL: @func_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x ptr> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %i = ptrtoint <2 x ptr> %X to <2 x i64>
  %p = inttoptr <2 x i64> %i to <2 x ptr>
  %cmp = icmp eq <2 x ptr> %p, %Y
  ret <2 x i1> %cmp
}

define <vscale x 2 x i1> @func_svec(<vscale x 2 x ptr> %X, <vscale x 2 x ptr> %Y) {
; CHECK-LABEL: @func_svec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <vscale x 2 x ptr> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <vscale x 2 x i1> [[CMP]]
;
  %i = ptrtoint <vscale x 2 x ptr> %X to <vscale x 2 x i64>
  %p = inttoptr <vscale x 2 x i64> %i to <vscale x 2 x ptr>
  %cmp = icmp eq <vscale x 2 x ptr> %p, %Y
  ret <vscale x 2 x i1> %cmp
}

define i1 @func_pointer_different_types(ptr %X, ptr %Y) {
; CHECK-LABEL: @func_pointer_different_types(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %i = ptrtoint ptr %X to i64
  %p = inttoptr i64 %i to ptr
  %cmp = icmp eq ptr %p, %Y
  ret i1 %cmp
}

declare ptr @gen8ptr()

define i1 @func_commutative(ptr %X) {
; CHECK-LABEL: @func_commutative(
; CHECK-NEXT:    [[Y:%.*]] = call ptr @gen8ptr()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[Y]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %Y = call ptr @gen8ptr() ; thwart complexity-based canonicalization
  %i = ptrtoint ptr %X to i64
  %p = inttoptr i64 %i to ptr
  %cmp = icmp eq ptr %Y, %p
  ret i1 %cmp
}

; Negative test - Wrong Integer type.

define i1 @func_integer_type_too_small(ptr %X, ptr %Y) {
; CHECK-LABEL: @func_integer_type_too_small(
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[X:%.*]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], 4294967295
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 [[TMP2]] to ptr
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[P]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %i = ptrtoint ptr %X to i32
  %p = inttoptr i32 %i to ptr
  %cmp = icmp eq ptr %Y, %p
  ret i1 %cmp
}

; Negative test - Pointers in different address space

define i1 @func_ptr_different_addrspace(ptr %X, ptr addrspace(3) %Y){
; CHECK-LABEL: @func_ptr_different_addrspace(
; CHECK-NEXT:    [[I:%.*]] = ptrtoint ptr [[X:%.*]] to i64
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 [[I]] to ptr addrspace(3)
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr addrspace(3) [[P]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %i = ptrtoint ptr %X to i64
  %p = inttoptr i64 %i to ptr addrspace(3)
  %cmp = icmp eq ptr addrspace(3) %Y, %p
  ret i1 %cmp
}

; Negative test - Pointers in different address space

define i1 @func_ptr_different_addrspace1(ptr addrspace(2) %X, ptr %Y){
; CHECK-LABEL: @func_ptr_different_addrspace1(
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr addrspace(2) [[X:%.*]] to i32
; CHECK-NEXT:    [[I:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 [[I]] to ptr
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[P]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %i = ptrtoint ptr addrspace(2) %X to i64
  %p = inttoptr i64 %i to ptr
  %cmp = icmp eq ptr %Y, %p
  ret i1 %cmp
}

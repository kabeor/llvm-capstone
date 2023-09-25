; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine -instcombine-infinite-loop-threshold=2 < %s | FileCheck %s

; This test used to cause an infinite combine loop.

define i16 @passthru(i16 returned %x) {
; CHECK-LABEL: @passthru(
; CHECK-NEXT:    ret i16 [[X:%.*]]
;
  ret i16 %x
}

define i16 @test(i16 %arg) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[ZERO:%.*]] = call i16 @passthru(i16 0)
; CHECK-NEXT:    [[RET:%.*]] = call i16 @llvm.smax.i16(i16 [[ARG:%.*]], i16 0)
; CHECK-NEXT:    ret i16 [[RET]]
;
  %zero = call i16 @passthru(i16 0)
  %sub = sub nuw nsw i16 %arg, %zero
  %cmp = icmp slt i16 %sub, 0
  %ret = select i1 %cmp, i16 0, i16 %sub
  ret i16 %ret
}

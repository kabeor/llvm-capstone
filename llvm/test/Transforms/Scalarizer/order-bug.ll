; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes='function(scalarizer)' -S -o - | FileCheck %s

; This input caused the scalarizer to replace & erase gathered results when
; future gathered results depended on them being alive

define dllexport spir_func <4 x i32> @main(float %a) {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[Z:%.*]]
; CHECK:       y:
; CHECK-NEXT:    [[F_UPTO0:%.*]] = insertelement <4 x i32> poison, i32 [[B_I0:%.*]], i32 0
; CHECK-NEXT:    [[F_UPTO1:%.*]] = insertelement <4 x i32> [[F_UPTO0]], i32 [[B_I0]], i32 1
; CHECK-NEXT:    [[F_UPTO2:%.*]] = insertelement <4 x i32> [[F_UPTO1]], i32 [[B_I0]], i32 2
; CHECK-NEXT:    [[F:%.*]] = insertelement <4 x i32> [[F_UPTO2]], i32 [[B_I0]], i32 3
; CHECK-NEXT:    ret <4 x i32> [[F]]
; CHECK:       z:
; CHECK-NEXT:    [[B_I0]] = bitcast float [[A:%.*]] to i32
; CHECK-NEXT:    br label [[Y:%.*]]
;
entry:
  %i = insertelement <4 x float> undef, float %a, i32 0
  br label %z

y:
  %f = shufflevector <4 x i32> %b, <4 x i32> undef, <4 x i32> zeroinitializer
  ret <4 x i32> %f

z:
  %b = bitcast <4 x float> %i to <4 x i32>
  br label %y
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define i32 @test2(float %f) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[T5:%.*]] = fmul float [[F:%.*]], [[F]]
; CHECK-NEXT:    [[T21:%.*]] = bitcast float [[T5]] to i32
; CHECK-NEXT:    ret i32 [[T21]]
;
  %t5 = fmul float %f, %f
  %t9 = insertelement <4 x float> poison, float %t5, i32 0
  %t10 = insertelement <4 x float> %t9, float 0.000000e+00, i32 1
  %t11 = insertelement <4 x float> %t10, float 0.000000e+00, i32 2
  %t12 = insertelement <4 x float> %t11, float 0.000000e+00, i32 3
  %t19 = bitcast <4 x float> %t12 to <4 x i32>
  %t21 = extractelement <4 x i32> %t19, i32 0
  ret i32 %t21
}

define void @get_image() nounwind {
; CHECK-LABEL: @get_image(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @fgetc(ptr null) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    br i1 false, label [[BB2:%.*]], label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    unreachable
;
entry:
  %0 = call i32 @fgetc(ptr null) nounwind
  %1 = trunc i32 %0 to i8
  %t2 = insertelement <100 x i8> zeroinitializer, i8 %1, i32 1
  %t1 = extractelement <100 x i8> %t2, i32 0
  %2 = icmp eq i8 %t1, 80
  br i1 %2, label %bb2, label %bb3

bb2:            ; preds = %entry
  br label %bb3

bb3:            ; preds = %bb2, %entry
  unreachable
}

; PR4340
define void @vac(ptr nocapture %a) nounwind {
; CHECK-LABEL: @vac(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store <4 x float> zeroinitializer, ptr [[A:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %t1 = load <4 x float>, ptr %a		; <<4 x float>> [#uses=1]
  %vecins = insertelement <4 x float> %t1, float 0.000000e+00, i32 0	; <<4 x float>> [#uses=1]
  %vecins4 = insertelement <4 x float> %vecins, float 0.000000e+00, i32 1; <<4 x float>> [#uses=1]
  %vecins6 = insertelement <4 x float> %vecins4, float 0.000000e+00, i32 2; <<4 x float>> [#uses=1]
  %vecins8 = insertelement <4 x float> %vecins6, float 0.000000e+00, i32 3; <<4 x float>> [#uses=1]
  store <4 x float> %vecins8, ptr %a
  ret void
}

declare i32 @fgetc(ptr)

define <4 x float> @dead_shuffle_elt(<4 x float> %x, <2 x float> %y) nounwind {
; CHECK-LABEL: @dead_shuffle_elt(
; CHECK-NEXT:    [[SHUFFLE_I:%.*]] = shufflevector <2 x float> [[Y:%.*]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
; CHECK-NEXT:    [[SHUFFLE9_I:%.*]] = shufflevector <4 x float> [[SHUFFLE_I]], <4 x float> [[X:%.*]], <4 x i32> <i32 0, i32 1, i32 6, i32 7>
; CHECK-NEXT:    ret <4 x float> [[SHUFFLE9_I]]
;
  %shuffle.i = shufflevector <2 x float> %y, <2 x float> %y, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %shuffle9.i = shufflevector <4 x float> %x, <4 x float> %shuffle.i, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
  ret <4 x float> %shuffle9.i
}

define <2 x float> @test_fptrunc(double %f) {
; CHECK-LABEL: @test_fptrunc(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> <double poison, double 0.000000e+00>, double [[F:%.*]], i64 0
; CHECK-NEXT:    [[RET:%.*]] = fptrunc <2 x double> [[TMP1]] to <2 x float>
; CHECK-NEXT:    ret <2 x float> [[RET]]
;
  %t9 = insertelement <4 x double> poison, double %f, i32 0
  %t10 = insertelement <4 x double> %t9, double 0.000000e+00, i32 1
  %t11 = insertelement <4 x double> %t10, double 0.000000e+00, i32 2
  %t12 = insertelement <4 x double> %t11, double 0.000000e+00, i32 3
  %t5 = fptrunc <4 x double> %t12 to <4 x float>
  %ret = shufflevector <4 x float> %t5, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  ret <2 x float> %ret
}

define <2 x double> @test_fpext(float %f) {
; CHECK-LABEL: @test_fpext(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x float> <float poison, float 0.000000e+00>, float [[F:%.*]], i64 0
; CHECK-NEXT:    [[RET:%.*]] = fpext <2 x float> [[TMP1]] to <2 x double>
; CHECK-NEXT:    ret <2 x double> [[RET]]
;
  %t9 = insertelement <4 x float> poison, float %f, i32 0
  %t10 = insertelement <4 x float> %t9, float 0.000000e+00, i32 1
  %t11 = insertelement <4 x float> %t10, float 0.000000e+00, i32 2
  %t12 = insertelement <4 x float> %t11, float 0.000000e+00, i32 3
  %t5 = fpext <4 x float> %t12 to <4 x double>
  %ret = shufflevector <4 x double> %t5, <4 x double> poison, <2 x i32> <i32 0, i32 1>
  ret <2 x double> %ret
}

define <4 x double> @test_shuffle(<4 x double> %f) {
; CHECK-LABEL: @test_shuffle(
; CHECK-NEXT:    [[RET1:%.*]] = insertelement <4 x double> [[F:%.*]], double 1.000000e+00, i64 3
; CHECK-NEXT:    ret <4 x double> [[RET1]]
;
  %ret = shufflevector <4 x double> %f, <4 x double> <double undef, double 1.0, double undef, double undef>, <4 x i32> <i32 0, i32 1, i32 2, i32 5>
  ret <4 x double> %ret
}

define <4 x float> @test_select(float %f, float %g) {
; CHECK-LABEL: @test_select(
; CHECK-NEXT:    [[A3:%.*]] = insertelement <4 x float> <float poison, float poison, float poison, float 3.000000e+00>, float [[F:%.*]], i64 0
; CHECK-NEXT:    [[RET:%.*]] = shufflevector <4 x float> [[A3]], <4 x float> <float poison, float 4.000000e+00, float 5.000000e+00, float poison>, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
; CHECK-NEXT:    ret <4 x float> [[RET]]
;
  %a0 = insertelement <4 x float> poison, float %f, i32 0
  %a1 = insertelement <4 x float> %a0, float 1.000000e+00, i32 1
  %a2 = insertelement <4 x float> %a1, float 2.000000e+00, i32 2
  %a3 = insertelement <4 x float> %a2, float 3.000000e+00, i32 3
  %b0 = insertelement <4 x float> poison, float %g, i32 0
  %b1 = insertelement <4 x float> %b0, float 4.000000e+00, i32 1
  %b2 = insertelement <4 x float> %b1, float 5.000000e+00, i32 2
  %b3 = insertelement <4 x float> %b2, float 6.000000e+00, i32 3
  %ret = select <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x float> %a3, <4 x float> %b3
  ret <4 x float> %ret
}

; Check that instcombine doesn't wrongly fold away the select completely.

define <2 x i64> @PR24922(<2 x i64> %v) {
; CHECK-LABEL: @PR24922(
; CHECK-NEXT:    [[RESULT1:%.*]] = insertelement <2 x i64> [[V:%.*]], i64 0, i64 0
; CHECK-NEXT:    ret <2 x i64> [[RESULT1]]
;
  %result = select <2 x i1> <i1 icmp eq (i64 extractelement (<2 x i64> bitcast (<4 x i32> <i32 15, i32 15, i32 15, i32 15> to <2 x i64>), i64 0), i64 0), i1 true>, <2 x i64> %v, <2 x i64> zeroinitializer
  ret <2 x i64> %result
}

; The shuffle only demands the 0th (undef) element of 'out123', so everything should fold away.

define <4 x float> @inselt_shuf_no_demand(float %a1, float %a2, float %a3) {
; CHECK-LABEL: @inselt_shuf_no_demand(
; CHECK-NEXT:    ret <4 x float> undef
;
  %out1 = insertelement <4 x float> poison, float %a1, i32 1
  %out12 = insertelement <4 x float> %out1, float %a2, i32 2
  %out123 = insertelement <4 x float> %out12, float %a3, i32 3
  %shuffle = shufflevector <4 x float> %out123, <4 x float> poison, <4 x i32> <i32 0, i32 undef, i32 undef, i32 undef>
  ret <4 x float> %shuffle
}

; The shuffle only demands the 0th (undef) element of 'out123', so everything should fold away.

define <4 x float> @inselt_shuf_no_demand_commute(float %a1, float %a2, float %a3) {
; CHECK-LABEL: @inselt_shuf_no_demand_commute(
; CHECK-NEXT:    ret <4 x float> undef
;
  %out1 = insertelement <4 x float> poison, float %a1, i32 1
  %out12 = insertelement <4 x float> %out1, float %a2, i32 2
  %out123 = insertelement <4 x float> %out12, float %a3, i32 3
  %shuffle = shufflevector <4 x float> undef, <4 x float> %out123, <4 x i32> <i32 4, i32 undef, i32 undef, i32 undef>
  ret <4 x float> %shuffle
}

; The add uses 'out012' giving it multiple uses after the shuffle is transformed to also
; use 'out012'. The analysis should be able to see past that.

define <4 x i32> @inselt_shuf_no_demand_multiuse(i32 %a0, i32 %a1, <4 x i32> %b) {
; CHECK-LABEL: @inselt_shuf_no_demand_multiuse(
; CHECK-NEXT:    [[OUT0:%.*]] = insertelement <4 x i32> poison, i32 [[A0:%.*]], i64 0
; CHECK-NEXT:    [[OUT01:%.*]] = insertelement <4 x i32> [[OUT0]], i32 [[A1:%.*]], i64 1
; CHECK-NEXT:    [[FOO:%.*]] = add <4 x i32> [[OUT01]], [[B:%.*]]
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[FOO]], <4 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
; CHECK-NEXT:    ret <4 x i32> [[SHUFFLE]]
;
  %out0 = insertelement <4 x i32> poison, i32 %a0, i32 0
  %out01 = insertelement <4 x i32> %out0, i32 %a1, i32 1
  %out012 = insertelement <4 x i32> %out01, i32 %a0, i32 2
  %foo = add <4 x i32> %out012, %b
  %out0123 = insertelement <4 x i32> %foo, i32 %a1, i32 3
  %shuffle = shufflevector <4 x i32> %out0123, <4 x i32> poison, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  ret <4 x i32> %shuffle
}

define <4 x float> @inselt_shuf_no_demand_bogus_insert_index_in_chain(float %a1, float %a2, float %a3, i32 %variable_index) {
; CHECK-LABEL: @inselt_shuf_no_demand_bogus_insert_index_in_chain(
; CHECK-NEXT:    [[OUT12:%.*]] = insertelement <4 x float> poison, float [[A2:%.*]], i32 [[VARIABLE_INDEX:%.*]]
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x float> [[OUT12]], <4 x float> poison, <4 x i32> <i32 0, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    ret <4 x float> [[SHUFFLE]]
;
  %out1 = insertelement <4 x float> poison, float %a1, i32 1
  %out12 = insertelement <4 x float> %out1, float %a2, i32 %variable_index ; something unexpected
  %out123 = insertelement <4 x float> %out12, float %a3, i32 3
  %shuffle = shufflevector <4 x float> %out123, <4 x float> poison, <4 x i32> <i32 0, i32 undef, i32 undef, i32 undef>
  ret <4 x float> %shuffle
}

; Test undef replacement in constant vector elements with binops.

define <3 x i8> @shuf_add(<3 x i8> %x) {
; CHECK-LABEL: @shuf_add(
; CHECK-NEXT:    [[BO:%.*]] = add nsw <3 x i8> [[X:%.*]], <i8 poison, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 1, i32 poison, i32 2>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = add nsw <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 1, i32 undef, i32 2>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_sub(<3 x i8> %x) {
; CHECK-LABEL: @shuf_sub(
; CHECK-NEXT:    [[BO:%.*]] = sub nuw <3 x i8> <i8 1, i8 poison, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 0, i32 poison, i32 2>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = sub nuw <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 0, i32 undef, i32 2>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_mul(<3 x i8> %x) {
; CHECK-LABEL: @shuf_mul(
; CHECK-NEXT:    [[BO:%.*]] = mul nsw <3 x i8> [[X:%.*]], <i8 1, i8 poison, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 0, i32 2, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = mul nsw <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 0, i32 2, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_and(<3 x i8> %x) {
; CHECK-LABEL: @shuf_and(
; CHECK-NEXT:    [[BO:%.*]] = and <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 poison>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 1, i32 1, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = and <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 1, i32 1, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_or(<3 x i8> %x) {
; CHECK-LABEL: @shuf_or(
; CHECK-NEXT:    [[BO:%.*]] = or <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 poison>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 1, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = or <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 1, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_xor(<3 x i8> %x) {
; CHECK-LABEL: @shuf_xor(
; CHECK-NEXT:    [[BO:%.*]] = xor <3 x i8> [[X:%.*]], <i8 1, i8 poison, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = xor <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_lshr_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_lshr_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = lshr <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 1, i32 poison>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = lshr <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 1, i32 undef>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_lshr_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_lshr_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = lshr exact <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 1, i32 poison>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = lshr exact <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 1, i32 undef>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_ashr_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_ashr_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = lshr <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 0, i32 poison, i32 1>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = ashr <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 0, i32 undef, i32 1>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_ashr_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_ashr_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = ashr exact <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 0, i32 poison, i32 1>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = ashr exact <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 0, i32 undef, i32 1>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_shl_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_shl_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = shl nsw <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = shl nsw <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_shl_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_shl_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = shl nuw <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = shl nuw <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_sdiv_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_sdiv_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = sdiv exact <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 0, i32 poison, i32 1>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = sdiv exact <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 0, i32 undef, i32 1>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_sdiv_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_sdiv_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = sdiv <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 1, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = sdiv <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 1, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_srem_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_srem_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = srem <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 1, i32 poison, i32 2>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = srem <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 1, i32 undef, i32 2>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_srem_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_srem_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = srem <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 poison, i32 1>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = srem <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 undef, i32 1>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_udiv_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_udiv_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = udiv exact <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = udiv exact <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_udiv_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_udiv_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = udiv <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 poison, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = udiv <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 undef, i32 0>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_urem_const_op0(<3 x i8> %x) {
; CHECK-LABEL: @shuf_urem_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = urem <3 x i8> <i8 1, i8 2, i8 3>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 2, i32 1, i32 poison>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = urem <3 x i8> <i8 1, i8 2, i8 3>, %x
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 2, i32 1, i32 undef>
  ret <3 x i8> %r
}

define <3 x i8> @shuf_urem_const_op1(<3 x i8> %x) {
; CHECK-LABEL: @shuf_urem_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = urem <3 x i8> [[X:%.*]], <i8 1, i8 2, i8 3>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x i8> [[BO]], <3 x i8> poison, <3 x i32> <i32 poison, i32 1, i32 0>
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %bo = urem <3 x i8> %x, <i8 1, i8 2, i8 3>
  %r = shufflevector <3 x i8> %bo, <3 x i8> poison, <3 x i32> <i32 undef, i32 1, i32 0>
  ret <3 x i8> %r
}

define <3 x float> @shuf_fadd(<3 x float> %x) {
; CHECK-LABEL: @shuf_fadd(
; CHECK-NEXT:    [[BO:%.*]] = fadd <3 x float> [[X:%.*]], <float 1.000000e+00, float 2.000000e+00, float poison>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 poison, i32 1, i32 0>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = fadd <3 x float> %x, <float 1.0, float 2.0, float 3.0>
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 undef, i32 1, i32 0>
  ret <3 x float> %r
}

define <3 x float> @shuf_fsub(<3 x float> %x) {
; CHECK-LABEL: @shuf_fsub(
; CHECK-NEXT:    [[BO:%.*]] = fsub fast <3 x float> <float 1.000000e+00, float poison, float 3.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 poison, i32 0, i32 2>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = fsub fast <3 x float> <float 1.0, float 2.0, float 3.0>, %x
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 undef, i32 0, i32 2>
  ret <3 x float> %r
}

define <3 x float> @shuf_fmul(<3 x float> %x) {
; CHECK-LABEL: @shuf_fmul(
; CHECK-NEXT:    [[BO:%.*]] = fmul reassoc <3 x float> [[X:%.*]], <float 1.000000e+00, float 2.000000e+00, float poison>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 poison, i32 1, i32 0>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = fmul reassoc <3 x float> %x, <float 1.0, float 2.0, float 3.0>
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 undef, i32 1, i32 0>
  ret <3 x float> %r
}

define <3 x float> @shuf_fdiv_const_op0(<3 x float> %x) {
; CHECK-LABEL: @shuf_fdiv_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = fdiv reassoc ninf <3 x float> <float 1.000000e+00, float poison, float 3.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 poison, i32 0, i32 2>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = fdiv ninf reassoc <3 x float> <float 1.0, float 2.0, float 3.0>, %x
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 undef, i32 0, i32 2>
  ret <3 x float> %r
}

define <3 x float> @shuf_fdiv_const_op1(<3 x float> %x) {
; CHECK-LABEL: @shuf_fdiv_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = fdiv nnan ninf <3 x float> [[X:%.*]], <float 1.000000e+00, float 2.000000e+00, float poison>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 poison, i32 1, i32 0>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = fdiv ninf nnan <3 x float> %x, <float 1.0, float 2.0, float 3.0>
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 undef, i32 1, i32 0>
  ret <3 x float> %r
}

define <3 x float> @shuf_frem_const_op0(<3 x float> %x) {
; CHECK-LABEL: @shuf_frem_const_op0(
; CHECK-NEXT:    [[BO:%.*]] = frem nnan <3 x float> <float 1.000000e+00, float poison, float 3.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 poison, i32 2, i32 0>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = frem nnan <3 x float> <float 1.0, float 2.0, float 3.0>, %x
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 undef, i32 2, i32 0>
  ret <3 x float> %r
}

define <3 x float> @shuf_frem_const_op1(<3 x float> %x) {
; CHECK-LABEL: @shuf_frem_const_op1(
; CHECK-NEXT:    [[BO:%.*]] = frem reassoc ninf <3 x float> [[X:%.*]], <float poison, float 2.000000e+00, float 3.000000e+00>
; CHECK-NEXT:    [[R:%.*]] = shufflevector <3 x float> [[BO]], <3 x float> poison, <3 x i32> <i32 1, i32 poison, i32 2>
; CHECK-NEXT:    ret <3 x float> [[R]]
;
  %bo = frem ninf reassoc <3 x float> %x, <float 1.0, float 2.0, float 3.0>
  %r = shufflevector <3 x float> %bo, <3 x float> poison, <3 x i32> <i32 1, i32 undef, i32 2>
  ret <3 x float> %r
}

define ptr @gep_vbase_w_s_idx(<2 x ptr> %base, i64 %index) {
; CHECK-LABEL: @gep_vbase_w_s_idx(
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x ptr> [[BASE:%.*]], i64 1
; CHECK-NEXT:    [[EE:%.*]] = getelementptr i32, ptr [[TMP1]], i64 [[INDEX:%.*]]
; CHECK-NEXT:    ret ptr [[EE]]
;
  %gep = getelementptr i32, <2 x ptr> %base, i64 %index
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}

define ptr @gep_splat_base_w_s_idx(ptr %base) {
; CHECK-LABEL: @gep_splat_base_w_s_idx(
; CHECK-NEXT:    [[EE:%.*]] = getelementptr i32, ptr [[BASE:%.*]], i64 1
; CHECK-NEXT:    ret ptr [[EE]]
;
  %basevec1 = insertelement <2 x ptr> poison, ptr %base, i32 0
  %basevec2 = shufflevector <2 x ptr> %basevec1, <2 x ptr> poison, <2 x i32> zeroinitializer
  %gep = getelementptr i32, <2 x ptr> %basevec2, i64 1
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}


define ptr @gep_splat_base_w_cv_idx(ptr %base) {
; CHECK-LABEL: @gep_splat_base_w_cv_idx(
; CHECK-NEXT:    [[BASEVEC2:%.*]] = insertelement <2 x ptr> poison, ptr [[BASE:%.*]], i64 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, <2 x ptr> [[BASEVEC2]], <2 x i64> <i64 poison, i64 1>
; CHECK-NEXT:    [[EE:%.*]] = extractelement <2 x ptr> [[GEP]], i64 1
; CHECK-NEXT:    ret ptr [[EE]]
;
  %basevec1 = insertelement <2 x ptr> poison, ptr %base, i32 0
  %basevec2 = shufflevector <2 x ptr> %basevec1, <2 x ptr> poison, <2 x i32> zeroinitializer
  %gep = getelementptr i32, <2 x ptr> %basevec2, <2 x i64> <i64 0, i64 1>
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}

define ptr @gep_splat_base_w_vidx(ptr %base, <2 x i64> %idxvec) {
; CHECK-LABEL: @gep_splat_base_w_vidx(
; CHECK-NEXT:    [[BASEVEC2:%.*]] = insertelement <2 x ptr> poison, ptr [[BASE:%.*]], i64 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, <2 x ptr> [[BASEVEC2]], <2 x i64> [[IDXVEC:%.*]]
; CHECK-NEXT:    [[EE:%.*]] = extractelement <2 x ptr> [[GEP]], i64 1
; CHECK-NEXT:    ret ptr [[EE]]
;
  %basevec1 = insertelement <2 x ptr> poison, ptr %base, i32 0
  %basevec2 = shufflevector <2 x ptr> %basevec1, <2 x ptr> poison, <2 x i32> zeroinitializer
  %gep = getelementptr i32, <2 x ptr> %basevec2, <2 x i64> %idxvec
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}


@GLOBAL = internal global i32 zeroinitializer

define ptr @gep_cvbase_w_s_idx(<2 x ptr> %base, i64 %raw_addr) {
; CHECK-LABEL: @gep_cvbase_w_s_idx(
; CHECK-NEXT:    [[EE:%.*]] = getelementptr i32, ptr @GLOBAL, i64 [[RAW_ADDR:%.*]]
; CHECK-NEXT:    ret ptr [[EE]]
;
  %gep = getelementptr i32, <2 x ptr> <ptr @GLOBAL, ptr @GLOBAL>, i64 %raw_addr
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}

define ptr @gep_cvbase_w_cv_idx(<2 x ptr> %base, i64 %raw_addr) {
; CHECK-LABEL: @gep_cvbase_w_cv_idx(
; CHECK-NEXT:    ret ptr getelementptr inbounds (i32, ptr @GLOBAL, i64 1)
;
  %gep = getelementptr i32, <2 x ptr> <ptr @GLOBAL, ptr @GLOBAL>, <2 x i64> <i64 0, i64 1>
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}


define ptr @gep_sbase_w_cv_idx(ptr %base) {
; CHECK-LABEL: @gep_sbase_w_cv_idx(
; CHECK-NEXT:    [[EE:%.*]] = getelementptr i32, ptr [[BASE:%.*]], i64 1
; CHECK-NEXT:    ret ptr [[EE]]
;
  %gep = getelementptr i32, ptr %base, <2 x i64> <i64 0, i64 1>
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}

define ptr @gep_sbase_w_splat_idx(ptr %base, i64 %idx) {
; CHECK-LABEL: @gep_sbase_w_splat_idx(
; CHECK-NEXT:    [[EE:%.*]] = getelementptr i32, ptr [[BASE:%.*]], i64 [[IDX:%.*]]
; CHECK-NEXT:    ret ptr [[EE]]
;
  %idxvec1 = insertelement <2 x i64> poison, i64 %idx, i32 0
  %idxvec2 = shufflevector <2 x i64> %idxvec1, <2 x i64> poison, <2 x i32> zeroinitializer
  %gep = getelementptr i32, ptr %base, <2 x i64> %idxvec2
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}
define ptr @gep_splat_both(ptr %base, i64 %idx) {
; CHECK-LABEL: @gep_splat_both(
; CHECK-NEXT:    [[BASEVEC2:%.*]] = insertelement <2 x ptr> poison, ptr [[BASE:%.*]], i64 1
; CHECK-NEXT:    [[IDXVEC2:%.*]] = insertelement <2 x i64> poison, i64 [[IDX:%.*]], i64 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, <2 x ptr> [[BASEVEC2]], <2 x i64> [[IDXVEC2]]
; CHECK-NEXT:    [[EE:%.*]] = extractelement <2 x ptr> [[GEP]], i64 1
; CHECK-NEXT:    ret ptr [[EE]]
;
  %basevec1 = insertelement <2 x ptr> poison, ptr %base, i32 0
  %basevec2 = shufflevector <2 x ptr> %basevec1, <2 x ptr> poison, <2 x i32> zeroinitializer
  %idxvec1 = insertelement <2 x i64> poison, i64 %idx, i32 0
  %idxvec2 = shufflevector <2 x i64> %idxvec1, <2 x i64> poison, <2 x i32> zeroinitializer
  %gep = getelementptr i32, <2 x ptr> %basevec2, <2 x i64> %idxvec2
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}

define <2 x ptr> @gep_all_lanes_undef(ptr %base, i64 %idx) {;
; CHECK-LABEL: @gep_all_lanes_undef(
; CHECK-NEXT:    [[BASEVEC:%.*]] = insertelement <2 x ptr> poison, ptr [[BASE:%.*]], i64 0
; CHECK-NEXT:    [[IDXVEC:%.*]] = insertelement <2 x i64> poison, i64 [[IDX:%.*]], i64 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, <2 x ptr> [[BASEVEC]], <2 x i64> [[IDXVEC]]
; CHECK-NEXT:    ret <2 x ptr> [[GEP]]
;
  %basevec = insertelement <2 x ptr> poison, ptr %base, i32 0
  %idxvec = insertelement <2 x i64> poison, i64 %idx, i32 1
  %gep = getelementptr i32, <2 x ptr> %basevec, <2 x i64> %idxvec
  ret <2 x ptr> %gep
}

define ptr @gep_demanded_lane_undef(ptr %base, i64 %idx) {
; CHECK-LABEL: @gep_demanded_lane_undef(
; CHECK-NEXT:    ret ptr undef
;
  %basevec = insertelement <2 x ptr> poison, ptr %base, i32 0
  %idxvec = insertelement <2 x i64> poison, i64 %idx, i32 1
  %gep = getelementptr i32, <2 x ptr> %basevec, <2 x i64> %idxvec
  %ee = extractelement <2 x ptr> %gep, i32 1
  ret ptr %ee
}


;; LangRef has an odd quirk around FCAs which make it illegal to use undef
;; indices.
define ptr @PR41624(<2 x ptr> %a) {
; CHECK-LABEL: @PR41624(
; CHECK-NEXT:    [[W:%.*]] = getelementptr { i32, i32 }, <2 x ptr> [[A:%.*]], <2 x i64> <i64 5, i64 5>, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[R:%.*]] = extractelement <2 x ptr> [[W]], i64 0
; CHECK-NEXT:    ret ptr [[R]]
;
  %w = getelementptr { i32, i32 }, <2 x ptr> %a, <2 x i64> <i64 5, i64 5>, <2 x i32> zeroinitializer
  %r = extractelement <2 x ptr> %w, i32 0
  ret ptr %r
}

@global = external global [0 x i32], align 4

; Make sure we don't get stuck in a loop turning the zeroinitializer into
; <0, undef, undef, undef> and then changing it back.
define ptr @zero_sized_type_extract(<4 x i64> %arg, i64 %arg1) {
; CHECK-LABEL: @zero_sized_type_extract(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[T:%.*]] = getelementptr inbounds [0 x i32], <4 x ptr> <ptr @global, ptr poison, ptr poison, ptr poison>, <4 x i64> <i64 0, i64 poison, i64 poison, i64 poison>, <4 x i64> [[ARG:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = extractelement <4 x ptr> [[T]], i64 0
; CHECK-NEXT:    ret ptr [[T2]]
;
bb:
  %t = getelementptr inbounds [0 x i32], <4 x ptr> <ptr @global, ptr @global, ptr @global, ptr @global>, <4 x i64> zeroinitializer, <4 x i64> %arg
  %t2 = extractelement <4 x ptr> %t, i64 0
  ret ptr %t2
}

; The non-zero elements of the result are always 'y', so the splat is unnecessary.

define <4 x i8> @select_cond_with_eq_true_false_elts(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @select_cond_with_eq_true_false_elts(
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x i8> [[SEL]], <4 x i8> [[Y]], <4 x i32> <i32 0, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %tval = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 6, i32 7>
  %splat = shufflevector <4 x i1> %cmp, <4 x i1> poison, <4 x i32> zeroinitializer
  %r = select <4 x i1> %splat, <4 x i8> %tval, <4 x i8> %y
  ret <4 x i8> %r
}

; First element of the result is always x[0], so first element of select condition is unnecessary.

define <4 x i8> @select_cond_with_eq_true_false_elts2(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @select_cond_with_eq_true_false_elts2(
; CHECK-NEXT:    [[COND:%.*]] = shufflevector <4 x i1> [[CMP:%.*]], <4 x i1> poison, <4 x i32> <i32 poison, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[COND]], <4 x i8> [[Y:%.*]], <4 x i8> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x i8> [[X]], <4 x i8> [[SEL]], <4 x i32> <i32 0, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %tval = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 6, i32 7>
  %cond = shufflevector <4 x i1> %cmp, <4 x i1> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %r = select <4 x i1> %cond, <4 x i8> %tval, <4 x i8> %x
  ret <4 x i8> %r
}

; Second element of the result is always x[3], so second element of select condition is unnecessary.
; Fourth element of the result is always undef, so fourth element of select condition is unnecessary.

define <4 x float> @select_cond_with_eq_true_false_elts3(<4 x float> %x, <4 x float> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @select_cond_with_eq_true_false_elts3(
; CHECK-NEXT:    [[TVAL:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> [[Y:%.*]], <4 x i32> <i32 1, i32 3, i32 5, i32 poison>
; CHECK-NEXT:    [[FVAL:%.*]] = shufflevector <4 x float> [[Y]], <4 x float> [[X]], <4 x i32> <i32 0, i32 7, i32 6, i32 poison>
; CHECK-NEXT:    [[COND:%.*]] = shufflevector <4 x i1> [[CMP:%.*]], <4 x i1> poison, <4 x i32> <i32 poison, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[COND]], <4 x float> [[TVAL]], <4 x float> [[FVAL]]
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %tval = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 1, i32 3, i32 5, i32 undef>
  %fval = shufflevector <4 x float> %y, <4 x float> %x, <4 x i32> <i32 0, i32 7, i32 6, i32 undef>
  %cond = shufflevector <4 x i1> %cmp, <4 x i1> poison, <4 x i32> <i32 undef, i32 1, i32 2, i32 3>
  %r = select <4 x i1> %cond, <4 x float> %tval, <4 x float> %fval
  ret <4 x float> %r
}

define <4 x i8> @select_cond_with_undef_true_false_elts(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @select_cond_with_undef_true_false_elts(
; CHECK-NEXT:    [[TVAL:%.*]] = shufflevector <4 x i8> [[Y:%.*]], <4 x i8> poison, <4 x i32> <i32 poison, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[COND:%.*]] = shufflevector <4 x i1> [[CMP:%.*]], <4 x i1> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[COND]], <4 x i8> [[TVAL]], <4 x i8> [[X:%.*]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %tval = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 undef, i32 5, i32 6, i32 7>
  %cond = shufflevector <4 x i1> %cmp, <4 x i1> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %r = select <4 x i1> %cond, <4 x i8> %tval, <4 x i8> %x
  ret <4 x i8> %r
}

; The insert can be safely eliminated because the shuffle blocks poison from cmp[0].

define <4 x i8> @select_cond_(<4 x i8> %x, <4 x i8> %min, <4 x i1> %cmp, i1 %poison_blocker) {
; CHECK-LABEL: @select_cond_(
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[MIN:%.*]], <4 x i8> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x i8> [[X]], <4 x i8> [[SEL]], <4 x i32> <i32 0, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %ins = insertelement <4 x i1> %cmp, i1 %poison_blocker, i32 0
  %vecins = shufflevector <4 x i8> %x, <4 x i8> %min, <4 x i32> <i32 0, i32 5, i32 6, i32 7>
  %r = select <4 x i1> %ins, <4 x i8> %vecins, <4 x i8> %x
  ret <4 x i8> %r
}

define <4 x float> @ins_of_ext(<4 x float> %x, float %y) {
; CHECK-LABEL: @ins_of_ext(
; CHECK-NEXT:    [[I1:%.*]] = insertelement <4 x float> [[X:%.*]], float [[Y:%.*]], i64 1
; CHECK-NEXT:    [[I2:%.*]] = insertelement <4 x float> [[I1]], float [[Y]], i64 2
; CHECK-NEXT:    [[I3:%.*]] = insertelement <4 x float> [[I2]], float [[Y]], i64 3
; CHECK-NEXT:    ret <4 x float> [[I3]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  %i0 = insertelement <4 x float> poison, float %e0, i32 0
  %i1 = insertelement <4 x float> %i0, float %y, i32 1
  %i2 = insertelement <4 x float> %i1, float %y, i32 2
  %i3 = insertelement <4 x float> %i2, float %y, i32 3
  ret <4 x float> %i3
}

define <4 x float> @ins_of_ext_twice(<4 x float> %x, float %y) {
; CHECK-LABEL: @ins_of_ext_twice(
; CHECK-NEXT:    [[I2:%.*]] = insertelement <4 x float> [[X:%.*]], float [[Y:%.*]], i64 2
; CHECK-NEXT:    [[I3:%.*]] = insertelement <4 x float> [[I2]], float [[Y]], i64 3
; CHECK-NEXT:    ret <4 x float> [[I3]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  %i0 = insertelement <4 x float> poison, float %e0, i32 0
  %e1 = extractelement <4 x float> %x, i32 1
  %i1 = insertelement <4 x float> %i0, float %e1, i32 1
  %i2 = insertelement <4 x float> %i1, float %y, i32 2
  %i3 = insertelement <4 x float> %i2, float %y, i32 3
  ret <4 x float> %i3
}

; Negative test - element 3 of the result must be undef to be poison safe.
; TODO: Could convert insert/extract to identity shuffle with undef mask elements.

define <4 x float> @ins_of_ext_wrong_demand(<4 x float> %x, float %y) {
; CHECK-LABEL: @ins_of_ext_wrong_demand(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <4 x float> [[X:%.*]], i64 0
; CHECK-NEXT:    [[I0:%.*]] = insertelement <4 x float> poison, float [[E0]], i64 0
; CHECK-NEXT:    [[I1:%.*]] = insertelement <4 x float> [[I0]], float [[Y:%.*]], i64 1
; CHECK-NEXT:    [[I2:%.*]] = insertelement <4 x float> [[I1]], float [[Y]], i64 2
; CHECK-NEXT:    ret <4 x float> [[I2]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  %i0 = insertelement <4 x float> poison, float %e0, i32 0
  %i1 = insertelement <4 x float> %i0, float %y, i32 1
  %i2 = insertelement <4 x float> %i1, float %y, i32 2
  ret <4 x float> %i2
}

; Negative test - can't replace i0 with x.
; TODO: Could convert insert/extract to identity shuffle with undef mask elements.

define <4 x float> @ins_of_ext_wrong_type(<5 x float> %x, float %y) {
; CHECK-LABEL: @ins_of_ext_wrong_type(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <5 x float> [[X:%.*]], i64 0
; CHECK-NEXT:    [[I0:%.*]] = insertelement <4 x float> poison, float [[E0]], i64 0
; CHECK-NEXT:    [[I1:%.*]] = insertelement <4 x float> [[I0]], float [[Y:%.*]], i64 1
; CHECK-NEXT:    [[I2:%.*]] = insertelement <4 x float> [[I1]], float [[Y]], i64 2
; CHECK-NEXT:    [[I3:%.*]] = insertelement <4 x float> [[I2]], float [[Y]], i64 3
; CHECK-NEXT:    ret <4 x float> [[I3]]
;
  %e0 = extractelement <5 x float> %x, i32 0
  %i0 = insertelement <4 x float> poison, float %e0, i32 0
  %i1 = insertelement <4 x float> %i0, float %y, i32 1
  %i2 = insertelement <4 x float> %i1, float %y, i32 2
  %i3 = insertelement <4 x float> %i2, float %y, i32 3
  ret <4 x float> %i3
}

; This should reduce, but the shuffle mask must remain as-is (no extra undef).

define <4 x i4> @ins_of_ext_undef_elts_propagation(<4 x i4> %v, <4 x i4> %v2, i4 %x) {
; CHECK-LABEL: @ins_of_ext_undef_elts_propagation(
; CHECK-NEXT:    [[T2:%.*]] = insertelement <4 x i4> [[V:%.*]], i4 [[X:%.*]], i64 2
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x i4> [[T2]], <4 x i4> [[V2:%.*]], <4 x i32> <i32 0, i32 6, i32 2, i32 7>
; CHECK-NEXT:    ret <4 x i4> [[R]]
;
  %v0 = extractelement <4 x i4> %v, i32 0
  %t0 = insertelement <4 x i4> poison, i4 %v0, i32 0
  %t2 = insertelement <4 x i4> %t0, i4 %x, i32 2
  %r = shufflevector <4 x i4> %t2, <4 x i4> %v2, <4 x i32> <i32 0, i32 6, i32 2, i32 7>
  ret <4 x i4> %r
}

; Similar to above, but more ops/uses to verify things work in more complicated cases.

define <8 x i4> @ins_of_ext_undef_elts_propagation2(<8 x i4> %v, <8 x i4> %v2, i4 %x) {
; CHECK-LABEL: @ins_of_ext_undef_elts_propagation2(
; CHECK-NEXT:    [[I19:%.*]] = insertelement <8 x i4> [[V:%.*]], i4 [[X:%.*]], i64 2
; CHECK-NEXT:    [[I20:%.*]] = shufflevector <8 x i4> [[I19]], <8 x i4> [[V2:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 11, i32 10, i32 9, i32 8, i32 poison>
; CHECK-NEXT:    [[I21:%.*]] = shufflevector <8 x i4> [[I20]], <8 x i4> [[V]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 15>
; CHECK-NEXT:    ret <8 x i4> [[I21]]
;
  %i15 = extractelement <8 x i4> %v, i32 0
  %i16 = insertelement <8 x i4> poison, i4 %i15, i32 0
  %i17 = extractelement <8 x i4> %v, i32 1
  %i18 = insertelement <8 x i4> %i16, i4 %i17, i32 1
  %i19 = insertelement <8 x i4> %i18, i4 %x, i32 2
  %i20 = shufflevector <8 x i4> %i19, <8 x i4> %v2, <8 x i32> <i32 0, i32 1, i32 2, i32 11, i32 10, i32 9, i32 8, i32 undef>
  %i21 = shufflevector <8 x i4> %i20, <8 x i4> %v, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 15>
  ret <8 x i4> %i21
}

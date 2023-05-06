; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer,dce -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.7.0"

@.str = private unnamed_addr constant [6 x i8] c"bingo\00", align 1

; Uses inside the tree must be scheduled after the corresponding tree bundle.
define void @in_tree_user(ptr nocapture %A, i32 %n) {
; CHECK-LABEL: @in_tree_user(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CONV:%.*]] = sitofp i32 [[N:%.*]] to double
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x double> poison, double [[CONV]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x double> [[TMP0]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = shl nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[A:%.*]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x double>, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = fmul <2 x double> [[SHUFFLE]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP4]], <double 7.000000e+00, double 4.000000e+00>
; CHECK-NEXT:    [[TMP6:%.*]] = fadd <2 x double> [[TMP5]], <double 5.000000e+00, double 9.000000e+00>
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP6]], i32 0
; CHECK-NEXT:    [[INTREEUSER:%.*]] = fadd double [[TMP7]], [[TMP7]]
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x double> [[TMP6]], i32 1
; CHECK-NEXT:    [[CMP11:%.*]] = fcmp ogt double [[TMP7]], [[TMP8]]
; CHECK-NEXT:    br i1 [[CMP11]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CALL:%.*]] = tail call i32 (ptr, ...) @printf(ptr @.str)
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[LFTR_WIDEIV]], 100
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    store double [[INTREEUSER]], ptr [[A]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %conv = sitofp i32 %n to double
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.inc ]
  %0 = shl nsw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds double, ptr %A, i64 %0
  %1 = load double, ptr %arrayidx, align 8
  %mul1 = fmul double %conv, %1
  %mul2 = fmul double %mul1, 7.000000e+00
  %add = fadd double %mul2, 5.000000e+00
  %InTreeUser = fadd double %add, %add    ; <------------------ In tree user.
  %2 = or i64 %0, 1
  %arrayidx6 = getelementptr inbounds double, ptr %A, i64 %2
  %3 = load double, ptr %arrayidx6, align 8
  %mul8 = fmul double %conv, %3
  %mul9 = fmul double %mul8, 4.000000e+00
  %add10 = fadd double %mul9, 9.000000e+00
  %cmp11 = fcmp ogt double %add, %add10
  br i1 %cmp11, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %call = tail call i32 (ptr, ...) @printf(ptr @.str)
  br label %for.inc

for.inc:                                          ; preds = %for.body, %if.then
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 100
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.inc
  store double %InTreeUser, ptr %A, align 8   ; Avoid dead code elimination of the InTreeUser.
  ret void
}

declare i32 @printf(ptr nocapture, ...)


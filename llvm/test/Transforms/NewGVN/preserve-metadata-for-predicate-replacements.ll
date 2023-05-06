; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=newgvn %s -S | FileCheck %s

declare void @use(i32)

; Make sure !tbaa metadata is preserved when only ssa_copy calls introduced by
; PredicateInfo are replaced.

define i32 @test(ptr %p1, ptr %p2, i1 %c) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[P1:%.*]], align 8, !tbaa !0
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp slt i32 [[LV]], 1
; CHECK-NEXT:    br i1 [[CMP_1]], label [[EXIT:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if.false:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT]], label [[FOR_CHECK:%.*]]
; CHECK:       for.check:
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sgt i32 [[LV]], 0
; CHECK-NEXT:    br i1 [[CMP_2]], label [[FOR_PH:%.*]], label [[EXIT]]
; CHECK:       for.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[FOR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    call void @use(i32 [[IV]])
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[CMP_3:%.*]] = icmp ne i32 [[IV_NEXT]], [[LV]]
; CHECK-NEXT:    br i1 [[CMP_3]], label [[FOR_BODY]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[LV]]
;
entry:
  %lv = load i32, ptr %p1, align 8, !tbaa !0
  %cmp.1 = icmp slt i32 %lv, 1
  br i1 %cmp.1, label %exit, label %if.false

if.false:                                         ; preds = %entry
  br i1 %c, label %exit, label %for.check

for.check:                                        ; preds = %if.false
  %cmp.2 = icmp sgt i32 %lv, 0
  br i1 %cmp.2, label %for.ph, label %exit

for.ph:                                           ; preds = %for.check
  br label %for.body

for.body:                                         ; preds = %for.body, %for.ph
  %iv = phi i32 [ 0, %for.ph ], [ %iv.next, %for.body ]
  call void @use(i32 %iv)
  %iv.next = add nuw nsw i32 %iv, 1
  %cmp.3 = icmp ne i32 %iv.next, %lv
  br i1 %cmp.3, label %for.body, label %exit

exit:                                            ; preds = %for.body, %for.check, %if.false, %entry
  ret i32 %lv
}

!0 = !{!1, !2, i64 0}
!1 = !{!"FULL", !2, i64 0, !2, i64 4, !3, i64 8}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}

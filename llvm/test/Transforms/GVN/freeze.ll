; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=gvn -S | FileCheck %s

define i1 @f(i1 %a) {
; CHECK-LABEL: @f(
; CHECK-NEXT:    [[B:%.*]] = freeze i1 [[A:%.*]]
; CHECK-NEXT:    ret i1 [[B]]
;
  %b = freeze i1 %a
  %c = freeze i1 %a
  %d = and i1 %b, %b
  ret i1 %d
}

define void @f_multipleuses(i1 %a) {
; CHECK-LABEL: @f_multipleuses(
; CHECK-NEXT:    [[B:%.*]] = freeze i1 [[A:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[B]])
; CHECK-NEXT:    call void @use1(i1 [[B]])
; CHECK-NEXT:    call void @use1(i1 [[B]])
; CHECK-NEXT:    ret void
;
  %b = freeze i1 %a
  %c = freeze i1 %a
  call void @use1(i1 %b)
  call void @use1(i1 %c)
  call void @use1(i1 %c)
  ret void
}

define void @f_dom(i1 %cond, i1 %a) {
; CHECK-LABEL: @f_dom(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       BB1:
; CHECK-NEXT:    [[X:%.*]] = freeze i1 [[A:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[X]])
; CHECK-NEXT:    ret void
; CHECK:       BB2:
; CHECK-NEXT:    [[Y:%.*]] = freeze i1 [[A]]
; CHECK-NEXT:    call void @use2(i1 [[Y]])
; CHECK-NEXT:    ret void
;
  br i1 %cond, label %BB1, label %BB2
BB1:
  %x = freeze i1 %a
  call void @use1(i1 %x)
  ret void
BB2:
  %y = freeze i1 %a
  call void @use2(i1 %y) ; cannot use %x
  ret void
}
declare void @use1(i1)
declare void @use2(i1)


; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt < %s -S -passes=ipsccp | FileCheck %s

; testf() performs an unconditional branch on undef, as such the testf() return
; value used in test1() will remain "unknown" and the following branch on it
; replaced by unreachable. This is fine, as the call to testf() will already
; trigger undefined behavior.
define void @test1() {
; CHECK-LABEL: define {{[^@]+}}@test1() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CALL:%.*]] = call i1 @testf()
; CHECK-NEXT:    unreachable
;
entry:
  br label %if.then
if.then:                                          ; preds = %entry, %if.then
  %foo = phi i32 [ 0, %entry], [ %next, %if.then]
  %next = add i32 %foo, 1
  %call = call i1 @testf()
  br i1 %call, label %if.end, label %if.then

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define internal i1 @testf() {
; CHECK-LABEL: define {{[^@]+}}@testf() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
;
entry:
  br i1 undef, label %if.then1, label %if.end3

if.then1:                                         ; preds = %if.end
  br label %if.end3

if.end3:                                          ; preds = %if.then1, %entry
  ret i1 true
}

; Call sites in unreachable blocks should not be a problem.
define i1 @test2() {
; CHECK-LABEL: define {{[^@]+}}@test2() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CALL2:%.*]] = call i1 @testf()
; CHECK-NEXT:    ret i1 undef
;
entry:
  br label %if.end

if.then:                                          ; preds = %entry, %if.then
  %call = call i1 @testf()
  br i1 %call, label %if.end, label %if.then

if.end:                                           ; preds = %if.then, %entry
  %call2 = call i1 @testf()
  ret i1 %call2
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 1, 0
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[CMP]], i32 1, i32 0
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.smin.i32(i32 [[SPEC_SELECT]], i32 1)
; CHECK-NEXT:    br label [[IF_END20:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END20]]
; CHECK:       if.end20:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i32 [ undef, [[IF_ELSE]] ], [ [[TMP0]], [[IF_THEN]] ]
; CHECK-NEXT:    ret void
;
entry:
  br i1 false, label %if.else, label %if.then

if.then:
  %cmp = icmp slt i32 1, 0
  %spec.select = select i1 %cmp, i32 1, i32 0
  %0 = call i32 @llvm.smin.i32(i32 %spec.select, i32 1)
  br label %if.end20

if.else:
  br label %if.end20

if.end20:
  %1 = phi i32 [ undef, %if.else ], [ %0, %if.then ]
  ret void
}

declare i32 @llvm.smin.i32(i32, i32)

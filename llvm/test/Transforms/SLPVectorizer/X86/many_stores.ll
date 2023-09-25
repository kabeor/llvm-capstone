; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux < %s | FileCheck %s

define i32 @test(ptr %p) {
; CHECK-LABEL: define i32 @test
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[IDX2:%.*]] = getelementptr i32, ptr [[P]], i64 4
; CHECK-NEXT:    store i32 0, ptr [[IDX2]], align 4
; CHECK-NEXT:    [[IDX3:%.*]] = getelementptr i32, ptr [[P]], i64 6
; CHECK-NEXT:    store i32 0, ptr [[IDX3]], align 4
; CHECK-NEXT:    [[IDX4:%.*]] = getelementptr i32, ptr [[P]], i64 8
; CHECK-NEXT:    store i32 0, ptr [[IDX4]], align 4
; CHECK-NEXT:    [[IDX5:%.*]] = getelementptr i32, ptr [[P]], i64 10
; CHECK-NEXT:    store i32 0, ptr [[IDX5]], align 4
; CHECK-NEXT:    [[IDX6:%.*]] = getelementptr i32, ptr [[P]], i64 12
; CHECK-NEXT:    store i32 0, ptr [[IDX6]], align 4
; CHECK-NEXT:    [[IDX7:%.*]] = getelementptr i32, ptr [[P]], i64 14
; CHECK-NEXT:    store i32 0, ptr [[IDX7]], align 4
; CHECK-NEXT:    [[IDX8:%.*]] = getelementptr i32, ptr [[P]], i64 16
; CHECK-NEXT:    store i32 0, ptr [[IDX8]], align 4
; CHECK-NEXT:    [[IDX9:%.*]] = getelementptr i32, ptr [[P]], i64 18
; CHECK-NEXT:    store i32 0, ptr [[IDX9]], align 4
; CHECK-NEXT:    [[IDX10:%.*]] = getelementptr i32, ptr [[P]], i64 20
; CHECK-NEXT:    store i32 0, ptr [[IDX10]], align 4
; CHECK-NEXT:    [[IDX11:%.*]] = getelementptr i32, ptr [[P]], i64 22
; CHECK-NEXT:    store i32 0, ptr [[IDX11]], align 4
; CHECK-NEXT:    [[IDX12:%.*]] = getelementptr i32, ptr [[P]], i64 24
; CHECK-NEXT:    store i32 0, ptr [[IDX12]], align 4
; CHECK-NEXT:    [[IDX13:%.*]] = getelementptr i32, ptr [[P]], i64 26
; CHECK-NEXT:    store i32 0, ptr [[IDX13]], align 4
; CHECK-NEXT:    [[IDX14:%.*]] = getelementptr i32, ptr [[P]], i64 28
; CHECK-NEXT:    store i32 0, ptr [[IDX14]], align 4
; CHECK-NEXT:    [[IDX15:%.*]] = getelementptr i32, ptr [[P]], i64 30
; CHECK-NEXT:    store i32 0, ptr [[IDX15]], align 4
; CHECK-NEXT:    [[IDX16:%.*]] = getelementptr i32, ptr [[P]], i64 32
; CHECK-NEXT:    store i32 0, ptr [[IDX16]], align 4
; CHECK-NEXT:    [[IDX18:%.*]] = getelementptr i32, ptr [[P]], i64 36
; CHECK-NEXT:    store i32 0, ptr [[IDX18]], align 4
; CHECK-NEXT:    [[IDX19:%.*]] = getelementptr i32, ptr [[P]], i64 38
; CHECK-NEXT:    store i32 0, ptr [[IDX19]], align 4
; CHECK-NEXT:    [[IDX20:%.*]] = getelementptr i32, ptr [[P]], i64 40
; CHECK-NEXT:    store i32 0, ptr [[IDX20]], align 4
; CHECK-NEXT:    [[IDX21:%.*]] = getelementptr i32, ptr [[P]], i64 42
; CHECK-NEXT:    store i32 0, ptr [[IDX21]], align 4
; CHECK-NEXT:    [[IDX22:%.*]] = getelementptr i32, ptr [[P]], i64 44
; CHECK-NEXT:    store i32 0, ptr [[IDX22]], align 4
; CHECK-NEXT:    [[IDX23:%.*]] = getelementptr i32, ptr [[P]], i64 46
; CHECK-NEXT:    store i32 0, ptr [[IDX23]], align 4
; CHECK-NEXT:    [[IDX24:%.*]] = getelementptr i32, ptr [[P]], i64 48
; CHECK-NEXT:    store i32 0, ptr [[IDX24]], align 4
; CHECK-NEXT:    [[IDX25:%.*]] = getelementptr i32, ptr [[P]], i64 50
; CHECK-NEXT:    store i32 0, ptr [[IDX25]], align 4
; CHECK-NEXT:    [[IDX26:%.*]] = getelementptr i32, ptr [[P]], i64 52
; CHECK-NEXT:    store i32 0, ptr [[IDX26]], align 4
; CHECK-NEXT:    [[IDX27:%.*]] = getelementptr i32, ptr [[P]], i64 54
; CHECK-NEXT:    store i32 0, ptr [[IDX27]], align 4
; CHECK-NEXT:    [[IDX28:%.*]] = getelementptr i32, ptr [[P]], i64 56
; CHECK-NEXT:    store i32 0, ptr [[IDX28]], align 4
; CHECK-NEXT:    [[IDX29:%.*]] = getelementptr i32, ptr [[P]], i64 58
; CHECK-NEXT:    store i32 0, ptr [[IDX29]], align 4
; CHECK-NEXT:    [[IDX30:%.*]] = getelementptr i32, ptr [[P]], i64 60
; CHECK-NEXT:    store i32 0, ptr [[IDX30]], align 4
; CHECK-NEXT:    [[IDX31:%.*]] = getelementptr i32, ptr [[P]], i64 62
; CHECK-NEXT:    store i32 0, ptr [[IDX31]], align 4
; CHECK-NEXT:    [[IDX32:%.*]] = getelementptr i32, ptr [[P]], i64 64
; CHECK-NEXT:    store i32 0, ptr [[IDX32]], align 4
; CHECK-NEXT:    [[IDX33:%.*]] = getelementptr i32, ptr [[P]], i64 66
; CHECK-NEXT:    store i32 0, ptr [[IDX33]], align 4
; CHECK-NEXT:    store i32 0, ptr [[P]], align 4
; CHECK-NEXT:    [[IDX0:%.*]] = getelementptr i32, ptr [[P]], i64 3
; CHECK-NEXT:    store i32 0, ptr [[IDX0]], align 4
; CHECK-NEXT:    [[IDX1:%.*]] = getelementptr i32, ptr [[P]], i64 5
; CHECK-NEXT:    store i32 0, ptr [[IDX1]], align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %idx2 = getelementptr i32, ptr %p, i64 4
  store i32 0, ptr %idx2, align 4
  %idx3 = getelementptr i32, ptr %p, i64 6
  store i32 0, ptr %idx3, align 4
  %idx4 = getelementptr i32, ptr %p, i64 8
  store i32 0, ptr %idx4, align 4
  %idx5 = getelementptr i32, ptr %p, i64 10
  store i32 0, ptr %idx5, align 4
  %idx6 = getelementptr i32, ptr %p, i64 12
  store i32 0, ptr %idx6, align 4
  %idx7 = getelementptr i32, ptr %p, i64 14
  store i32 0, ptr %idx7, align 4
  %idx8 = getelementptr i32, ptr %p, i64 16
  store i32 0, ptr %idx8, align 4
  %idx9 = getelementptr i32, ptr %p, i64 18
  store i32 0, ptr %idx9, align 4
  %idx10 = getelementptr i32, ptr %p, i64 20
  store i32 0, ptr %idx10, align 4
  %idx11 = getelementptr i32, ptr %p, i64 22
  store i32 0, ptr %idx11, align 4
  %idx12 = getelementptr i32, ptr %p, i64 24
  store i32 0, ptr %idx12, align 4
  %idx13 = getelementptr i32, ptr %p, i64 26
  store i32 0, ptr %idx13, align 4
  %idx14 = getelementptr i32, ptr %p, i64 28
  store i32 0, ptr %idx14, align 4
  %idx15 = getelementptr i32, ptr %p, i64 30
  store i32 0, ptr %idx15, align 4
  %idx16 = getelementptr i32, ptr %p, i64 32
  store i32 0, ptr %idx16, align 4
  %idx18 = getelementptr i32, ptr %p, i64 36
  store i32 0, ptr %idx18, align 4
  %idx19 = getelementptr i32, ptr %p, i64 38
  store i32 0, ptr %idx19, align 4
  %idx20 = getelementptr i32, ptr %p, i64 40
  store i32 0, ptr %idx20, align 4
  %idx21 = getelementptr i32, ptr %p, i64 42
  store i32 0, ptr %idx21, align 4
  %idx22 = getelementptr i32, ptr %p, i64 44
  store i32 0, ptr %idx22, align 4
  %idx23 = getelementptr i32, ptr %p, i64 46
  store i32 0, ptr %idx23, align 4
  %idx24 = getelementptr i32, ptr %p, i64 48
  store i32 0, ptr %idx24, align 4
  %idx25 = getelementptr i32, ptr %p, i64 50
  store i32 0, ptr %idx25, align 4
  %idx26 = getelementptr i32, ptr %p, i64 52
  store i32 0, ptr %idx26, align 4
  %idx27 = getelementptr i32, ptr %p, i64 54
  store i32 0, ptr %idx27, align 4
  %idx28 = getelementptr i32, ptr %p, i64 56
  store i32 0, ptr %idx28, align 4
  %idx29 = getelementptr i32, ptr %p, i64 58
  store i32 0, ptr %idx29, align 4
  %idx30 = getelementptr i32, ptr %p, i64 60
  store i32 0, ptr %idx30, align 4
  %idx31 = getelementptr i32, ptr %p, i64 62
  store i32 0, ptr %idx31, align 4
  %idx32 = getelementptr i32, ptr %p, i64 64
  store i32 0, ptr %idx32, align 4
  %idx33 = getelementptr i32, ptr %p, i64 66
  store i32 0, ptr %idx33, align 4
  store i32 0, ptr %p, align 4
  %idx0 = getelementptr i32, ptr %p, i64 3
  store i32 0, ptr %idx0, align 4
  %idx1 = getelementptr i32, ptr %p, i64 5
  store i32 0, ptr %idx1, align 4
  ret i32 0
}

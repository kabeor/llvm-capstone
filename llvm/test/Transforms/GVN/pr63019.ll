; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=gvn < %s | FileCheck %s

; Make sure the two offsets from the phi don't get merged incorrectly.
define i8 @test(i1 %c, i64 %offset, ptr %ptr) {
; CHECK-LABEL: define i8 @test
; CHECK-SAME: (i1 [[C:%.*]], i64 [[OFFSET:%.*]], ptr [[PTR:%.*]]) {
; CHECK-NEXT:  start:
; CHECK-NEXT:    [[ALLOCA:%.*]] = alloca [8 x i8], align 8
; CHECK-NEXT:    store i64 1234605616436508552, ptr [[ALLOCA]], align 8
; CHECK-NEXT:    [[GEP_2:%.*]] = getelementptr i8, ptr [[ALLOCA]], i64 2
; CHECK-NEXT:    [[GEP_UNKNOWN:%.*]] = getelementptr i8, ptr [[ALLOCA]], i64 [[OFFSET]]
; CHECK-NEXT:    br i1 [[C]], label [[JOIN:%.*]], label [[IF:%.*]]
; CHECK:       if:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    [[PHI:%.*]] = phi ptr [ [[GEP_UNKNOWN]], [[START:%.*]] ], [ [[GEP_2]], [[IF]] ]
; CHECK-NEXT:    store i8 0, ptr [[ALLOCA]], align 8
; CHECK-NEXT:    [[LOAD1:%.*]] = load i64, ptr [[ALLOCA]], align 8
; CHECK-NEXT:    store i64 [[LOAD1]], ptr [[PTR]], align 8
; CHECK-NEXT:    [[LOAD2:%.*]] = load i8, ptr [[PHI]], align 1
; CHECK-NEXT:    ret i8 [[LOAD2]]
;
start:
  %alloca = alloca [8 x i8], align 8
  store i64 u0x1122334455667788, ptr %alloca, align 8
  %gep.2 = getelementptr i8, ptr %alloca, i64 2
  %gep.unknown = getelementptr i8, ptr %alloca, i64 %offset
  br i1 %c, label %join, label %if

if:
  br label %join

join:
  %phi = phi ptr [ %gep.unknown, %start ], [ %gep.2, %if ]
  store i8 0, ptr %alloca, align 8
  %load1 = load i64, ptr %alloca, align 8
  store i64 %load1, ptr %ptr, align 8
  %load2 = load i8, ptr %phi, align 1
  ret i8 %load2
}

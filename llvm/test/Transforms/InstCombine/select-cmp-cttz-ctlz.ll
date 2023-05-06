; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

; This test is to verify that the instruction combiner is able to fold
; a cttz/ctlz followed by a icmp + select into a single cttz/ctlz with
; the 'is_zero_undef' flag cleared.

define i16 @test1(i16 %x) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.ctlz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    ret i16 [[CT]]
;
  %ct = tail call i16 @llvm.ctlz.i16(i16 %x, i1 true)
  %tobool = icmp ne i16 %x, 0
  %cond = select i1 %tobool, i16 %ct, i16 16
  ret i16 %cond
}

define i32 @test2(i32 %x) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    ret i32 [[CT]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true)
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i32 %ct, i32 32
  ret i32 %cond
}

define i64 @test3(i64 %x) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2:![0-9]+]]
; CHECK-NEXT:    ret i64 [[CT]]
;
  %ct = tail call i64 @llvm.ctlz.i64(i64 %x, i1 true)
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i64 %ct, i64 64
  ret i64 %cond
}

define i16 @test4(i16 %x) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.ctlz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    ret i16 [[CT]]
;
  %ct = tail call i16 @llvm.ctlz.i16(i16 %x, i1 true)
  %tobool = icmp eq i16 %x, 0
  %cond = select i1 %tobool, i16 16, i16 %ct
  ret i16 %cond
}

define i32 @test5(i32 %x) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[CT]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true)
  %tobool = icmp eq i32 %x, 0
  %cond = select i1 %tobool, i32 32, i32 %ct
  ret i32 %cond
}

define i64 @test6(i64 %x) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    ret i64 [[CT]]
;
  %ct = tail call i64 @llvm.ctlz.i64(i64 %x, i1 true)
  %tobool = icmp eq i64 %x, 0
  %cond = select i1 %tobool, i64 64, i64 %ct
  ret i64 %cond
}

define i16 @test1b(i16 %x) {
; CHECK-LABEL: @test1b(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.cttz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    ret i16 [[CT]]
;
  %ct = tail call i16 @llvm.cttz.i16(i16 %x, i1 true)
  %tobool = icmp ne i16 %x, 0
  %cond = select i1 %tobool, i16 %ct, i16 16
  ret i16 %cond
}

define i32 @test2b(i32 %x) {
; CHECK-LABEL: @test2b(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[CT]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i32 %ct, i32 32
  ret i32 %cond
}

define i64 @test3b(i64 %x) {
; CHECK-LABEL: @test3b(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    ret i64 [[CT]]
;
  %ct = tail call i64 @llvm.cttz.i64(i64 %x, i1 true)
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i64 %ct, i64 64
  ret i64 %cond
}

define i16 @test4b(i16 %x) {
; CHECK-LABEL: @test4b(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.cttz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    ret i16 [[CT]]
;
  %ct = tail call i16 @llvm.cttz.i16(i16 %x, i1 true)
  %tobool = icmp eq i16 %x, 0
  %cond = select i1 %tobool, i16 16, i16 %ct
  ret i16 %cond
}

define i32 @test5b(i32 %x) {
; CHECK-LABEL: @test5b(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[CT]]
;
entry:
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %tobool = icmp eq i32 %x, 0
  %cond = select i1 %tobool, i32 32, i32 %ct
  ret i32 %cond
}

define i64 @test6b(i64 %x) {
; CHECK-LABEL: @test6b(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    ret i64 [[CT]]
;
  %ct = tail call i64 @llvm.cttz.i64(i64 %x, i1 true)
  %tobool = icmp eq i64 %x, 0
  %cond = select i1 %tobool, i64 64, i64 %ct
  ret i64 %cond
}

define i32 @test1c(i16 %x) {
; CHECK-LABEL: @test1c(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.cttz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[CAST2:%.*]] = zext i16 [[CT]] to i32
; CHECK-NEXT:    ret i32 [[CAST2]]
;
  %ct = tail call i16 @llvm.cttz.i16(i16 %x, i1 true)
  %cast2 = zext i16 %ct to i32
  %tobool = icmp ne i16 %x, 0
  %cond = select i1 %tobool, i32 %cast2, i32 16
  ret i32 %cond
}

define i64 @test2c(i16 %x) {
; CHECK-LABEL: @test2c(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.cttz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[CONV:%.*]] = zext i16 [[CT]] to i64
; CHECK-NEXT:    ret i64 [[CONV]]
;
  %ct = tail call i16 @llvm.cttz.i16(i16 %x, i1 true)
  %conv = zext i16 %ct to i64
  %tobool = icmp ne i16 %x, 0
  %cond = select i1 %tobool, i64 %conv, i64 16
  ret i64 %cond
}

define i64 @test3c(i32 %x) {
; CHECK-LABEL: @test3c(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CONV:%.*]] = zext i32 [[CT]] to i64
; CHECK-NEXT:    ret i64 [[CONV]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %conv = zext i32 %ct to i64
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i64 %conv, i64 32
  ret i64 %cond
}

define i32 @test4c(i16 %x) {
; CHECK-LABEL: @test4c(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.ctlz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[CAST:%.*]] = zext i16 [[CT]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %ct = tail call i16 @llvm.ctlz.i16(i16 %x, i1 true)
  %cast = zext i16 %ct to i32
  %tobool = icmp ne i16 %x, 0
  %cond = select i1 %tobool, i32 %cast, i32 16
  ret i32 %cond
}

define i64 @test5c(i16 %x) {
; CHECK-LABEL: @test5c(
; CHECK-NEXT:    [[CT:%.*]] = tail call i16 @llvm.ctlz.i16(i16 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[CAST:%.*]] = zext i16 [[CT]] to i64
; CHECK-NEXT:    ret i64 [[CAST]]
;
  %ct = tail call i16 @llvm.ctlz.i16(i16 %x, i1 true)
  %cast = zext i16 %ct to i64
  %tobool = icmp ne i16 %x, 0
  %cond = select i1 %tobool, i64 %cast, i64 16
  ret i64 %cond
}

define i64 @test6c(i32 %x) {
; CHECK-LABEL: @test6c(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CAST:%.*]] = zext i32 [[CT]] to i64
; CHECK-NEXT:    ret i64 [[CAST]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true)
  %cast = zext i32 %ct to i64
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i64 %cast, i64 32
  ret i64 %cond
}

define i16 @test1d(i64 %x) {
; CHECK-LABEL: @test1d(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CONV:%.*]] = trunc i64 [[CT]] to i16
; CHECK-NEXT:    ret i16 [[CONV]]
;
  %ct = tail call i64 @llvm.cttz.i64(i64 %x, i1 true)
  %conv = trunc i64 %ct to i16
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i16 %conv, i16 64
  ret i16 %cond
}

define i32 @test2d(i64 %x) {
; CHECK-LABEL: @test2d(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %ct = tail call i64 @llvm.cttz.i64(i64 %x, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i32 %cast, i32 64
  ret i32 %cond
}

define i16 @test3d(i32 %x) {
; CHECK-LABEL: @test3d(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i32 [[CT]] to i16
; CHECK-NEXT:    ret i16 [[CAST]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %cast = trunc i32 %ct to i16
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i16 %cast, i16 32
  ret i16 %cond
}

define i16 @test4d(i64 %x) {
; CHECK-LABEL: @test4d(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i16
; CHECK-NEXT:    ret i16 [[CAST]]
;
  %ct = tail call i64 @llvm.ctlz.i64(i64 %x, i1 true)
  %cast = trunc i64 %ct to i16
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i16 %cast, i16 64
  ret i16 %cond
}

define i32 @test5d(i64 %x) {
; CHECK-LABEL: @test5d(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %ct = tail call i64 @llvm.ctlz.i64(i64 %x, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i32 %cast, i32 64
  ret i32 %cond
}

; Same as above, but the counting zeros on an inverted operand with opposite compare.

define i32 @not_op_ctlz(i64 %x) {
; CHECK-LABEL: @not_op_ctlz(
; CHECK-NEXT:    [[N:%.*]] = xor i64 [[X:%.*]], -1
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[N]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %n = xor i64 %x, -1
  %ct = tail call i64 @llvm.ctlz.i64(i64 %n, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp eq i64 %x, -1
  %r = select i1 %tobool, i32 64, i32 %cast
  ret i32 %r
}

define i32 @not_op_cttz(i64 %x) {
; CHECK-LABEL: @not_op_cttz(
; CHECK-NEXT:    [[N:%.*]] = xor i64 [[X:%.*]], -1
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[N]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %n = xor i64 %x, -1
  %ct = tail call i64 @llvm.cttz.i64(i64 %n, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp eq i64 %x, -1
  %r = select i1 %tobool, i32 64, i32 %cast
  ret i32 %r
}

; negative test

define i32 @not_op_ctlz_wrong_xor_op1(i64 %x) {
; CHECK-LABEL: @not_op_ctlz_wrong_xor_op1(
; CHECK-NEXT:    [[N:%.*]] = xor i64 [[X:%.*]], -2
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[N]], i1 true), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i64 [[X]], -1
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TOBOOL]], i32 64, i32 [[CAST]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %n = xor i64 %x, -2
  %ct = tail call i64 @llvm.ctlz.i64(i64 %n, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp eq i64 %x, -1
  %r = select i1 %tobool, i32 64, i32 %cast
  ret i32 %r
}

; negative test

define i32 @not_op_ctlz_wrong_xor_op0(i64 %x, i64 %y) {
; CHECK-LABEL: @not_op_ctlz_wrong_xor_op0(
; CHECK-NEXT:    [[N:%.*]] = xor i64 [[Y:%.*]], -1
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[N]], i1 true), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i64 [[X:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TOBOOL]], i32 64, i32 [[CAST]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %n = xor i64 %y, -1
  %ct = tail call i64 @llvm.ctlz.i64(i64 %n, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp eq i64 %x, -1
  %r = select i1 %tobool, i32 64, i32 %cast
  ret i32 %r
}

; negative test

define i32 @not_op_cttz_wrong_cmp(i64 %x) {
; CHECK-LABEL: @not_op_cttz_wrong_cmp(
; CHECK-NEXT:    [[N:%.*]] = xor i64 [[X:%.*]], -1
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[N]], i1 true), !range [[RNG2]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i64 [[CT]] to i32
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i64 [[X]], 0
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TOBOOL]], i32 64, i32 [[CAST]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %n = xor i64 %x, -1
  %ct = tail call i64 @llvm.cttz.i64(i64 %n, i1 true)
  %cast = trunc i64 %ct to i32
  %tobool = icmp eq i64 %x, 0
  %r = select i1 %tobool, i32 64, i32 %cast
  ret i32 %r
}

define i16 @test6d(i32 %x) {
; CHECK-LABEL: @test6d(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CAST:%.*]] = trunc i32 [[CT]] to i16
; CHECK-NEXT:    ret i16 [[CAST]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true)
  %cast = trunc i32 %ct to i16
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i16 %cast, i16 32
  ret i16 %cond
}

define i64 @select_bug1(i32 %x) {
; CHECK-LABEL: @select_bug1(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CONV:%.*]] = zext i32 [[CT]] to i64
; CHECK-NEXT:    ret i64 [[CONV]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  %conv = zext i32 %ct to i64
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i64 %conv, i64 32
  ret i64 %cond
}

define i16 @select_bug2(i32 %x) {
; CHECK-LABEL: @select_bug2(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CONV:%.*]] = trunc i32 [[CT]] to i16
; CHECK-NEXT:    ret i16 [[CONV]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  %conv = trunc i32 %ct to i16
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i16 %conv, i16 32
  ret i16 %cond
}

define i128 @test7(i128 %x) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[CT:%.*]] = tail call i128 @llvm.ctlz.i128(i128 [[X:%.*]], i1 false), !range [[RNG3:![0-9]+]]
; CHECK-NEXT:    ret i128 [[CT]]
;
  %ct = tail call i128 @llvm.ctlz.i128(i128 %x, i1 true)
  %tobool = icmp ne i128 %x, 0
  %cond = select i1 %tobool, i128 %ct, i128 128
  ret i128 %cond
}

define i128 @test8(i128 %x) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[CT:%.*]] = tail call i128 @llvm.cttz.i128(i128 [[X:%.*]], i1 false), !range [[RNG3]]
; CHECK-NEXT:    ret i128 [[CT]]
;
  %ct = tail call i128 @llvm.cttz.i128(i128 %x, i1 true)
  %tobool = icmp ne i128 %x, 0
  %cond = select i1 %tobool, i128 %ct, i128 128
  ret i128 %cond
}

define i32 @test_ctlz_not_bw(i32 %x) {
; CHECK-LABEL: @test_ctlz_not_bw(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 true), !range [[RNG1]]
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[X]], 0
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP_NOT]], i32 123, i32 [[CT]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 false)
  %cmp = icmp ne i32 %x, 0
  %res = select i1 %cmp, i32 %ct, i32 123
  ret i32 %res
}

define i32 @test_ctlz_not_bw_multiuse(i32 %x) {
; CHECK-LABEL: @test_ctlz_not_bw_multiuse(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[X]], 0
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_NOT]], i32 123, i32 [[CT]]
; CHECK-NEXT:    [[RES:%.*]] = or i32 [[SEL]], [[CT]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 false)
  %cmp = icmp ne i32 %x, 0
  %sel = select i1 %cmp, i32 %ct, i32 123
  %res = or i32 %sel, %ct
  ret i32 %res
}

define i32 @test_cttz_not_bw(i32 %x) {
; CHECK-LABEL: @test_cttz_not_bw(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 true), !range [[RNG1]]
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[X]], 0
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP_NOT]], i32 123, i32 [[CT]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  %cmp = icmp ne i32 %x, 0
  %res = select i1 %cmp, i32 %ct, i32 123
  ret i32 %res
}

define i32 @test_cttz_not_bw_multiuse(i32 %x) {
; CHECK-LABEL: @test_cttz_not_bw_multiuse(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[X]], 0
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_NOT]], i32 123, i32 [[CT]]
; CHECK-NEXT:    [[RES:%.*]] = or i32 [[SEL]], [[CT]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  %cmp = icmp ne i32 %x, 0
  %sel = select i1 %cmp, i32 %ct, i32 123
  %res = or i32 %sel, %ct
  ret i32 %res
}

define <2 x i32> @test_ctlz_bw_vec(<2 x i32> %x) {
; CHECK-LABEL: @test_ctlz_bw_vec(
; CHECK-NEXT:    [[CT:%.*]] = tail call <2 x i32> @llvm.ctlz.v2i32(<2 x i32> [[X:%.*]], i1 false)
; CHECK-NEXT:    ret <2 x i32> [[CT]]
;
  %ct = tail call <2 x i32> @llvm.ctlz.v2i32(<2 x i32> %x, i1 true)
  %cmp = icmp ne <2 x i32> %x, zeroinitializer
  %res = select <2 x i1> %cmp, <2 x i32> %ct, <2 x i32> <i32 32, i32 32>
  ret <2 x i32> %res
}

define <2 x i32> @test_ctlz_not_bw_vec(<2 x i32> %x) {
; CHECK-LABEL: @test_ctlz_not_bw_vec(
; CHECK-NEXT:    [[CT:%.*]] = tail call <2 x i32> @llvm.ctlz.v2i32(<2 x i32> [[X:%.*]], i1 true)
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq <2 x i32> [[X]], zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = select <2 x i1> [[CMP_NOT]], <2 x i32> zeroinitializer, <2 x i32> [[CT]]
; CHECK-NEXT:    ret <2 x i32> [[RES]]
;
  %ct = tail call <2 x i32> @llvm.ctlz.v2i32(<2 x i32> %x, i1 false)
  %cmp = icmp ne <2 x i32> %x, zeroinitializer
  %res = select <2 x i1> %cmp, <2 x i32> %ct, <2 x i32> <i32 0, i32 0>
  ret <2 x i32> %res
}

define <2 x i32> @test_cttz_bw_vec(<2 x i32> %x) {
; CHECK-LABEL: @test_cttz_bw_vec(
; CHECK-NEXT:    [[CT:%.*]] = tail call <2 x i32> @llvm.cttz.v2i32(<2 x i32> [[X:%.*]], i1 false)
; CHECK-NEXT:    ret <2 x i32> [[CT]]
;
  %ct = tail call <2 x i32> @llvm.cttz.v2i32(<2 x i32> %x, i1 true)
  %cmp = icmp ne <2 x i32> %x, zeroinitializer
  %res = select <2 x i1> %cmp, <2 x i32> %ct, <2 x i32> <i32 32, i32 32>
  ret <2 x i32> %res
}

define <2 x i32> @test_cttz_not_bw_vec(<2 x i32> %x) {
; CHECK-LABEL: @test_cttz_not_bw_vec(
; CHECK-NEXT:    [[CT:%.*]] = tail call <2 x i32> @llvm.cttz.v2i32(<2 x i32> [[X:%.*]], i1 true)
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq <2 x i32> [[X]], zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = select <2 x i1> [[CMP_NOT]], <2 x i32> zeroinitializer, <2 x i32> [[CT]]
; CHECK-NEXT:    ret <2 x i32> [[RES]]
;
  %ct = tail call <2 x i32> @llvm.cttz.v2i32(<2 x i32> %x, i1 false)
  %cmp = icmp ne <2 x i32> %x, zeroinitializer
  %res = select <2 x i1> %cmp, <2 x i32> %ct, <2 x i32> <i32 0, i32 0>
  ret <2 x i32> %res
}

define i32 @test_multiuse_def(i32 %x, ptr %p) {
; CHECK-LABEL: @test_multiuse_def(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    store i32 [[CT]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret i32 [[CT]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 false)
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i32 %ct, i32 32
  store i32 %ct, ptr %p
  ret i32 %cond
}

define i32 @test_multiuse_undef(i32 %x, ptr %p) {
; CHECK-LABEL: @test_multiuse_undef(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    store i32 [[CT]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret i32 [[CT]]
;
  %ct = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true)
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i32 %ct, i32 32
  store i32 %ct, ptr %p
  ret i32 %cond
}

define i64 @test_multiuse_zext_def(i32 %x, ptr %p) {
; CHECK-LABEL: @test_multiuse_zext_def(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CONV:%.*]] = zext i32 [[CT]] to i64
; CHECK-NEXT:    store i64 [[CONV]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret i64 [[CONV]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  %conv = zext i32 %ct to i64
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i64 %conv, i64 32
  store i64 %conv, ptr %p
  ret i64 %cond
}

define i64 @test_multiuse_zext_undef(i32 %x, ptr %p) {
; CHECK-LABEL: @test_multiuse_zext_undef(
; CHECK-NEXT:    [[CT:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    [[CONV:%.*]] = zext i32 [[CT]] to i64
; CHECK-NEXT:    store i64 [[CONV]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret i64 [[CONV]]
;
  %ct = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %conv = zext i32 %ct to i64
  %tobool = icmp ne i32 %x, 0
  %cond = select i1 %tobool, i64 %conv, i64 32
  store i64 %conv, ptr %p
  ret i64 %cond
}

define i16 @test_multiuse_trunc_def(i64 %x, ptr %p) {
; CHECK-LABEL: @test_multiuse_trunc_def(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CONV:%.*]] = trunc i64 [[CT]] to i16
; CHECK-NEXT:    store i16 [[CONV]], ptr [[P:%.*]], align 2
; CHECK-NEXT:    ret i16 [[CONV]]
;
  %ct = tail call i64 @llvm.cttz.i64(i64 %x, i1 false)
  %conv = trunc i64 %ct to i16
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i16 %conv, i16 64
  store i16 %conv, ptr %p
  ret i16 %cond
}

define i16 @test_multiuse_trunc_undef(i64 %x, ptr %p) {
; CHECK-LABEL: @test_multiuse_trunc_undef(
; CHECK-NEXT:    [[CT:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG2]]
; CHECK-NEXT:    [[CONV:%.*]] = trunc i64 [[CT]] to i16
; CHECK-NEXT:    store i16 [[CONV]], ptr [[P:%.*]], align 2
; CHECK-NEXT:    ret i16 [[CONV]]
;
  %ct = tail call i64 @llvm.cttz.i64(i64 %x, i1 true)
  %conv = trunc i64 %ct to i16
  %tobool = icmp ne i64 %x, 0
  %cond = select i1 %tobool, i16 %conv, i16 64
  store i16 %conv, ptr %p
  ret i16 %cond
}

declare i16 @llvm.ctlz.i16(i16, i1)
declare i32 @llvm.ctlz.i32(i32, i1)
declare i64 @llvm.ctlz.i64(i64, i1)
declare i128 @llvm.ctlz.i128(i128, i1)
declare <2 x i32> @llvm.ctlz.v2i32(<2 x i32>, i1)
declare i16 @llvm.cttz.i16(i16, i1)
declare i32 @llvm.cttz.i32(i32, i1)
declare i64 @llvm.cttz.i64(i64, i1)
declare i128 @llvm.cttz.i128(i128, i1)
declare <2 x i32> @llvm.cttz.v2i32(<2 x i32>, i1)

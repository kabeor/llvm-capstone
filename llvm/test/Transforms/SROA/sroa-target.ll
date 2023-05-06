; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=sroa < %s | FileCheck %s

; Check that SROA can work with target extension types correctly.

target datalayout = "e-p:64:64:64-p1:16:16:16-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-n8:16:32:64"

define target("spirv.DeviceEvent") @basic_alloc(target("spirv.DeviceEvent") %arg) {
; CHECK-LABEL: @basic_alloc(
; CHECK-NEXT:    ret target("spirv.DeviceEvent") [[ARG:%.*]]
;
  %val = alloca target("spirv.DeviceEvent")
  store target("spirv.DeviceEvent") %arg, ptr %val
  %ret = load target("spirv.DeviceEvent"), ptr %val
  ret target("spirv.DeviceEvent") %ret
}

define target("spirv.DeviceEvent") @via_memcpy(target("spirv.DeviceEvent") %arg) {
; CHECK-LABEL: @via_memcpy(
; CHECK-NEXT:    ret target("spirv.DeviceEvent") [[ARG:%.*]]
;
  %val = alloca target("spirv.DeviceEvent")
  %bar = alloca target("spirv.DeviceEvent")
  store target("spirv.DeviceEvent") %arg, ptr %val
  call void @llvm.memcpy.p0.p0.i64(ptr %bar, ptr %val, i64 8, i1 false)
  %ret = load target("spirv.DeviceEvent"), ptr %bar
  ret target("spirv.DeviceEvent") %ret
}

define target("spirv.DeviceEvent") @nobitcast(ptr %arg) {
; CHECK-LABEL: @nobitcast(
; CHECK-NEXT:    [[VAL:%.*]] = alloca target("spirv.DeviceEvent"), align 8
; CHECK-NEXT:    store ptr [[ARG:%.*]], ptr [[VAL]], align 8
; CHECK-NEXT:    [[VAL_0_RET:%.*]] = load target("spirv.DeviceEvent"), ptr [[VAL]], align 8
; CHECK-NEXT:    ret target("spirv.DeviceEvent") [[VAL_0_RET]]
;
  %val = alloca target("spirv.DeviceEvent")
  store ptr %arg, ptr %val
  %ret = load target("spirv.DeviceEvent"), ptr %val
  ret target("spirv.DeviceEvent") %ret
}

define target("spirv.DeviceEvent") @viai64(target("spirv.DeviceEvent") %arg) {
; CHECK-LABEL: @viai64(
; CHECK-NEXT:    [[VAL:%.*]] = alloca target("spirv.DeviceEvent"), align 8
; CHECK-NEXT:    [[BAR:%.*]] = alloca target("spirv.DeviceEvent"), align 8
; CHECK-NEXT:    store target("spirv.DeviceEvent") [[ARG:%.*]], ptr [[VAL]], align 8
; CHECK-NEXT:    [[VAL_0_IMEMCPY:%.*]] = load i64, ptr [[VAL]], align 8
; CHECK-NEXT:    store i64 [[VAL_0_IMEMCPY]], ptr [[BAR]], align 8
; CHECK-NEXT:    [[BAR_0_RET:%.*]] = load target("spirv.DeviceEvent"), ptr [[BAR]], align 8
; CHECK-NEXT:    ret target("spirv.DeviceEvent") [[BAR_0_RET]]
;
  %val = alloca target("spirv.DeviceEvent")
  %bar = alloca target("spirv.DeviceEvent")
  store target("spirv.DeviceEvent") %arg, ptr %val
  %imemcpy = load i64, ptr %val
  store i64 %imemcpy, ptr %bar
  %ret = load target("spirv.DeviceEvent"), ptr %bar
  ret target("spirv.DeviceEvent") %ret
}

declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -data-layout=p:32:32 -S | FileCheck %s

declare void @bcopy(ptr nocapture readonly, ptr nocapture, i32)

define void @bcopy_memmove(ptr nocapture readonly %a, ptr nocapture %b) {
; CHECK-LABEL: @bcopy_memmove(
; CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[A:%.*]], align 1
; CHECK-NEXT:    store i64 [[TMP3]], ptr [[B:%.*]], align 1
; CHECK-NEXT:    ret void
;
  tail call void @bcopy(ptr %a, ptr %b, i32 8)
  ret void
}

define void @bcopy_memmove2(ptr nocapture readonly %a, ptr nocapture %b, i32 %len) {
; CHECK-LABEL: @bcopy_memmove2(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i32(ptr align 1 [[B:%.*]], ptr align 1 [[A:%.*]], i32 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @bcopy(ptr %a, ptr %b, i32 %len)
  ret void
}

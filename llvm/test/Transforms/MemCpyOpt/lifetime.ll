; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=memcpyopt -S -verify-memoryssa | FileCheck %s

; performCallSlotOptzn in MemCpy should not exchange the calls to
; @llvm.lifetime.start and @llvm.memcpy.

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture readonly, i64, i1)
declare void @llvm.lifetime.start.p0(i64, ptr nocapture)
declare void @llvm.lifetime.end.p0(i64, ptr nocapture)

define void @call_slot(ptr nocapture dereferenceable(16) %arg1) {
; CHECK-LABEL: @call_slot(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = alloca [8 x i8], align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 16, ptr [[TMP]])
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, ptr [[TMP]], i64 7
; CHECK-NEXT:    store i8 0, ptr [[TMP10]], align 1
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 16, ptr [[TMP]])
; CHECK-NEXT:    ret void
;
bb:
  %tmp = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr %tmp)
  %tmp10 = getelementptr inbounds i8, ptr %tmp, i64 7
  store i8 0, ptr %tmp10, align 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %arg1, ptr align 8 %tmp, i64 16, i1 false)
  call void @llvm.lifetime.end.p0(i64 16, ptr %tmp)
  ret void
}

define void @memcpy_memcpy_across_lifetime(ptr noalias %p1, ptr noalias %p2, ptr noalias %p3) {
; CHECK-LABEL: @memcpy_memcpy_across_lifetime(
; CHECK-NEXT:    [[A:%.*]] = alloca [16 x i8], align 1
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 16, ptr [[A]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[A]], ptr [[P1:%.*]], i64 16, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[P1]], ptr [[P2:%.*]], i64 16, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[P2]], ptr [[A]], i64 16, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 16, ptr [[A]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[P3:%.*]], ptr [[P2]], i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %a = alloca [16 x i8]
  call void @llvm.lifetime.start.p0(i64 16, ptr %a)
  call void @llvm.memcpy.p0.p0.i64(ptr %a, ptr %p1, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %p1, ptr %p2, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %p2, ptr %a, i64 16, i1 false)
  call void @llvm.lifetime.end.p0(i64 16, ptr %a)
  call void @llvm.memcpy.p0.p0.i64(ptr %p3, ptr %p2, i64 16, i1 false)
  ret void
}

declare void @call(ptr)

define i32 @call_slot_move_lifetime_start() {
; CHECK-LABEL: @call_slot_move_lifetime_start(
; CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DST:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    call void @call(ptr [[DST]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[DST]], align 4
; CHECK-NEXT:    ret i32 [[V]]
;
  %tmp = alloca i32
  %dst = alloca i32
  call void @call(ptr %tmp)
  call void @llvm.lifetime.start.p0(i64 4, ptr %dst)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %dst, ptr align 4 %tmp, i64 4, i1 false)
  call void @llvm.lifetime.end.p0(i64 4, ptr %dst)
  %v = load i32, ptr %dst
  ret i32 %v
}

define i32 @call_slot_two_lifetime_starts() {
; CHECK-LABEL: @call_slot_two_lifetime_starts(
; CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DST:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @call(ptr [[TMP]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 4 [[DST]], ptr align 4 [[TMP]], i64 4, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[DST]], align 4
; CHECK-NEXT:    ret i32 [[V]]
;
  %tmp = alloca i32
  %dst = alloca i32
  call void @call(ptr %tmp)
  call void @llvm.lifetime.start.p0(i64 4, ptr %dst)
  call void @llvm.lifetime.start.p0(i64 4, ptr %dst)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %dst, ptr align 4 %tmp, i64 4, i1 false)
  call void @llvm.lifetime.end.p0(i64 4, ptr %dst)
  %v = load i32, ptr %dst
  ret i32 %v
}

define i32 @call_slot_clobber_before_lifetime_start() {
; CHECK-LABEL: @call_slot_clobber_before_lifetime_start(
; CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DST:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @call(ptr [[TMP]])
; CHECK-NEXT:    store i32 0, ptr [[DST]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 4 [[DST]], ptr align 4 [[TMP]], i64 4, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[DST]])
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[DST]], align 4
; CHECK-NEXT:    ret i32 [[V]]
;
  %tmp = alloca i32
  %dst = alloca i32
  call void @call(ptr %tmp)
  store i32 0, ptr %dst
  call void @llvm.lifetime.start.p0(i64 4, ptr %dst)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %dst, ptr align 4 %tmp, i64 4, i1 false)
  call void @llvm.lifetime.end.p0(i64 4, ptr %dst)
  %v = load i32, ptr %dst
  ret i32 %v
}

define void @call_slot_lifetime_bitcast(ptr %ptr) {
; CHECK-LABEL: @call_slot_lifetime_bitcast(
; CHECK-NEXT:    [[TMP1:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP2]], ptr align 4 [[PTR:%.*]], i64 4, i1 false)
; CHECK-NEXT:    [[TMP1_CAST:%.*]] = bitcast ptr [[TMP1]] to ptr
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr nonnull [[TMP1_CAST]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 4 [[TMP1_CAST]], ptr align 4 [[PTR]], i64 4, i1 false)
; CHECK-NEXT:    ret void
;
  %tmp1 = alloca i32
  %tmp2 = alloca i32
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %tmp2, ptr align 4 %ptr, i64 4, i1 false)
  %tmp1.cast = bitcast ptr %tmp1 to ptr
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %tmp1.cast)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %tmp1.cast, ptr align 4 %tmp2, i64 4, i1 false)
  ret void
}

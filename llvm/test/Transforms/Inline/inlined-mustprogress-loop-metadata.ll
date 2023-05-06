; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --force-update
; RUN: opt < %s -S -passes="inline" | FileCheck %s

define void @callee(i32 %a, i32 %b) #0 {
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond, !llvm.loop !0
for.end:
  br label %while.body
while.body:
  br label %while.body
}

define void @caller(i32 %a, i32 %b) #1 {
; CHECK: Function Attrs: noinline
; CHECK-LABEL: define {{[^@]+}}@caller
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]]) [[ATTR1:#.*]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[A]], [[B]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
  ; CHECK-NEXT:    br label [[FOR_COND_I]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       callee.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  call void @callee(i32 0, i32 5)
  ret void
}

define void @callee_no_metadata(i32 %a, i32 %b) {
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  br label %while.body
while.body:
  br label %while.body
}

define void @caller_no_metadata(i32 %a, i32 %b) {
; CHECK-LABEL: define {{[^@]+}}@caller_no_metadata
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[A]], [[B]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
; CHECK-NEXT:    br label [[FOR_COND_I]]
; CHECK:       callee_no_metadata.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  call void @callee_no_metadata(i32 0, i32 5)
  ret void
}

define void @callee_mustprogress(i32 %a, i32 %b) #0 {
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  br label %while.body
while.body:
  br label %while.body
}

define void @caller_mustprogress(i32 %a, i32 %b) #0 {
; CHECK: Function Attrs: mustprogress
; CHECK-LABEL: define {{[^@]+}}@caller_mustprogress
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]]) [[ATTR0:#[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[A]], [[B]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
; CHECK-NEXT:    br label [[FOR_COND_I]]
; CHECK:       callee_mustprogress.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  call void @callee_mustprogress(i32 0, i32 5)
  ret void
}

define void @caller_mustprogress_callee_no_metadata(i32 %a, i32 %b) #0 {
; CHECK-LABEL: define {{[^@]+}}@caller_mustprogress_callee_no_metadata
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[A]], [[B]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
; CHECK-NEXT:    br label [[FOR_COND_I]]
; CHECK:       callee_no_metadata.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond
for.cond:
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  call void @callee_no_metadata(i32 0, i32 5)
  ret void
}

define void @callee_multiple(i32 %a, i32 %b) #0 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  br label %for.cond
for.cond:
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond, !llvm.loop !2
for.end:
  store i32 0, ptr %i, align 4
  br label %for.cond1
for.cond1:
  %2 = load i32, ptr %i, align 4
  %cmp2 = icmp slt i32 %2, 10
  br i1 %cmp2, label %for.body3, label %for.end4
for.body3:
  br label %for.inc
for.inc:
  %3 = load i32, ptr %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond1, !llvm.loop !4
for.end4:
  br label %while.body
while.body:
  br label %while.body
}

define void @caller_multiple(i32 %a, i32 %b) #1 {
; CHECK: Function Attrs: noinline
; CHECK-LABEL: define {{[^@]+}}@caller_multiple
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]]) [[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_ADDR_I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_ADDR_I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[I_I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 [[A]], ptr [[A_ADDR]], align 4
; CHECK-NEXT:    store i32 [[B]], ptr [[B_ADDR]], align 4
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A_ADDR]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[B_ADDR]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end:
; CHECK-NEXT:    store i32 0, ptr [[I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1:%.*]]
; CHECK:       for.cond1:
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[I]], align 4
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[TMP2]], 10
; CHECK-NEXT:    br i1 [[CMP2]], label [[FOR_BODY3:%.*]], label [[FOR_END4:%.*]]
; CHECK:       for.body3:
; CHECK-NEXT:    br label [[FOR_INC:%.*]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[I]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP3]], 1
; CHECK-NEXT:    store i32 [[INC]], ptr [[I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1]]
; CHECK:       for.end4:
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[A_ADDR_I]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[B_ADDR_I]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[I_I]])
; CHECK-NEXT:    store i32 0, ptr [[A_ADDR_I]], align 4
; CHECK-NEXT:    store i32 5, ptr [[B_ADDR_I]], align 4
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr [[A_ADDR_I]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr [[B_ADDR_I]], align 4
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp slt i32 [[TMP7]], [[TMP8]]
; CHECK-NEXT:    br i1 [[CMP_I]], label [[FOR_BODY_I:%.*]], label [[FOR_END_I:%.*]]
; CHECK:       for.body.i:
  ; CHECK-NEXT:    br label [[FOR_COND_I]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       for.end.i:
; CHECK-NEXT:    store i32 0, ptr [[I_I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1_I:%.*]]
; CHECK:       for.cond1.i:
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr [[I_I]], align 4
; CHECK-NEXT:    [[CMP2_I:%.*]] = icmp slt i32 [[TMP9]], 10
; CHECK-NEXT:    br i1 [[CMP2_I]], label [[FOR_BODY3_I:%.*]], label [[FOR_END4_I:%.*]]
; CHECK:       for.body3.i:
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr [[I_I]], align 4
; CHECK-NEXT:    [[INC_I:%.*]] = add nsw i32 [[TMP10]], 1
; CHECK-NEXT:    store i32 [[INC_I]], ptr [[I_I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1_I]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.end4.i:
; CHECK-NEXT:    br label [[WHILE_BODY_I:%.*]]
; CHECK:       while.body.i:
; CHECK-NEXT:    br label [[WHILE_BODY_I]]
; CHECK:       callee_multiple.exit:
; CHECK-NEXT:    ret void
;
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  br label %for.cond
for.cond:
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond
for.end:
  store i32 0, ptr %i, align 4
  br label %for.cond1
for.cond1:
  %2 = load i32, ptr %i, align 4
  %cmp2 = icmp slt i32 %2, 10
  br i1 %cmp2, label %for.body3, label %for.end4
for.body3:
  br label %for.inc
for.inc:
  %3 = load i32, ptr %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond1
for.end4:
  call void @callee_multiple(i32 0, i32 5)
  ret void
}

define void @callee_nested(i32 %a, i32 %b) #0 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  br label %for.cond
for.cond:
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end
for.body:
  br label %for.cond, !llvm.loop !0
for.end:
  store i32 0, ptr %i, align 4
  br label %for.cond1
for.cond1:
  %2 = load i32, ptr %i, align 4
  %cmp2 = icmp slt i32 %2, 10
  br i1 %cmp2, label %for.body3, label %for.end8
for.body3:
  br label %for.cond4
for.cond4:
  %3 = load i32, ptr %b.addr, align 4
  %4 = load i32, ptr %a.addr, align 4
  %cmp5 = icmp slt i32 %3, %4
  br i1 %cmp5, label %for.body6, label %for.end7
for.body6:
  br label %for.cond4, !llvm.loop !2
for.end7:
  br label %for.inc
for.inc:
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond1, !llvm.loop !3
for.end8:
  br label %while.body
while.body:
  br label %while.body
}

define void @caller_nested(i32 %a, i32 %b) #1 {
; CHECK: Function Attrs: noinline
; CHECK-LABEL: define {{[^@]+}}@caller_nested
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]]) [[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_ADDR_I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_ADDR_I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[I_I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[I:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[I9:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 [[A]], ptr [[A_ADDR]], align 4
; CHECK-NEXT:    store i32 [[B]], ptr [[B_ADDR]], align 4
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A_ADDR]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[B_ADDR]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END8:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    store i32 0, ptr [[I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1:%.*]]
; CHECK:       for.cond1:
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[I]], align 4
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[TMP2]], 10
; CHECK-NEXT:    br i1 [[CMP2]], label [[FOR_BODY3:%.*]], label [[FOR_END7:%.*]]
; CHECK:       for.body3:
; CHECK-NEXT:    br label [[FOR_COND4:%.*]]
; CHECK:       for.cond4:
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[B_ADDR]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[A_ADDR]], align 4
; CHECK-NEXT:    [[CMP5:%.*]] = icmp slt i32 [[TMP3]], [[TMP4]]
; CHECK-NEXT:    br i1 [[CMP5]], label [[FOR_BODY6:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body6:
; CHECK-NEXT:    br label [[FOR_COND4]]
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FOR_INC:%.*]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[I]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP5]], 1
; CHECK-NEXT:    store i32 [[INC]], ptr [[I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1]]
; CHECK:       for.end7:
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end8:
; CHECK-NEXT:    store i32 0, ptr [[I9]], align 4
; CHECK-NEXT:    br label [[FOR_COND10:%.*]]
; CHECK:       for.cond10:
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[I9]], align 4
; CHECK-NEXT:    [[CMP11:%.*]] = icmp slt i32 [[TMP6]], 10
; CHECK-NEXT:    br i1 [[CMP11]], label [[FOR_BODY12:%.*]], label [[FOR_END15:%.*]]
; CHECK:       for.body12:
; CHECK-NEXT:    br label [[FOR_INC13:%.*]]
; CHECK:       for.inc13:
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr [[I9]], align 4
; CHECK-NEXT:    [[INC14:%.*]] = add nsw i32 [[TMP7]], 1
; CHECK-NEXT:    store i32 [[INC14]], ptr [[I9]], align 4
; CHECK-NEXT:    br label [[FOR_COND10]]
; CHECK:       for.end15:
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[A_ADDR_I]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[B_ADDR_I]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[I_I]])
; CHECK-NEXT:    store i32 0, ptr [[A_ADDR_I]], align 4
; CHECK-NEXT:    store i32 5, ptr [[B_ADDR_I]], align 4
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr [[A_ADDR_I]], align 4
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[B_ADDR_I]], align 4
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp slt i32 [[TMP11]], [[TMP12]]
; CHECK-NEXT:    br i1 [[CMP_I]], label [[FOR_BODY_I:%.*]], label [[FOR_END_I:%.*]]
; CHECK:       for.body.i:
; CHECK-NEXT:    br label [[FOR_COND_I]], !llvm.loop [[LOOP0]]
; CHECK:       for.end.i:
; CHECK-NEXT:    store i32 0, ptr [[I_I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1_I:%.*]]
; CHECK:       for.cond1.i:
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr [[I_I]], align 4
; CHECK-NEXT:    [[CMP2_I:%.*]] = icmp slt i32 [[TMP13]], 10
; CHECK-NEXT:    br i1 [[CMP2_I]], label [[FOR_BODY3_I:%.*]], label [[FOR_END8_I:%.*]]
; CHECK:       for.body3.i:
; CHECK-NEXT:    br label [[FOR_COND4_I:%.*]]
; CHECK:       for.cond4.i:
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, ptr [[B_ADDR_I]], align 4
; CHECK-NEXT:    [[TMP15:%.*]] = load i32, ptr [[A_ADDR_I]], align 4
; CHECK-NEXT:    [[CMP5_I:%.*]] = icmp slt i32 [[TMP14]], [[TMP15]]
; CHECK-NEXT:    br i1 [[CMP5_I]], label [[FOR_BODY6_I:%.*]], label [[FOR_END7_I:%.*]]
; CHECK:       for.body6.i:
  ; CHECK-NEXT:    br label [[FOR_COND4_I]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       for.end7.i:
; CHECK-NEXT:    [[TMP16:%.*]] = load i32, ptr [[I_I]], align 4
; CHECK-NEXT:    [[INC_I:%.*]] = add nsw i32 [[TMP16]], 1
; CHECK-NEXT:    store i32 [[INC_I]], ptr [[I_I]], align 4
; CHECK-NEXT:    br label [[FOR_COND1_I]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       for.end8.i:
; CHECK-NEXT:    br label [[WHILE_BODY_I:%.*]]
; CHECK:       while.body.i:
; CHECK-NEXT:    br label [[WHILE_BODY_I]]
; CHECK:       callee_nested.exit:
; CHECK-NEXT:    ret void
;
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %i9 = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  br label %for.cond
for.cond:
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end8
for.body:
  store i32 0, ptr %i, align 4
  br label %for.cond1
for.cond1:
  %2 = load i32, ptr %i, align 4
  %cmp2 = icmp slt i32 %2, 10
  br i1 %cmp2, label %for.body3, label %for.end7
for.body3:
  br label %for.cond4
for.cond4:
  %3 = load i32, ptr %b.addr, align 4
  %4 = load i32, ptr %a.addr, align 4
  %cmp5 = icmp slt i32 %3, %4
  br i1 %cmp5, label %for.body6, label %for.end
for.body6:
  br label %for.cond4
for.end:
  br label %for.inc
for.inc:
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond1
for.end7:
  br label %for.cond
for.end8:
  store i32 0, ptr %i9, align 4
  br label %for.cond10
for.cond10:
  %6 = load i32, ptr %i9, align 4
  %cmp11 = icmp slt i32 %6, 10
  br i1 %cmp11, label %for.body12, label %for.end15
for.body12:
  br label %for.inc13
for.inc13:
  %7 = load i32, ptr %i9, align 4
  %inc14 = add nsw i32 %7, 1
  store i32 %inc14, ptr %i9, align 4
  br label %for.cond10
for.end15:
  call void @callee_nested(i32 0, i32 5)
  ret void
}

; CHECK: attributes [[ATTR0]] = { mustprogress }
; CHECK: attributes [[ATTR1]] = { noinline }

; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[GEN1:!.*]]}
; CHECK: [[GEN1]] = !{!"llvm.loop.mustprogress"}
; CHECK: [[LOOP2]] = distinct !{[[LOOP2]], [[GEN1:!.*]]}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[GEN1:!.*]]}
; CHECK: [[LOOP4]] = distinct !{[[LOOP4]], [[GEN1:!.*]]}

attributes #0 = { mustprogress }
attributes #1 = { noinline }
attributes #2 = { noinline mustprogress }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.mustprogress"}
!2 = distinct !{!2, !1}
!3 = distinct !{!3, !1}
!4 = distinct !{!4, !1}
!5 = distinct !{!5, !1}
!6 = distinct !{!6, !1}
!7 = distinct !{!7, !1}

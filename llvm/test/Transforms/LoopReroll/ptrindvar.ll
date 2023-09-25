; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=loop-reroll   %s | FileCheck %s
target triple = "aarch64--linux-gnu"

define i32 @test(ptr readonly %buf, ptr readnone %end) #0 {
; CHECK-LABEL: define i32 @test
; CHECK-SAME: (ptr readonly [[BUF:%.*]], ptr readnone [[END:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BUF2:%.*]] = ptrtoint ptr [[BUF]] to i64
; CHECK-NEXT:    [[END1:%.*]] = ptrtoint ptr [[END]] to i64
; CHECK-NEXT:    [[CMP_9:%.*]] = icmp eq ptr [[BUF]], [[END]]
; CHECK-NEXT:    br i1 [[CMP_9]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; CHECK:       while.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[END1]], -8
; CHECK-NEXT:    [[TMP1:%.*]] = sub i64 [[TMP0]], [[BUF2]]
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw nsw i64 [[TMP2]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = add nuw nsw i64 [[TMP3]], 1
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[INDVAR:%.*]] = phi i64 [ [[INDVAR_NEXT:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[S_011:%.*]] = phi i32 [ [[ADD:%.*]], [[WHILE_BODY]] ], [ undef, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = shl nuw i64 [[INDVAR]], 2
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[BUF]], i64 [[TMP5]]
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[SCEVGEP]], align 4
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[TMP6]], [[S_011]]
; CHECK-NEXT:    [[INDVAR_NEXT]] = add i64 [[INDVAR]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVAR]], [[TMP4]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; CHECK:       while.end.loopexit:
; CHECK-NEXT:    [[ADD2_LCSSA:%.*]] = phi i32 [ [[ADD]], [[WHILE_BODY]] ]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       while.end:
; CHECK-NEXT:    [[S_0_LCSSA:%.*]] = phi i32 [ undef, [[ENTRY:%.*]] ], [ [[ADD2_LCSSA]], [[WHILE_END_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[S_0_LCSSA]]
;
entry:
  %cmp.9 = icmp eq ptr %buf, %end
  br i1 %cmp.9, label %while.end, label %while.body.preheader

while.body.preheader:
  br label %while.body

while.body:

  %S.011 = phi i32 [ %add2, %while.body ], [ undef, %while.body.preheader ]
  %buf.addr.010 = phi ptr [ %add.ptr, %while.body ], [ %buf, %while.body.preheader ]
  %0 = load i32, ptr %buf.addr.010, align 4
  %add = add nsw i32 %0, %S.011
  %arrayidx1 = getelementptr inbounds i32, ptr %buf.addr.010, i64 1
  %1 = load i32, ptr %arrayidx1, align 4
  %add2 = add nsw i32 %add, %1
  %add.ptr = getelementptr inbounds i32, ptr %buf.addr.010, i64 2
  %cmp = icmp eq ptr %add.ptr, %end
  br i1 %cmp, label %while.end.loopexit, label %while.body

while.end.loopexit:
  %add2.lcssa = phi i32 [ %add2, %while.body ]
  br label %while.end

while.end:
  %S.0.lcssa = phi i32 [ undef, %entry ], [ %add2.lcssa, %while.end.loopexit ]
  ret i32 %S.0.lcssa
}

define i32 @test2(ptr readonly %buf, ptr readnone %end) #0 {
; CHECK-LABEL: define i32 @test2
; CHECK-SAME: (ptr readonly [[BUF:%.*]], ptr readnone [[END:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[END2:%.*]] = ptrtoint ptr [[END]] to i64
; CHECK-NEXT:    [[BUF1:%.*]] = ptrtoint ptr [[BUF]] to i64
; CHECK-NEXT:    [[CMP_9:%.*]] = icmp eq ptr [[BUF]], [[END]]
; CHECK-NEXT:    br i1 [[CMP_9]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; CHECK:       while.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[BUF1]], -8
; CHECK-NEXT:    [[TMP1:%.*]] = sub i64 [[TMP0]], [[END2]]
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw nsw i64 [[TMP2]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = add nuw nsw i64 [[TMP3]], 1
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[INDVAR:%.*]] = phi i64 [ [[INDVAR_NEXT:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[S_011:%.*]] = phi i32 [ [[ADD:%.*]], [[WHILE_BODY]] ], [ undef, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = mul nsw i64 [[INDVAR]], -4
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[BUF]], i64 [[TMP5]]
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[SCEVGEP]], align 4
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[TMP6]], [[S_011]]
; CHECK-NEXT:    [[INDVAR_NEXT]] = add i64 [[INDVAR]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVAR]], [[TMP4]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; CHECK:       while.end.loopexit:
; CHECK-NEXT:    [[ADD2_LCSSA:%.*]] = phi i32 [ [[ADD]], [[WHILE_BODY]] ]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       while.end:
; CHECK-NEXT:    [[S_0_LCSSA:%.*]] = phi i32 [ undef, [[ENTRY:%.*]] ], [ [[ADD2_LCSSA]], [[WHILE_END_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[S_0_LCSSA]]
;
entry:
  %cmp.9 = icmp eq ptr %buf, %end
  br i1 %cmp.9, label %while.end, label %while.body.preheader

while.body.preheader:
  br label %while.body

while.body:

  %S.011 = phi i32 [ %add2, %while.body ], [ undef, %while.body.preheader ]
  %buf.addr.010 = phi ptr [ %add.ptr, %while.body ], [ %buf, %while.body.preheader ]
  %0 = load i32, ptr %buf.addr.010, align 4
  %add = add nsw i32 %0, %S.011
  %arrayidx1 = getelementptr inbounds i32, ptr %buf.addr.010, i64 -1
  %1 = load i32, ptr %arrayidx1, align 4
  %add2 = add nsw i32 %add, %1
  %add.ptr = getelementptr inbounds i32, ptr %buf.addr.010, i64 -2
  %cmp = icmp eq ptr %add.ptr, %end
  br i1 %cmp, label %while.end.loopexit, label %while.body

while.end.loopexit:
  %add2.lcssa = phi i32 [ %add2, %while.body ]
  br label %while.end

while.end:
  %S.0.lcssa = phi i32 [ undef, %entry ], [ %add2.lcssa, %while.end.loopexit ]
  ret i32 %S.0.lcssa
}

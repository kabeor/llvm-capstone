; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=gvn -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

@a = common global [100 x i64] zeroinitializer, align 16
@b = common global [100 x i64] zeroinitializer, align 16
@g1 = common global i64 0, align 8
@g2 = common global i64 0, align 8
@g3 = common global i64 0, align 8
declare i64 @goo(...) local_unnamed_addr #1

define void @test1(i64 %a, i64 %b, i64 %c, i64 %d) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i64 [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    store i64 [[MUL]], ptr @g1, align 8
; CHECK-NEXT:    [[T0:%.*]] = load i64, ptr @g2, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[T0]], 3
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[MUL2:%.*]] = mul nsw i64 [[D:%.*]], [[C:%.*]]
; CHECK-NEXT:    store i64 [[MUL2]], ptr @g2, align 8
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[MUL3_PRE_PHI:%.*]] = phi i64 [ [[MUL2]], [[IF_THEN]] ], [ [[MUL]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[B_ADDR_0:%.*]] = phi i64 [ [[D]], [[IF_THEN]] ], [ [[B]], [[ENTRY]] ]
; CHECK-NEXT:    [[A_ADDR_0:%.*]] = phi i64 [ [[C]], [[IF_THEN]] ], [ [[A]], [[ENTRY]] ]
; CHECK-NEXT:    store i64 [[MUL3_PRE_PHI]], ptr @g3, align 8
; CHECK-NEXT:    ret void
;
entry:
  %mul = mul nsw i64 %b, %a
  store i64 %mul, ptr @g1, align 8
  %t0 = load i64, ptr @g2, align 8
  %cmp = icmp sgt i64 %t0, 3
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %mul2 = mul nsw i64 %d, %c
  store i64 %mul2, ptr @g2, align 8
  br label %if.end

; Check phi-translate works and mul is removed.
if.end:                                           ; preds = %if.then, %entry
  %b.addr.0 = phi i64 [ %d, %if.then ], [ %b, %entry ]
  %a.addr.0 = phi i64 [ %c, %if.then ], [ %a, %entry ]
  %mul3 = mul nsw i64 %a.addr.0, %b.addr.0
  store i64 %mul3, ptr @g3, align 8
  ret void
}

define void @test2(i64 %i) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [100 x i64], ptr @a, i64 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[T0:%.*]] = load i64, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds [100 x i64], ptr @b, i64 0, i64 [[I]]
; CHECK-NEXT:    [[T1:%.*]] = load i64, ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i64 [[T1]], [[T0]]
; CHECK-NEXT:    store i64 [[MUL]], ptr @g1, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[MUL]], 3
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CALL:%.*]] = tail call i64 (...) @goo()
; CHECK-NEXT:    store i64 [[CALL]], ptr @g2, align 8
; CHECK-NEXT:    [[T2_PRE:%.*]] = load i64, ptr getelementptr inbounds ([100 x i64], ptr @a, i64 0, i64 3), align 8
; CHECK-NEXT:    [[T3_PRE:%.*]] = load i64, ptr getelementptr inbounds ([100 x i64], ptr @b, i64 0, i64 3), align 8
; CHECK-NEXT:    [[DOTPRE:%.*]] = mul nsw i64 [[T3_PRE]], [[T2_PRE]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[MUL5_PRE_PHI:%.*]] = phi i64 [ [[DOTPRE]], [[IF_THEN]] ], [ [[MUL]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[T3:%.*]] = phi i64 [ [[T3_PRE]], [[IF_THEN]] ], [ [[T1]], [[ENTRY]] ]
; CHECK-NEXT:    [[T2:%.*]] = phi i64 [ [[T2_PRE]], [[IF_THEN]] ], [ [[T0]], [[ENTRY]] ]
; CHECK-NEXT:    [[I_ADDR_0:%.*]] = phi i64 [ 3, [[IF_THEN]] ], [ [[I]], [[ENTRY]] ]
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds [100 x i64], ptr @a, i64 0, i64 [[I_ADDR_0]]
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds [100 x i64], ptr @b, i64 0, i64 [[I_ADDR_0]]
; CHECK-NEXT:    store i64 [[MUL5_PRE_PHI]], ptr @g3, align 8
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx = getelementptr inbounds [100 x i64], ptr @a, i64 0, i64 %i
  %t0 = load i64, ptr %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds [100 x i64], ptr @b, i64 0, i64 %i
  %t1 = load i64, ptr %arrayidx1, align 8
  %mul = mul nsw i64 %t1, %t0
  store i64 %mul, ptr @g1, align 8
  %cmp = icmp sgt i64 %mul, 3
  br i1 %cmp, label %if.then, label %if.end

; Check phi-translate works for the phi generated by loadpre. A new mul will be
; inserted in if.then block.
if.then:                                          ; preds = %entry
  %call = tail call i64 (...) @goo() #2
  store i64 %call, ptr @g2, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %i.addr.0 = phi i64 [ 3, %if.then ], [ %i, %entry ]
  %arrayidx3 = getelementptr inbounds [100 x i64], ptr @a, i64 0, i64 %i.addr.0
  %t2 = load i64, ptr %arrayidx3, align 8
  %arrayidx4 = getelementptr inbounds [100 x i64], ptr @b, i64 0, i64 %i.addr.0
  %t3 = load i64, ptr %arrayidx4, align 8
  %mul5 = mul nsw i64 %t3, %t2
  store i64 %mul5, ptr @g3, align 8
  ret void
}

; Check phi-translate doesn't go through backedge, which may lead to incorrect
; pre transformation.
define void @test3(i64 %N, ptr nocapture readonly %a) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[I_0:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_BODY:%.*]] ]
; CHECK-NEXT:    [[ADD]] = add nuw nsw i64 [[I_0]], 1
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, ptr [[A:%.*]], i64 [[ADD]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i64 [[I_0]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[CALL:%.*]] = tail call i64 (...) @goo()
; CHECK-NEXT:    [[ADD1:%.*]] = sub nsw i64 0, [[CALL]]
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i64 [[TMP0]], [[ADD1]]
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[FOR_COND]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, ptr [[A]], i64 [[I_0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, ptr [[ARRAYIDX2]], align 8
; CHECK-NEXT:    store i64 [[TMP1]], ptr @g1, align 8
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  %add = add nuw nsw i64 %i.0, 1
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %add
  %tmp0 = load i64, ptr %arrayidx, align 8
  %cmp = icmp slt i64 %i.0, %N
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call = tail call i64 (...) @goo() #2
  %add1 = sub nsw i64 0, %call
  %tobool = icmp eq i64 %tmp0, %add1
  br i1 %tobool, label %for.cond, label %for.end

for.end:                                          ; preds = %for.body, %for.cond
  %i.0.lcssa = phi i64 [ %i.0, %for.body ], [ %i.0, %for.cond ]
  %arrayidx2 = getelementptr inbounds i64, ptr %a, i64 %i.0.lcssa
  %tmp1 = load i64, ptr %arrayidx2, align 8
  store i64 %tmp1, ptr @g1, align 8
  ret void
}

; It is incorrect to use the value of %andres in last loop iteration
; to do pre.
define i32 @test4(i32 %cond, i32 %SectionAttrs.0231.ph, ptr %AttrFlag) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  for.body.preheader:
; CHECK-NEXT:    [[T514:%.*]] = load volatile i32, ptr [[ATTRFLAG:%.*]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[T320:%.*]] = phi i32 [ [[T334:%.*]], [[BB343:%.*]] ], [ [[T514]], [[FOR_BODY_PREHEADER:%.*]] ]
; CHECK-NEXT:    [[ANDRES:%.*]] = and i32 [[T320]], [[SECTIONATTRS_0231_PH:%.*]]
; CHECK-NEXT:    [[TOBOOL1:%.*]] = icmp eq i32 [[ANDRES]], 0
; CHECK-NEXT:    br i1 [[TOBOOL1]], label [[BB343]], label [[CRITEDGE_LOOPEXIT:%.*]]
; CHECK:       bb343:
; CHECK-NEXT:    [[T334]] = load volatile i32, ptr [[ATTRFLAG]], align 4
; CHECK-NEXT:    [[TOBOOL2:%.*]] = icmp eq i32 [[COND:%.*]], 0
; CHECK-NEXT:    br i1 [[TOBOOL2]], label [[CRITEDGE_LOOPEXIT]], label [[FOR_BODY]]
; CHECK:       critedge.loopexit:
; CHECK-NEXT:    unreachable
;
for.body.preheader:
  %t514 = load volatile i32, ptr %AttrFlag
  br label %for.body

for.body:
  %t320 = phi i32 [ %t334, %bb343 ], [ %t514, %for.body.preheader ]
  %andres = and i32 %t320, %SectionAttrs.0231.ph
  %tobool1 = icmp eq i32 %andres, 0
  br i1 %tobool1, label %bb343, label %critedge.loopexit

bb343:
  %t334 = load volatile i32, ptr %AttrFlag
  %tobool2 = icmp eq i32 %cond, 0
  br i1 %tobool2, label %critedge.loopexit, label %for.body

critedge.loopexit:
  unreachable
}

declare void @bar(...) local_unnamed_addr #1

; Check sub expression will be pre transformed.
define i64 @test5(ptr %start, ptr %e, i32 %n1, i32 %n2) local_unnamed_addr #0 {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_PTR_LHS_CAST:%.*]] = ptrtoint ptr [[E:%.*]] to i64
; CHECK-NEXT:    [[SUB_PTR_RHS_CAST:%.*]] = ptrtoint ptr [[START:%.*]] to i64
; CHECK-NEXT:    [[SUB_PTR_SUB:%.*]] = sub i64 [[SUB_PTR_LHS_CAST]], [[SUB_PTR_RHS_CAST]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[SUB_PTR_SUB]], 4000
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[N1:%.*]], [[N2:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[IF_THEN2:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then2:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[START]], i64 800
; CHECK-NEXT:    [[DOTPRE:%.*]] = ptrtoint ptr [[ADD_PTR]] to i64
; CHECK-NEXT:    [[DOTPRE1:%.*]] = sub i64 [[SUB_PTR_LHS_CAST]], [[DOTPRE]]
; CHECK-NEXT:    br label [[IF_END3]]
; CHECK:       if.else:
; CHECK-NEXT:    tail call void (...) @bar()
; CHECK-NEXT:    br label [[IF_END3]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[SUB_PTR_SUB6_PRE_PHI:%.*]] = phi i64 [ [[SUB_PTR_SUB]], [[IF_ELSE]] ], [ [[DOTPRE1]], [[IF_THEN2]] ], [ [[SUB_PTR_SUB]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[SUB_PTR_RHS_CAST5_PRE_PHI:%.*]] = phi i64 [ [[SUB_PTR_RHS_CAST]], [[IF_ELSE]] ], [ [[DOTPRE]], [[IF_THEN2]] ], [ [[SUB_PTR_RHS_CAST]], [[ENTRY]] ]
; CHECK-NEXT:    [[P_0:%.*]] = phi ptr [ [[ADD_PTR]], [[IF_THEN2]] ], [ [[START]], [[IF_ELSE]] ], [ [[START]], [[ENTRY]] ]
; CHECK-NEXT:    [[SUB_PTR_DIV7:%.*]] = ashr exact i64 [[SUB_PTR_SUB6_PRE_PHI]], 2
; CHECK-NEXT:    ret i64 [[SUB_PTR_DIV7]]
;
entry:
  %sub.ptr.lhs.cast = ptrtoint ptr %e to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %start to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %cmp = icmp sgt i64 %sub.ptr.sub, 4000
  br i1 %cmp, label %if.then, label %if.end3

if.then:                                          ; preds = %entry
  %cmp1 = icmp sgt i32 %n1, %n2
  br i1 %cmp1, label %if.then2, label %if.else

if.then2:                                         ; preds = %if.then
  %add.ptr = getelementptr inbounds i32, ptr %start, i64 800
  br label %if.end3

if.else:                                          ; preds = %if.then
  tail call void (...) @bar() #2
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %if.else, %entry
  %p.0 = phi ptr [ %add.ptr, %if.then2 ], [ %start, %if.else ], [ %start, %entry ]
  %sub.ptr.rhs.cast5 = ptrtoint ptr %p.0 to i64
  %sub.ptr.sub6 = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast5
  %sub.ptr.div7 = ashr exact i64 %sub.ptr.sub6, 2
  ret i64 %sub.ptr.div7
}

; Here the load from arrayidx1 is partially redundant, but its value is
; available in if.then. Check that we correctly phi-translate to the phi that
; the load has been replaced with.
define void @test6(ptr %ptr) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX1_PHI_TRANS_INSERT:%.*]] = getelementptr inbounds i32, ptr [[PTR:%.*]], i64 1
; CHECK-NEXT:    [[DOTPRE:%.*]] = load i32, ptr [[ARRAYIDX1_PHI_TRANS_INSERT]], align 4
; CHECK-NEXT:    br label [[WHILE:%.*]]
; CHECK:       while:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i32 [ [[DOTPRE]], [[ENTRY:%.*]] ], [ [[TMP2:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ 1, [[ENTRY]] ], [ [[I_NEXT:%.*]], [[IF_END]] ]
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw nsw i64 [[I]], 1
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[I_NEXT]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END]]
; CHECK:       if.then:
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    store i32 [[TMP0]], ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMP2]] = phi i32 [ [[TMP0]], [[IF_THEN]] ], [ [[TMP1]], [[WHILE]] ]
; CHECK-NEXT:    br i1 undef, label [[WHILE_END:%.*]], label [[WHILE]]
; CHECK:       while.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %while

while:
  %i = phi i64 [ 1, %entry ], [ %i.next, %if.end ]
  %arrayidx1 = getelementptr inbounds i32, ptr %ptr, i64 %i
  %0 = load i32, ptr %arrayidx1, align 4
  %i.next = add nuw nsw i64 %i, 1
  %arrayidx2 = getelementptr inbounds i32, ptr %ptr, i64 %i.next
  %1 = load i32, ptr %arrayidx2, align 4
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:
  store i32 %1, ptr %arrayidx1, align 4
  store i32 %0, ptr %arrayidx2, align 4
  br label %if.end

if.end:
  br i1 undef, label %while.end, label %while

while.end:
  ret void
}

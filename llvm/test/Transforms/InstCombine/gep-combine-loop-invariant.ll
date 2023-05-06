; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -opaque-pointers=0 < %s -passes='require<loops>,instcombine' -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @foo(i8* nocapture readnone %match, i32 %cur_match, i32 %best_len, i32 %scan_end, i32* nocapture readonly %prev, i32 %limit, i32 %chain_length, i8* nocapture readonly %win, i32 %wmask) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[IDX_EXT2:%.*]] = zext i32 [[CUR_MATCH:%.*]] to i64
; CHECK-NEXT:    [[ADD_PTR4:%.*]] = getelementptr inbounds i8, i8* [[WIN:%.*]], i64 [[IDX_EXT2]]
; CHECK-NEXT:    [[IDX_EXT1:%.*]] = zext i32 [[BEST_LEN:%.*]] to i64
; CHECK-NEXT:    [[ADD_PTR25:%.*]] = getelementptr inbounds i8, i8* [[ADD_PTR4]], i64 [[IDX_EXT1]]
; CHECK-NEXT:    [[ADD_PTR36:%.*]] = getelementptr inbounds i8, i8* [[ADD_PTR25]], i64 -1
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8* [[ADD_PTR36]] to i32*
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[TMP0]], align 4
; CHECK-NEXT:    [[CMP7:%.*]] = icmp eq i32 [[TMP1]], [[SCAN_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP7]], label [[DO_END:%.*]], label [[IF_THEN_LR_PH:%.*]]
; CHECK:       if.then.lr.ph:
; CHECK-NEXT:    br label [[IF_THEN:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[IDX_EXT:%.*]] = zext i32 [[TMP4:%.*]] to i64
; CHECK-NEXT:    [[ADD_PTR1:%.*]] = getelementptr inbounds i8, i8* [[WIN]], i64 [[IDX_EXT1]]
; CHECK-NEXT:    [[ADD_PTR22:%.*]] = getelementptr i8, i8* [[ADD_PTR1]], i64 -1
; CHECK-NEXT:    [[ADD_PTR3:%.*]] = getelementptr i8, i8* [[ADD_PTR22]], i64 [[IDX_EXT]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i8* [[ADD_PTR3]] to i32*
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[TMP2]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP3]], [[SCAN_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_END]], label [[IF_THEN]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CUR_MATCH_ADDR_09:%.*]] = phi i32 [ [[CUR_MATCH]], [[IF_THEN_LR_PH]] ], [ [[TMP4]], [[DO_BODY:%.*]] ]
; CHECK-NEXT:    [[CHAIN_LENGTH_ADDR_08:%.*]] = phi i32 [ [[CHAIN_LENGTH:%.*]], [[IF_THEN_LR_PH]] ], [ [[DEC:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[CUR_MATCH_ADDR_09]], [[WMASK:%.*]]
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[AND]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[PREV:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[TMP4]] = load i32, i32* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[CMP4:%.*]] = icmp ugt i32 [[TMP4]], [[LIMIT:%.*]]
; CHECK-NEXT:    br i1 [[CMP4]], label [[LAND_LHS_TRUE:%.*]], label [[DO_END]]
; CHECK:       land.lhs.true:
; CHECK-NEXT:    [[DEC]] = add i32 [[CHAIN_LENGTH_ADDR_08]], -1
; CHECK-NEXT:    [[CMP5:%.*]] = icmp eq i32 [[DEC]], 0
; CHECK-NEXT:    br i1 [[CMP5]], label [[DO_END]], label [[DO_BODY]]
; CHECK:       do.end:
; CHECK-NEXT:    [[CONT_0:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ 0, [[IF_THEN]] ], [ 0, [[LAND_LHS_TRUE]] ], [ 1, [[DO_BODY]] ]
; CHECK-NEXT:    ret i32 [[CONT_0]]
;
entry:
  %idx.ext2 = zext i32 %cur_match to i64
  %add.ptr4 = getelementptr inbounds i8, i8* %win, i64 %idx.ext2
  %idx.ext1 = zext i32 %best_len to i64
  %add.ptr25 = getelementptr inbounds i8, i8* %add.ptr4, i64 %idx.ext1
  %add.ptr36 = getelementptr inbounds i8, i8* %add.ptr25, i64 -1
  %0 = bitcast i8* %add.ptr36 to i32*
  %1 = load i32, i32* %0, align 4
  %cmp7 = icmp eq i32 %1, %scan_end
  br i1 %cmp7, label %do.end, label %if.then.lr.ph

if.then.lr.ph:                                    ; preds = %entry
  br label %if.then

do.body:                                          ; preds = %land.lhs.true
  %chain_length.addr.0 = phi i32 [ %dec, %land.lhs.true ]
  %cur_match.addr.0 = phi i32 [ %4, %land.lhs.true ]
  %idx.ext = zext i32 %cur_match.addr.0 to i64
  %add.ptr = getelementptr inbounds i8, i8* %win, i64 %idx.ext
  %add.ptr2 = getelementptr inbounds i8, i8* %add.ptr, i64 %idx.ext1
  %add.ptr3 = getelementptr inbounds i8, i8* %add.ptr2, i64 -1
  %2 = bitcast i8* %add.ptr3 to i32*
  %3 = load i32, i32* %2, align 4
  %cmp = icmp eq i32 %3, %scan_end
  br i1 %cmp, label %do.end, label %if.then

if.then:                                          ; preds = %if.then.lr.ph, %do.body
  %cur_match.addr.09 = phi i32 [ %cur_match, %if.then.lr.ph ], [ %cur_match.addr.0, %do.body ]
  %chain_length.addr.08 = phi i32 [ %chain_length, %if.then.lr.ph ], [ %chain_length.addr.0, %do.body ]
  %and = and i32 %cur_match.addr.09, %wmask
  %idxprom = zext i32 %and to i64
  %arrayidx = getelementptr inbounds i32, i32* %prev, i64 %idxprom
  %4 = load i32, i32* %arrayidx, align 4
  %cmp4 = icmp ugt i32 %4, %limit
  br i1 %cmp4, label %land.lhs.true, label %do.end

land.lhs.true:                                    ; preds = %if.then
  %dec = add i32 %chain_length.addr.08, -1
  %cmp5 = icmp eq i32 %dec, 0
  br i1 %cmp5, label %do.end, label %do.body

do.end:                                           ; preds = %do.body, %land.lhs.true, %if.then, %entry
  %cont.0 = phi i32 [ 1, %entry ], [ 0, %if.then ], [ 0, %land.lhs.true ], [ 1, %do.body ]
  ret i32 %cont.0
}

declare void @blackhole(<2 x i8*>)

define void @PR37005(i8* %base, i8** %in) {
; CHECK-LABEL: @PR37005(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[E2:%.*]] = getelementptr inbounds i8*, i8** [[IN:%.*]], i64 undef
; CHECK-NEXT:    [[E4:%.*]] = getelementptr inbounds i8*, i8** [[E2]], <2 x i64> <i64 0, i64 1>
; CHECK-NEXT:    [[PI1:%.*]] = ptrtoint <2 x i8**> [[E4]] to <2 x i64>
; CHECK-NEXT:    [[TMP0:%.*]] = lshr <2 x i64> [[PI1]], <i64 14, i64 14>
; CHECK-NEXT:    [[SL1:%.*]] = and <2 x i64> [[TMP0]], <i64 1125899906842496, i64 1125899906842496>
; CHECK-NEXT:    [[E51:%.*]] = getelementptr inbounds i8, i8* [[BASE:%.*]], i64 80
; CHECK-NEXT:    [[E6:%.*]] = getelementptr inbounds i8, i8* [[E51]], <2 x i64> [[SL1]]
; CHECK-NEXT:    call void @blackhole(<2 x i8*> [[E6]])
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  br label %loop

loop:
  %e1 = getelementptr inbounds i8*, i8** %in, i64 undef
  %e2 = getelementptr inbounds i8*, i8** %e1, i64 6
  %bc1 = bitcast i8** %e2 to <2 x i8*>*
  %e3 = getelementptr inbounds <2 x i8*>, <2 x i8*>* %bc1, i64 0, i64 0
  %e4 = getelementptr inbounds i8*, i8** %e3, <2 x i64> <i64 0, i64 1>
  %pi1 = ptrtoint <2 x i8**> %e4 to <2 x i64>
  %lr1 = lshr <2 x i64> %pi1, <i64 21, i64 21>
  %sl1 = shl nuw nsw <2 x i64> %lr1, <i64 7, i64 7>
  %e5 = getelementptr inbounds i8, i8* %base, <2 x i64> %sl1
  %e6 = getelementptr inbounds i8, <2 x i8*> %e5, i64 80
  call void @blackhole(<2 x i8*> %e6)
  br label %loop
}

define void @PR37005_2(i8* %base, i8** %in) {
; CHECK-LABEL: @PR37005_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[E2:%.*]] = getelementptr inbounds i8*, i8** [[IN:%.*]], i64 undef
; CHECK-NEXT:    [[PI1:%.*]] = ptrtoint i8** [[E2]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = lshr i64 [[PI1]], 14
; CHECK-NEXT:    [[SL1:%.*]] = and i64 [[TMP0]], 1125899906842496
; CHECK-NEXT:    [[E51:%.*]] = getelementptr inbounds i8, i8* [[BASE:%.*]], <2 x i64> <i64 80, i64 60>
; CHECK-NEXT:    [[E6:%.*]] = getelementptr inbounds i8, <2 x i8*> [[E51]], i64 [[SL1]]
; CHECK-NEXT:    call void @blackhole(<2 x i8*> [[E6]])
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  br label %loop

loop:
  %e1 = getelementptr inbounds i8*, i8** %in, i64 undef
  %e2 = getelementptr inbounds i8*, i8** %e1, i64 6
  %pi1 = ptrtoint i8** %e2 to i64
  %lr1 = lshr i64 %pi1, 21
  %sl1 = shl nuw nsw i64 %lr1, 7
  %e5 = getelementptr inbounds i8, i8* %base, i64 %sl1
  %e6 = getelementptr inbounds i8, i8* %e5, <2 x i64> <i64 80, i64 60>
  call void @blackhole(<2 x i8*> %e6)
  br label %loop
}

define void @PR37005_3(<2 x i8*> %base, i8** %in) {
; CHECK-LABEL: @PR37005_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[E2:%.*]] = getelementptr inbounds i8*, i8** [[IN:%.*]], i64 undef
; CHECK-NEXT:    [[E4:%.*]] = getelementptr inbounds i8*, i8** [[E2]], <2 x i64> <i64 0, i64 1>
; CHECK-NEXT:    [[PI1:%.*]] = ptrtoint <2 x i8**> [[E4]] to <2 x i64>
; CHECK-NEXT:    [[TMP0:%.*]] = lshr <2 x i64> [[PI1]], <i64 14, i64 14>
; CHECK-NEXT:    [[SL1:%.*]] = and <2 x i64> [[TMP0]], <i64 1125899906842496, i64 1125899906842496>
; CHECK-NEXT:    [[E51:%.*]] = getelementptr inbounds i8, <2 x i8*> [[BASE:%.*]], i64 80
; CHECK-NEXT:    [[E6:%.*]] = getelementptr inbounds i8, <2 x i8*> [[E51]], <2 x i64> [[SL1]]
; CHECK-NEXT:    call void @blackhole(<2 x i8*> [[E6]])
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  br label %loop

loop:
  %e1 = getelementptr inbounds i8*, i8** %in, i64 undef
  %e2 = getelementptr inbounds i8*, i8** %e1, i64 6
  %bc1 = bitcast i8** %e2 to <2 x i8*>*
  %e3 = getelementptr inbounds <2 x i8*>, <2 x i8*>* %bc1, i64 0, i64 0
  %e4 = getelementptr inbounds i8*, i8** %e3, <2 x i64> <i64 0, i64 1>
  %pi1 = ptrtoint <2 x i8**> %e4 to <2 x i64>
  %lr1 = lshr <2 x i64> %pi1, <i64 21, i64 21>
  %sl1 = shl nuw nsw <2 x i64> %lr1, <i64 7, i64 7>
  %e5 = getelementptr inbounds i8, <2 x i8*> %base, <2 x i64> %sl1
  %e6 = getelementptr inbounds i8, <2 x i8*> %e5, i64 80
  call void @blackhole(<2 x i8*> %e6)
  br label %loop
}

; This would crash because we did not expect to be able to constant fold a GEP.

define void @PR51485(<2 x i64> %v) {
; CHECK-LABEL: @PR51485(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[SL1:%.*]] = shl nuw nsw <2 x i64> [[V:%.*]], <i64 7, i64 7>
; CHECK-NEXT:    [[E6:%.*]] = getelementptr i8, i8* getelementptr (i8, i8* bitcast (void (<2 x i64>)* @PR51485 to i8*), i64 80), <2 x i64> [[SL1]]
; CHECK-NEXT:    call void @blackhole(<2 x i8*> [[E6]])
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  br label %loop

loop:
  %sl1 = shl nuw nsw <2 x i64> %v, <i64 7, i64 7>
  %e5 = getelementptr inbounds i8, i8* bitcast (void (<2 x i64>)* @PR51485 to i8*), <2 x i64> %sl1
  %e6 = getelementptr inbounds i8, <2 x i8*> %e5, i64 80
  call void @blackhole(<2 x i8*> %e6)
  br label %loop
}

; Avoid folding the GEP outside the loop to inside, and increasing loop
; instruction count.
define float @gep_cross_loop(i64* %_arg_, float* %_arg_3, float %_arg_8)
; CHECK-LABEL: @gep_cross_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, i64* [[_ARG_:%.*]], align 8
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds float, float* [[_ARG_3:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    br label [[FOR_COND_I:%.*]]
; CHECK:       for.cond.i:
; CHECK-NEXT:    [[IDX:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[ADD11_I:%.*]], [[FOR_BODY_I:%.*]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi float [ 0.000000e+00, [[ENTRY]] ], [ [[ADD_I:%.*]], [[FOR_BODY_I]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[IDX]], 17
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY_I]], label [[FOR_COND_I_I_I_PREHEADER:%.*]]
; CHECK:       for.cond.i.i.i.preheader:
; CHECK-NEXT:    ret float [[SUM]]
; CHECK:       for.body.i:
; CHECK-NEXT:    [[ARRAYIDX_I84_I:%.*]] = getelementptr inbounds float, float* [[ADD_PTR]], i64 [[IDX]]
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[ARRAYIDX_I84_I]], align 4
; CHECK-NEXT:    [[ADD_I]] = fadd fast float [[SUM]], [[TMP1]]
; CHECK-NEXT:    [[ADD11_I]] = add nuw nsw i64 [[IDX]], 1
; CHECK-NEXT:    br label [[FOR_COND_I]]
;
{
entry:
  %0 = load i64, i64* %_arg_, align 8
  %add.ptr = getelementptr inbounds float, float* %_arg_3, i64 %0
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.body.i, %entry
  %idx = phi i64 [ 0, %entry ], [ %add11.i, %for.body.i ]
  %sum = phi float [ 0.000000e+00, %entry ], [ %add.i, %for.body.i ]
  %cmp = icmp ule i64 %idx, 16
  br i1 %cmp, label %for.body.i, label %for.cond.i.i.i.preheader

for.cond.i.i.i.preheader:                         ; preds = %for.cond.i
  ret float %sum

for.body.i:                                       ; preds = %for.cond.i
  %arrayidx.i84.i = getelementptr inbounds float, float * %add.ptr, i64 %idx
  %1 = load float, float* %arrayidx.i84.i, align 4
  %add.i = fadd fast float %sum, %1
  %add11.i = add nsw i64 %idx, 1
  br label %for.cond.i
}

declare void @use(i8*)

define void @only_one_inbounds(i8* %ptr, i1 %c, i32 noundef %arg1, i32 noundef %arg2) {
; CHECK-LABEL: @only_one_inbounds(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARG2_EXT:%.*]] = zext i32 [[ARG2:%.*]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[ARG1_EXT:%.*]] = zext i32 [[ARG1:%.*]] to i64
; CHECK-NEXT:    [[PTR21:%.*]] = getelementptr i8, i8* [[PTR:%.*]], i64 [[ARG2_EXT]]
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr i8, i8* [[PTR21]], i64 [[ARG1_EXT]]
; CHECK-NEXT:    call void @use(i8* [[PTR3]])
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %arg2.ext = zext i32 %arg2 to i64
  br label %loop

loop:
  %arg1.ext = zext i32 %arg1 to i64
  %ptr2 = getelementptr inbounds i8, i8* %ptr, i64 %arg1.ext
  %ptr3 = getelementptr i8, i8* %ptr2, i64 %arg2.ext
  call void @use(i8* %ptr3)
  br i1 %c, label %loop, label %exit

exit:
  ret void
}

define void @both_inbounds_one_neg(i8* %ptr, i1 %c, i32 noundef %arg) {
; CHECK-LABEL: @both_inbounds_one_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[ARG_EXT:%.*]] = zext i32 [[ARG:%.*]] to i64
; CHECK-NEXT:    [[PTR21:%.*]] = getelementptr i8, i8* [[PTR:%.*]], i64 -1
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr i8, i8* [[PTR21]], i64 [[ARG_EXT]]
; CHECK-NEXT:    call void @use(i8* [[PTR3]])
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %arg.ext = zext i32 %arg to i64
  %ptr2 = getelementptr inbounds i8, i8* %ptr, i64 %arg.ext
  %ptr3 = getelementptr inbounds i8, i8* %ptr2, i64 -1
  call void @use(i8* %ptr3)
  br i1 %c, label %loop, label %exit

exit:
  ret void
}

define void @both_inbounds_pos(i8* %ptr, i1 %c, i32 noundef %arg) {
; CHECK-LABEL: @both_inbounds_pos(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[ARG_EXT:%.*]] = zext i32 [[ARG:%.*]] to i64
; CHECK-NEXT:    [[PTR21:%.*]] = getelementptr inbounds i8, i8* [[PTR:%.*]], i64 1
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr inbounds i8, i8* [[PTR21]], i64 [[ARG_EXT]]
; CHECK-NEXT:    call void @use(i8* nonnull [[PTR3]])
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %arg.ext = zext i32 %arg to i64
  %ptr2 = getelementptr inbounds i8, i8* %ptr, i64 %arg.ext
  %ptr3 = getelementptr inbounds i8, i8* %ptr2, i64 1
  call void @use(i8* %ptr3)
  br i1 %c, label %loop, label %exit

exit:
  ret void
}

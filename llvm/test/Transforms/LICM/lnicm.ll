; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -aa-pipeline=basic-aa -passes='loop(loop-interchange)' -cache-line-size=64 -S %s | FileCheck %s --check-prefixes INTC
; RUN: opt -aa-pipeline=basic-aa -passes='loop-mssa(lnicm),loop(loop-interchange)' -cache-line-size=64 -S %s | FileCheck %s --check-prefixes LNICM
; RUN: opt -aa-pipeline=basic-aa -passes='loop-mssa(licm),loop(loop-interchange)' -cache-line-size=64 -S %s | FileCheck %s --check-prefixes LICM

; This test represents the following function:
; void test(int n, int m, int x[m][n], int y[n], int *z) {
;   for (int k = 0; k < n; k++) {
;     int tmp = *z;
;     for (int i = 0; i < m; i++)
;       x[i][k] += y[k] + tmp;
;   }
; }
; We only want to hoist the load of z out of the loop nest.
; LICM hoists the load of y[k] out of the i-loop, but LNICM doesn't do so
; to keep perfect loop nest. This enables optimizations that require
; perfect loop nest (e.g. loop-interchange) to perform.


define dso_local void @test(i64 %n, i64 %m, ptr noalias %x, ptr noalias readonly %y, ptr readonly %z) {
; The loopnest is not interchanged when we only run loop interchange.
; INTC-LABEL: @test(
; INTC-NEXT:  gurad:
; INTC-NEXT:    [[CMP23:%.*]] = icmp sgt i64 [[M:%.*]], 0
; INTC-NEXT:    [[CMP32:%.*]] = icmp sgt i64 [[N:%.*]], 0
; INTC-NEXT:    br i1 [[CMP23]], label [[FOR_COND1_PREHEADER_LR_PH:%.*]], label [[FOR_END11:%.*]]
; INTC:       for.cond1.preheader.lr.ph:
; INTC-NEXT:    br i1 [[CMP32]], label [[FOR_I_PREHEADER:%.*]], label [[FOR_END11]]
; INTC:       for.i.preheader:
; INTC-NEXT:    br label [[ENTRY:%.*]]
; INTC:       entry:
; INTC-NEXT:    br label [[FOR_BODY:%.*]]
; INTC:       for.body:
; INTC-NEXT:    [[K_02:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC10:%.*]], [[FOR_END:%.*]] ]
; INTC-NEXT:    [[TMP0:%.*]] = load i32, ptr [[Z:%.*]], align 4
; INTC-NEXT:    br label [[FOR_BODY3:%.*]]
; INTC:       for.body3:
; INTC-NEXT:    [[I_01:%.*]] = phi i32 [ 0, [[FOR_BODY]] ], [ [[INC:%.*]], [[FOR_BODY3]] ]
; INTC-NEXT:    [[IDXPROM:%.*]] = sext i32 [[K_02]] to i64
; INTC-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[Y:%.*]], i64 [[IDXPROM]]
; INTC-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; INTC-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP1]], [[TMP0]]
; INTC-NEXT:    [[IDXPROM4:%.*]] = sext i32 [[I_01]] to i64
; INTC-NEXT:    [[INDEX0:%.*]] = mul i64 [[IDXPROM4]], [[N]]
; INTC-NEXT:    [[INDEX1:%.*]] = add i64 [[INDEX0]], [[IDXPROM]]
; INTC-NEXT:    [[ARRAYIDX7:%.*]] = getelementptr inbounds i32, ptr [[X:%.*]], i64 [[INDEX1]]
; INTC-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARRAYIDX7]], align 4
; INTC-NEXT:    [[ADD8:%.*]] = add nsw i32 [[TMP2]], [[ADD]]
; INTC-NEXT:    store i32 [[ADD8]], ptr [[ARRAYIDX7]], align 4
; INTC-NEXT:    [[INC]] = add nsw i32 [[I_01]], 1
; INTC-NEXT:    [[INC_EXT:%.*]] = sext i32 [[INC]] to i64
; INTC-NEXT:    [[CMP2:%.*]] = icmp slt i64 [[INC_EXT]], [[M]]
; INTC-NEXT:    br i1 [[CMP2]], label [[FOR_BODY3]], label [[FOR_END]], !llvm.loop [[LOOP0:![0-9]+]]
; INTC:       for.end:
; INTC-NEXT:    [[INC10]] = add nsw i32 [[K_02]], 1
; INTC-NEXT:    [[INC10_EXT:%.*]] = sext i32 [[INC10]] to i64
; INTC-NEXT:    [[CMP:%.*]] = icmp slt i64 [[INC10_EXT]], [[N]]
; INTC-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END11_LOOPEXIT:%.*]], !llvm.loop [[LOOP2:![0-9]+]]
; INTC:       for.end11.loopexit:
; INTC-NEXT:    br label [[FOR_END11]]
; INTC:       for.end11:
; INTC-NEXT:    ret void
;
; The loopnest is interchanged when we run lnicm and loop interchange.
; LNICM-LABEL: @test(
; LNICM-NEXT:  gurad:
; LNICM-NEXT:    [[CMP23:%.*]] = icmp sgt i64 [[M:%.*]], 0
; LNICM-NEXT:    [[CMP32:%.*]] = icmp sgt i64 [[N:%.*]], 0
; LNICM-NEXT:    br i1 [[CMP23]], label [[FOR_COND1_PREHEADER_LR_PH:%.*]], label [[FOR_END11:%.*]]
; LNICM:       for.cond1.preheader.lr.ph:
; LNICM-NEXT:    br i1 [[CMP32]], label [[FOR_I_PREHEADER:%.*]], label [[FOR_END11]]
; LNICM:       for.i.preheader:
; LNICM-NEXT:    br label [[FOR_BODY3_PREHEADER:%.*]]
; LNICM:       entry:
; LNICM-NEXT:    br label [[FOR_BODY:%.*]]
; LNICM:       for.body:
; LNICM-NEXT:    [[K_02:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC10:%.*]], [[FOR_END:%.*]] ]
; LNICM-NEXT:    br label [[FOR_BODY3_SPLIT1:%.*]]
; LNICM:       for.body3.preheader:
; LNICM-NEXT:    [[TMP0:%.*]] = load i32, ptr [[Z:%.*]], align 4
; LNICM-NEXT:    br label [[FOR_BODY3:%.*]]
; LNICM:       for.body3:
; LNICM-NEXT:    [[I_01:%.*]] = phi i32 [ [[TMP3:%.*]], [[FOR_BODY3_SPLIT:%.*]] ], [ 0, [[FOR_BODY3_PREHEADER]] ]
; LNICM-NEXT:    br label [[ENTRY]]
; LNICM:       for.body3.split1:
; LNICM-NEXT:    [[IDXPROM:%.*]] = sext i32 [[K_02]] to i64
; LNICM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[Y:%.*]], i64 [[IDXPROM]]
; LNICM-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; LNICM-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP1]], [[TMP0]]
; LNICM-NEXT:    [[IDXPROM4:%.*]] = sext i32 [[I_01]] to i64
; LNICM-NEXT:    [[INDEX0:%.*]] = mul i64 [[IDXPROM4]], [[N]]
; LNICM-NEXT:    [[INDEX1:%.*]] = add i64 [[INDEX0]], [[IDXPROM]]
; LNICM-NEXT:    [[ARRAYIDX7:%.*]] = getelementptr inbounds i32, ptr [[X:%.*]], i64 [[INDEX1]]
; LNICM-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARRAYIDX7]], align 4
; LNICM-NEXT:    [[ADD8:%.*]] = add nsw i32 [[TMP2]], [[ADD]]
; LNICM-NEXT:    store i32 [[ADD8]], ptr [[ARRAYIDX7]], align 4
; LNICM-NEXT:    [[INC:%.*]] = add nsw i32 [[I_01]], 1
; LNICM-NEXT:    [[INC_EXT:%.*]] = sext i32 [[INC]] to i64
; LNICM-NEXT:    [[CMP2:%.*]] = icmp slt i64 [[INC_EXT]], [[M]]
; LNICM-NEXT:    br label [[FOR_END]]
; LNICM:       for.body3.split:
; LNICM-NEXT:    [[TMP3]] = add nsw i32 [[I_01]], 1
; LNICM-NEXT:    [[TMP4:%.*]] = sext i32 [[TMP3]] to i64
; LNICM-NEXT:    [[TMP5:%.*]] = icmp slt i64 [[TMP4]], [[M]]
; LNICM-NEXT:    br i1 [[TMP5]], label [[FOR_BODY3]], label [[FOR_END11_LOOPEXIT:%.*]], !llvm.loop [[LOOP0:![0-9]+]]
; LNICM:       for.end:
; LNICM-NEXT:    [[INC10]] = add nsw i32 [[K_02]], 1
; LNICM-NEXT:    [[INC10_EXT:%.*]] = sext i32 [[INC10]] to i64
; LNICM-NEXT:    [[CMP:%.*]] = icmp slt i64 [[INC10_EXT]], [[N]]
; LNICM-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_BODY3_SPLIT]], !llvm.loop [[LOOP2:![0-9]+]]
; LNICM:       for.end11.loopexit:
; LNICM-NEXT:    br label [[FOR_END11]]
; LNICM:       for.end11:
; LNICM-NEXT:    ret void
;
; The loopnest is not interchanged when we run licm and loop interchange.
; LICM-LABEL: @test(
; LICM-NEXT:  gurad:
; LICM-NEXT:    [[CMP23:%.*]] = icmp sgt i64 [[M:%.*]], 0
; LICM-NEXT:    [[CMP32:%.*]] = icmp sgt i64 [[N:%.*]], 0
; LICM-NEXT:    br i1 [[CMP23]], label [[FOR_COND1_PREHEADER_LR_PH:%.*]], label [[FOR_END11:%.*]]
; LICM:       for.cond1.preheader.lr.ph:
; LICM-NEXT:    br i1 [[CMP32]], label [[FOR_I_PREHEADER:%.*]], label [[FOR_END11]]
; LICM:       for.i.preheader:
; LICM-NEXT:    br label [[ENTRY:%.*]]
; LICM:       entry:
; LICM-NEXT:    [[TMP0:%.*]] = load i32, ptr [[Z:%.*]], align 4
; LICM-NEXT:    br label [[FOR_BODY:%.*]]
; LICM:       for.body:
; LICM-NEXT:    [[K_02:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC10:%.*]], [[FOR_END:%.*]] ]
; LICM-NEXT:    [[IDXPROM:%.*]] = sext i32 [[K_02]] to i64
; LICM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[Y:%.*]], i64 [[IDXPROM]]
; LICM-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; LICM-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP1]], [[TMP0]]
; LICM-NEXT:    br label [[FOR_BODY3:%.*]]
; LICM:       for.body3:
; LICM-NEXT:    [[I_01:%.*]] = phi i32 [ 0, [[FOR_BODY]] ], [ [[INC:%.*]], [[FOR_BODY3]] ]
; LICM-NEXT:    [[IDXPROM4:%.*]] = sext i32 [[I_01]] to i64
; LICM-NEXT:    [[INDEX0:%.*]] = mul i64 [[IDXPROM4]], [[N]]
; LICM-NEXT:    [[INDEX1:%.*]] = add i64 [[INDEX0]], [[IDXPROM]]
; LICM-NEXT:    [[ARRAYIDX7:%.*]] = getelementptr inbounds i32, ptr [[X:%.*]], i64 [[INDEX1]]
; LICM-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARRAYIDX7]], align 4
; LICM-NEXT:    [[ADD8:%.*]] = add nsw i32 [[TMP2]], [[ADD]]
; LICM-NEXT:    store i32 [[ADD8]], ptr [[ARRAYIDX7]], align 4
; LICM-NEXT:    [[INC]] = add nsw i32 [[I_01]], 1
; LICM-NEXT:    [[INC_EXT:%.*]] = sext i32 [[INC]] to i64
; LICM-NEXT:    [[CMP2:%.*]] = icmp slt i64 [[INC_EXT]], [[M]]
; LICM-NEXT:    br i1 [[CMP2]], label [[FOR_BODY3]], label [[FOR_END]], !llvm.loop [[LOOP0:![0-9]+]]
; LICM:       for.end:
; LICM-NEXT:    [[INC10]] = add nsw i32 [[K_02]], 1
; LICM-NEXT:    [[INC10_EXT:%.*]] = sext i32 [[INC10]] to i64
; LICM-NEXT:    [[CMP:%.*]] = icmp slt i64 [[INC10_EXT]], [[N]]
; LICM-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END11_LOOPEXIT:%.*]], !llvm.loop [[LOOP2:![0-9]+]]
; LICM:       for.end11.loopexit:
; LICM-NEXT:    br label [[FOR_END11]]
; LICM:       for.end11:
; LICM-NEXT:    ret void
;

gurad:
  %cmp23 = icmp sgt i64 %m, 0
  %cmp32 = icmp sgt i64 %n, 0
  br i1 %cmp23, label %for.cond1.preheader.lr.ph, label %for.end11

for.cond1.preheader.lr.ph:                        ; preds = %gurad
  br i1 %cmp32, label %for.i.preheader, label %for.end11

for.i.preheader:                                  ; preds = %for.cond1.preheader.lr.ph
  br label %entry

entry:                                  ; preds = %for.i.preheader
  br label %for.body

for.body:
  %k.02 = phi i32 [ 0, %entry ], [ %inc10, %for.end ]
  %0 = load i32, ptr %z, align 4
  br label %for.body3

for.body3:
  %i.01 = phi i32 [ 0, %for.body ], [ %inc, %for.body3 ]
  %idxprom = sext i32 %k.02 to i64
  %arrayidx = getelementptr inbounds i32, ptr %y, i64 %idxprom
  %1 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %1, %0
  %idxprom4 = sext i32 %i.01 to i64
  %index0 = mul i64 %idxprom4, %n
  %index1 = add i64 %index0, %idxprom
  %arrayidx7 = getelementptr inbounds i32, ptr %x, i64 %index1
  %2 = load i32, ptr %arrayidx7, align 4
  %add8 = add nsw i32 %2, %add
  store i32 %add8, ptr %arrayidx7, align 4
  %inc = add nsw i32 %i.01, 1
  %inc.ext = sext i32 %inc to i64
  %cmp2 = icmp slt i64 %inc.ext, %m
  br i1 %cmp2, label %for.body3, label %for.end, !llvm.loop !0

for.end:
  %inc10 = add nsw i32 %k.02, 1
  %inc10.ext = sext i32 %inc10 to i64
  %cmp = icmp slt i64 %inc10.ext, %n
  br i1 %cmp, label %for.body, label %for.end11, !llvm.loop !2

for.end11:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.mustprogress"}
!2 = distinct !{!2, !1}

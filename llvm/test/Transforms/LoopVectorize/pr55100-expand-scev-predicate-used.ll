; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop-vectorize' -force-vector-width=2 -force-vector-interleave=1 -S %s | FileCheck %s

define void @test_pr55100(i32 %N) {
; CHECK-LABEL: @test_pr55100(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sub i32 0, [[N:%.*]]
; CHECK-NEXT:    br label [[LOOP_1_HEADER:%.*]]
; CHECK:       loop.1.header:
; CHECK-NEXT:    [[IV_1:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_1_NEXT:%.*]], [[LOOP_1_LATCH:%.*]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = mul nuw nsw i32 [[IV_1]], -1
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[UMIN:%.*]] = call i32 @llvm.umin.i32(i32 [[TMP2]], i32 18)
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i32 [[UMIN]], 1
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i32 [[IV_1]], 10
; CHECK-NEXT:    br i1 [[C_2]], label [[LOOP_2_HEADER_PREHEADER:%.*]], label [[EXIT_LOOPEXIT1:%.*]]
; CHECK:       loop.2.header.preheader:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i32 [[TMP3]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[TMP3]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i32 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP5:%.*]] = select i1 [[TMP4]], i32 2, i32 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[TMP3]], [[TMP5]]
; CHECK-NEXT:    [[IND_END:%.*]] = trunc i32 [[N_VEC]] to i16
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i16 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 0, [[LOOP_2_HEADER_PREHEADER]] ]
; CHECK-NEXT:    br label [[LOOP_2_HEADER:%.*]]
; CHECK:       loop.2.header:
; CHECK-NEXT:    [[IV_2:%.*]] = phi i16 [ [[IV_2_NEXT:%.*]], [[LOOP_2_LATCH:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[C_3:%.*]] = icmp slt i16 [[IV_2]], 18
; CHECK-NEXT:    br i1 [[C_3]], label [[LOOP_2_LATCH]], label [[LOOP_1_LATCH]]
; CHECK:       loop.2.latch:
; CHECK-NEXT:    [[ADD_1:%.*]] = add i32 [[N]], [[IV_1]]
; CHECK-NEXT:    [[IV_2_EXT:%.*]] = sext i16 [[IV_2]] to i32
; CHECK-NEXT:    [[ADD_2:%.*]] = add i32 [[ADD_1]], [[IV_2_EXT]]
; CHECK-NEXT:    [[C_4:%.*]] = icmp ult i32 [[ADD_2]], 1
; CHECK-NEXT:    [[IV_2_NEXT]] = add i16 [[IV_2]], 1
; CHECK-NEXT:    br i1 [[C_4]], label [[EXIT_LOOPEXIT:%.*]], label [[LOOP_2_HEADER]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       loop.1.latch:
; CHECK-NEXT:    [[IV_1_NEXT]] = add i32 [[IV_1]], 1
; CHECK-NEXT:    br label [[LOOP_1_HEADER]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit.loopexit1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.1.header

loop.1.header:
  %iv.1 = phi i32 [ 0, %entry ], [ %iv.1.next, %loop.1.latch ]
  %c.2 = icmp ugt i32 %iv.1, 10
  br i1 %c.2, label %loop.2.header, label %exit

loop.2.header:
  %iv.2 = phi i16 [ 0, %loop.1.header ], [ %iv.2.next, %loop.2.latch ]
  %c.3 = icmp slt i16 %iv.2, 18
  br i1 %c.3, label %loop.2.latch, label %loop.1.latch

loop.2.latch:
  %add.1 = add i32 %N, %iv.1
  %iv.2.ext = sext i16 %iv.2 to i32
  %add.2 = add i32 %add.1, %iv.2.ext
  %c.4 = icmp ult i32 %add.2, 1
  %iv.2.next = add i16 %iv.2, 1
  br i1 %c.4, label %exit, label %loop.2.header

loop.1.latch:
  %iv.1.next = add i32 %iv.1, 1
  br label %loop.1.header

exit:
  ret void
}

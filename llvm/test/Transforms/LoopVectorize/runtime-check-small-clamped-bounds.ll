; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -force-vector-width=4 -S %s | FileCheck %s

; Tests where the indices of some accesses are clamped to a small range.

; FIXME: At the moment, the runtime checks require that the indices do not wrap
;        and runtime checks are emitted to ensure that. The clamped indices do
;        wrap, so the vector loops are dead at the moment. But it is still
;        possible to compute the bounds of the accesses and generate proper
;        runtime checks.

; The relevant bounds for %gep.A are [%A, %A+4).
define void @load_clamped_index(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @load_clamped_index(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A2:%.*]] = ptrtoint ptr [[A:%.*]] to i64
; CHECK-NEXT:    [[B1:%.*]] = ptrtoint ptr [[B:%.*]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[TMP0]], 3
; CHECK-NEXT:    br i1 [[TMP1]], label [[SCALAR_PH]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP2:%.*]] = sub i64 [[B1]], [[A2]]
; CHECK-NEXT:    [[DIFF_CHECK:%.*]] = icmp ult i64 [[TMP2]], 16
; CHECK-NEXT:    br i1 [[DIFF_CHECK]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = urem i32 [[TMP3]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[TMP5]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = add <4 x i32> [[WIDE_LOAD]], <i32 10, i32 10, i32 10, i32 10>
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP3]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP8]], i32 0
; CHECK-NEXT:    store <4 x i32> [[TMP7]], ptr [[TMP9]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_SCEVCHECK]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV]], 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV]], 10
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %clamped.index = urem i32 %iv, 4
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  %lv = load i32, ptr %gep.A
  %add = add i32 %lv, 10
  %gep.B = getelementptr inbounds i32, ptr %B, i32 %iv
  store i32 %add, ptr %gep.B
  %iv.next = add nuw nsw i32 %iv, 1
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

; The relevant bounds for %gep.A are [%A, %A+4).
define void @store_clamped_index(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @store_clamped_index(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B2:%.*]] = ptrtoint ptr [[B:%.*]] to i64
; CHECK-NEXT:    [[A1:%.*]] = ptrtoint ptr [[A:%.*]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[TMP0]], 3
; CHECK-NEXT:    br i1 [[TMP1]], label [[SCALAR_PH]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP2:%.*]] = sub i64 [[A1]], [[B2]]
; CHECK-NEXT:    [[DIFF_CHECK:%.*]] = icmp ult i64 [[TMP2]], 16
; CHECK-NEXT:    br i1 [[DIFF_CHECK]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = urem i32 [[TMP3]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[TMP5]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = add <4 x i32> [[WIDE_LOAD]], <i32 10, i32 10, i32 10, i32 10>
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP4]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP8]], i32 0
; CHECK-NEXT:    store <4 x i32> [[TMP7]], ptr [[TMP9]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_SCEVCHECK]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV]], 4
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[IV]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV]], 10
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %clamped.index = urem i32 %iv, 4
  %gep.B = getelementptr inbounds i32, ptr %B, i32 %iv
  %lv = load i32, ptr %gep.B
  %add = add i32 %lv, 10
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  store i32 %add, ptr %gep.A
  %iv.next = add nuw nsw i32 %iv, 1
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

; The relevant bounds for %gep.A are [%A, %A+4), but the access order is %A+1,
; %A+2, %A+3, %A.
define void @load_clamped_index_offset_1(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @load_clamped_index_offset_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A2:%.*]] = ptrtoint ptr [[A:%.*]] to i64
; CHECK-NEXT:    [[B1:%.*]] = ptrtoint ptr [[B:%.*]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N:%.*]], -1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[TMP0]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[N]], -2
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[TMP1]] to i2
; CHECK-NEXT:    [[TMP3:%.*]] = add i2 1, [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ult i2 [[TMP3]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ugt i32 [[TMP1]], 3
; CHECK-NEXT:    [[TMP6:%.*]] = or i1 [[TMP4]], [[TMP5]]
; CHECK-NEXT:    br i1 [[TMP6]], label [[SCALAR_PH]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP7:%.*]] = add nuw i64 [[B1]], 4
; CHECK-NEXT:    [[TMP8:%.*]] = add i64 [[A2]], 4
; CHECK-NEXT:    [[TMP9:%.*]] = sub i64 [[TMP7]], [[TMP8]]
; CHECK-NEXT:    [[DIFF_CHECK:%.*]] = icmp ult i64 [[TMP9]], 16
; CHECK-NEXT:    br i1 [[DIFF_CHECK]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[TMP0]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[TMP0]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = add i32 1, [[N_VEC]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i32 1, [[INDEX]]
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP11:%.*]] = urem i32 [[TMP10]], 4
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, ptr [[TMP12]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP13]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = add <4 x i32> [[WIDE_LOAD]], <i32 10, i32 10, i32 10, i32 10>
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[TMP10]]
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i32, ptr [[TMP15]], i32 0
; CHECK-NEXT:    store <4 x i32> [[TMP14]], ptr [[TMP16]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP17:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP17]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[TMP0]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 1, [[ENTRY:%.*]] ], [ 1, [[VECTOR_SCEVCHECK]] ], [ 1, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV]], 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV]], 10
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %loop ]
  %clamped.index = urem i32 %iv, 4
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  %lv = load i32, ptr %gep.A
  %add = add i32 %lv, 10
  %gep.B = getelementptr inbounds i32, ptr %B, i32 %iv
  store i32 %add, ptr %gep.B
  %iv.next = add nuw nsw i32 %iv, 1
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

; The relevant bounds for %gep.A are [%A, %A+5).
define void @load_clamped_index_urem_5(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @load_clamped_index_urem_5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV]], 5
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV]], 10
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %loop ]
  %clamped.index = urem i32 %iv, 5
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  %lv = load i32, ptr %gep.A
  %add = add i32 %lv, 10
  %gep.B = getelementptr inbounds i32, ptr %B, i32 %iv
  store i32 %add, ptr %gep.B
  %iv.next = add nuw nsw i32 %iv, 1
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}
define void @clamped_index_dependence_non_clamped(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @clamped_index_dependence_non_clamped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[IV]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[GEP_A_1:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[IV]]
; CHECK-NEXT:    [[LV_A:%.*]] = load i32, ptr [[GEP_A_1]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV]], [[LV_A]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV_NEXT]], 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.B = getelementptr inbounds i32, ptr %B, i32 %iv
  %lv = load i32, ptr %gep.B
  %gep.A.1 = getelementptr inbounds i32, ptr %A, i32 %iv
  %lv.A = load i32, ptr %gep.A.1
  %add = add i32 %lv, %lv.A

  %iv.next = add nuw nsw i32 %iv, 1
  %clamped.index = urem i32 %iv.next, 4
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  store i32 %add, ptr %gep.A
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

define void @clamped_index_dependence_clamped_index(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @clamped_index_dependence_clamped_index(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CLAMPED_INDEX_1:%.*]] = urem i32 [[IV]], 4
; CHECK-NEXT:    [[GEP_A_1:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[CLAMPED_INDEX_1]]
; CHECK-NEXT:    [[LV_A:%.*]] = load i32, ptr [[GEP_A_1]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV_A]], 10
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV_NEXT]], 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %clamped.index.1 = urem i32 %iv, 4
  %gep.A.1 = getelementptr inbounds i32, ptr %A, i32 %clamped.index.1
  %lv.A = load i32, ptr %gep.A.1
  %add = add i32 %lv.A, 10

  %iv.next = add nuw nsw i32 %iv, 1
  %clamped.index = urem i32 %iv.next, 4
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  store i32 %add, ptr %gep.A
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

define void @clamped_index_equal_dependence(ptr %A, ptr %B, i32 %N) {
; CHECK-LABEL: @clamped_index_equal_dependence(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[TMP0]], 3
; CHECK-NEXT:    br i1 [[TMP1]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = urem i32 [[TMP2]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, ptr [[TMP4]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = add <4 x i32> [[WIDE_LOAD]], <i32 10, i32 10, i32 10, i32 10>
; CHECK-NEXT:    store <4 x i32> [[TMP6]], ptr [[TMP5]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP7:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP7]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CLAMPED_INDEX:%.*]] = urem i32 [[IV]], 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[CLAMPED_INDEX]]
; CHECK-NEXT:    [[LV_A:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LV_A]], 10
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_A]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %clamped.index = urem i32 %iv, 4
  %gep.A = getelementptr inbounds i32, ptr %A, i32 %clamped.index
  %lv.A = load i32, ptr %gep.A
  %add = add i32 %lv.A, 10

  %iv.next = add nuw nsw i32 %iv, 1
  store i32 %add, ptr %gep.A
  %cond = icmp eq i32 %iv.next, %N
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

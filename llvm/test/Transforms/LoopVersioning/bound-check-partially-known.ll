; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -aa-pipeline=basic-aa -passes=loop-versioning -S %s | FileCheck %s

%struct.foo = type { [32000 x double], [32000 x double] }

@global = external global %struct.foo, align 32

define void @bound_check_partially_known_1(i32 %N) {
; CHECK-LABEL: define void @bound_check_partially_known_1
; CHECK-SAME: (i32 [[N:%.*]]) {
; CHECK-NEXT:  loop.lver.check:
; CHECK-NEXT:    [[N_EXT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = shl nuw nsw i64 [[N_EXT]], 3
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr @global, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw nsw i64 [[N_EXT]], 4
; CHECK-NEXT:    [[SCEVGEP1:%.*]] = getelementptr i8, ptr @global, i64 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP0]], 256000
; CHECK-NEXT:    [[SCEVGEP2:%.*]] = getelementptr i8, ptr @global, i64 [[TMP2]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr @global, [[SCEVGEP1]]
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[SCEVGEP]], [[SCEVGEP2]]
; CHECK-NEXT:    [[BOUND13:%.*]] = icmp ult ptr getelementptr inbounds ([[STRUCT_FOO:%.*]], ptr @global, i64 0, i32 1, i64 0), [[SCEVGEP1]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND13]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[LOOP_PH_LVER_ORIG:%.*]], label [[LOOP_PH:%.*]]
; CHECK:       loop.ph.lver.orig:
; CHECK-NEXT:    br label [[LOOP_LVER_ORIG:%.*]]
; CHECK:       loop.lver.orig:
; CHECK-NEXT:    [[IV_LVER_ORIG:%.*]] = phi i64 [ 0, [[LOOP_PH_LVER_ORIG]] ], [ [[IV_NEXT_LVER_ORIG:%.*]], [[LOOP_LVER_ORIG]] ]
; CHECK-NEXT:    [[GEP_0_IV_LVER_ORIG:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @global, i64 0, i32 0, i64 [[IV_LVER_ORIG]]
; CHECK-NEXT:    [[L_0_LVER_ORIG:%.*]] = load double, ptr [[GEP_0_IV_LVER_ORIG]], align 8
; CHECK-NEXT:    [[GEP_1_IV_LVER_ORIG:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @global, i64 0, i32 1, i64 [[IV_LVER_ORIG]]
; CHECK-NEXT:    [[L_1_LVER_ORIG:%.*]] = load double, ptr [[GEP_1_IV_LVER_ORIG]], align 8
; CHECK-NEXT:    [[ADD_LVER_ORIG:%.*]] = fadd double [[L_0_LVER_ORIG]], [[L_1_LVER_ORIG]]
; CHECK-NEXT:    [[IV_N_LVER_ORIG:%.*]] = add nuw nsw i64 [[IV_LVER_ORIG]], [[N_EXT]]
; CHECK-NEXT:    [[GEP_0_IV_N_LVER_ORIG:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @global, i64 0, i32 0, i64 [[IV_N_LVER_ORIG]]
; CHECK-NEXT:    store double [[ADD_LVER_ORIG]], ptr [[GEP_0_IV_N_LVER_ORIG]], align 8
; CHECK-NEXT:    [[IV_NEXT_LVER_ORIG]] = add nuw nsw i64 [[IV_LVER_ORIG]], 1
; CHECK-NEXT:    [[EXITCOND_LVER_ORIG:%.*]] = icmp eq i64 [[IV_NEXT_LVER_ORIG]], [[N_EXT]]
; CHECK-NEXT:    br i1 [[EXITCOND_LVER_ORIG]], label [[EXIT_LOOPEXIT:%.*]], label [[LOOP_LVER_ORIG]]
; CHECK:       loop.ph:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[LOOP_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP_0_IV:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @global, i64 0, i32 0, i64 [[IV]]
; CHECK-NEXT:    [[L_0:%.*]] = load double, ptr [[GEP_0_IV]], align 8, !alias.scope !0
; CHECK-NEXT:    [[GEP_1_IV:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @global, i64 0, i32 1, i64 [[IV]]
; CHECK-NEXT:    [[L_1:%.*]] = load double, ptr [[GEP_1_IV]], align 8, !alias.scope !3
; CHECK-NEXT:    [[ADD:%.*]] = fadd double [[L_0]], [[L_1]]
; CHECK-NEXT:    [[IV_N:%.*]] = add nuw nsw i64 [[IV]], [[N_EXT]]
; CHECK-NEXT:    [[GEP_0_IV_N:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @global, i64 0, i32 0, i64 [[IV_N]]
; CHECK-NEXT:    store double [[ADD]], ptr [[GEP_0_IV_N]], align 8, !alias.scope !5, !noalias !7
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV_NEXT]], [[N_EXT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[EXIT_LOOPEXIT4:%.*]], label [[LOOP]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit.loopexit4:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %N.ext = zext i32 %N to i64
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.0.iv = getelementptr inbounds %struct.foo, ptr @global, i64 0, i32 0, i64 %iv
  %l.0 = load double, ptr %gep.0.iv, align 8
  %gep.1.iv = getelementptr inbounds %struct.foo, ptr @global, i64 0, i32 1, i64 %iv
  %l.1 = load double, ptr %gep.1.iv, align 8
  %add = fadd double %l.0, %l.1
  %iv.N = add nuw nsw i64 %iv, %N.ext
  %gep.0.iv.N = getelementptr inbounds %struct.foo, ptr @global, i64 0, i32 0, i64 %iv.N
  store double %add, ptr %gep.0.iv.N, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, %N.ext
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

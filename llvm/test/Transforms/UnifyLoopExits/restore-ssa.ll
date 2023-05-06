; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='lowerswitch,unify-loop-exits' -S | FileCheck %s

; Loop consists of A and B:
; - A is the header
; - A and B are exiting blocks
; - C and return are exit blocks.
; Pattern: Value (%mytmp42) defined in exiting block (A) and used in
;          exit block (return).
;          The relevant code uses DT::dominates(Value,
;          BasicBlock). This is misnamed because it actually checks
;          strict dominance, causing the pattern to be miscompiled
;          (the use receives an undef value).
define i32 @exiting-used-in-exit(ptr %arg1, ptr %arg2) local_unnamed_addr align 2 {
; CHECK-LABEL: @exiting-used-in-exit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[A:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[MYTMP42:%.*]] = load i32, ptr [[ARG1:%.*]], align 4
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[B:%.*]], label [[LOOP_EXIT_GUARD:%.*]]
; CHECK:       B:
; CHECK-NEXT:    [[MYTMP41:%.*]] = load i32, ptr [[ARG2:%.*]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[MYTMP41]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[A]], label [[LOOP_EXIT_GUARD]]
; CHECK:       C:
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[MYTMP41_MOVED:%.*]], 1
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       return:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ [[INC]], [[C:%.*]] ], [ [[PHI_MOVED:%.*]], [[LOOP_EXIT_GUARD]] ]
; CHECK-NEXT:    ret i32 [[PHI]]
; CHECK:       loop.exit.guard:
; CHECK-NEXT:    [[MYTMP41_MOVED]] = phi i32 [ undef, [[A]] ], [ [[MYTMP41]], [[B]] ]
; CHECK-NEXT:    [[PHI_MOVED]] = phi i32 [ [[MYTMP42]], [[A]] ], [ undef, [[B]] ]
; CHECK-NEXT:    [[GUARD_RETURN:%.*]] = phi i1 [ true, [[A]] ], [ false, [[B]] ]
; CHECK-NEXT:    br i1 [[GUARD_RETURN]], label [[RETURN]], label [[C]]
;
entry:
  br label %A

A:
  %mytmp42 = load i32, ptr %arg1, align 4
  %cmp1 = icmp slt i32 %mytmp42, 0
  br i1 %cmp1, label %B, label %return

B:
  %mytmp41 = load i32, ptr %arg2, align 4
  %cmp = icmp slt i32 %mytmp41, 0
  br i1 %cmp, label %A, label %C

C:
  %inc = add i32 %mytmp41, 1
  br label %return

return:
  %phi = phi i32 [ %inc, %C ], [ %mytmp42, %A ]
  ret i32 %phi
}

; Loop consists of A, B and C:
; - A is the header
; - A and C are exiting blocks
; - B is an "internal" block that dominates exiting block C
; - D and return are exit blocks.
; Pattern: Value (%mytmp41) defined in internal block (B) and used in an
;          exit block (D).
define i32 @internal-used-in-exit(ptr %arg1, ptr %arg2) local_unnamed_addr align 2 {
; CHECK-LABEL: @internal-used-in-exit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MYTMP42:%.*]] = load i32, ptr [[ARG1:%.*]], align 4
; CHECK-NEXT:    br label [[A:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[B:%.*]], label [[LOOP_EXIT_GUARD:%.*]]
; CHECK:       B:
; CHECK-NEXT:    [[MYTMP41:%.*]] = load i32, ptr [[ARG2:%.*]], align 4
; CHECK-NEXT:    br label [[C:%.*]]
; CHECK:       C:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[A]], label [[LOOP_EXIT_GUARD]]
; CHECK:       D:
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[MYTMP41_MOVED:%.*]], 1
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       return:
; CHECK-NEXT:    ret i32 0
; CHECK:       loop.exit.guard:
; CHECK-NEXT:    [[MYTMP41_MOVED]] = phi i32 [ undef, [[A]] ], [ [[MYTMP41]], [[C]] ]
; CHECK-NEXT:    [[GUARD_RETURN:%.*]] = phi i1 [ true, [[A]] ], [ false, [[C]] ]
; CHECK-NEXT:    br i1 [[GUARD_RETURN]], label [[RETURN]], label [[D:%.*]]
;
entry:
  %mytmp42 = load i32, ptr %arg1, align 4
  br label %A

A:
  %cmp1 = icmp slt i32 %mytmp42, 0
  br i1 %cmp1, label %B, label %return

B:
  %mytmp41 = load i32, ptr %arg2, align 4
  br label %C

C:
  %cmp = icmp slt i32 %mytmp42, 0
  br i1 %cmp, label %A, label %D

D:
  %inc = add i32 %mytmp41, 1
  br label %return

return:
  ret i32 0
}

; Loop consists of A, B and C:
; - A is the header
; - A and C are exiting blocks
; - B is an "internal" block that dominates exiting block C
; - D and return are exit blocks.
; Pattern: %return contains a phi node that receives values from
;          %entry, %A and %D. This mixes all the special cases in a single phi.
define i32 @mixed-use-in-exit(ptr %arg1, ptr %arg2) local_unnamed_addr align 2 {
; CHECK-LABEL: @mixed-use-in-exit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MYTMP42:%.*]] = load i32, ptr [[ARG1:%.*]], align 4
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP2]], label [[A:%.*]], label [[RETURN:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[MYTMP43:%.*]] = add i32 [[MYTMP42]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[B:%.*]], label [[LOOP_EXIT_GUARD:%.*]]
; CHECK:       B:
; CHECK-NEXT:    [[MYTMP41:%.*]] = load i32, ptr [[ARG2:%.*]], align 4
; CHECK-NEXT:    br label [[C:%.*]]
; CHECK:       C:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[A]], label [[LOOP_EXIT_GUARD]]
; CHECK:       D:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ [[MYTMP41_MOVED:%.*]], [[D:%.*]] ], [ [[MYTMP42]], [[ENTRY:%.*]] ], [ [[PHI_MOVED:%.*]], [[LOOP_EXIT_GUARD]] ]
; CHECK-NEXT:    ret i32 [[PHI]]
; CHECK:       loop.exit.guard:
; CHECK-NEXT:    [[MYTMP41_MOVED]] = phi i32 [ undef, [[A]] ], [ [[MYTMP41]], [[C]] ]
; CHECK-NEXT:    [[PHI_MOVED]] = phi i32 [ [[MYTMP43]], [[A]] ], [ undef, [[C]] ]
; CHECK-NEXT:    [[GUARD_RETURN:%.*]] = phi i1 [ true, [[A]] ], [ false, [[C]] ]
; CHECK-NEXT:    br i1 [[GUARD_RETURN]], label [[RETURN]], label [[D]]
;
entry:
  %mytmp42 = load i32, ptr %arg1, align 4
  %cmp2 = icmp slt i32 %mytmp42, 0
  br i1 %cmp2, label %A, label %return

A:
  %mytmp43 = add i32 %mytmp42, 1
  %cmp1 = icmp slt i32 %mytmp42, 0
  br i1 %cmp1, label %B, label %return

B:
  %mytmp41 = load i32, ptr %arg2, align 4
  br label %C

C:
  %cmp = icmp slt i32 %mytmp42, 0
  br i1 %cmp, label %A, label %D

D:
  br label %return

return:
  %phi = phi i32 [ %mytmp41, %D ], [ %mytmp43, %A ], [%mytmp42, %entry]
  ret i32 %phi
}

; Loop consists of A, B and C:
; - A is the header
; - A and C are exiting blocks
; - B is an "internal" block that dominates exiting block C
; - D and E are exit blocks.
; Pattern: Value (%mytmp41) defined in internal block (B) and used in a
;          downstream block not related to the loop (return). The use
;          is a phi where the incoming block for %mytmp41 is not related
;          to the loop (D).
;          This pattern does not involve either the exiting blocks or
;          the exit blocks, which catches any such assumptions built
;          into the SSA reconstruction phase.
define i32 @phi-via-external-block(ptr %arg1, ptr %arg2) local_unnamed_addr align 2 {
; CHECK-LABEL: @phi-via-external-block(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MYTMP42:%.*]] = load i32, ptr [[ARG1:%.*]], align 4
; CHECK-NEXT:    br label [[A:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[B:%.*]], label [[LOOP_EXIT_GUARD:%.*]]
; CHECK:       B:
; CHECK-NEXT:    [[MYTMP41:%.*]] = load i32, ptr [[ARG2:%.*]], align 4
; CHECK-NEXT:    br label [[C:%.*]]
; CHECK:       C:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[MYTMP42]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[A]], label [[LOOP_EXIT_GUARD]]
; CHECK:       D:
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       E:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ [[MYTMP41_MOVED:%.*]], [[D:%.*]] ], [ [[MYTMP42]], [[E:%.*]] ]
; CHECK-NEXT:    ret i32 [[PHI]]
; CHECK:       loop.exit.guard:
; CHECK-NEXT:    [[MYTMP41_MOVED]] = phi i32 [ undef, [[A]] ], [ [[MYTMP41]], [[C]] ]
; CHECK-NEXT:    [[GUARD_E:%.*]] = phi i1 [ true, [[A]] ], [ false, [[C]] ]
; CHECK-NEXT:    br i1 [[GUARD_E]], label [[E]], label [[D]]
;
entry:
  %mytmp42 = load i32, ptr %arg1, align 4
  br label %A

A:
  %cmp1 = icmp slt i32 %mytmp42, 0
  br i1 %cmp1, label %B, label %E

B:
  %mytmp41 = load i32, ptr %arg2, align 4
  br label %C

C:
  %cmp = icmp slt i32 %mytmp42, 0
  br i1 %cmp, label %A, label %D

D:
  br label %return

E:
  br label %return

return:
  %phi = phi i32 [ %mytmp41, %D ], [ %mytmp42, %E ]
  ret i32 %phi
}

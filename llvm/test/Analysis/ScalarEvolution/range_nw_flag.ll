; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -S -disable-output "-passes=print<scalar-evolution>" 2>&1 | FileCheck %s

; copied from flags-from-poison.ll
define void @test-add-nuw(ptr %input, i32 %offset, i32 %numIterations) {
; CHECK-LABEL: 'test-add-nuw'
; CHECK-NEXT:  Classifying expressions for: @test-add-nuw
; CHECK-NEXT:    %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%loop> U: full-set S: full-set Exits: (-1 + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %nexti = add nuw i32 %i, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,0) S: [1,0) Exits: %numIterations LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index32 = add nuw i32 %nexti, %offset
; CHECK-NEXT:    --> {(1 + %offset)<nuw>,+,1}<nuw><%loop> U: [1,0) S: [1,0) Exits: (%offset + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %ptr = getelementptr inbounds float, ptr %input, i32 %index32
; CHECK-NEXT:    --> ((4 * (sext i32 {(1 + %offset)<nuw>,+,1}<nuw><%loop> to i64))<nsw> + %input) U: full-set S: full-set Exits: ((4 * (sext i32 (%offset + %numIterations) to i64))<nsw> + %input) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test-add-nuw
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop
loop:
  %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
  %nexti = add nuw i32 %i, 1
  %index32 = add nuw i32 %nexti, %offset
  %ptr = getelementptr inbounds float, ptr %input, i32 %index32
  %f = load float, ptr %ptr, align 4
  %exitcond = icmp eq i32 %nexti, %numIterations
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test-addrec-nuw(ptr %input, i32 %offset, i32 %numIterations) {
; CHECK-LABEL: 'test-addrec-nuw'
; CHECK-NEXT:  Classifying expressions for: @test-addrec-nuw
; CHECK-NEXT:    %min.10 = select i1 %cmp, i32 %offset, i32 10
; CHECK-NEXT:    --> (10 smax %offset) U: [10,-2147483648) S: [10,-2147483648)
; CHECK-NEXT:    %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%loop> U: full-set S: full-set Exits: (-1 + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %nexti = add nuw i32 %i, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,0) S: [1,0) Exits: %numIterations LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index32 = add nuw i32 %nexti, %min.10
; CHECK-NEXT:    --> {(1 + (10 smax %offset))<nuw>,+,1}<nuw><%loop> U: [11,0) S: [11,0) Exits: ((10 smax %offset) + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %ptr = getelementptr inbounds float, ptr %input, i32 %index32
; CHECK-NEXT:    --> ((4 * (sext i32 {(1 + (10 smax %offset))<nuw>,+,1}<nuw><%loop> to i64))<nsw> + %input) U: full-set S: full-set Exits: ((4 * (sext i32 ((10 smax %offset) + %numIterations) to i64))<nsw> + %input) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test-addrec-nuw
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp = icmp sgt i32 %offset, 10
  %min.10 = select i1 %cmp, i32 %offset, i32 10
  br label %loop
loop:
  %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
  %nexti = add nuw i32 %i, 1
  %index32 = add nuw i32 %nexti, %min.10
  %ptr = getelementptr inbounds float, ptr %input, i32 %index32
  %f = load float, ptr %ptr, align 4
  %exitcond = icmp eq i32 %nexti, %numIterations
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test-addrec-nsw-start-neg-strip-neg(ptr %input, i32 %offset, i32 %numIterations) {
; CHECK-LABEL: 'test-addrec-nsw-start-neg-strip-neg'
; CHECK-NEXT:  Classifying expressions for: @test-addrec-nsw-start-neg-strip-neg
; CHECK-NEXT:    %max = select i1 %cmp, i32 %offset, i32 -10
; CHECK-NEXT:    --> (-10 smin %offset) U: [-2147483648,-9) S: [-2147483648,-9)
; CHECK-NEXT:    %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,-1}<nsw><%loop> U: [-2147483648,1) S: [-2147483648,1) Exits: (1 + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %nexti = add nsw i32 %i, -1
; CHECK-NEXT:    --> {-1,+,-1}<nsw><%loop> U: [-2147483648,0) S: [-2147483648,0) Exits: %numIterations LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index32 = add nsw i32 %nexti, %max
; CHECK-NEXT:    --> {(-1 + (-10 smin %offset))<nsw>,+,-1}<nsw><%loop> U: [-2147483648,-10) S: [-2147483648,-10) Exits: ((-10 smin %offset) + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %ptr = getelementptr inbounds float, ptr %input, i32 %index32
; CHECK-NEXT:    --> {(-4 + (4 * (-10 smin (sext i32 %offset to i64)))<nsw> + %input),+,-4}<nw><%loop> U: full-set S: full-set Exits: (-4 + (4 * (-10 smin (sext i32 %offset to i64)))<nsw> + (-4 * (zext i32 (-1 + (-1 * %numIterations)) to i64))<nsw> + %input) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test-addrec-nsw-start-neg-strip-neg
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + (-1 * %numIterations))
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-1 + (-1 * %numIterations))
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + (-1 * %numIterations))
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp = icmp slt i32 %offset, -10
  %max = select i1 %cmp, i32 %offset, i32 -10
  br label %loop
loop:
  %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
  %nexti = add nsw i32 %i, -1
  %index32 = add nsw i32 %nexti, %max
  %ptr = getelementptr inbounds float, ptr %input, i32 %index32
  %f = load float, ptr %ptr, align 4
  %exitcond = icmp eq i32 %nexti, %numIterations
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test-addrec-nsw-start-pos-strip-neg(ptr %input, i32 %offset, i32 %numIterations) {
; CHECK-LABEL: 'test-addrec-nsw-start-pos-strip-neg'
; CHECK-NEXT:  Classifying expressions for: @test-addrec-nsw-start-pos-strip-neg
; CHECK-NEXT:    %max = select i1 %cmp, i32 %offset, i32 10
; CHECK-NEXT:    --> (10 smin %offset) U: [-2147483648,11) S: [-2147483648,11)
; CHECK-NEXT:    %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,-1}<nsw><%loop> U: [-2147483648,1) S: [-2147483648,1) Exits: (1 + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %nexti = add nsw i32 %i, -1
; CHECK-NEXT:    --> {-1,+,-1}<nsw><%loop> U: [-2147483648,0) S: [-2147483648,0) Exits: %numIterations LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index32 = add nsw i32 %nexti, %max
; CHECK-NEXT:    --> {(-1 + (10 smin %offset))<nsw>,+,-1}<nsw><%loop> U: [-2147483648,10) S: [-2147483648,10) Exits: ((10 smin %offset) + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %ptr = getelementptr inbounds float, ptr %input, i32 %index32
; CHECK-NEXT:    --> {(-4 + (4 * (10 smin (sext i32 %offset to i64)))<nsw> + %input),+,-4}<nw><%loop> U: full-set S: full-set Exits: (-4 + (4 * (10 smin (sext i32 %offset to i64)))<nsw> + (-4 * (zext i32 (-1 + (-1 * %numIterations)) to i64))<nsw> + %input) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test-addrec-nsw-start-pos-strip-neg
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + (-1 * %numIterations))
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-1 + (-1 * %numIterations))
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + (-1 * %numIterations))
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp = icmp slt i32 %offset, 10
  %max = select i1 %cmp, i32 %offset, i32  10
  br label %loop
loop:
  %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
  %nexti = add nsw i32 %i, -1
  %index32 = add nsw i32 %nexti, %max
  %ptr = getelementptr inbounds float, ptr %input, i32 %index32
  %f = load float, ptr %ptr, align 4
  %exitcond = icmp eq i32 %nexti, %numIterations
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test-addrec-nsw-start-pos-strip-pos(ptr %input, i32 %offset, i32 %numIterations) {
; CHECK-LABEL: 'test-addrec-nsw-start-pos-strip-pos'
; CHECK-NEXT:  Classifying expressions for: @test-addrec-nsw-start-pos-strip-pos
; CHECK-NEXT:    %min = select i1 %cmp, i32 %offset, i32 10
; CHECK-NEXT:    --> (10 smax %offset) U: [10,-2147483648) S: [10,-2147483648)
; CHECK-NEXT:    %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,-2147483648) S: [0,-2147483648) Exits: (-1 + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %nexti = add nsw i32 %i, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop> U: [1,-2147483648) S: [1,-2147483648) Exits: %numIterations LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index32 = add nsw i32 %nexti, %min
; CHECK-NEXT:    --> {(1 + (10 smax %offset))<nuw><nsw>,+,1}<nuw><nsw><%loop> U: [11,-2147483648) S: [11,-2147483648) Exits: ((10 smax %offset) + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %ptr = getelementptr inbounds float, ptr %input, i32 %index32
; CHECK-NEXT:    --> {(4 + (4 * (zext i32 (10 smax %offset) to i64))<nuw><nsw> + %input)<nuw>,+,4}<nuw><%loop> U: [44,0) S: [44,0) Exits: (4 + (4 * (zext i32 (-1 + %numIterations) to i64))<nuw><nsw> + (4 * (zext i32 (10 smax %offset) to i64))<nuw><nsw> + %input) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test-addrec-nsw-start-pos-strip-pos
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp = icmp sgt i32 %offset, 10
  %min = select i1 %cmp, i32 %offset, i32  10
  br label %loop
loop:
  %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
  %nexti = add nsw i32 %i, 1
  %index32 = add nsw i32 %nexti, %min
  %ptr = getelementptr inbounds float, ptr %input, i32 %index32
  %f = load float, ptr %ptr, align 4
  %exitcond = icmp eq i32 %nexti, %numIterations
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test-addrec-nsw-start-neg-strip-pos(ptr %input, i32 %offset, i32 %numIterations) {
; CHECK-LABEL: 'test-addrec-nsw-start-neg-strip-pos'
; CHECK-NEXT:  Classifying expressions for: @test-addrec-nsw-start-neg-strip-pos
; CHECK-NEXT:    %min = select i1 %cmp, i32 %offset, i32 -10
; CHECK-NEXT:    --> (-10 smax %offset) U: [-10,-2147483648) S: [-10,-2147483648)
; CHECK-NEXT:    %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,-2147483648) S: [0,-2147483648) Exits: (-1 + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %nexti = add nsw i32 %i, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop> U: [1,-2147483648) S: [1,-2147483648) Exits: %numIterations LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index32 = add nsw i32 %nexti, %min
; CHECK-NEXT:    --> {(1 + (-10 smax %offset))<nsw>,+,1}<nsw><%loop> U: [-9,-2147483648) S: [-9,-2147483648) Exits: ((-10 smax %offset) + %numIterations) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %ptr = getelementptr inbounds float, ptr %input, i32 %index32
; CHECK-NEXT:    --> {(4 + (4 * (-10 smax (sext i32 %offset to i64)))<nsw> + %input),+,4}<nw><%loop> U: full-set S: full-set Exits: (4 + (4 * (zext i32 (-1 + %numIterations) to i64))<nuw><nsw> + (4 * (-10 smax (sext i32 %offset to i64)))<nsw> + %input) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test-addrec-nsw-start-neg-strip-pos
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + %numIterations)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp = icmp sgt i32 %offset, -10
  %min = select i1 %cmp, i32 %offset, i32  -10
  br label %loop
loop:
  %i = phi i32 [ %nexti, %loop ], [ 0, %entry ]
  %nexti = add nsw i32 %i, 1
  %index32 = add nsw i32 %nexti, %min
  %ptr = getelementptr inbounds float, ptr %input, i32 %index32
  %f = load float, ptr %ptr, align 4
  %exitcond = icmp eq i32 %nexti, %numIterations
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}


; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --filter "LV: Found an estimated cost of [0-9]+ for VF [0-9]+ For instruction:\s*store i8 %v6, ptr %out6"
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=SSE2
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx  --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX1
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX2
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx512vl --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX512DQ
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx512vl,+avx512bw --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX512BW
; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = global [1024 x i8] zeroinitializer, align 128
@B = global [1024 x i8] zeroinitializer, align 128

define void @test() {
; SSE2-LABEL: 'test'
; SSE2:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %v6, ptr %out6, align 1
; SSE2:  LV: Found an estimated cost of 56 for VF 2 For instruction: store i8 %v6, ptr %out6, align 1
; SSE2:  LV: Found an estimated cost of 112 for VF 4 For instruction: store i8 %v6, ptr %out6, align 1
; SSE2:  LV: Found an estimated cost of 225 for VF 8 For instruction: store i8 %v6, ptr %out6, align 1
; SSE2:  LV: Found an estimated cost of 456 for VF 16 For instruction: store i8 %v6, ptr %out6, align 1
;
; AVX1-LABEL: 'test'
; AVX1:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %v6, ptr %out6, align 1
; AVX1:  LV: Found an estimated cost of 33 for VF 2 For instruction: store i8 %v6, ptr %out6, align 1
; AVX1:  LV: Found an estimated cost of 63 for VF 4 For instruction: store i8 %v6, ptr %out6, align 1
; AVX1:  LV: Found an estimated cost of 119 for VF 8 For instruction: store i8 %v6, ptr %out6, align 1
; AVX1:  LV: Found an estimated cost of 232 for VF 16 For instruction: store i8 %v6, ptr %out6, align 1
; AVX1:  LV: Found an estimated cost of 469 for VF 32 For instruction: store i8 %v6, ptr %out6, align 1
;
; AVX2-LABEL: 'test'
; AVX2:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %v6, ptr %out6, align 1
; AVX2:  LV: Found an estimated cost of 33 for VF 2 For instruction: store i8 %v6, ptr %out6, align 1
; AVX2:  LV: Found an estimated cost of 63 for VF 4 For instruction: store i8 %v6, ptr %out6, align 1
; AVX2:  LV: Found an estimated cost of 119 for VF 8 For instruction: store i8 %v6, ptr %out6, align 1
; AVX2:  LV: Found an estimated cost of 232 for VF 16 For instruction: store i8 %v6, ptr %out6, align 1
; AVX2:  LV: Found an estimated cost of 469 for VF 32 For instruction: store i8 %v6, ptr %out6, align 1
;
; AVX512DQ-LABEL: 'test'
; AVX512DQ:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512DQ:  LV: Found an estimated cost of 33 for VF 2 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512DQ:  LV: Found an estimated cost of 63 for VF 4 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512DQ:  LV: Found an estimated cost of 121 for VF 8 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512DQ:  LV: Found an estimated cost of 234 for VF 16 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512DQ:  LV: Found an estimated cost of 470 for VF 32 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512DQ:  LV: Found an estimated cost of 945 for VF 64 For instruction: store i8 %v6, ptr %out6, align 1
;
; AVX512BW-LABEL: 'test'
; AVX512BW:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512BW:  LV: Found an estimated cost of 22 for VF 2 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512BW:  LV: Found an estimated cost of 46 for VF 4 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512BW:  LV: Found an estimated cost of 118 for VF 8 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512BW:  LV: Found an estimated cost of 236 for VF 16 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512BW:  LV: Found an estimated cost of 472 for VF 32 For instruction: store i8 %v6, ptr %out6, align 1
; AVX512BW:  LV: Found an estimated cost of 826 for VF 64 For instruction: store i8 %v6, ptr %out6, align 1
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]

  %iv.0 = add nuw nsw i64 %iv, 0
  %iv.1 = add nuw nsw i64 %iv, 1
  %iv.2 = add nuw nsw i64 %iv, 2
  %iv.3 = add nuw nsw i64 %iv, 3
  %iv.4 = add nuw nsw i64 %iv, 4
  %iv.5 = add nuw nsw i64 %iv, 5
  %iv.6 = add nuw nsw i64 %iv, 6

  %in = getelementptr inbounds [1024 x i8], ptr @A, i64 0, i64 %iv.0
  %v = load i8, ptr %in

  %v0 = add i8 %v, 0
  %v1 = add i8 %v, 1
  %v2 = add i8 %v, 2
  %v3 = add i8 %v, 3
  %v4 = add i8 %v, 4
  %v5 = add i8 %v, 5
  %v6 = add i8 %v, 6

  %out0 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.0
  %out1 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.1
  %out2 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.2
  %out3 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.3
  %out4 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.4
  %out5 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.5
  %out6 = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.6

  store i8 %v0, ptr %out0
  store i8 %v1, ptr %out1
  store i8 %v2, ptr %out2
  store i8 %v3, ptr %out3
  store i8 %v4, ptr %out4
  store i8 %v5, ptr %out5
  store i8 %v6, ptr %out6

  %iv.next = add nuw nsw i64 %iv.0, 7
  %cmp = icmp ult i64 %iv.next, 1024
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void
}

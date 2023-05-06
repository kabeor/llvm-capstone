; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
;
; Test that the stpncpy library call simplifier works correctly.
;
; RUN: opt < %s -data-layout="E" -passes=instcombine -S | FileCheck %s --check-prefixes=ANY,BE
; RUN: opt < %s -data-layout="e" -passes=instcombine -S | FileCheck %s --check-prefixes=ANY,LE

declare ptr @stpncpy(ptr, ptr, i64)

declare void @sink(ptr, ptr)

@a4 = constant [4 x i8] c"1234"
@s4 = constant [5 x i8] c"1234\00"


; The following are generated by the stpncpy -> memcpy transformation
; (trading space for speed).
@str = private constant [4 x i8] c"4\00\00\00"
@str.1 = private constant [10 x i8] c"4\00\00\00\00\00\00\00\00\00"
@str.2 = private constant [10 x i8] c"1234\00\00\00\00\00\00"
@str.3 = private unnamed_addr constant [4 x i8] c"4\00\00\00", align 1
@str.4 = private unnamed_addr constant [10 x i8] c"4\00\00\00\00\00\00\00\00\00", align 1
@str.5 = private unnamed_addr constant [10 x i8] c"1234\00\00\00\00\00\00", align 1

; Verify that the generated constants have the expected contents.

; Verify that exactly overlapping stpncpy(D, D, N) calls are transformed
; to D + strnlen(D, N) or, equivalently, D + (*D != '\0'), when N < 2.

;.
; ANY: @[[A4:[a-zA-Z0-9_$"\\.-]+]] = constant [4 x i8] c"1234"
; ANY: @[[S4:[a-zA-Z0-9_$"\\.-]+]] = constant [5 x i8] c"1234\00"
; ANY: @[[STR:[a-zA-Z0-9_$"\\.-]+]] = private constant [4 x i8] c"4\00\00\00"
; ANY: @[[STR_1:[a-zA-Z0-9_$"\\.-]+]] = private constant [10 x i8] c"4\00\00\00\00\00\00\00\00\00"
; ANY: @[[STR_2:[a-zA-Z0-9_$"\\.-]+]] = private constant [10 x i8] c"1234\00\00\00\00\00\00"
; ANY: @[[STR_3:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [4 x i8] c"4\00\00\00", align 1
; ANY: @[[STR_4:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [10 x i8] c"4\00\00\00\00\00\00\00\00\00", align 1
; ANY: @[[STR_5:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [10 x i8] c"1234\00\00\00\00\00\00", align 1
; ANY: @[[STR_6:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [4 x i8] c"4\00\00\00", align 1
; ANY: @[[STR_7:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [10 x i8] c"4\00\00\00\00\00\00\00\00\00", align 1
; ANY: @[[STR_8:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [10 x i8] c"1234\00\00\00\00\00\00", align 1
; ANY: @[[STR_9:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [10 x i8] c"1234\00\00\00\00\00\00", align 1
;.
define void @fold_stpncpy_overlap(ptr %dst, i64 %n) {
; ANY-LABEL: @fold_stpncpy_overlap(
; ANY-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; ANY-NEXT:    [[STXNCPY_CHAR0:%.*]] = load i8, ptr [[DST]], align 1
; ANY-NEXT:    [[STPNCPY_CHAR0CMP:%.*]] = icmp ne i8 [[STXNCPY_CHAR0]], 0
; ANY-NEXT:    [[STPNCPY_SEL_IDX:%.*]] = zext i1 [[STPNCPY_CHAR0CMP]] to i64
; ANY-NEXT:    [[STPNCPY_SEL:%.*]] = getelementptr i8, ptr [[DST]], i64 [[STPNCPY_SEL_IDX]]
; ANY-NEXT:    call void @sink(ptr nonnull [[DST]], ptr [[STPNCPY_SEL]])
; ANY-NEXT:    ret void
;
; Fold stpncpy(D, D, 0) to just D.
  %es_0 = call ptr @stpncpy(ptr %dst, ptr %dst, i64 0)
  call void @sink(ptr %dst, ptr %es_0)

; Fold stpncpy(D, D, 1) to D + (*D != '\0').
  %es_1 = call ptr @stpncpy(ptr %dst, ptr %dst, i64 1)
  call void @sink(ptr %dst, ptr %es_1)

  ret void
}


; Verify that exactly overlapping stpncpy(D, D, N) calls are left alone
; when N >= 2.  Such calls are strictly undefined and while simplifying
; them to the expected result is possible there is little to gain from it.

define void @call_stpncpy_overlap(ptr %dst, i64 %n) {
; ANY-LABEL: @call_stpncpy_overlap(
; ANY-NEXT:    [[ES_2:%.*]] = call ptr @stpncpy(ptr noundef nonnull dereferenceable(1) [[DST:%.*]], ptr noundef nonnull dereferenceable(1) [[DST]], i64 2)
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES_2]])
; ANY-NEXT:    [[ES_3:%.*]] = call ptr @stpncpy(ptr noundef nonnull dereferenceable(1) [[DST]], ptr noundef nonnull dereferenceable(1) [[DST]], i64 3)
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES_3]])
; ANY-NEXT:    [[ES_N:%.*]] = call ptr @stpncpy(ptr [[DST]], ptr [[DST]], i64 [[N:%.*]])
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES_N]])
; ANY-NEXT:    ret void
;
; Do not transform stpncpy(D, D, 2).
  %es_2 = call ptr @stpncpy(ptr %dst, ptr %dst, i64 2)
  call void @sink(ptr %dst, ptr %es_2)

; Do not transform stpncpy(D, D, 3).
  %es_3 = call ptr @stpncpy(ptr %dst, ptr %dst, i64 3)
  call void @sink(ptr %dst, ptr %es_3)

; Do not transform stpncpy(D, D, N).
  %es_n = call ptr @stpncpy(ptr %dst, ptr %dst, i64 %n)
  call void @sink(ptr %dst, ptr %es_n)

  ret void
}


; Verify that stpncpy(D, "", N) calls are transformed to memset(D, 0, N).

define void @fold_stpncpy_s0(ptr %dst, i64 %n) {
; ANY-LABEL: @fold_stpncpy_s0(
; ANY-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; ANY-NEXT:    store i8 0, ptr [[DST]], align 1
; ANY-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[DST]])
; ANY-NEXT:    store i16 0, ptr [[DST]], align 1
; ANY-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[DST]])
; ANY-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], i8 0, i64 9, i1 false)
; ANY-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[DST]])
; ANY-NEXT:    call void @llvm.memset.p0.i64(ptr nonnull align 1 [[DST]], i8 0, i64 [[N:%.*]], i1 false)
; ANY-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[DST]])
; ANY-NEXT:    ret void
;
  %ps0 = getelementptr [5 x i8], ptr @s4, i32 0, i32 4

; Fold stpncpy(D, "", 0) to just D.
  %es0_0 = call ptr @stpncpy(ptr %dst, ptr %ps0, i64 0)
  call void @sink(ptr %dst, ptr %es0_0)

; Transform stpncpy(D, "", 1) to *D = '\0, D.
  %es0_1 = call ptr @stpncpy(ptr %dst, ptr %ps0, i64 1)
  call void @sink(ptr %dst, ptr %es0_1)

; Transform stpncpy(D, "", 2) to memset(D, 0, 2), D.
  %es0_2 = call ptr @stpncpy(ptr %dst, ptr %ps0, i64 2)
  call void @sink(ptr %dst, ptr %es0_2)

; Transform stpncpy(D, "", 9) to memset(D, 0, 9), D.
  %es0_9 = call ptr @stpncpy(ptr %dst, ptr %ps0, i64 9)
  call void @sink(ptr %dst, ptr %es0_9)

; Transform stpncpy(D, "", n) to memset(D, 0, n), D.
  %es0_n = call ptr @stpncpy(ptr %dst, ptr %ps0, i64 %n)
  call void @sink(ptr %dst, ptr %es0_n)

  ret void
}


; Verify that stpncpy(D, "4", N) calls are transformed to the equivalent
; of strncpy(D, "4", N) and the result folded to D + (N != 0).

define void @fold_stpncpy_s1(ptr %dst) {
; BE-LABEL: @fold_stpncpy_s1(
; BE-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; BE-NEXT:    store i8 52, ptr [[DST]], align 1
; BE-NEXT:    [[STPNCPY_END:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[STPNCPY_END]])
; BE-NEXT:    store i16 13312, ptr [[DST]], align 1
; BE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(3) [[DST]], ptr noundef nonnull align 1 dereferenceable(3) @str.6, i64 3, i1 false)
; BE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR1]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], ptr noundef nonnull align 1 dereferenceable(9) @str.7, i64 9, i1 false)
; BE-NEXT:    [[ENDPTR2:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR2]])
; BE-NEXT:    ret void
;
; LE-LABEL: @fold_stpncpy_s1(
; LE-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; LE-NEXT:    store i8 52, ptr [[DST]], align 1
; LE-NEXT:    [[STPNCPY_END:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[STPNCPY_END]])
; LE-NEXT:    store i16 52, ptr [[DST]], align 1
; LE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(3) [[DST]], ptr noundef nonnull align 1 dereferenceable(3) @str.6, i64 3, i1 false)
; LE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR1]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], ptr noundef nonnull align 1 dereferenceable(9) @str.7, i64 9, i1 false)
; LE-NEXT:    [[ENDPTR2:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR2]])
; LE-NEXT:    ret void
;
  %ps1 = getelementptr [5 x i8], ptr @s4, i32 0, i32 3

; Fold stpncpy(D, "4", 0) to just D.
  %es1_0 = call ptr @stpncpy(ptr %dst, ptr %ps1, i64 0)
  call void @sink(ptr %dst, ptr %es1_0)

; Transform stpncpy(D, "4", 1) to *D = '4', D + 1.
  %es1_1 = call ptr @stpncpy(ptr %dst, ptr %ps1, i64 1)
  call void @sink(ptr %dst, ptr %es1_1)

; Transform stpncpy(D, "4", 2) to strncpy(D, "4", 2) + 1.
  %es1_2 = call ptr @stpncpy(ptr %dst, ptr %ps1, i64 2)
  call void @sink(ptr %dst, ptr %es1_2)

; Transform stpncpy(D, "4", 3) to strncpy(D, "4", 3) + 1, which is then
; transformed to memcpy(D, "4", 2), D[2] = '\0', D + 1.
  %es1_3 = call ptr @stpncpy(ptr %dst, ptr %ps1, i64 3)
  call void @sink(ptr %dst, ptr %es1_3)

; Transform stpncpy(D, "4", 9) to strncpy(D, "4", 9) + 1.
  %es1_9 = call ptr @stpncpy(ptr %dst, ptr %ps1, i64 9)
  call void @sink(ptr %dst, ptr %es1_9)

  ret void
}


; Verify that stpncpy(D, "1234", N) calls are transformed to the equivalent
; of strncpy(D, "1234", N) and the result folded to D + min(4, N).

define void @fold_stpncpy_s4(ptr %dst, i64 %n) {
; BE-LABEL: @fold_stpncpy_s4(
; BE-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; BE-NEXT:    store i8 49, ptr [[DST]], align 1
; BE-NEXT:    [[STPNCPY_END:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[STPNCPY_END]])
; BE-NEXT:    store i16 12594, ptr [[DST]], align 1
; BE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 2
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(3) [[DST]], ptr noundef nonnull align 1 dereferenceable(5) @s4, i64 3, i1 false)
; BE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 3
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR1]])
; BE-NEXT:    store i32 825373492, ptr [[DST]], align 1
; BE-NEXT:    [[ENDPTR2:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR2]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], ptr noundef nonnull align 1 dereferenceable(9) @str.8, i64 9, i1 false)
; BE-NEXT:    [[ENDPTR3:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR3]])
; BE-NEXT:    ret void
;
; LE-LABEL: @fold_stpncpy_s4(
; LE-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; LE-NEXT:    store i8 49, ptr [[DST]], align 1
; LE-NEXT:    [[STPNCPY_END:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[STPNCPY_END]])
; LE-NEXT:    store i16 12849, ptr [[DST]], align 1
; LE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 2
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(3) [[DST]], ptr noundef nonnull align 1 dereferenceable(5) @s4, i64 3, i1 false)
; LE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 3
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR1]])
; LE-NEXT:    store i32 875770417, ptr [[DST]], align 1
; LE-NEXT:    [[ENDPTR2:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR2]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], ptr noundef nonnull align 1 dereferenceable(9) @str.8, i64 9, i1 false)
; LE-NEXT:    [[ENDPTR3:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR3]])
; LE-NEXT:    ret void
;

; Fold stpncpy(D, "1234", 0) to just D.
  %es4_0 = call ptr @stpncpy(ptr %dst, ptr @s4, i64 0)
  call void @sink(ptr %dst, ptr %es4_0)

; Transform stpncpy(D, "1234", 1) to *D = '4', D + 1.
  %es4_1 = call ptr @stpncpy(ptr %dst, ptr @s4, i64 1)
  call void @sink(ptr %dst, ptr %es4_1)

; Transform stpncpy(D, "1234", 2) to strncpy(D, "1234", 2) + 2.
  %es4_2 = call ptr @stpncpy(ptr %dst, ptr @s4, i64 2)
  call void @sink(ptr %dst, ptr %es4_2)

; Transform stpncpy(D, "1234", 3) to strncpy(D, "1234", 3) + 3
  %es4_3 = call ptr @stpncpy(ptr %dst, ptr @s4, i64 3)
  call void @sink(ptr %dst, ptr %es4_3)

; Transform stpncpy(D, "1234", 4) to strncpy(D, "1234", 4) + 4.
  %es4_4 = call ptr @stpncpy(ptr %dst, ptr @s4, i64 4)
  call void @sink(ptr %dst, ptr %es4_4)

; Transform stpncpy(D, "1234", 9) to strncpy(D, "1234", 9) + 4.
  %es4_9 = call ptr @stpncpy(ptr %dst, ptr @s4, i64 9)
  call void @sink(ptr %dst, ptr %es4_9)

  ret void
}


; Verify that a call to stpncpy(D, A, N) with a constant source larger
; than one byte is left alone when N is unknown.

define void @call_stpncpy_xx_n(ptr %dst, i64 %n) {
; ANY-LABEL: @call_stpncpy_xx_n(
; ANY-NEXT:    [[EA1_N:%.*]] = call ptr @stpncpy(ptr [[DST:%.*]], ptr nonnull dereferenceable(2) getelementptr inbounds ([4 x i8], ptr @a4, i64 0, i64 3), i64 [[N:%.*]])
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[EA1_N]])
; ANY-NEXT:    [[EA4_N:%.*]] = call ptr @stpncpy(ptr [[DST]], ptr nonnull dereferenceable(5) @a4, i64 [[N]])
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[EA4_N]])
; ANY-NEXT:    [[ES1_N:%.*]] = call ptr @stpncpy(ptr [[DST]], ptr nonnull dereferenceable(2) getelementptr inbounds ([5 x i8], ptr @s4, i64 0, i64 3), i64 [[N]])
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES1_N]])
; ANY-NEXT:    [[ES4_N:%.*]] = call ptr @stpncpy(ptr [[DST]], ptr nonnull dereferenceable(5) @s4, i64 [[N]])
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES4_N]])
; ANY-NEXT:    ret void
;
; Do not transform stpncpy(D, A4 + 3, N) when N is unknown.
  %pa1 = getelementptr [4 x i8], ptr @a4, i32 0, i32 3
  %ea1_n = call ptr @stpncpy(ptr %dst, ptr %pa1, i64 %n)
  call void @sink(ptr %dst, ptr %ea1_n)

; Do not transform stpncpy(D, A4, N) when N is unknown.
  %ea4_n = call ptr @stpncpy(ptr %dst, ptr @a4, i64 %n)
  call void @sink(ptr %dst, ptr %ea4_n)

; Do not transform stpncpy(D, "4", N) when N is unknown.
  %ps1 = getelementptr [5 x i8], ptr @s4, i32 0, i32 3
  %es1_n = call ptr @stpncpy(ptr %dst, ptr %ps1, i64 %n)
  call void @sink(ptr %dst, ptr %es1_n)

; Likewise, do not transform stpncpy(D, "1234", N) when N is unknown.
  %es4_n = call ptr @stpncpy(ptr %dst, ptr @s4, i64 %n)
  call void @sink(ptr %dst, ptr %es4_n)

  ret void
}

; Verify that stpncpy(D, (char[4]){"1234"}, N) calls with an unterminated
; source array are transformed to the equivalent strncpy call and the result
; folded to D + min(4, N).

define void @fold_stpncpy_a4(ptr %dst, i64 %n) {
; BE-LABEL: @fold_stpncpy_a4(
; BE-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; BE-NEXT:    store i8 49, ptr [[DST]], align 1
; BE-NEXT:    [[STPNCPY_END:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[STPNCPY_END]])
; BE-NEXT:    store i16 12594, ptr [[DST]], align 1
; BE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 2
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(3) [[DST]], ptr noundef nonnull align 1 dereferenceable(5) @a4, i64 3, i1 false)
; BE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 3
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR1]])
; BE-NEXT:    store i32 825373492, ptr [[DST]], align 1
; BE-NEXT:    [[ENDPTR2:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR2]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(5) [[DST]], ptr noundef nonnull align 1 dereferenceable(5) @a4, i64 5, i1 false)
; BE-NEXT:    [[ENDPTR3:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR3]])
; BE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], ptr noundef nonnull align 1 dereferenceable(9) @str.9, i64 9, i1 false)
; BE-NEXT:    [[ENDPTR4:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; BE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR4]])
; BE-NEXT:    ret void
;
; LE-LABEL: @fold_stpncpy_a4(
; LE-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; LE-NEXT:    store i8 49, ptr [[DST]], align 1
; LE-NEXT:    [[STPNCPY_END:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 1
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[STPNCPY_END]])
; LE-NEXT:    store i16 12849, ptr [[DST]], align 1
; LE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 2
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(3) [[DST]], ptr noundef nonnull align 1 dereferenceable(5) @a4, i64 3, i1 false)
; LE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 3
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR1]])
; LE-NEXT:    store i32 875770417, ptr [[DST]], align 1
; LE-NEXT:    [[ENDPTR2:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR2]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(5) [[DST]], ptr noundef nonnull align 1 dereferenceable(5) @a4, i64 5, i1 false)
; LE-NEXT:    [[ENDPTR3:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR3]])
; LE-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(9) [[DST]], ptr noundef nonnull align 1 dereferenceable(9) @str.9, i64 9, i1 false)
; LE-NEXT:    [[ENDPTR4:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 4
; LE-NEXT:    call void @sink(ptr nonnull [[DST]], ptr nonnull [[ENDPTR4]])
; LE-NEXT:    ret void
;


; Fold stpncpy(D, A4, 0) to just D.
  %ea4_0 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 0)
  call void @sink(ptr %dst, ptr %ea4_0)

; Transform stpncpy(D, A4, 1) to *D = '4', D + 1.
  %ea4_1 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 1)
  call void @sink(ptr %dst, ptr %ea4_1)

; Transform stpncpy(D, A4, 2) to strncpy(D, A4, 2) + 2.
  %ea4_2 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 2)
  call void @sink(ptr %dst, ptr %ea4_2)

; Transform stpncpy(D, A4, 3) to strncpy(D, A4, 3) + 3
  %ea4_3 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 3)
  call void @sink(ptr %dst, ptr %ea4_3)

; Transform stpncpy(D, A4, 4) to strncpy(D, A4, 4) + 4.
  %ea4_4 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 4)
  call void @sink(ptr %dst, ptr %ea4_4)

; Transform stpncpy(D, A4, 5) to strncpy(D, A4, 5) + 4.
  %ea4_5 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 5)
  call void @sink(ptr %dst, ptr %ea4_5)

; Transform stpncpy(D, A4, 9) to strncpy(D, A4, 9) + 4.
  %ea4_9 = call ptr @stpncpy(ptr %dst, ptr @a4, i64 9)
  call void @sink(ptr %dst, ptr %ea4_9)

  ret void
}


; Verify that stpncpy(D, S, N) calls with N < 2 are transformed to
; the equivalent of strncpy and either folded to D if N == 0 or to
; *D ? D + 1 : D otherwise.

define void @fold_stpncpy_s(ptr %dst, ptr %src) {
; ANY-LABEL: @fold_stpncpy_s(
; ANY-NEXT:    call void @sink(ptr [[DST:%.*]], ptr [[DST]])
; ANY-NEXT:    [[STXNCPY_CHAR0:%.*]] = load i8, ptr [[SRC:%.*]], align 1
; ANY-NEXT:    store i8 [[STXNCPY_CHAR0]], ptr [[DST]], align 1
; ANY-NEXT:    [[STPNCPY_CHAR0CMP:%.*]] = icmp ne i8 [[STXNCPY_CHAR0]], 0
; ANY-NEXT:    [[STPNCPY_SEL_IDX:%.*]] = zext i1 [[STPNCPY_CHAR0CMP]] to i64
; ANY-NEXT:    [[STPNCPY_SEL:%.*]] = getelementptr i8, ptr [[DST]], i64 [[STPNCPY_SEL_IDX]]
; ANY-NEXT:    call void @sink(ptr nonnull [[DST]], ptr [[STPNCPY_SEL]])
; ANY-NEXT:    ret void
;
; Fold stpncpy(D, S, 0) to just D.
  %es_0 = call ptr @stpncpy(ptr %dst, ptr %src, i64 0)
  call void @sink(ptr %dst, ptr %es_0)

; Transform stpncpy(D, "", 1) to *D = '\0, D.
  %es_1 = call ptr @stpncpy(ptr %dst, ptr %src, i64 1)
  call void @sink(ptr %dst, ptr %es_1)

  ret void
}


; Verify that stpncpy(D, S, N) calls with N >= 2 are not transformed.
; In theory they could be transformed to the equivalent of the following
; though it's not clear that it would be a win:
;   P = memccpy(D, S, 0, N)
;   N' = P ? N - (P - D) : 0
;   Q = P ? P : D + N
;   memset(Q, 0, N')
;   Q
; Also verify that the arguments of the call are annotated with the right
; attributes.

define void @call_stpncpy_s(ptr %dst, ptr %src, i64 %n) {
; ANY-LABEL: @call_stpncpy_s(
; ANY-NEXT:    [[ES_2:%.*]] = call ptr @stpncpy(ptr noundef nonnull dereferenceable(1) [[DST:%.*]], ptr noundef nonnull dereferenceable(1) [[SRC:%.*]], i64 2)
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES_2]])
; ANY-NEXT:    [[ES_N:%.*]] = call ptr @stpncpy(ptr [[DST]], ptr [[SRC]], i64 [[N:%.*]])
; ANY-NEXT:    call void @sink(ptr [[DST]], ptr [[ES_N]])
; ANY-NEXT:    ret void
;
; Do not transform stpncpy(D, S, 2).  Both *D and *S must be derefernceable
; but neither D[1] nor S[1] need be.
  %es_2 = call ptr @stpncpy(ptr %dst, ptr %src, i64 2)
  call void @sink(ptr %dst, ptr %es_2)

; Do not transform stpncpy(D, S, N).  Both D and S must be nonnull but
; neither *D nor *S need be dereferenceable.
; TODO: Both D and S should be annotated nonnull and noundef regardless
; of the value of N.  See https://reviews.llvm.org/D124633.
  %es_n = call ptr @stpncpy(ptr %dst, ptr %src, i64 %n)
  call void @sink(ptr %dst, ptr %es_n)

  ret void
}
;.
; ANY: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: write) }
; ANY: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
;.

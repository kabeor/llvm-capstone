; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s "-passes=print<scalar-evolution>" -disable-output -scalar-evolution-classify-expressions=0 2>&1 | FileCheck %s

; ScalarEvolution can't compute a trip count because it doesn't know if
; dividing by the stride will have a remainder. This could theoretically
; be teaching it how to use a more elaborate trip count computation.

%struct.FILE = type { i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, [1 x i8], ptr, i64, ptr, ptr, ptr, ptr, i64, i32, [20 x i8] }
%struct.SHA_INFO = type { [5 x i32], i32, i32, [16 x i32] }
%struct._IO_marker = type { ptr, ptr, i32 }

@_2E_str = external constant [26 x i8]
@stdin = external global ptr
@_2E_str1 = external constant [3 x i8]
@_2E_str12 = external constant [30 x i8]

declare void @sha_init(ptr nocapture) nounwind

declare fastcc void @sha_transform(ptr nocapture) nounwind

declare void @sha_print(ptr nocapture) nounwind

declare i32 @printf(ptr nocapture, ...) nounwind

declare void @sha_final(ptr nocapture) nounwind

declare void @sha_update(ptr nocapture, ptr nocapture, i32) nounwind

declare i64 @fread(ptr noalias nocapture, i64, i64, ptr noalias nocapture) nounwind

declare i32 @main(i32, ptr nocapture) nounwind

declare noalias ptr @fopen(ptr noalias nocapture, ptr noalias nocapture) nounwind

declare i32 @fclose(ptr nocapture) nounwind

declare void @sha_stream(ptr nocapture, ptr nocapture) nounwind

define void @sha_stream_bb3_2E_i(ptr %sha_info, ptr %data1, i32, ptr %buffer_addr.0.i.out, ptr %count_addr.0.i.out) nounwind {
; CHECK-LABEL: 'sha_stream_bb3_2E_i'
; CHECK-NEXT:  Determining loop execution counts for: @sha_stream_bb3_2E_i
; CHECK-NEXT:  Loop %bb3.i: backedge-taken count is ((63 + (-1 * (63 smin %0)) + %0) /u 64)
; CHECK-NEXT:  Loop %bb3.i: constant max backedge-taken count is 33554431
; CHECK-NEXT:  Loop %bb3.i: symbolic max backedge-taken count is ((63 + (-1 * (63 smin %0)) + %0) /u 64)
; CHECK-NEXT:  Loop %bb3.i: Predicated backedge-taken count is ((63 + (-1 * (63 smin %0)) + %0) /u 64)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %bb3.i: Trip multiple is 1
;
newFuncRoot:
  br label %bb3.i

sha_update.exit.exitStub:                         ; preds = %bb3.i
  store ptr %buffer_addr.0.i, ptr %buffer_addr.0.i.out
  store i32 %count_addr.0.i, ptr %count_addr.0.i.out
  ret void

bb2.i:                                            ; preds = %bb3.i
  %1 = getelementptr %struct.SHA_INFO, ptr %sha_info, i64 0, i32 3
  call void @llvm.memcpy.p0.p0.i64(ptr %1, ptr %buffer_addr.0.i, i64 64, i1 false)
  %2 = getelementptr %struct.SHA_INFO, ptr %sha_info, i64 0, i32 3, i64 0
  br label %codeRepl

codeRepl:                                         ; preds = %bb2.i
  call void @sha_stream_bb3_2E_i_bb1_2E_i_2E_i(ptr %2)
  br label %byte_reverse.exit.i

byte_reverse.exit.i:                              ; preds = %codeRepl
  call fastcc void @sha_transform(ptr %sha_info) nounwind
  %3 = getelementptr i8, ptr %buffer_addr.0.i, i64 64
  %4 = add i32 %count_addr.0.i, -64
  br label %bb3.i

bb3.i:                                            ; preds = %byte_reverse.exit.i, %newFuncRoot
  %buffer_addr.0.i = phi ptr [ %data1, %newFuncRoot ], [ %3, %byte_reverse.exit.i ]
  %count_addr.0.i = phi i32 [ %0, %newFuncRoot ], [ %4, %byte_reverse.exit.i ]
  %5 = icmp sgt i32 %count_addr.0.i, 63
  br i1 %5, label %bb2.i, label %sha_update.exit.exitStub
}

declare void @sha_stream_bb3_2E_i_bb1_2E_i_2E_i(ptr) nounwind

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind


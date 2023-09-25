; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; Check getShuffleCost for scalable vector

; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64 -mattr=+m,+v < %s | FileCheck %s

define void  @vector_broadcast() {
; CHECK-LABEL: 'vector_broadcast'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %zero = shufflevector <vscale x 8 x i8> undef, <vscale x 8 x i8> undef, <vscale x 8 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %1 = shufflevector <vscale x 16 x i8> undef, <vscale x 16 x i8> undef, <vscale x 16 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %2 = shufflevector <vscale x 4 x i16> undef, <vscale x 4 x i16> undef, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %3 = shufflevector <vscale x 8 x i16> undef, <vscale x 8 x i16> undef, <vscale x 8 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %4 = shufflevector <vscale x 2 x i32> undef, <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %5 = shufflevector <vscale x 4 x i32> undef, <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %6 = shufflevector <vscale x 1 x i64> undef, <vscale x 1 x i64> undef, <vscale x 1 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %7 = shufflevector <vscale x 2 x i64> undef, <vscale x 2 x i64> undef, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %8 = shufflevector <vscale x 16 x i1> undef, <vscale x 16 x i1> undef, <vscale x 16 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %9 = shufflevector <vscale x 8 x i1> undef, <vscale x 8 x i1> undef, <vscale x 8 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %10 = shufflevector <vscale x 4 x i1> undef, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %11 = shufflevector <vscale x 2 x i1> undef, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %zero = shufflevector <vscale x 8 x i8> undef, <vscale x 8 x i8> undef, <vscale x 8 x i32> zeroinitializer
  %1 = shufflevector <vscale x 16 x i8> undef, <vscale x 16 x i8> undef, <vscale x 16 x i32> zeroinitializer
  %2 = shufflevector <vscale x 4 x i16> undef, <vscale x 4 x i16> undef, <vscale x 4 x i32> zeroinitializer
  %3 = shufflevector <vscale x 8 x i16> undef, <vscale x 8 x i16> undef, <vscale x 8 x i32> zeroinitializer
  %4 = shufflevector <vscale x 2 x i32> undef, <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer
  %5 = shufflevector <vscale x 4 x i32> undef, <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
  %6 = shufflevector <vscale x 1 x i64> undef, <vscale x 1 x i64> undef, <vscale x 1 x i32> zeroinitializer
  %7 = shufflevector <vscale x 2 x i64> undef, <vscale x 2 x i64> undef, <vscale x 2 x i32> zeroinitializer
  %8 = shufflevector <vscale x 16 x i1> undef, <vscale x 16 x i1> undef, <vscale x 16 x i32> zeroinitializer
  %9 = shufflevector <vscale x 8 x i1> undef, <vscale x 8 x i1> undef, <vscale x 8 x i32> zeroinitializer
  %10 = shufflevector <vscale x 4 x i1> undef, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
  %11 = shufflevector <vscale x 2 x i1> undef, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  ret void
}

define void @vector_insert_extract(<vscale x 4 x i32> %v0, <vscale x 16 x i32> %v1, <16 x i32> %v2) {
; CHECK-LABEL: 'vector_insert_extract'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %extract_fixed_from_scalable = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %v0, i64 0)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %insert_fixed_into_scalable = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> %v0, <16 x i32> %v2, i64 0)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %extract_scalable_from_scalable = call <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv16i32(<vscale x 16 x i32> %v1, i64 0)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %insert_scalable_into_scalable = call <vscale x 16 x i32> @llvm.vector.insert.nxv16i32.nxv4i32(<vscale x 16 x i32> %v1, <vscale x 4 x i32> %v0, i64 0)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %extract_fixed_from_scalable = call <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> %v0, i64 0)
  %insert_fixed_into_scalable = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> %v0, <16 x i32> %v2, i64 0)
  %extract_scalable_from_scalable = call <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv16i32(<vscale x 16 x i32> %v1, i64 0)
  %insert_scalable_into_scalable = call <vscale x 16 x i32> @llvm.vector.insert.nxv16i32.nxv4i32(<vscale x 16 x i32> %v1, <vscale x 4 x i32> %v0, i64 0)
  ret void
}
declare <16 x i32> @llvm.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32>, i64)
declare <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32>, <16 x i32>, i64)
declare <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv16i32(<vscale x 16 x i32>, i64)
declare <vscale x 16 x i32> @llvm.vector.insert.nxv16i32.nxv4i32(<vscale x 16 x i32>, <vscale x 4 x i32>, i64)

define void @vector_reverse() {
; CHECK-LABEL: 'vector_reverse'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv16i8 = call <vscale x 16 x i8> @llvm.experimental.vector.reverse.nxv16i8(<vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 21 for instruction: %reverse_nxv32i8 = call <vscale x 32 x i8> @llvm.experimental.vector.reverse.nxv32i8(<vscale x 32 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %reverse_nxv2i16 = call <vscale x 2 x i16> @llvm.experimental.vector.reverse.nxv2i16(<vscale x 2 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %reverse_nxv4i16 = call <vscale x 4 x i16> @llvm.experimental.vector.reverse.nxv4i16(<vscale x 4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv8i16 = call <vscale x 8 x i16> @llvm.experimental.vector.reverse.nxv8i16(<vscale x 8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 21 for instruction: %reverse_nxv16i16 = call <vscale x 16 x i16> @llvm.experimental.vector.reverse.nxv16i16(<vscale x 16 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv4i32 = call <vscale x 4 x i32> @llvm.experimental.vector.reverse.nxv4i32(<vscale x 4 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 21 for instruction: %reverse_nxv8i32 = call <vscale x 8 x i32> @llvm.experimental.vector.reverse.nxv8i32(<vscale x 8 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv2i64 = call <vscale x 2 x i64> @llvm.experimental.vector.reverse.nxv2i64(<vscale x 2 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 21 for instruction: %reverse_nxv4i64 = call <vscale x 4 x i64> @llvm.experimental.vector.reverse.nxv4i64(<vscale x 4 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 69 for instruction: %reverse_nxv8i64 = call <vscale x 8 x i64> @llvm.experimental.vector.reverse.nxv8i64(<vscale x 8 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 138 for instruction: %reverse_nxv16i64 = call <vscale x 16 x i64> @llvm.experimental.vector.reverse.nxv16i64(<vscale x 16 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 276 for instruction: %reverse_nxv32i64 = call <vscale x 32 x i64> @llvm.experimental.vector.reverse.nxv32i64(<vscale x 32 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %reverse_nxv16i1 = call <vscale x 16 x i1> @llvm.experimental.vector.reverse.nxv16i1(<vscale x 16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv8i1 = call <vscale x 8 x i1> @llvm.experimental.vector.reverse.nxv8i1(<vscale x 8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv4i1 = call <vscale x 4 x i1> @llvm.experimental.vector.reverse.nxv4i1(<vscale x 4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %reverse_nxv2i1 = call <vscale x 2 x i1> @llvm.experimental.vector.reverse.nxv2i1(<vscale x 2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %reverse_nxv16i8 = call <vscale x 16 x i8> @llvm.experimental.vector.reverse.nxv16i8(<vscale x 16 x i8> undef)
  %reverse_nxv32i8 = call <vscale x 32 x i8> @llvm.experimental.vector.reverse.nxv32i8(<vscale x 32 x i8> undef)
  %reverse_nxv2i16 = call <vscale x 2 x i16> @llvm.experimental.vector.reverse.nxv2i16(<vscale x 2 x i16> undef)
  %reverse_nxv4i16 = call <vscale x 4 x i16> @llvm.experimental.vector.reverse.nxv4i16(<vscale x 4 x i16> undef)
  %reverse_nxv8i16 = call <vscale x 8 x i16> @llvm.experimental.vector.reverse.nxv8i16(<vscale x 8 x i16> undef)
  %reverse_nxv16i16 = call <vscale x 16 x i16> @llvm.experimental.vector.reverse.nxv16i16(<vscale x 16 x i16> undef)
  %reverse_nxv4i32 = call <vscale x 4 x i32> @llvm.experimental.vector.reverse.nxv4i32(<vscale x 4 x i32> undef)
  %reverse_nxv8i32 = call <vscale x 8 x i32> @llvm.experimental.vector.reverse.nxv8i32(<vscale x 8 x i32> undef)
  %reverse_nxv2i64 = call <vscale x 2 x i64> @llvm.experimental.vector.reverse.nxv2i64(<vscale x 2 x i64> undef)
  %reverse_nxv4i64 = call <vscale x 4 x i64> @llvm.experimental.vector.reverse.nxv4i64(<vscale x 4 x i64> undef)
  %reverse_nxv8i64 = call <vscale x 8 x i64> @llvm.experimental.vector.reverse.nxv8i64(<vscale x 8 x i64> undef)
  %reverse_nxv16i64 = call <vscale x 16 x i64> @llvm.experimental.vector.reverse.nxv16i64(<vscale x 16 x i64> undef)
  %reverse_nxv32i64 = call <vscale x 32 x i64> @llvm.experimental.vector.reverse.nxv32i64(<vscale x 32 x i64> undef)
  %reverse_nxv16i1 = call <vscale x 16 x i1> @llvm.experimental.vector.reverse.nxv16i1(<vscale x 16 x i1> undef)
  %reverse_nxv8i1 =  call <vscale x 8 x i1> @llvm.experimental.vector.reverse.nxv8i1(<vscale x 8 x i1> undef)
  %reverse_nxv4i1 = call <vscale x 4 x i1> @llvm.experimental.vector.reverse.nxv4i1(<vscale x 4 x i1> undef)
  %reverse_nxv2i1 = call <vscale x 2 x i1> @llvm.experimental.vector.reverse.nxv2i1(<vscale x 2 x i1> undef)
  ret void
}

declare <vscale x 16 x i8> @llvm.experimental.vector.reverse.nxv16i8(<vscale x 16 x i8>)
declare <vscale x 32 x i8> @llvm.experimental.vector.reverse.nxv32i8(<vscale x 32 x i8>)
declare <vscale x 2 x i16> @llvm.experimental.vector.reverse.nxv2i16(<vscale x 2 x i16>)
declare <vscale x 4 x i16> @llvm.experimental.vector.reverse.nxv4i16(<vscale x 4 x i16>)
declare <vscale x 8 x i16> @llvm.experimental.vector.reverse.nxv8i16(<vscale x 8 x i16>)
declare <vscale x 16 x i16> @llvm.experimental.vector.reverse.nxv16i16(<vscale x 16 x i16>)
declare <vscale x 4 x i32> @llvm.experimental.vector.reverse.nxv4i32(<vscale x 4 x i32>)
declare <vscale x 8 x i32> @llvm.experimental.vector.reverse.nxv8i32(<vscale x 8 x i32>)
declare <vscale x 2 x i64> @llvm.experimental.vector.reverse.nxv2i64(<vscale x 2 x i64>)
declare <vscale x 4 x i64> @llvm.experimental.vector.reverse.nxv4i64(<vscale x 4 x i64>)
declare <vscale x 8 x i64> @llvm.experimental.vector.reverse.nxv8i64(<vscale x 8 x i64>)
declare <vscale x 16 x i64> @llvm.experimental.vector.reverse.nxv16i64(<vscale x 16 x i64>)
declare <vscale x 32 x i64> @llvm.experimental.vector.reverse.nxv32i64(<vscale x 32 x i64>)
declare <vscale x 16 x i1> @llvm.experimental.vector.reverse.nxv16i1(<vscale x 16 x i1>)
declare <vscale x 8 x i1> @llvm.experimental.vector.reverse.nxv8i1(<vscale x 8 x i1>)
declare <vscale x 4 x i1> @llvm.experimental.vector.reverse.nxv4i1(<vscale x 4 x i1>)
declare <vscale x 2 x i1> @llvm.experimental.vector.reverse.nxv2i1(<vscale x 2 x i1>)


define void @vector_splice() {
; CHECK-LABEL: 'vector_splice'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %splice_nxv16i8 = call <vscale x 16 x i8> @llvm.experimental.vector.splice.nxv16i8(<vscale x 16 x i8> zeroinitializer, <vscale x 16 x i8> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %splice_nxv32i8 = call <vscale x 32 x i8> @llvm.experimental.vector.splice.nxv32i8(<vscale x 32 x i8> zeroinitializer, <vscale x 32 x i8> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %splice_nxv2i16 = call <vscale x 2 x i16> @llvm.experimental.vector.splice.nxv2i16(<vscale x 2 x i16> zeroinitializer, <vscale x 2 x i16> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %splice_nxv4i16 = call <vscale x 4 x i16> @llvm.experimental.vector.splice.nxv4i16(<vscale x 4 x i16> zeroinitializer, <vscale x 4 x i16> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %splice_nxv8i16 = call <vscale x 8 x i16> @llvm.experimental.vector.splice.nxv8i16(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x i16> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %splice_nxv16i16 = call <vscale x 16 x i16> @llvm.experimental.vector.splice.nxv16i16(<vscale x 16 x i16> zeroinitializer, <vscale x 16 x i16> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %splice_nxv4i32 = call <vscale x 4 x i32> @llvm.experimental.vector.splice.nxv4i32(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %splice_nxv8i32 = call <vscale x 8 x i32> @llvm.experimental.vector.splice.nxv8i32(<vscale x 8 x i32> zeroinitializer, <vscale x 8 x i32> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %splice_nxv2i64 = call <vscale x 2 x i64> @llvm.experimental.vector.splice.nxv2i64(<vscale x 2 x i64> zeroinitializer, <vscale x 2 x i64> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %splice_nxv4i64 = call <vscale x 4 x i64> @llvm.experimental.vector.splice.nxv4i64(<vscale x 4 x i64> zeroinitializer, <vscale x 4 x i64> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %splice_nxv16i1 = call <vscale x 16 x i1> @llvm.experimental.vector.splice.nxv16i1(<vscale x 16 x i1> zeroinitializer, <vscale x 16 x i1> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %splice_nxv8i1 = call <vscale x 8 x i1> @llvm.experimental.vector.splice.nxv8i1(<vscale x 8 x i1> zeroinitializer, <vscale x 8 x i1> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %splice_nxv4i1 = call <vscale x 4 x i1> @llvm.experimental.vector.splice.nxv4i1(<vscale x 4 x i1> zeroinitializer, <vscale x 4 x i1> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %splice_nxv2i1 = call <vscale x 2 x i1> @llvm.experimental.vector.splice.nxv2i1(<vscale x 2 x i1> zeroinitializer, <vscale x 2 x i1> zeroinitializer, i32 1)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %splice_nxv16i8 = call <vscale x 16 x i8> @llvm.experimental.vector.splice.nxv16i8(<vscale x 16 x i8> zeroinitializer, <vscale x 16 x i8> zeroinitializer, i32 1)
  %splice_nxv32i8 = call <vscale x 32 x i8> @llvm.experimental.vector.splice.nxv32i8(<vscale x 32 x i8> zeroinitializer, <vscale x 32 x i8> zeroinitializer, i32 1)
  %splice_nxv2i16 = call <vscale x 2 x i16> @llvm.experimental.vector.splice.nxv2i16(<vscale x 2 x i16> zeroinitializer, <vscale x 2 x i16> zeroinitializer, i32 1)
  %splice_nxv4i16 = call <vscale x 4 x i16> @llvm.experimental.vector.splice.nxv4i16(<vscale x 4 x i16> zeroinitializer, <vscale x 4 x i16> zeroinitializer, i32 1)
  %splice_nxv8i16 = call <vscale x 8 x i16> @llvm.experimental.vector.splice.nxv8i16(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x i16> zeroinitializer, i32 1)
  %splice_nxv16i16 = call <vscale x 16 x i16> @llvm.experimental.vector.splice.nxv16i16(<vscale x 16 x i16> zeroinitializer, <vscale x 16 x i16> zeroinitializer, i32 1)
  %splice_nxv4i32 = call <vscale x 4 x i32> @llvm.experimental.vector.splice.nxv4i32(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> zeroinitializer, i32 1)
  %splice_nxv8i32 = call <vscale x 8 x i32> @llvm.experimental.vector.splice.nxv8i32(<vscale x 8 x i32> zeroinitializer, <vscale x 8 x i32> zeroinitializer, i32 1)
  %splice_nxv2i64 = call <vscale x 2 x i64> @llvm.experimental.vector.splice.nxv2i64(<vscale x 2 x i64> zeroinitializer, <vscale x 2 x i64> zeroinitializer, i32 1)
  %splice_nxv4i64 = call <vscale x 4 x i64> @llvm.experimental.vector.splice.nxv4i64(<vscale x 4 x i64> zeroinitializer, <vscale x 4 x i64> zeroinitializer, i32 1)
  %splice_nxv16i1 = call <vscale x 16 x i1> @llvm.experimental.vector.splice.nxv16i1(<vscale x 16 x i1> zeroinitializer, <vscale x 16 x i1> zeroinitializer, i32 1)
  %splice_nxv8i1 =  call <vscale x 8 x i1> @llvm.experimental.vector.splice.nxv8i1(<vscale x 8 x i1> zeroinitializer, <vscale x 8 x i1> zeroinitializer, i32 1)
  %splice_nxv4i1 = call <vscale x 4 x i1> @llvm.experimental.vector.splice.nxv4i1(<vscale x 4 x i1> zeroinitializer, <vscale x 4 x i1> zeroinitializer, i32 1)
  %splice_nxv2i1 = call <vscale x 2 x i1> @llvm.experimental.vector.splice.nxv2i1(<vscale x 2 x i1> zeroinitializer, <vscale x 2 x i1> zeroinitializer, i32 1)
  ret void
}

declare <vscale x 2 x i1> @llvm.experimental.vector.splice.nxv2i1(<vscale x 2 x i1>, <vscale x 2 x i1>, i32)
declare <vscale x 4 x i1> @llvm.experimental.vector.splice.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, i32)
declare <vscale x 8 x i1> @llvm.experimental.vector.splice.nxv8i1(<vscale x 8 x i1>, <vscale x 8 x i1>, i32)
declare <vscale x 16 x i1> @llvm.experimental.vector.splice.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>, i32)
declare <vscale x 2 x i8> @llvm.experimental.vector.splice.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i8>, i32)
declare <vscale x 16 x i8> @llvm.experimental.vector.splice.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>, i32)
declare <vscale x 32 x i8> @llvm.experimental.vector.splice.nxv32i8(<vscale x 32 x i8>, <vscale x 32 x i8>, i32)
declare <vscale x 2 x i16> @llvm.experimental.vector.splice.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i16>, i32)
declare <vscale x 4 x i16> @llvm.experimental.vector.splice.nxv4i16(<vscale x 4 x i16>, <vscale x 4 x i16>, i32)
declare <vscale x 8 x i16> @llvm.experimental.vector.splice.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>, i32)
declare <vscale x 16 x i16> @llvm.experimental.vector.splice.nxv16i16(<vscale x 16 x i16>, <vscale x 16 x i16>, i32)
declare <vscale x 4 x i32> @llvm.experimental.vector.splice.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>, i32)
declare <vscale x 8 x i32> @llvm.experimental.vector.splice.nxv8i32(<vscale x 8 x i32>, <vscale x 8 x i32>, i32)
declare <vscale x 2 x i64> @llvm.experimental.vector.splice.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>, i32)
declare <vscale x 4 x i64> @llvm.experimental.vector.splice.nxv4i64(<vscale x 4 x i64>, <vscale x 4 x i64>, i32)

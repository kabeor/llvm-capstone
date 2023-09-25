; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=riscv32 -mattr=+v -interleaved-access -S | FileCheck %s --check-prefix=RV32
; RUN: opt < %s -mtriple=riscv64 -mattr=+v -interleaved-access -S | FileCheck %s --check-prefix=RV64

define void @load_factor2(ptr %ptr) {
; RV32-LABEL: @load_factor2(
; RV32-NEXT:    [[TMP1:%.*]] = call { <8 x i32>, <8 x i32> } @llvm.riscv.seg2.load.v8i32.p0.i32(ptr [[PTR:%.*]], i32 8)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <8 x i32>, <8 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <8 x i32>, <8 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor2(
; RV64-NEXT:    [[TMP1:%.*]] = call { <8 x i32>, <8 x i32> } @llvm.riscv.seg2.load.v8i32.p0.i64(ptr [[PTR:%.*]], i64 8)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <8 x i32>, <8 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <8 x i32>, <8 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <16 x i32>, ptr %ptr
  %v0 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %v1 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  ret void
}

define void @load_factor3(ptr %ptr) {
; RV32-LABEL: @load_factor3(
; RV32-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg3.load.v4i32.p0.i32(ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor3(
; RV64-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg3.load.v4i32.p0.i64(ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <12 x i32>, ptr %ptr
  %v0 = shufflevector <12 x i32> %interleaved.vec, <12 x i32> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %v1 = shufflevector <12 x i32> %interleaved.vec, <12 x i32> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %v2 = shufflevector <12 x i32> %interleaved.vec, <12 x i32> poison, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  ret void
}

define void @load_factor4(ptr %ptr) {
; RV32-LABEL: @load_factor4(
; RV32-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg4.load.v4i32.p0.i32(ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV32-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor4(
; RV64-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg4.load.v4i32.p0.i64(ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV64-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <16 x i32>, ptr %ptr
  %v0 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %v1 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %v2 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %v3 = shufflevector <16 x i32> %interleaved.vec, <16 x i32> poison, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  ret void
}

define void @load_factor5(ptr %ptr) {
; RV32-LABEL: @load_factor5(
; RV32-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg5.load.v4i32.p0.i32(ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV32-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV32-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor5(
; RV64-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg5.load.v4i32.p0.i64(ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV64-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <20 x i32>, ptr %ptr
  %v0 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 0, i32 5, i32 10, i32 15>
  %v1 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 1, i32 6, i32 11, i32 16>
  %v2 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 2, i32 7, i32 12, i32 17>
  %v3 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 3, i32 8, i32 13, i32 18>
  %v4 = shufflevector <20 x i32> %interleaved.vec, <20 x i32> poison, <4 x i32> <i32 4, i32 9, i32 14, i32 19>
  ret void
}

define void @load_factor6(ptr %ptr) {
; RV32-LABEL: @load_factor6(
; RV32-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg6.load.v4i32.p0.i32(ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 5
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV32-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV32-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV32-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor6(
; RV64-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg6.load.v4i32.p0.i64(ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 5
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV64-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV64-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <24 x i32>, ptr %ptr
  %v0 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 0, i32 6, i32 12, i32 18>
  %v1 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 1, i32 7, i32 13, i32 19>
  %v2 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 2, i32 8, i32 14, i32 20>
  %v3 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 3, i32 9, i32 15, i32 21>
  %v4 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 4, i32 10, i32 16, i32 22>
  %v5 = shufflevector <24 x i32> %interleaved.vec, <24 x i32> poison, <4 x i32> <i32 5, i32 11, i32 17, i32 23>
  ret void
}

define void @load_factor7(ptr %ptr) {
; RV32-LABEL: @load_factor7(
; RV32-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg7.load.v4i32.p0.i32(ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 6
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 5
; RV32-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV32-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV32-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV32-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP8:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor7(
; RV64-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg7.load.v4i32.p0.i64(ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 6
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 5
; RV64-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV64-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <28 x i32>, ptr %ptr
  %v0 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 0, i32 7, i32 14, i32 21>
  %v1 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 1, i32 8, i32 15, i32 22>
  %v2 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 2, i32 9, i32 16, i32 23>
  %v3 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 3, i32 10, i32 17, i32 24>
  %v4 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 4, i32 11, i32 18, i32 25>
  %v5 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 5, i32 12, i32 19, i32 26>
  %v6 = shufflevector <28 x i32> %interleaved.vec, <28 x i32> poison, <4 x i32> <i32 6, i32 13, i32 20, i32 27>
  ret void
}

define void @load_factor8(ptr %ptr) {
; RV32-LABEL: @load_factor8(
; RV32-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg8.load.v4i32.p0.i32(ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 7
; RV32-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 6
; RV32-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 5
; RV32-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV32-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV32-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV32-NEXT:    [[TMP8:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV32-NEXT:    [[TMP9:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor8(
; RV64-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } @llvm.riscv.seg8.load.v4i32.p0.i64(ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 7
; RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 6
; RV64-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 5
; RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 4
; RV64-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 3
; RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 2
; RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 1
; RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32> } [[TMP1]], 0
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <32 x i32>, ptr %ptr
  %v0 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 0, i32 8, i32 16, i32 24>
  %v1 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 1, i32 9, i32 17, i32 25>
  %v2 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 2, i32 10, i32 18, i32 26>
  %v3 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 3, i32 11, i32 19, i32 27>
  %v4 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 4, i32 12, i32 20, i32 28>
  %v5 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 5, i32 13, i32 21, i32 29>
  %v6 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 6, i32 14, i32 22, i32 30>
  %v7 = shufflevector <32 x i32> %interleaved.vec, <32 x i32> poison, <4 x i32> <i32 7, i32 15, i32 23, i32 31>
  ret void
}


define void @store_factor2(ptr %ptr, <8 x i8> %v0, <8 x i8> %v1) {
; RV32-LABEL: @store_factor2(
; RV32-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i8> [[V0:%.*]], <8 x i8> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i8> [[V0]], <8 x i8> [[V1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    call void @llvm.riscv.seg2.store.v8i8.p0.i32(<8 x i8> [[TMP1]], <8 x i8> [[TMP2]], ptr [[PTR:%.*]], i32 8)
; RV32-NEXT:    ret void
;
; RV64-LABEL: @store_factor2(
; RV64-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i8> [[V0:%.*]], <8 x i8> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i8> [[V0]], <8 x i8> [[V1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    call void @llvm.riscv.seg2.store.v8i8.p0.i64(<8 x i8> [[TMP1]], <8 x i8> [[TMP2]], ptr [[PTR:%.*]], i64 8)
; RV64-NEXT:    ret void
;
  %interleaved.vec = shufflevector <8 x i8> %v0, <8 x i8> %v1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  store <16 x i8> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor3(ptr %ptr, <4 x i32> %v0, <4 x i32> %v1, <4 x i32> %v2) {
; RV32-LABEL: @store_factor3(
; RV32-NEXT:    [[S0:%.*]] = shufflevector <4 x i32> [[V0:%.*]], <4 x i32> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[S1:%.*]] = shufflevector <4 x i32> [[V2:%.*]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; RV32-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; RV32-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 8, i32 9, i32 10, i32 11>
; RV32-NEXT:    call void @llvm.riscv.seg3.store.v4i32.p0.i32(<4 x i32> [[TMP1]], <4 x i32> [[TMP2]], <4 x i32> [[TMP3]], ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    ret void
;
; RV64-LABEL: @store_factor3(
; RV64-NEXT:    [[S0:%.*]] = shufflevector <4 x i32> [[V0:%.*]], <4 x i32> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[S1:%.*]] = shufflevector <4 x i32> [[V2:%.*]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; RV64-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; RV64-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 8, i32 9, i32 10, i32 11>
; RV64-NEXT:    call void @llvm.riscv.seg3.store.v4i32.p0.i64(<4 x i32> [[TMP1]], <4 x i32> [[TMP2]], <4 x i32> [[TMP3]], ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    ret void
;
  %s0 = shufflevector <4 x i32> %v0, <4 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s1 = shufflevector <4 x i32> %v2, <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
  %interleaved.vec = shufflevector <8 x i32> %s0, <8 x i32> %s1, <12 x i32> <i32 0, i32 4, i32 8, i32 1, i32 5, i32 9, i32 2, i32 6, i32 10, i32 3, i32 7, i32 11>
  store <12 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor4(ptr %ptr, <4 x i32> %v0, <4 x i32> %v1, <4 x i32> %v2, <4 x i32> %v3) {
; RV32-LABEL: @store_factor4(
; RV32-NEXT:    [[S0:%.*]] = shufflevector <4 x i32> [[V0:%.*]], <4 x i32> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[S1:%.*]] = shufflevector <4 x i32> [[V2:%.*]], <4 x i32> [[V3:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; RV32-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 8, i32 9, i32 10, i32 11>
; RV32-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    call void @llvm.riscv.seg4.store.v4i32.p0.i32(<4 x i32> [[TMP1]], <4 x i32> [[TMP2]], <4 x i32> [[TMP3]], <4 x i32> [[TMP4]], ptr [[PTR:%.*]], i32 4)
; RV32-NEXT:    ret void
;
; RV64-LABEL: @store_factor4(
; RV64-NEXT:    [[S0:%.*]] = shufflevector <4 x i32> [[V0:%.*]], <4 x i32> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[S1:%.*]] = shufflevector <4 x i32> [[V2:%.*]], <4 x i32> [[V3:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; RV64-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 8, i32 9, i32 10, i32 11>
; RV64-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[S0]], <8 x i32> [[S1]], <4 x i32> <i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    call void @llvm.riscv.seg4.store.v4i32.p0.i64(<4 x i32> [[TMP1]], <4 x i32> [[TMP2]], <4 x i32> [[TMP3]], <4 x i32> [[TMP4]], ptr [[PTR:%.*]], i64 4)
; RV64-NEXT:    ret void
;
  %s0 = shufflevector <4 x i32> %v0, <4 x i32> %v1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s1 = shufflevector <4 x i32> %v2, <4 x i32> %v3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %interleaved.vec = shufflevector <8 x i32> %s0, <8 x i32> %s1, <16 x i32> <i32 0, i32 4, i32 8, i32 12, i32 1, i32 5, i32 9, i32 13, i32 2, i32 6, i32 10, i32 14, i32 3, i32 7, i32 11, i32 15>
  store <16 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}


define void @store_factor2_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1) {
; RV32-LABEL: @store_factor2_wide(
; RV32-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[V0:%.*]], <8 x i32> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[V0]], <8 x i32> [[V1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    call void @llvm.riscv.seg2.store.v8i32.p0.i32(<8 x i32> [[TMP1]], <8 x i32> [[TMP2]], ptr [[PTR:%.*]], i32 8)
; RV32-NEXT:    ret void
;
; RV64-LABEL: @store_factor2_wide(
; RV64-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[V0:%.*]], <8 x i32> [[V1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[V0]], <8 x i32> [[V1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    call void @llvm.riscv.seg2.store.v8i32.p0.i64(<8 x i32> [[TMP1]], <8 x i32> [[TMP2]], ptr [[PTR:%.*]], i64 8)
; RV64-NEXT:    ret void
;
  %interleaved.vec = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  store <16 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor3_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1, <8 x i32> %v2) {
; RV32-LABEL: @store_factor3_wide(
; RV32-NEXT:    [[S0:%.*]] = shufflevector <8 x i32> [[V0:%.*]], <8 x i32> [[V1:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    [[S1:%.*]] = shufflevector <8 x i32> [[V2:%.*]], <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; RV32-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    [[TMP3:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; RV32-NEXT:    call void @llvm.riscv.seg3.store.v8i32.p0.i32(<8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], ptr [[PTR:%.*]], i32 8)
; RV32-NEXT:    ret void
;
; RV64-LABEL: @store_factor3_wide(
; RV64-NEXT:    [[S0:%.*]] = shufflevector <8 x i32> [[V0:%.*]], <8 x i32> [[V1:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    [[S1:%.*]] = shufflevector <8 x i32> [[V2:%.*]], <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; RV64-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    [[TMP3:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; RV64-NEXT:    call void @llvm.riscv.seg3.store.v8i32.p0.i64(<8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], ptr [[PTR:%.*]], i64 8)
; RV64-NEXT:    ret void
;
  %s0 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %s1 = shufflevector <8 x i32> %v2, <8 x i32> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %interleaved.vec = shufflevector <16 x i32> %s0, <16 x i32> %s1, <24 x i32> <i32 0, i32 8, i32 16, i32 1, i32 9, i32 17, i32 2, i32 10, i32 18, i32 3, i32 11, i32 19, i32 4, i32 12, i32 20, i32 5, i32 13, i32 21, i32 6, i32 14, i32 22, i32 7, i32 15, i32 23>
  store <24 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @store_factor4_wide(ptr %ptr, <8 x i32> %v0, <8 x i32> %v1, <8 x i32> %v2, <8 x i32> %v3) {
; RV32-LABEL: @store_factor4_wide(
; RV32-NEXT:    [[S0:%.*]] = shufflevector <8 x i32> [[V0:%.*]], <8 x i32> [[V1:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    [[S1:%.*]] = shufflevector <8 x i32> [[V2:%.*]], <8 x i32> [[V3:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV32-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV32-NEXT:    [[TMP3:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; RV32-NEXT:    [[TMP4:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
; RV32-NEXT:    call void @llvm.riscv.seg4.store.v8i32.p0.i32(<8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> [[TMP4]], ptr [[PTR:%.*]], i32 8)
; RV32-NEXT:    ret void
;
; RV64-LABEL: @store_factor4_wide(
; RV64-NEXT:    [[S0:%.*]] = shufflevector <8 x i32> [[V0:%.*]], <8 x i32> [[V1:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    [[S1:%.*]] = shufflevector <8 x i32> [[V2:%.*]], <8 x i32> [[V3:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; RV64-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; RV64-NEXT:    [[TMP3:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; RV64-NEXT:    [[TMP4:%.*]] = shufflevector <16 x i32> [[S0]], <16 x i32> [[S1]], <8 x i32> <i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
; RV64-NEXT:    call void @llvm.riscv.seg4.store.v8i32.p0.i64(<8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> [[TMP4]], ptr [[PTR:%.*]], i64 8)
; RV64-NEXT:    ret void
;
  %s0 = shufflevector <8 x i32> %v0, <8 x i32> %v1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %s1 = shufflevector <8 x i32> %v2, <8 x i32> %v3, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i32> %s0, <16 x i32> %s1, <32 x i32> <i32 0, i32 8, i32 16, i32 24, i32 1, i32 9, i32 17, i32 25, i32 2, i32 10, i32 18, i32 26, i32 3, i32 11, i32 19, i32 27, i32 4, i32 12, i32 20, i32 28, i32 5, i32 13, i32 21, i32 29, i32 6, i32 14, i32 22, i32 30, i32 7, i32 15, i32 23, i32 31>
  store <32 x i32> %interleaved.vec, ptr %ptr, align 4
  ret void
}

define void @load_factor2_fp128(ptr %ptr) {
; RV32-LABEL: @load_factor2_fp128(
; RV32-NEXT:    [[INTERLEAVED_VEC:%.*]] = load <4 x fp128>, ptr [[PTR:%.*]], align 16
; RV32-NEXT:    [[V0:%.*]] = shufflevector <4 x fp128> [[INTERLEAVED_VEC]], <4 x fp128> poison, <2 x i32> <i32 0, i32 2>
; RV32-NEXT:    [[V1:%.*]] = shufflevector <4 x fp128> [[INTERLEAVED_VEC]], <4 x fp128> poison, <2 x i32> <i32 1, i32 3>
; RV32-NEXT:    ret void
;
; RV64-LABEL: @load_factor2_fp128(
; RV64-NEXT:    [[INTERLEAVED_VEC:%.*]] = load <4 x fp128>, ptr [[PTR:%.*]], align 16
; RV64-NEXT:    [[V0:%.*]] = shufflevector <4 x fp128> [[INTERLEAVED_VEC]], <4 x fp128> poison, <2 x i32> <i32 0, i32 2>
; RV64-NEXT:    [[V1:%.*]] = shufflevector <4 x fp128> [[INTERLEAVED_VEC]], <4 x fp128> poison, <2 x i32> <i32 1, i32 3>
; RV64-NEXT:    ret void
;
  %interleaved.vec = load <4 x fp128>, ptr %ptr, align 16
  %v0 = shufflevector <4 x fp128> %interleaved.vec, <4 x fp128> poison, <2 x i32> <i32 0, i32 2>
  %v1 = shufflevector <4 x fp128> %interleaved.vec, <4 x fp128> poison, <2 x i32> <i32 1, i32 3>
  ret void
}













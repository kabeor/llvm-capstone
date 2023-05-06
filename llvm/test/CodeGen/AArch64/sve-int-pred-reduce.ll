; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; ANDV

define i1 @reduce_and_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_and_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.b
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.and.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_and_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_and_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.and.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_and_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_and_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.and.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_and_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_and_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.and.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_and_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_and_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p2.h, p1.b
; CHECK-NEXT:    eor p0.b, p1/z, p0.b, p2.b
; CHECK-NEXT:    ptest p2, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.and.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

; ORV

define i1 @reduce_or_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_or_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptest p0, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.or.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_or_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_or_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.or.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_or_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_or_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.or.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_or_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_or_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.or.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_or_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_or_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p1.h, p1.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.or.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

; XORV

define i1 @reduce_xor_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_xor_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.b
; CHECK-NEXT:    cntp x8, p1, p0.b
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.xor.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_xor_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_xor_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    cntp x8, p1, p0.h
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.xor.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_xor_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_xor_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    cntp x8, p1, p0.s
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.xor.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_xor_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_xor_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    cntp x8, p1, p0.d
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.xor.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_xor_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_xor_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p1.h, p1.b
; CHECK-NEXT:    cntp x8, p1, p0.d
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.xor.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

; SMAXV

define i1 @reduce_smax_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_smax_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.b
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smax.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smax_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_smax_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smax.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smax_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_smax_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smax.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smax_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_smax_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smax.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smax_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_smax_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p2.h, p1.b
; CHECK-NEXT:    eor p0.b, p1/z, p0.b, p2.b
; CHECK-NEXT:    ptest p2, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smax.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

; SMINV

define i1 @reduce_smin_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_smin_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptest p0, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smin.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smin_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_smin_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smin.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smin_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_smin_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smin.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smin_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_smin_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smin.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_smin_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_smin_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p1.h, p1.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.smin.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

; UMAXV

define i1 @reduce_umax_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_umax_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptest p0, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umax.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umax_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_umax_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umax.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umax_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_umax_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umax.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umax_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_umax_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umax.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umax_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_umax_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p1.h, p1.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umax.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

; UMINV

define i1 @reduce_umin_nxv16i1(<vscale x 16 x i1> %vec) {
; CHECK-LABEL: reduce_umin_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.b
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umin.i1.nxv16i1(<vscale x 16 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umin_nxv8i1(<vscale x 8 x i1> %vec) {
; CHECK-LABEL: reduce_umin_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umin.i1.nxv8i1(<vscale x 8 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umin_nxv4i1(<vscale x 4 x i1> %vec) {
; CHECK-LABEL: reduce_umin_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umin.i1.nxv4i1(<vscale x 4 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umin_nxv1i1(<vscale x 1 x i1> %vec) {
; CHECK-LABEL: reduce_umin_nxv1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p2.h, p1.b
; CHECK-NEXT:    eor p0.b, p1/z, p0.b, p2.b
; CHECK-NEXT:    ptest p2, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umin.i1.nxv1i1(<vscale x 1 x i1> %vec)
  ret i1 %res
}

define i1 @reduce_umin_nxv2i1(<vscale x 2 x i1> %vec) {
; CHECK-LABEL: reduce_umin_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    nots p0.b, p1/z, p0.b
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %res = call i1 @llvm.vector.reduce.umin.i1.nxv2i1(<vscale x 2 x i1> %vec)
  ret i1 %res
}

declare i1 @llvm.vector.reduce.and.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.and.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.and.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.and.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.and.i1.nxv1i1(<vscale x 1 x i1> %vec)

declare i1 @llvm.vector.reduce.or.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.or.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.or.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.or.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.or.i1.nxv1i1(<vscale x 1 x i1> %vec)

declare i1 @llvm.vector.reduce.xor.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.xor.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.xor.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.xor.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.xor.i1.nxv1i1(<vscale x 1 x i1> %vec)

declare i1 @llvm.vector.reduce.smin.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.smin.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.smin.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.smin.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.smin.i1.nxv1i1(<vscale x 1 x i1> %vec)

declare i1 @llvm.vector.reduce.smax.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.smax.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.smax.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.smax.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.smax.i1.nxv1i1(<vscale x 1 x i1> %vec)

declare i1 @llvm.vector.reduce.umin.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.umin.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.umin.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.umin.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.umin.i1.nxv1i1(<vscale x 1 x i1> %vec)

declare i1 @llvm.vector.reduce.umax.i1.nxv16i1(<vscale x 16 x i1> %vec)
declare i1 @llvm.vector.reduce.umax.i1.nxv8i1(<vscale x 8 x i1> %vec)
declare i1 @llvm.vector.reduce.umax.i1.nxv4i1(<vscale x 4 x i1> %vec)
declare i1 @llvm.vector.reduce.umax.i1.nxv2i1(<vscale x 2 x i1> %vec)
declare i1 @llvm.vector.reduce.umax.i1.nxv1i1(<vscale x 1 x i1> %vec)

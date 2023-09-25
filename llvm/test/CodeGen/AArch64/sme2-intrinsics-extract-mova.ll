; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -verify-machineinstrs < %s | FileCheck %s

;
; Move Multi-Vector From Tile (Read) x2
;

; Horizontal

define { <vscale x 16 x i8>, <vscale x 16 x i8> } @za_read_horiz_vg2_b(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.b, z1.b }, za0h.b[w12, 0:1]
; CHECK-NEXT:    mov { z0.b, z1.b }, za0h.b[w12, 14:15]
; CHECK-NEXT:    ret
  %res = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.hor.vg2.nxv16i8(i32 0, i32 %slice)
  %slice.14 = add i32 %slice, 14
  %res2 = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.hor.vg2.nxv16i8(i32 0, i32 %slice.14)
  ret { <vscale x 16 x i8>, <vscale x 16 x i8> } %res2
}

define { <vscale x 8 x i16>, <vscale x 8 x i16> } @za_read_horiz_vg2_h(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h, z1.h }, za0h.h[w12, 0:1]
; CHECK-NEXT:    mov { z0.h, z1.h }, za1h.h[w12, 6:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.hor.vg2.nxv8i16(i32 0, i32 %slice)
  %slice.6 = add i32 %slice, 6
  %res2 = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.hor.vg2.nxv8i16(i32 1, i32 %slice.6)
  ret { <vscale x 8 x i16>, <vscale x 8 x i16> } %res2
}

define { <vscale x 8 x half>, <vscale x 8 x half> } @za_read_horiz_vg2_f16(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h, z1.h }, za0h.h[w12, 0:1]
; CHECK-NEXT:    mov { z0.h, z1.h }, za1h.h[w12, 6:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.hor.vg2.nxv8f16(i32 0, i32 %slice)
  %slice.6 = add i32 %slice, 6
  %res2 = call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.hor.vg2.nxv8f16(i32 1, i32 %slice.6)
  ret { <vscale x 8 x half>, <vscale x 8 x half> } %res2
}

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @za_read_horiz_vg2_bf16(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h, z1.h }, za0h.h[w12, 0:1]
; CHECK-NEXT:    mov { z0.h, z1.h }, za1h.h[w12, 6:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.hor.vg2.nxv8bf16(i32 0, i32 %slice)
  %slice.6 = add i32 %slice, 6
  %res2 = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.hor.vg2.nxv8bf16(i32 1, i32 %slice.6)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res2
}

define { <vscale x 4 x i32>, <vscale x 4 x i32> } @za_read_horiz_vg2_s(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s, z1.s }, za0h.s[w12, 0:1]
; CHECK-NEXT:    mov { z0.s, z1.s }, za3h.s[w12, 2:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.hor.vg2.nxv4i32(i32 0, i32 %slice)
  %slice.2 = add i32 %slice, 2
  %res2 = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.hor.vg2.nxv4i32(i32 3, i32 %slice.2)
  ret { <vscale x 4 x i32>, <vscale x 4 x i32> } %res2
}

define { <vscale x 4 x float>, <vscale x 4 x float> } @za_read_horiz_vg2_f32(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s, z1.s }, za0h.s[w12, 0:1]
; CHECK-NEXT:    mov { z0.s, z1.s }, za3h.s[w12, 2:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.hor.vg2.nxv4f32(i32 0, i32 %slice)
  %slice.2 = add i32 %slice, 2
  %res2 = call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.hor.vg2.nxv4f32(i32 3, i32 %slice.2)
  ret { <vscale x 4 x float>, <vscale x 4 x float> } %res2
}

define { <vscale x 2 x i64>, <vscale x 2 x i64> } @za_read_horiz_vg2_d(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d, z1.d }, za0h.d[w12, 0:1]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.hor.vg2.nxv2i64(i32 0, i32 %slice)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64> } %res
}

define { <vscale x 2 x double>, <vscale x 2 x double> } @za_read_horiz_vg2_f64(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg2_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d, z1.d }, za0h.d[w12, 0:1]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.hor.vg2.nxv2f64(i32 0, i32 %slice)
  ret { <vscale x 2 x double>, <vscale x 2 x double> } %res
}

; Vertical

define { <vscale x 16 x i8>, <vscale x 16 x i8> } @za_read_vert_vg2_b(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.b, z1.b }, za0v.b[w12, 0:1]
; CHECK-NEXT:    mov { z0.b, z1.b }, za0v.b[w12, 14:15]
; CHECK-NEXT:    ret
  %res = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.ver.vg2.nxv16i8(i32 0, i32 %slice)
  %slice.14 = add i32 %slice, 14
  %res2 = call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.ver.vg2.nxv16i8(i32 0, i32 %slice.14)
  ret { <vscale x 16 x i8>, <vscale x 16 x i8> } %res2
}

define { <vscale x 8 x i16>, <vscale x 8 x i16> } @za_read_vert_vg2_h(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h, z1.h }, za0v.h[w12, 0:1]
; CHECK-NEXT:    mov { z0.h, z1.h }, za1v.h[w12, 6:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.ver.vg2.nxv8i16(i32 0, i32 %slice)
  %slice.6 = add i32 %slice, 6
  %res2 = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.ver.vg2.nxv8i16(i32 1, i32 %slice.6)
  ret { <vscale x 8 x i16>, <vscale x 8 x i16> } %res2
}

define { <vscale x 8 x half>, <vscale x 8 x half> } @za_read_vert_vg2_f16(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h, z1.h }, za0v.h[w12, 0:1]
; CHECK-NEXT:    mov { z0.h, z1.h }, za1v.h[w12, 6:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.ver.vg2.nxv8f16(i32 0, i32 %slice)
  %slice.6 = add i32 %slice, 6
  %res2 = call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.ver.vg2.nxv8f16(i32 1, i32 %slice.6)
  ret { <vscale x 8 x half>, <vscale x 8 x half> } %res2
}

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @za_read_vert_vg2_bf16(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h, z1.h }, za0v.h[w12, 0:1]
; CHECK-NEXT:    mov { z0.h, z1.h }, za1v.h[w12, 6:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.ver.vg2.nxv8bf16(i32 0, i32 %slice)
  %slice.6 = add i32 %slice, 6
  %res2 = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.ver.vg2.nxv8bf16(i32 1, i32 %slice.6)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res2
}

define { <vscale x 4 x i32>, <vscale x 4 x i32> } @za_read_vert_vg2_s(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s, z1.s }, za0v.s[w12, 0:1]
; CHECK-NEXT:    mov { z0.s, z1.s }, za3v.s[w12, 2:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.ver.vg2.nxv4i32(i32 0, i32 %slice)
  %slice.2 = add i32 %slice, 2
  %res2 = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.ver.vg2.nxv4i32(i32 3, i32 %slice.2)
  ret { <vscale x 4 x i32>, <vscale x 4 x i32> } %res2
}

define { <vscale x 4 x float>, <vscale x 4 x float> } @za_read_vert_vg2_f32(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s, z1.s }, za0v.s[w12, 0:1]
; CHECK-NEXT:    mov { z0.s, z1.s }, za3v.s[w12, 2:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.ver.vg2.nxv4f32(i32 0, i32 %slice)
  %slice.2 = add i32 %slice, 2
  %res2 = call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.ver.vg2.nxv4f32(i32 3, i32 %slice.2)
  ret { <vscale x 4 x float>, <vscale x 4 x float> } %res2
}

define { <vscale x 2 x i64>, <vscale x 2 x i64> } @za_read_vert_vg2_d(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d, z1.d }, za0v.d[w12, 0:1]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.ver.vg2.nxv2i64(i32 0, i32 %slice)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64> } %res
}

define { <vscale x 2 x double>, <vscale x 2 x double> } @za_read_vert_vg2_f64(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg2_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d, z1.d }, za0v.d[w12, 0:1]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.ver.vg2.nxv2f64(i32 0, i32 %slice)
  ret { <vscale x 2 x double>, <vscale x 2 x double> } %res
}

;
; Move Multi-Vector From Tile (Read) x4
;

; Horizontal

define { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @za_read_horiz_vg4_b(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.b - z3.b }, za0h.b[w12, 0:3]
; CHECK-NEXT:    mov { z0.b - z3.b }, za0h.b[w12, 12:15]
; CHECK-NEXT:    ret
  %res = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.hor.vg4.nxv16i8(i32 0, i32 %slice)
  %slice.12 = add i32 %slice, 12
  %res2 = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.hor.vg4.nxv16i8(i32 0, i32 %slice.12)
  ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %res2
}

define { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @za_read_horiz_vg4_h(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h - z3.h }, za0h.h[w12, 0:3]
; CHECK-NEXT:    mov { z0.h - z3.h }, za1h.h[w12, 4:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.hor.vg4.nxv8i16(i32 0, i32 %slice)
  %slice.4 = add i32 %slice, 4
  %res2 = call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.hor.vg4.nxv8i16(i32 1, i32 %slice.4)
  ret { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } %res2
}

define { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @za_read_horiz_vg4_f16(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h - z3.h }, za0h.h[w12, 0:3]
; CHECK-NEXT:    mov { z0.h - z3.h }, za1h.h[w12, 4:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.hor.vg4.nxv8f16(i32 0, i32 %slice)
  %slice.4 = add i32 %slice, 4
  %res2 = call { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.hor.vg4.nxv8f16(i32 1, i32 %slice.4)
  ret { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } %res2
}

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @za_read_horiz_vg4_bf16(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h - z3.h }, za0h.h[w12, 0:3]
; CHECK-NEXT:    mov { z0.h - z3.h }, za1h.h[w12, 4:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.hor.vg4.nxv8bf16(i32 0, i32 %slice)
  %slice.4 = add i32 %slice, 4
  %res2 = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.hor.vg4.nxv8bf16(i32 1, i32 %slice.4)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res2
}

define { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @za_read_horiz_vg4_s(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s - z3.s }, za0h.s[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.hor.vg4.nxv4i32(i32 0, i32 %slice)
  ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %res
}

define { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @za_read_horiz_vg4_f32(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s - z3.s }, za0h.s[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.hor.vg4.nxv4f32(i32 0, i32 %slice)
  ret { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } %res
}

define { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @za_read_horiz_vg4_d(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d - z3.d }, za0h.d[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.hor.vg4.nxv2i64(i32 0, i32 %slice)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %res
}

define { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @za_read_horiz_vg4_f64(i32 %slice) {
; CHECK-LABEL: za_read_horiz_vg4_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d - z3.d }, za0h.d[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.hor.vg4.nxv2f64(i32 0, i32 %slice)
  ret { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } %res
}

; Vertical

define { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @za_read_vert_vg4_b(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.b - z3.b }, za0v.b[w12, 0:3]
; CHECK-NEXT:    mov { z0.b - z3.b }, za0v.b[w12, 12:15]
; CHECK-NEXT:    ret
  %res = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.ver.vg4.nxv16i8(i32 0, i32 %slice)
  %slice.12 = add i32 %slice, 12
  %res2 = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.ver.vg4.nxv16i8(i32 0, i32 %slice.12)
  ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } %res2
}

define { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @za_read_vert_vg4_h(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h - z3.h }, za0v.h[w12, 0:3]
; CHECK-NEXT:    mov { z0.h - z3.h }, za1v.h[w12, 4:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.ver.vg4.nxv8i16(i32 0, i32 %slice)
  %slice.4 = add i32 %slice, 4
  %res2 = call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.ver.vg4.nxv8i16(i32 1, i32 %slice.4)
  ret { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } %res2
}

define { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @za_read_vert_vg4_f16(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h - z3.h }, za0v.h[w12, 0:3]
; CHECK-NEXT:    mov { z0.h - z3.h }, za1v.h[w12, 4:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.ver.vg4.nxv8f16(i32 0, i32 %slice)
  %slice.4 = add i32 %slice, 4
  %res2 = call { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.ver.vg4.nxv8f16(i32 1, i32 %slice.4)
  ret { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } %res2
}

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @za_read_vert_vg4_bf16(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.h - z3.h }, za0v.h[w12, 0:3]
; CHECK-NEXT:    mov { z0.h - z3.h }, za1v.h[w12, 4:7]
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.ver.vg4.nxv8bf16(i32 0, i32 %slice)
  %slice.4 = add i32 %slice, 4
  %res2 = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.ver.vg4.nxv8bf16(i32 1, i32 %slice.4)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res2
}

define { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @za_read_vert_vg4_s(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s - z3.s }, za0v.s[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.ver.vg4.nxv4i32(i32 0, i32 %slice)
  ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %res
}

define { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @za_read_vert_vg4_f32(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.s - z3.s }, za0v.s[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.ver.vg4.nxv4f32(i32 0, i32 %slice)
  ret { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } %res
}

define { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @za_read_vert_vg4_d(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d - z3.d }, za0v.d[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.ver.vg4.nxv2i64(i32 0, i32 %slice)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %res
}

define { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @za_read_vert_vg4_f64(i32 %slice) {
; CHECK-LABEL: za_read_vert_vg4_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov { z0.d - z3.d }, za0v.d[w12, 0:3]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.ver.vg4.nxv2f64(i32 0, i32 %slice)
  ret { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } %res
}

; Move Multi-Vector From ZA (Read) x2

define { <vscale x 2 x i64>, <vscale x 2 x i64> } @za_read_vg1x2_d(i32 %slice) {
; CHECK-LABEL: za_read_vg1x2_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    mov { z0.d, z1.d }, za.d[w8, 0, vgx2]
; CHECK-NEXT:    mov { z0.d, z1.d }, za.d[w8, 7, vgx2]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.vg1x2.nxv2i64(i32 %slice)
  %slice.7 = add i32 %slice, 7
  %res2 = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.vg1x2.nxv2i64(i32 %slice.7)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64> } %res2
}

define { <vscale x 2 x double>, <vscale x 2 x double> } @za_read_vg1x2_f64(i32 %slice) {
; CHECK-LABEL: za_read_vg1x2_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    mov { z0.d, z1.d }, za.d[w8, 0, vgx2]
; CHECK-NEXT:    mov { z0.d, z1.d }, za.d[w8, 7, vgx2]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.vg1x2.nxv2f64(i32 %slice)
  %slice.7 = add i32 %slice, 7
  %res2 = call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.vg1x2.nxv2f64(i32 %slice.7)
  ret { <vscale x 2 x double>, <vscale x 2 x double> } %res2
}

; Move Multi-Vector From ZA (Read) x4

define { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @za_read_vg1x4_d(i32 %slice) {
; CHECK-LABEL: za_read_vg1x4_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    mov { z0.d - z3.d }, za.d[w8, 0, vgx4]
; CHECK-NEXT:    mov { z0.d - z3.d }, za.d[w8, 7, vgx4]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.vg1x4.nxv2i64(i32 %slice)
  %slice.7 = add i32 %slice, 7
  %res2 = call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.vg1x4.nxv2i64(i32 %slice.7)
  ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } %res2
}

define { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @za_read_vg1x4_f64(i32 %slice) {
; CHECK-LABEL: za_read_vg1x4_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    mov { z0.d - z3.d }, za.d[w8, 0, vgx4]
; CHECK-NEXT:    mov { z0.d - z3.d }, za.d[w8, 7, vgx4]
; CHECK-NEXT:    ret
  %res = call { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.vg1x4.nxv2f64(i32 %slice)
  %slice.7 = add i32 %slice, 7
  %res2 = call { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.vg1x4.nxv2f64(i32 %slice.7)
  ret { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } %res2
}

declare { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.hor.vg2.nxv16i8(i32, i32)
declare { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.hor.vg2.nxv8i16(i32, i32)
declare { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.hor.vg2.nxv8f16(i32, i32)
declare { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.hor.vg2.nxv8bf16(i32, i32)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.hor.vg2.nxv4i32(i32, i32)
declare { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.hor.vg2.nxv4f32(i32, i32)
declare { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.hor.vg2.nxv2i64(i32, i32)
declare { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.hor.vg2.nxv2f64(i32, i32)

declare { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.hor.vg4.nxv16i8(i32, i32)
declare { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.hor.vg4.nxv8i16(i32, i32)
declare { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.hor.vg4.nxv8f16(i32, i32)
declare { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.hor.vg4.nxv8bf16(i32, i32)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.hor.vg4.nxv4i32(i32, i32)
declare { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.hor.vg4.nxv4f32(i32, i32)
declare { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.hor.vg4.nxv2i64(i32, i32)
declare { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.hor.vg4.nxv2f64(i32, i32)

declare { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.ver.vg2.nxv16i8(i32, i32)
declare { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.ver.vg2.nxv8i16(i32, i32)
declare { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.ver.vg2.nxv8f16(i32, i32)
declare { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.ver.vg2.nxv8bf16(i32, i32)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.ver.vg2.nxv4i32(i32, i32)
declare { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.ver.vg2.nxv4f32(i32, i32)
declare { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.ver.vg2.nxv2i64(i32, i32)
declare { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.ver.vg2.nxv2f64(i32, i32)

declare { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.read.ver.vg4.nxv16i8(i32, i32)
declare { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.read.ver.vg4.nxv8i16(i32, i32)
declare { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.read.ver.vg4.nxv8f16(i32, i32)
declare { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.read.ver.vg4.nxv8bf16(i32, i32)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.read.ver.vg4.nxv4i32(i32, i32)
declare { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.read.ver.vg4.nxv4f32(i32, i32)
declare { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.ver.vg4.nxv2i64(i32, i32)
declare { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.ver.vg4.nxv2f64(i32, i32)

declare { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.vg1x2.nxv2i64(i32)
declare { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.vg1x2.nxv2f64(i32)

declare { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sme.read.vg1x4.nxv2i64(i32)
declare { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> } @llvm.aarch64.sme.read.vg1x4.nxv2f64(i32)

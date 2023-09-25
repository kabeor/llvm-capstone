; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve < %s | FileCheck %s

; FIXME: Streaming-compatible SVE doesn't include FADDA, so this shouldn't compile!
; RUN: llc -mattr=+sve -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-linux-gnu"

; FADD

define half @fadda_nxv2f16(half %init, <vscale x 2 x half> %a) {
; CHECK-LABEL: fadda_nxv2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadda h0, p0, h0, z1.h
; CHECK-NEXT:    // kill: def $h0 killed $h0 killed $z0
; CHECK-NEXT:    ret
  %res = call half @llvm.vector.reduce.fadd.nxv2f16(half %init, <vscale x 2 x half> %a)
  ret half %res
}

define half @fadda_nxv4f16(half %init, <vscale x 4 x half> %a) {
; CHECK-LABEL: fadda_nxv4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadda h0, p0, h0, z1.h
; CHECK-NEXT:    // kill: def $h0 killed $h0 killed $z0
; CHECK-NEXT:    ret
  %res = call half @llvm.vector.reduce.fadd.nxv4f16(half %init, <vscale x 4 x half> %a)
  ret half %res
}

define half @fadda_nxv8f16(half %init, <vscale x 8 x half> %a) {
; CHECK-LABEL: fadda_nxv8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fadda h0, p0, h0, z1.h
; CHECK-NEXT:    // kill: def $h0 killed $h0 killed $z0
; CHECK-NEXT:    ret
  %res = call half @llvm.vector.reduce.fadd.nxv8f16(half %init, <vscale x 8 x half> %a)
  ret half %res
}

define half @fadda_nxv6f16(<vscale x 6 x half> %v, half %s) {
; CHECK-LABEL: fadda_nxv6f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 8 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    mov w8, #32768 // =0x8000
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    fmov s0, s1
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    st1h { z2.d }, p1, [sp, #3, mul vl]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [sp]
; CHECK-NEXT:    fadda h0, p0, h0, z2.h
; CHECK-NEXT:    // kill: def $h0 killed $h0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call half @llvm.vector.reduce.fadd.nxv6f16(half %s, <vscale x 6 x half> %v)
  ret half %res
}

define half @fadda_nxv10f16(<vscale x 10 x half> %v, half %s) {
; CHECK-LABEL: fadda_nxv10f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-3
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x18, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 24 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    mov w8, #32768 // =0x8000
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    st1h { z1.h }, p0, [sp]
; CHECK-NEXT:    // kill: def $h2 killed $h2 def $z2
; CHECK-NEXT:    mov z3.h, w8
; CHECK-NEXT:    addvl x8, sp, #1
; CHECK-NEXT:    st1h { z3.d }, p1, [sp, #1, mul vl]
; CHECK-NEXT:    fadda h2, p0, h2, z0.h
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [sp]
; CHECK-NEXT:    st1h { z1.h }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1h { z3.d }, p1, [sp, #6, mul vl]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [sp, #1, mul vl]
; CHECK-NEXT:    st1h { z1.h }, p0, [sp, #2, mul vl]
; CHECK-NEXT:    st1h { z3.d }, p1, [x8, #7, mul vl]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [sp, #2, mul vl]
; CHECK-NEXT:    fadda h2, p0, h2, z1.h
; CHECK-NEXT:    fmov s0, s2
; CHECK-NEXT:    addvl sp, sp, #3
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call half @llvm.vector.reduce.fadd.nxv10f16(half %s, <vscale x 10 x half> %v)
  ret half %res
}

define half @fadda_nxv12f16(<vscale x 12 x half> %v, half %s) {
; CHECK-LABEL: fadda_nxv12f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32768 // =0x8000
; CHECK-NEXT:    // kill: def $h2 killed $h2 def $z2
; CHECK-NEXT:    uunpklo z1.s, z1.h
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fadda h2, p0, h2, z0.h
; CHECK-NEXT:    mov z3.h, w8
; CHECK-NEXT:    uzp1 z1.h, z1.h, z3.h
; CHECK-NEXT:    fadda h2, p0, h2, z1.h
; CHECK-NEXT:    fmov s0, s2
; CHECK-NEXT:    ret
  %res = call half @llvm.vector.reduce.fadd.nxv12f16(half %s, <vscale x 12 x half> %v)
  ret half %res
}

define float @fadda_nxv2f32(float %init, <vscale x 2 x float> %a) {
; CHECK-LABEL: fadda_nxv2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadda s0, p0, s0, z1.s
; CHECK-NEXT:    // kill: def $s0 killed $s0 killed $z0
; CHECK-NEXT:    ret
  %res = call float @llvm.vector.reduce.fadd.nxv2f32(float %init, <vscale x 2 x float> %a)
  ret float %res
}

define float @fadda_nxv4f32(float %init, <vscale x 4 x float> %a) {
; CHECK-LABEL: fadda_nxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadda s0, p0, s0, z1.s
; CHECK-NEXT:    // kill: def $s0 killed $s0 killed $z0
; CHECK-NEXT:    ret
  %res = call float @llvm.vector.reduce.fadd.nxv4f32(float %init, <vscale x 4 x float> %a)
  ret float %res
}

define double @fadda_nxv2f64(double %init, <vscale x 2 x double> %a) {
; CHECK-LABEL: fadda_nxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadda d0, p0, d0, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call double @llvm.vector.reduce.fadd.nxv2f64(double %init, <vscale x 2 x double> %a)
  ret double %res
}

declare half @llvm.vector.reduce.fadd.nxv2f16(half, <vscale x 2 x half>)
declare half @llvm.vector.reduce.fadd.nxv4f16(half, <vscale x 4 x half>)
declare half @llvm.vector.reduce.fadd.nxv8f16(half, <vscale x 8 x half>)
declare half @llvm.vector.reduce.fadd.nxv6f16(half, <vscale x 6 x half>)
declare half @llvm.vector.reduce.fadd.nxv10f16(half, <vscale x 10 x half>)
declare half @llvm.vector.reduce.fadd.nxv12f16(half, <vscale x 12 x half>)
declare float @llvm.vector.reduce.fadd.nxv2f32(float, <vscale x 2 x float>)
declare float @llvm.vector.reduce.fadd.nxv4f32(float, <vscale x 4 x float>)
declare float @llvm.vector.reduce.fadd.nxv8f32(float, <vscale x 8 x float>)
declare double @llvm.vector.reduce.fadd.nxv2f64(double, <vscale x 2 x double>)

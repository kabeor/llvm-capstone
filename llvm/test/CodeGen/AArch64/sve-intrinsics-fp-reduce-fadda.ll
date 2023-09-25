; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; FIXME: Streaming-compatible SVE doesn't include FADDA, so this shouldn't compile!
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -force-streaming-compatible-sve < %s | FileCheck %s

;
; FADDA
;

define half @fadda_f16(<vscale x 8 x i1> %pg, half %init, <vscale x 8 x half> %a) {
; CHECK-LABEL: fadda_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    fadda h0, p0, h0, z1.h
; CHECK-NEXT:    // kill: def $h0 killed $h0 killed $z0
; CHECK-NEXT:    ret
  %res = call half @llvm.aarch64.sve.fadda.nxv8f16(<vscale x 8 x i1> %pg,
                                                   half %init,
                                                   <vscale x 8 x half> %a)
  ret half %res
}

define float @fadda_f32(<vscale x 4 x i1> %pg, float %init, <vscale x 4 x float> %a) {
; CHECK-LABEL: fadda_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    fadda s0, p0, s0, z1.s
; CHECK-NEXT:    // kill: def $s0 killed $s0 killed $z0
; CHECK-NEXT:    ret
  %res = call float @llvm.aarch64.sve.fadda.nxv4f32(<vscale x 4 x i1> %pg,
                                                    float %init,
                                                    <vscale x 4 x float> %a)
  ret float %res
}

define double @fadda_f64(<vscale x 2 x i1> %pg, double %init, <vscale x 2 x double> %a) {
; CHECK-LABEL: fadda_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    fadda d0, p0, d0, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call double @llvm.aarch64.sve.fadda.nxv2f64(<vscale x 2 x i1> %pg,
                                                     double %init,
                                                     <vscale x 2 x double> %a)
  ret double %res
}

declare half @llvm.aarch64.sve.fadda.nxv8f16(<vscale x 8 x i1>, half, <vscale x 8 x half>)
declare float @llvm.aarch64.sve.fadda.nxv4f32(<vscale x 4 x i1>, float, <vscale x 4 x float>)
declare double @llvm.aarch64.sve.fadda.nxv2f64(<vscale x 2 x i1>, double, <vscale x 2 x double>)

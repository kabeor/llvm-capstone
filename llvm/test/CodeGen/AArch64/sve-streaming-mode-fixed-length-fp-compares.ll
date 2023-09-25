; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve  < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; FCMP OEQ
;

define <2 x i16> @fcmp_oeq_v2f16(<2 x half> %op1, <2 x half> %op2) {
; CHECK-LABEL: fcmp_oeq_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    fcmeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    punpklo p0.h, p0.b
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <2 x half> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i16>
  ret <2 x i16> %sext
}

define <4 x i16> @fcmp_oeq_v4f16(<4 x half> %op1, <4 x half> %op2) {
; CHECK-LABEL: fcmp_oeq_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    fcmeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <4 x half> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i16>
  ret <4 x i16> %sext
}

define <8 x i16> @fcmp_oeq_v8f16(<8 x half> %op1, <8 x half> %op2) {
; CHECK-LABEL: fcmp_oeq_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    fcmeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <8 x half> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i16>
  ret <8 x i16> %sext
}

define void @fcmp_oeq_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_oeq_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmeq p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmeq p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp oeq <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

define <2 x i32> @fcmp_oeq_v2f32(<2 x float> %op1, <2 x float> %op2) {
; CHECK-LABEL: fcmp_oeq_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    fcmeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <2 x float> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %sext
}

define <4 x i32> @fcmp_oeq_v4f32(<4 x float> %op1, <4 x float> %op2) {
; CHECK-LABEL: fcmp_oeq_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    fcmeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <4 x float> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  ret <4 x i32> %sext
}

define void @fcmp_oeq_v8f32(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_oeq_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmeq p1.s, p0/z, z1.s, z0.s
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmeq p0.s, p0/z, z2.s, z3.s
; CHECK-NEXT:    mov z1.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <8 x float>, ptr %a
  %op2 = load <8 x float>, ptr %b
  %cmp = fcmp oeq <8 x float> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %sext, ptr %c
  ret void
}

define <1 x i64> @fcmp_oeq_v1f64(<1 x double> %op1, <1 x double> %op2) {
; CHECK-LABEL: fcmp_oeq_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    fcmeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <1 x double> %op1, %op2
  %sext = sext <1 x i1> %cmp to <1 x i64>
  ret <1 x i64> %sext
}

define <2 x i64> @fcmp_oeq_v2f64(<2 x double> %op1, <2 x double> %op2) {
; CHECK-LABEL: fcmp_oeq_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    fcmeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq <2 x double> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  ret <2 x i64> %sext
}

define void @fcmp_oeq_v4f64(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_oeq_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmeq p1.d, p0/z, z1.d, z0.d
; CHECK-NEXT:    mov z0.d, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmeq p0.d, p0/z, z2.d, z3.d
; CHECK-NEXT:    mov z1.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <4 x double>, ptr %a
  %op2 = load <4 x double>, ptr %b
  %cmp = fcmp oeq <4 x double> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %sext, ptr %c
  ret void
}

;
; FCMP UEQ
;

define void @fcmp_ueq_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ueq_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmuo p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    fcmeq p2.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov p1.b, p2/m, p2.b
; CHECK-NEXT:    fcmuo p2.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    fcmeq p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    sel p0.b, p0, p0.b, p2.b
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ueq <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP ONE
;

define void @fcmp_one_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_one_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    fcmgt p2.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov p1.b, p2/m, p2.b
; CHECK-NEXT:    fcmgt p2.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    fcmgt p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    sel p0.b, p0, p0.b, p2.b
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp one <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP UNE
;

define void @fcmp_une_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_une_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmne p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmne p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp une <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP OGT
;

define void @fcmp_ogt_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ogt_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmgt p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ogt <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP UGT
;

define void @fcmp_ugt_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ugt_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmge p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmge p0.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    eor z1.d, z1.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    stp q1, q0, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ugt <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP OLT
;

define void @fcmp_olt_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_olt_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmgt p0.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp olt <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP ULT
;

define void @fcmp_ult_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ult_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmge p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmge p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    eor z1.d, z1.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    stp q1, q0, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ult <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP OGE
;

define void @fcmp_oge_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_oge_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmge p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmge p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp oge <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP UGE
;

define void @fcmp_uge_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_uge_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmgt p0.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    eor z1.d, z1.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    stp q1, q0, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp uge <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP OLE
;

define void @fcmp_ole_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ole_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmge p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmge p0.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ole <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP ULE
;

define void @fcmp_ule_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ule_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmgt p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    eor z1.d, z1.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    stp q1, q0, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ule <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP UNO
;

define void @fcmp_uno_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_uno_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmuo p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmuo p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp uno <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP ORD
;

define void @fcmp_ord_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ord_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmuo p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmuo p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    eor z1.d, z1.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    stp q1, q0, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp ord <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP EQ
;

define void @fcmp_eq_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_eq_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmeq p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmeq p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp fast oeq <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP NE
;

define void @fcmp_ne_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ne_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmne p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmne p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp fast one <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP GT
;

define void @fcmp_gt_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_gt_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmgt p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp fast ogt <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP LT
;

define void @fcmp_lt_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_lt_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmgt p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmgt p0.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp fast olt <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP GE
;

define void @fcmp_ge_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_ge_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmge p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmge p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp fast oge <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

;
; FCMP LE
;

define void @fcmp_le_v16f16(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: fcmp_le_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    fcmge p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    fcmge p0.h, p0/z, z3.h, z2.h
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x2]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %cmp = fcmp fast ole <16 x half> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %c
  ret void
}

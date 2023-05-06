; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; Masked Store
;

define void @masked_store_v4i8(ptr %dst, <4 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    asr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    cmpne p0.h, p0/z, z0.h, #0
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    st1b { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4i8(<4 x i8> zeroinitializer, ptr %dst, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v8i8(ptr %dst, <8 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    lsl z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    asr z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    cmpne p0.b, p0/z, z0.b, #0
; CHECK-NEXT:    mov z0.b, #0 // =0x0
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8i8(<8 x i8> zeroinitializer, ptr %dst, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v16i8(ptr %dst, <16 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    lsl z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    asr z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    cmpne p0.b, p0/z, z0.b, #0
; CHECK-NEXT:    mov z0.b, #0 // =0x0
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v16i8(<16 x i8> zeroinitializer, ptr %dst, i32 8, <16 x i1> %mask)
  ret void
}

define void @masked_store_v32i8(ptr %dst, <32 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    ldr w8, [sp, #96]
; CHECK-NEXT:    strb w7, [sp, #6]
; CHECK-NEXT:    ldr w9, [sp, #88]
; CHECK-NEXT:    strb w6, [sp, #5]
; CHECK-NEXT:    ldr w10, [sp, #80]
; CHECK-NEXT:    strb w5, [sp, #4]
; CHECK-NEXT:    strb w8, [sp, #15]
; CHECK-NEXT:    ldr w8, [sp, #72]
; CHECK-NEXT:    strb w9, [sp, #14]
; CHECK-NEXT:    ldr w9, [sp, #64]
; CHECK-NEXT:    strb w10, [sp, #13]
; CHECK-NEXT:    ldr w10, [sp, #56]
; CHECK-NEXT:    strb w8, [sp, #12]
; CHECK-NEXT:    ldr w8, [sp, #48]
; CHECK-NEXT:    strb w9, [sp, #11]
; CHECK-NEXT:    ldr w9, [sp, #40]
; CHECK-NEXT:    strb w10, [sp, #10]
; CHECK-NEXT:    ldr w10, [sp, #32]
; CHECK-NEXT:    strb w8, [sp, #9]
; CHECK-NEXT:    ldr w8, [sp, #224]
; CHECK-NEXT:    strb w9, [sp, #8]
; CHECK-NEXT:    ldr w9, [sp, #216]
; CHECK-NEXT:    strb w10, [sp, #7]
; CHECK-NEXT:    ldr w10, [sp, #208]
; CHECK-NEXT:    strb w8, [sp, #31]
; CHECK-NEXT:    ldr w8, [sp, #200]
; CHECK-NEXT:    strb w9, [sp, #30]
; CHECK-NEXT:    ldr w9, [sp, #192]
; CHECK-NEXT:    strb w10, [sp, #29]
; CHECK-NEXT:    ldr w10, [sp, #184]
; CHECK-NEXT:    strb w8, [sp, #28]
; CHECK-NEXT:    ldr w8, [sp, #176]
; CHECK-NEXT:    strb w9, [sp, #27]
; CHECK-NEXT:    ldr w9, [sp, #168]
; CHECK-NEXT:    strb w10, [sp, #26]
; CHECK-NEXT:    ldr w10, [sp, #160]
; CHECK-NEXT:    strb w8, [sp, #25]
; CHECK-NEXT:    ldr w8, [sp, #152]
; CHECK-NEXT:    strb w9, [sp, #24]
; CHECK-NEXT:    ldr w9, [sp, #144]
; CHECK-NEXT:    strb w10, [sp, #23]
; CHECK-NEXT:    ldr w10, [sp, #136]
; CHECK-NEXT:    strb w8, [sp, #22]
; CHECK-NEXT:    ldr w8, [sp, #128]
; CHECK-NEXT:    strb w9, [sp, #21]
; CHECK-NEXT:    ldr w9, [sp, #120]
; CHECK-NEXT:    strb w10, [sp, #20]
; CHECK-NEXT:    ldr w10, [sp, #112]
; CHECK-NEXT:    strb w8, [sp, #19]
; CHECK-NEXT:    ldr w8, [sp, #104]
; CHECK-NEXT:    strb w4, [sp, #3]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    strb w3, [sp, #2]
; CHECK-NEXT:    strb w2, [sp, #1]
; CHECK-NEXT:    strb w1, [sp]
; CHECK-NEXT:    strb w9, [sp, #18]
; CHECK-NEXT:    strb w10, [sp, #17]
; CHECK-NEXT:    strb w8, [sp, #16]
; CHECK-NEXT:    mov w8, #16
; CHECK-NEXT:    ldp q0, q1, [sp]
; CHECK-NEXT:    lsl z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    asr z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    lsl z1.b, p0/m, z1.b, #7
; CHECK-NEXT:    cmpne p1.b, p0/z, z0.b, #0
; CHECK-NEXT:    movprfx z0, z1
; CHECK-NEXT:    asr z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    cmpne p0.b, p0/z, z0.b, #0
; CHECK-NEXT:    mov z0.b, #0 // =0x0
; CHECK-NEXT:    st1b { z0.b }, p0, [x0, x8]
; CHECK-NEXT:    st1b { z0.b }, p1, [x0]
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v32i8(<32 x i8> zeroinitializer, ptr %dst, i32 8, <32 x i1> %mask)
  ret void
}

define void @masked_store_v2f16(ptr %dst, <2 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    str wzr, [sp, #12]
; CHECK-NEXT:    mov z0.s, z0.s[1]
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    fmov w9, s0
; CHECK-NEXT:    strh w8, [sp, #8]
; CHECK-NEXT:    strh w9, [sp, #10]
; CHECK-NEXT:    ldr d0, [sp, #8]
; CHECK-NEXT:    lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    asr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    cmpne p0.h, p0/z, z0.h, #0
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v2f16(<2 x half> zeroinitializer, ptr %dst, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_store_v4f16(ptr %dst, <4 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    asr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    cmpne p0.h, p0/z, z0.h, #0
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4f16(<4 x half> zeroinitializer, ptr %dst, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v8f16(ptr %dst, <8 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    uunpklo z0.h, z0.b
; CHECK-NEXT:    lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    asr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    cmpne p0.h, p0/z, z0.h, #0
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8f16(<8 x half> zeroinitializer, ptr %dst, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v16f16(ptr %dst, <16 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ext z1.b, z1.b, z0.b, #8
; CHECK-NEXT:    uunpklo z0.h, z0.b
; CHECK-NEXT:    uunpklo z1.h, z1.b
; CHECK-NEXT:    mov x8, #8
; CHECK-NEXT:    lsl z1.h, p0/m, z1.h, #15
; CHECK-NEXT:    lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    asr z1.h, p0/m, z1.h, #15
; CHECK-NEXT:    asr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    cmpne p1.h, p0/z, z1.h, #0
; CHECK-NEXT:    mov z1.h, #0 // =0x0
; CHECK-NEXT:    cmpne p0.h, p0/z, z0.h, #0
; CHECK-NEXT:    st1h { z1.h }, p1, [x0, x8, lsl #1]
; CHECK-NEXT:    st1h { z1.h }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v16f16(<16 x half> zeroinitializer, ptr %dst, i32 8, <16 x i1> %mask)
  ret void
}

define void @masked_store_v4f32(ptr %dst, <4 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    uunpklo z0.s, z0.h
; CHECK-NEXT:    lsl z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    asr z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    cmpne p0.s, p0/z, z0.s, #0
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4f32(<4 x float> zeroinitializer, ptr %dst, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v8f32(ptr %dst, <8 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    mov z1.b, z0.b[7]
; CHECK-NEXT:    mov z2.b, z0.b[6]
; CHECK-NEXT:    fmov w8, s1
; CHECK-NEXT:    mov z1.b, z0.b[5]
; CHECK-NEXT:    fmov w9, s2
; CHECK-NEXT:    mov z2.b, z0.b[4]
; CHECK-NEXT:    fmov w10, s1
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    strh w8, [sp, #14]
; CHECK-NEXT:    fmov w8, s2
; CHECK-NEXT:    strh w9, [sp, #12]
; CHECK-NEXT:    mov z2.b, z0.b[3]
; CHECK-NEXT:    strh w10, [sp, #10]
; CHECK-NEXT:    mov z3.b, z0.b[2]
; CHECK-NEXT:    strh w8, [sp, #8]
; CHECK-NEXT:    mov z4.b, z0.b[1]
; CHECK-NEXT:    ldr d1, [sp, #8]
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    mov x9, #4
; CHECK-NEXT:    fmov w10, s2
; CHECK-NEXT:    uunpklo z0.s, z1.h
; CHECK-NEXT:    lsl z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    asr z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    cmpne p1.s, p0/z, z0.s, #0
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    st1w { z0.s }, p1, [x0, x9, lsl #2]
; CHECK-NEXT:    fmov w9, s3
; CHECK-NEXT:    strh w8, [sp]
; CHECK-NEXT:    fmov w8, s4
; CHECK-NEXT:    strh w10, [sp, #6]
; CHECK-NEXT:    strh w9, [sp, #4]
; CHECK-NEXT:    strh w8, [sp, #2]
; CHECK-NEXT:    ldr d1, [sp]
; CHECK-NEXT:    uunpklo z1.s, z1.h
; CHECK-NEXT:    lsl z1.s, p0/m, z1.s, #31
; CHECK-NEXT:    asr z1.s, p0/m, z1.s, #31
; CHECK-NEXT:    cmpne p0.s, p0/z, z1.s, #0
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8f32(<8 x float> zeroinitializer, ptr %dst, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v2f64(ptr %dst, <2 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    uunpklo z0.d, z0.s
; CHECK-NEXT:    lsl z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    asr z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    cmpne p0.d, p0/z, z0.d, #0
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v2f64(<2 x double> zeroinitializer, ptr %dst, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_store_v4f64(ptr %dst, <4 x i1> %mask) #0 {
; CHECK-LABEL: masked_store_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    mov x8, #2
; CHECK-NEXT:    uunpklo z0.s, z0.h
; CHECK-NEXT:    uunpklo z1.d, z0.s
; CHECK-NEXT:    ext z0.b, z0.b, z0.b, #8
; CHECK-NEXT:    uunpklo z0.d, z0.s
; CHECK-NEXT:    lsl z1.d, p0/m, z1.d, #63
; CHECK-NEXT:    lsl z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    asr z1.d, p0/m, z1.d, #63
; CHECK-NEXT:    asr z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    cmpne p1.d, p0/z, z0.d, #0
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    cmpne p0.d, p0/z, z1.d, #0
; CHECK-NEXT:    st1d { z0.d }, p1, [x0, x8, lsl #3]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4f64(<4 x double> zeroinitializer, ptr %dst, i32 8, <4 x i1> %mask)
  ret void
}

declare void @llvm.masked.store.v4i8(<4 x i8>, ptr, i32, <4 x i1>)
declare void @llvm.masked.store.v8i8(<8 x i8>, ptr, i32, <8 x i1>)
declare void @llvm.masked.store.v16i8(<16 x i8>, ptr, i32, <16 x i1>)
declare void @llvm.masked.store.v32i8(<32 x i8>, ptr, i32, <32 x i1>)
declare void @llvm.masked.store.v2f16(<2 x half>, ptr, i32, <2 x i1>)
declare void @llvm.masked.store.v4f16(<4 x half>, ptr, i32, <4 x i1>)
declare void @llvm.masked.store.v8f16(<8 x half>, ptr, i32, <8 x i1>)
declare void @llvm.masked.store.v16f16(<16 x half>, ptr, i32, <16 x i1>)
declare void @llvm.masked.store.v4f32(<4 x float>, ptr, i32, <4 x i1>)
declare void @llvm.masked.store.v8f32(<8 x float>, ptr, i32, <8 x i1>)
declare void @llvm.masked.store.v2f64(<2 x double>, ptr, i32, <2 x i1>)
declare void @llvm.masked.store.v4f64(<4 x double>, ptr, i32, <4 x i1>)

attributes #0 = { "target-features"="+sve" }

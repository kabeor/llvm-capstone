; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=avx512f | FileCheck %s

declare <4 x float> @llvm.x86.avx512.mask3.vfmadd.ss(<4 x float>, <4 x float>, <4 x float>, i8, i32)
declare <2 x double> @llvm.x86.avx512.mask3.vfmadd.sd(<2 x double>, <2 x double>, <2 x double>, i8, i32)
declare <4 x float> @llvm.x86.avx512.mask3.vfmsub.ss(<4 x float>, <4 x float>, <4 x float>, i8, i32)
declare <2 x double> @llvm.x86.avx512.mask3.vfmsub.sd(<2 x double>, <2 x double>, <2 x double>, i8, i32)

define <4 x float> @test_int_x86_avx512_mask3_vfmadd_ss_load0(ptr %x0ptr, <4 x float> %x1, <4 x float> %x2) {
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmadd_ss_load0:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmadd231ss {{.*#+}} xmm1 = (xmm0 * mem) + xmm1
; CHECK-NEXT:    vmovaps %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x0 = load <4 x float>, ptr %x0ptr
  %res = call <4 x float> @llvm.x86.avx512.mask3.vfmadd.ss(<4 x float> %x0, <4 x float> %x1, <4 x float> %x2, i8 -1, i32 4)
  ret <4 x float> %res
}

define <4 x float> @test_int_x86_avx512_mask3_vfmadd_ss_load1(<4 x float> %x0, ptr %x1ptr, <4 x float> %x2){
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmadd_ss_load1:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmadd231ss {{.*#+}} xmm1 = (xmm0 * mem) + xmm1
; CHECK-NEXT:    vmovaps %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x1 = load <4 x float>, ptr %x1ptr
  %res = call <4 x float> @llvm.x86.avx512.mask3.vfmadd.ss(<4 x float> %x0, <4 x float> %x1, <4 x float> %x2, i8 -1, i32 4)
  ret <4 x float> %res
}

define <2 x double> @test_int_x86_avx512_mask3_vfmadd_sd_load0(ptr %x0ptr, <2 x double> %x1, <2 x double> %x2) {
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmadd_sd_load0:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmadd231sd {{.*#+}} xmm1 = (xmm0 * mem) + xmm1
; CHECK-NEXT:    vmovapd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x0 = load <2 x double>, ptr %x0ptr
  %res = call <2 x double> @llvm.x86.avx512.mask3.vfmadd.sd(<2 x double> %x0, <2 x double> %x1, <2 x double> %x2, i8 -1, i32 4)
  ret <2 x double> %res
}

define <2 x double> @test_int_x86_avx512_mask3_vfmadd_sd_load1(<2 x double> %x0, ptr %x1ptr, <2 x double> %x2){
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmadd_sd_load1:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmadd231sd {{.*#+}} xmm1 = (xmm0 * mem) + xmm1
; CHECK-NEXT:    vmovapd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x1 = load <2 x double>, ptr %x1ptr
  %res = call <2 x double> @llvm.x86.avx512.mask3.vfmadd.sd(<2 x double> %x0, <2 x double> %x1, <2 x double> %x2, i8 -1, i32 4)
  ret <2 x double> %res
}

define <4 x float> @test_int_x86_avx512_mask3_vfmsub_ss_load0(ptr %x0ptr, <4 x float> %x1, <4 x float> %x2) {
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmsub_ss_load0:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmsub231ss {{.*#+}} xmm1 = (xmm0 * mem) - xmm1
; CHECK-NEXT:    vmovaps %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x0 = load <4 x float>, ptr %x0ptr
  %res = call <4 x float> @llvm.x86.avx512.mask3.vfmsub.ss(<4 x float> %x0, <4 x float> %x1, <4 x float> %x2, i8 -1, i32 4)
  ret <4 x float> %res
}

define <4 x float> @test_int_x86_avx512_mask3_vfmsub_ss_load1(<4 x float> %x0, ptr %x1ptr, <4 x float> %x2){
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmsub_ss_load1:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmsub231ss {{.*#+}} xmm1 = (xmm0 * mem) - xmm1
; CHECK-NEXT:    vmovaps %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x1 = load <4 x float>, ptr %x1ptr
  %res = call <4 x float> @llvm.x86.avx512.mask3.vfmsub.ss(<4 x float> %x0, <4 x float> %x1, <4 x float> %x2, i8 -1, i32 4)
  ret <4 x float> %res
}

define <2 x double> @test_int_x86_avx512_mask3_vfmsub_sd_load0(ptr %x0ptr, <2 x double> %x1, <2 x double> %x2) {
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmsub_sd_load0:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmsub231sd {{.*#+}} xmm1 = (xmm0 * mem) - xmm1
; CHECK-NEXT:    vmovapd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x0 = load <2 x double>, ptr %x0ptr
  %res = call <2 x double> @llvm.x86.avx512.mask3.vfmsub.sd(<2 x double> %x0, <2 x double> %x1, <2 x double> %x2, i8 -1, i32 4)
  ret <2 x double> %res
}

define <2 x double> @test_int_x86_avx512_mask3_vfmsub_sd_load1(<2 x double> %x0, ptr %x1ptr, <2 x double> %x2){
; CHECK-LABEL: test_int_x86_avx512_mask3_vfmsub_sd_load1:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vfmsub231sd {{.*#+}} xmm1 = (xmm0 * mem) - xmm1
; CHECK-NEXT:    vmovapd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %x1 = load <2 x double>, ptr %x1ptr
  %res = call <2 x double> @llvm.x86.avx512.mask3.vfmsub.sd(<2 x double> %x0, <2 x double> %x1, <2 x double> %x2, i8 -1, i32 4)
  ret <2 x double> %res
}

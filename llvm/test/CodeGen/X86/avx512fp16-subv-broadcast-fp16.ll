; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=skx -mattr=+avx512fp16 | FileCheck %s

define dso_local void @test_v8f16_v32f16(ptr %x_addr, ptr %y_addr) {
; CHECK-LABEL: test_v8f16_v32f16:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    vbroadcastf32x4 {{.*#+}} zmm0 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
; CHECK-NEXT:    vmovdqa64 %zmm0, (%rsi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %0 = load <8 x half>, ptr %x_addr, align 16
  %shuffle.i58 = shufflevector <8 x half> %0, <8 x half> %0, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  store <32 x half> %shuffle.i58, ptr %y_addr, align 64
  ret void
}

define dso_local void @test_v8f16_v16f16(ptr %x_addr, ptr %y_addr) {
; CHECK-LABEL: test_v8f16_v16f16:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    vbroadcastf128 {{.*#+}} ymm0 = mem[0,1,0,1]
; CHECK-NEXT:    vmovdqa %ymm0, (%rsi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %0 = load <8 x half>, ptr %x_addr, align 16
  %shuffle.i58 = shufflevector <8 x half> %0, <8 x half> %0, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  store <16 x half> %shuffle.i58, ptr %y_addr, align 64
  ret void
}

define dso_local void @test_v16f16_v32f16(ptr %x_addr, ptr %y_addr) {
; CHECK-LABEL: test_v16f16_v32f16:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    vbroadcastf64x4 {{.*#+}} zmm0 = mem[0,1,2,3,0,1,2,3]
; CHECK-NEXT:    vmovdqa64 %zmm0, (%rsi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %0 = load <16 x half>, ptr %x_addr, align 16
  %shuffle.i58 = shufflevector <16 x half> %0, <16 x half> %0, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  store <32 x half> %shuffle.i58, ptr %y_addr, align 64
  ret void
}

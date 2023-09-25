; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avxvnni | FileCheck %s --check-prefixes=ALL,AVXVNNI
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vnni | FileCheck %s --check-prefixes=ALL,AVX512,AVX512VNNI
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vnni -mattr=+avx512vl | FileCheck %s --check-prefixes=ALL,AVX512,AVX512VLVNNI

define i32 @mul_4xi8_zc_exceed(<4 x i8> %a, i32 %c) {
; ALL-LABEL: mul_4xi8_zc_exceed:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    vpmovzxbd {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; ALL-NEXT:    vpmaddwd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; ALL-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; ALL-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; ALL-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vmovd %xmm0, %eax
; ALL-NEXT:    addl %edi, %eax
; ALL-NEXT:    retq
entry:
  %0 = zext <4 x i8> %a to <4 x i32>
  %1 = mul nsw <4 x i32> %0, <i32 0, i32 1, i32 2, i32 128>
  %2 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_4xi8_zc(<4 x i8> %a, i32 %c) {
; AVXVNNI-LABEL: mul_4xi8_zc:
; AVXVNNI:       # %bb.0: # %entry
; AVXVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVXVNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVXVNNI-NEXT:    {vex} vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVXVNNI-NEXT:    vmovd %xmm1, %eax
; AVXVNNI-NEXT:    addl %edi, %eax
; AVXVNNI-NEXT:    retq
;
; AVX512VNNI-LABEL: mul_4xi8_zc:
; AVX512VNNI:       # %bb.0: # %entry
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm0, %zmm1
; AVX512VNNI-NEXT:    vmovd %xmm1, %eax
; AVX512VNNI-NEXT:    addl %edi, %eax
; AVX512VNNI-NEXT:    vzeroupper
; AVX512VNNI-NEXT:    retq
;
; AVX512VLVNNI-LABEL: mul_4xi8_zc:
; AVX512VLVNNI:       # %bb.0: # %entry
; AVX512VLVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VLVNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVX512VLVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VLVNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX512VLVNNI-NEXT:    vmovd %xmm1, %eax
; AVX512VLVNNI-NEXT:    addl %edi, %eax
; AVX512VLVNNI-NEXT:    retq
entry:
  %0 = zext <4 x i8> %a to <4 x i32>
  %1 = mul nsw <4 x i32> %0, <i32 0, i32 1, i32 2, i32 127>
  %2 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_4xi4_cz(<4 x i4> %a, i32 %c) {
; AVXVNNI-LABEL: mul_4xi4_cz:
; AVXVNNI:       # %bb.0: # %entry
; AVXVNNI-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVXVNNI-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVXVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVXVNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVXVNNI-NEXT:    {vex} vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVXVNNI-NEXT:    vmovd %xmm1, %eax
; AVXVNNI-NEXT:    addl %edi, %eax
; AVXVNNI-NEXT:    retq
;
; AVX512VNNI-LABEL: mul_4xi4_cz:
; AVX512VNNI:       # %bb.0: # %entry
; AVX512VNNI-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512VNNI-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm0, %zmm1
; AVX512VNNI-NEXT:    vmovd %xmm1, %eax
; AVX512VNNI-NEXT:    addl %edi, %eax
; AVX512VNNI-NEXT:    vzeroupper
; AVX512VNNI-NEXT:    retq
;
; AVX512VLVNNI-LABEL: mul_4xi4_cz:
; AVX512VLVNNI:       # %bb.0: # %entry
; AVX512VLVNNI-NEXT:    vpmovdb %xmm0, %xmm0
; AVX512VLVNNI-NEXT:    vpandd {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm0
; AVX512VLVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VLVNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX512VLVNNI-NEXT:    vmovd %xmm1, %eax
; AVX512VLVNNI-NEXT:    addl %edi, %eax
; AVX512VLVNNI-NEXT:    retq
entry:
  %0 = zext <4 x i4> %a to <4 x i32>
  %1 = mul nsw <4 x i32> <i32 0, i32 1, i32 2, i32 127>, %0
  %2 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_4xi8_cs(<4 x i8> %a, i32 %c) {
; AVXVNNI-LABEL: mul_4xi8_cs:
; AVXVNNI:       # %bb.0: # %entry
; AVXVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVXVNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVXVNNI-NEXT:    vmovdqa {{.*#+}} xmm2 = [0,1,2,255,0,0,0,0,0,0,0,0,0,0,0,0]
; AVXVNNI-NEXT:    {vex} vpdpbusd %xmm0, %xmm2, %xmm1
; AVXVNNI-NEXT:    vmovd %xmm1, %eax
; AVXVNNI-NEXT:    addl %edi, %eax
; AVXVNNI-NEXT:    retq
;
; AVX512VNNI-LABEL: mul_4xi8_cs:
; AVX512VNNI:       # %bb.0: # %entry
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVX512VNNI-NEXT:    vmovdqa {{.*#+}} xmm1 = [0,1,2,255,0,0,0,0,0,0,0,0,0,0,0,0]
; AVX512VNNI-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX512VNNI-NEXT:    vpdpbusd %zmm0, %zmm1, %zmm2
; AVX512VNNI-NEXT:    vmovd %xmm2, %eax
; AVX512VNNI-NEXT:    addl %edi, %eax
; AVX512VNNI-NEXT:    vzeroupper
; AVX512VNNI-NEXT:    retq
;
; AVX512VLVNNI-LABEL: mul_4xi8_cs:
; AVX512VLVNNI:       # %bb.0: # %entry
; AVX512VLVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VLVNNI-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3,4,5,6,7]
; AVX512VLVNNI-NEXT:    vmovdqa {{.*#+}} xmm1 = [0,1,2,255,0,0,0,0,0,0,0,0,0,0,0,0]
; AVX512VLVNNI-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX512VLVNNI-NEXT:    vpdpbusd %xmm0, %xmm1, %xmm2
; AVX512VLVNNI-NEXT:    vmovd %xmm2, %eax
; AVX512VLVNNI-NEXT:    addl %edi, %eax
; AVX512VLVNNI-NEXT:    retq
entry:
  %0 = sext <4 x i8> %a to <4 x i32>
  %1 = mul nsw <4 x i32> <i32 0, i32 1, i32 2, i32 255>, %0
  %2 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_4xi8_cs_exceed(<4 x i8> %a, i32 %c) {
; ALL-LABEL: mul_4xi8_cs_exceed:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    vpmovsxbd %xmm0, %xmm0
; ALL-NEXT:    vpmaddwd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; ALL-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; ALL-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; ALL-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vmovd %xmm0, %eax
; ALL-NEXT:    addl %edi, %eax
; ALL-NEXT:    retq
entry:
  %0 = sext <4 x i8> %a to <4 x i32>
  %1 = mul nsw <4 x i32> <i32 0, i32 1, i32 2, i32 256>, %0
  %2 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_16xi8_zc(<16 x i8> %a, i32 %c) {
; AVXVNNI-LABEL: mul_16xi8_zc:
; AVXVNNI:       # %bb.0: # %entry
; AVXVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVXVNNI-NEXT:    {vex} vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVXVNNI-NEXT:    vpshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; AVXVNNI-NEXT:    vpaddd %xmm0, %xmm1, %xmm0
; AVXVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVXVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVXVNNI-NEXT:    vmovd %xmm0, %eax
; AVXVNNI-NEXT:    addl %edi, %eax
; AVXVNNI-NEXT:    retq
;
; AVX512VNNI-LABEL: mul_16xi8_zc:
; AVX512VNNI:       # %bb.0: # %entry
; AVX512VNNI-NEXT:    vmovdqa %xmm0, %xmm0
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm0, %zmm1
; AVX512VNNI-NEXT:    vpshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; AVX512VNNI-NEXT:    vpaddd %xmm0, %xmm1, %xmm0
; AVX512VNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVX512VNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512VNNI-NEXT:    vmovd %xmm0, %eax
; AVX512VNNI-NEXT:    addl %edi, %eax
; AVX512VNNI-NEXT:    vzeroupper
; AVX512VNNI-NEXT:    retq
;
; AVX512VLVNNI-LABEL: mul_16xi8_zc:
; AVX512VLVNNI:       # %bb.0: # %entry
; AVX512VLVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VLVNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX512VLVNNI-NEXT:    vpshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; AVX512VLVNNI-NEXT:    vpaddd %xmm0, %xmm1, %xmm0
; AVX512VLVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVX512VLVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512VLVNNI-NEXT:    vmovd %xmm0, %eax
; AVX512VLVNNI-NEXT:    addl %edi, %eax
; AVX512VLVNNI-NEXT:    retq
entry:
  %0 = zext <16 x i8> %a to <16 x i32>
  %1 = mul nsw <16 x i32> %0, <i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64>
  %2 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_32xi8_zc(<32 x i8> %a, i32 %c) {
; AVXVNNI-LABEL: mul_32xi8_zc:
; AVXVNNI:       # %bb.0: # %entry
; AVXVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVXVNNI-NEXT:    {vex} vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm1
; AVXVNNI-NEXT:    vextracti128 $1, %ymm1, %xmm0
; AVXVNNI-NEXT:    vpaddd %xmm0, %xmm1, %xmm0
; AVXVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVXVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVXVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVXVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVXVNNI-NEXT:    vmovd %xmm0, %eax
; AVXVNNI-NEXT:    addl %edi, %eax
; AVXVNNI-NEXT:    vzeroupper
; AVXVNNI-NEXT:    retq
;
; AVX512VNNI-LABEL: mul_32xi8_zc:
; AVX512VNNI:       # %bb.0: # %entry
; AVX512VNNI-NEXT:    vmovdqa %ymm0, %ymm0
; AVX512VNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm0, %zmm1
; AVX512VNNI-NEXT:    vextracti128 $1, %ymm1, %xmm0
; AVX512VNNI-NEXT:    vpaddd %xmm0, %xmm1, %xmm0
; AVX512VNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVX512VNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512VNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVX512VNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512VNNI-NEXT:    vmovd %xmm0, %eax
; AVX512VNNI-NEXT:    addl %edi, %eax
; AVX512VNNI-NEXT:    vzeroupper
; AVX512VNNI-NEXT:    retq
;
; AVX512VLVNNI-LABEL: mul_32xi8_zc:
; AVX512VLVNNI:       # %bb.0: # %entry
; AVX512VLVNNI-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512VLVNNI-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm1
; AVX512VLVNNI-NEXT:    vextracti128 $1, %ymm1, %xmm0
; AVX512VLVNNI-NEXT:    vpaddd %xmm0, %xmm1, %xmm0
; AVX512VLVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVX512VLVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512VLVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVX512VLVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512VLVNNI-NEXT:    vmovd %xmm0, %eax
; AVX512VLVNNI-NEXT:    addl %edi, %eax
; AVX512VLVNNI-NEXT:    vzeroupper
; AVX512VLVNNI-NEXT:    retq
entry:
  %0 = zext <32 x i8> %a to <32 x i32>
  %1 = mul nsw <32 x i32> %0, <i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64>
  %2 = call i32 @llvm.vector.reduce.add.v32i32(<32 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

define i32 @mul_64xi8_zc(<64 x i8> %a, i32 %c) {
; AVXVNNI-LABEL: mul_64xi8_zc:
; AVXVNNI:       # %bb.0: # %entry
; AVXVNNI-NEXT:    vpbroadcastd {{.*#+}} ymm2 = [0,1,2,64,0,1,2,64,0,1,2,64,0,1,2,64,0,1,2,64,0,1,2,64,0,1,2,64,0,1,2,64]
; AVXVNNI-NEXT:    vpxor %xmm3, %xmm3, %xmm3
; AVXVNNI-NEXT:    vpxor %xmm4, %xmm4, %xmm4
; AVXVNNI-NEXT:    {vex} vpdpbusd %ymm2, %ymm1, %ymm4
; AVXVNNI-NEXT:    {vex} vpdpbusd %ymm2, %ymm0, %ymm3
; AVXVNNI-NEXT:    vpaddd %ymm4, %ymm3, %ymm0
; AVXVNNI-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVXVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVXVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVXVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVXVNNI-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVXVNNI-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVXVNNI-NEXT:    vmovd %xmm0, %eax
; AVXVNNI-NEXT:    addl %edi, %eax
; AVXVNNI-NEXT:    vzeroupper
; AVXVNNI-NEXT:    retq
;
; AVX512-LABEL: mul_64xi8_zc:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512-NEXT:    vpdpbusd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm0, %zmm1
; AVX512-NEXT:    vextracti64x4 $1, %zmm1, %ymm0
; AVX512-NEXT:    vpaddd %zmm0, %zmm1, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVX512-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; AVX512-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovd %xmm0, %eax
; AVX512-NEXT:    addl %edi, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
entry:
  %0 = zext <64 x i8> %a to <64 x i32>
  %1 = mul nsw <64 x i32> %0, <i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64, i32 0, i32 1, i32 2, i32 64>
  %2 = call i32 @llvm.vector.reduce.add.v64i32(<64 x i32> %1)
  %op.extra = add nsw i32 %2, %c
  ret i32 %op.extra
}

declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>)
declare i32 @llvm.vector.reduce.add.v32i32(<32 x i32>)
declare i32 @llvm.vector.reduce.add.v64i32(<64 x i32>)

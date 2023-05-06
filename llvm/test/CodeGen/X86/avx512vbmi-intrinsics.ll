; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512vbmi --show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vbmi --show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64

declare <64 x i8> @llvm.x86.avx512.permvar.qi.512(<64 x i8>, <64 x i8>)

define <64 x i8>@test_int_x86_avx512_permvar_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2) {
; CHECK-LABEL: test_int_x86_avx512_permvar_qi_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpermb %zmm0, %zmm1, %zmm0 # encoding: [0x62,0xf2,0x75,0x48,0x8d,0xc0]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.permvar.qi.512(<64 x i8> %x0, <64 x i8> %x1)
  ret <64 x i8> %1
}

define <64 x i8>@test_int_x86_avx512_mask_permvar_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_mask_permvar_qi_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpermb %zmm0, %zmm1, %zmm2 {%k1} # encoding: [0x62,0xf2,0x75,0x49,0x8d,0xd0]
; X86-NEXT:    vmovdqa64 %zmm2, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_mask_permvar_qi_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpermb %zmm0, %zmm1, %zmm2 {%k1} # encoding: [0x62,0xf2,0x75,0x49,0x8d,0xd0]
; X64-NEXT:    vmovdqa64 %zmm2, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.permvar.qi.512(<64 x i8> %x0, <64 x i8> %x1)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> %x2
  ret <64 x i8> %3
}

define <64 x i8>@test_int_x86_avx512_maskz_permvar_qi_512(<64 x i8> %x0, <64 x i8> %x1, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_maskz_permvar_qi_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpermb %zmm0, %zmm1, %zmm0 {%k1} {z} # encoding: [0x62,0xf2,0x75,0xc9,0x8d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_maskz_permvar_qi_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpermb %zmm0, %zmm1, %zmm0 {%k1} {z} # encoding: [0x62,0xf2,0x75,0xc9,0x8d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.permvar.qi.512(<64 x i8> %x0, <64 x i8> %x1)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> zeroinitializer
  ret <64 x i8> %3
}

declare <64 x i8> @llvm.x86.avx512.pmultishift.qb.512(<64 x i8>, <64 x i8>)

define <64 x i8>@test_int_x86_avx512_pmultishift_qb_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2) {
; CHECK-LABEL: test_int_x86_avx512_pmultishift_qb_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpmultishiftqb %zmm1, %zmm0, %zmm0 # encoding: [0x62,0xf2,0xfd,0x48,0x83,0xc1]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.pmultishift.qb.512(<64 x i8> %x0, <64 x i8> %x1)
  ret <64 x i8> %1
}

define <64 x i8>@test_int_x86_avx512_mask_pmultishift_qb_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_mask_pmultishift_qb_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpmultishiftqb %zmm1, %zmm0, %zmm2 {%k1} # encoding: [0x62,0xf2,0xfd,0x49,0x83,0xd1]
; X86-NEXT:    vmovdqa64 %zmm2, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_mask_pmultishift_qb_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpmultishiftqb %zmm1, %zmm0, %zmm2 {%k1} # encoding: [0x62,0xf2,0xfd,0x49,0x83,0xd1]
; X64-NEXT:    vmovdqa64 %zmm2, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.pmultishift.qb.512(<64 x i8> %x0, <64 x i8> %x1)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> %x2
  ret <64 x i8> %3
}

define <64 x i8>@test_int_x86_avx512_maskz_pmultishift_qb_512(<64 x i8> %x0, <64 x i8> %x1, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_maskz_pmultishift_qb_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpmultishiftqb %zmm1, %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf2,0xfd,0xc9,0x83,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_maskz_pmultishift_qb_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpmultishiftqb %zmm1, %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf2,0xfd,0xc9,0x83,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.pmultishift.qb.512(<64 x i8> %x0, <64 x i8> %x1)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> zeroinitializer
  ret <64 x i8> %3
}

declare <64 x i8> @llvm.x86.avx512.vpermi2var.qi.512(<64 x i8>, <64 x i8>, <64 x i8>)

define <64 x i8>@test_int_x86_avx512_vpermi2var_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2) {
; CHECK-LABEL: test_int_x86_avx512_vpermi2var_qi_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpermt2b %zmm2, %zmm1, %zmm0 # encoding: [0x62,0xf2,0x75,0x48,0x7d,0xc2]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.vpermi2var.qi.512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2)
  ret <64 x i8> %1
}

define <64 x i8>@test_int_x86_avx512_mask_vpermi2var_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_mask_vpermi2var_qi_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpermi2b %zmm2, %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf2,0x7d,0x49,0x75,0xca]
; X86-NEXT:    vmovdqa64 %zmm1, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_mask_vpermi2var_qi_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpermi2b %zmm2, %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf2,0x7d,0x49,0x75,0xca]
; X64-NEXT:    vmovdqa64 %zmm1, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.vpermi2var.qi.512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> %x1
  ret <64 x i8> %3
}

define <64 x i8>@test_int_x86_avx512_vpermt2var_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2) {
; CHECK-LABEL: test_int_x86_avx512_vpermt2var_qi_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpermi2b %zmm2, %zmm1, %zmm0 # encoding: [0x62,0xf2,0x75,0x48,0x75,0xc2]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.vpermi2var.qi.512(<64 x i8> %x1, <64 x i8> %x0, <64 x i8> %x2)
  ret <64 x i8> %1
}

define <64 x i8>@test_int_x86_avx512_mask_vpermt2var_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_mask_vpermt2var_qi_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpermt2b %zmm2, %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf2,0x7d,0x49,0x7d,0xca]
; X86-NEXT:    vmovdqa64 %zmm1, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_mask_vpermt2var_qi_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpermt2b %zmm2, %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf2,0x7d,0x49,0x7d,0xca]
; X64-NEXT:    vmovdqa64 %zmm1, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.vpermi2var.qi.512(<64 x i8> %x1, <64 x i8> %x0, <64 x i8> %x2)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> %x1
  ret <64 x i8> %3
}

define <64 x i8>@test_int_x86_avx512_maskz_vpermt2var_qi_512(<64 x i8> %x0, <64 x i8> %x1, <64 x i8> %x2, i64 %x3) {
; X86-LABEL: test_int_x86_avx512_maskz_vpermt2var_qi_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovq {{[0-9]+}}(%esp), %k1 # encoding: [0xc4,0xe1,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vpermi2b %zmm2, %zmm1, %zmm0 {%k1} {z} # encoding: [0x62,0xf2,0x75,0xc9,0x75,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_int_x86_avx512_maskz_vpermt2var_qi_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovq %rdi, %k1 # encoding: [0xc4,0xe1,0xfb,0x92,0xcf]
; X64-NEXT:    vpermi2b %zmm2, %zmm1, %zmm0 {%k1} {z} # encoding: [0x62,0xf2,0x75,0xc9,0x75,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
  %1 = call <64 x i8> @llvm.x86.avx512.vpermi2var.qi.512(<64 x i8> %x1, <64 x i8> %x0, <64 x i8> %x2)
  %2 = bitcast i64 %x3 to <64 x i1>
  %3 = select <64 x i1> %2, <64 x i8> %1, <64 x i8> zeroinitializer
  ret <64 x i8> %3
}

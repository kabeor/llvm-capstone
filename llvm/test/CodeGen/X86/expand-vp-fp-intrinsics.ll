; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown                  | FileCheck %s --check-prefixes=SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx      | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2     | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl | FileCheck %s --check-prefixes=AVX,AVX512

define void @vp_fadd_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_fadd_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    addps %xmm1, %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX-LABEL: vp_fadd_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fadd.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fadd.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define void @vp_fsub_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_fsub_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    subps %xmm1, %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX-LABEL: vp_fsub_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vsubps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fsub.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define void @vp_fmul_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_fmul_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    mulps %xmm1, %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX-LABEL: vp_fmul_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fmul.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fmul.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define void @vp_fdiv_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_fdiv_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    divps %xmm1, %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX-LABEL: vp_fdiv_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vdivps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fdiv.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define void @vp_frem_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_frem_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    pushq %rbx
; SSE-NEXT:    subq $64, %rsp
; SSE-NEXT:    movq %rdi, %rbx
; SSE-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[3,3,3,3]
; SSE-NEXT:    callq fmodf@PLT
; SSE-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    callq fmodf@PLT
; SSE-NEXT:    unpcklps (%rsp), %xmm0 # 16-byte Folded Reload
; SSE-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    callq fmodf@PLT
; SSE-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; SSE-NEXT:    callq fmodf@PLT
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE-NEXT:    unpcklpd (%rsp), %xmm1 # 16-byte Folded Reload
; SSE-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE-NEXT:    movaps %xmm1, (%rbx)
; SSE-NEXT:    addq $64, %rsp
; SSE-NEXT:    popq %rbx
; SSE-NEXT:    retq
;
; AVX-LABEL: vp_frem_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    pushq %rbx
; AVX-NEXT:    subq $48, %rsp
; AVX-NEXT:    movq %rdi, %rbx
; AVX-NEXT:    vmovaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX-NEXT:    callq fmodf@PLT
; AVX-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX-NEXT:    # xmm0 = mem[1,1,3,3]
; AVX-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX-NEXT:    # xmm1 = mem[1,1,3,3]
; AVX-NEXT:    callq fmodf@PLT
; AVX-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; AVX-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX-NEXT:    # xmm0 = mem[1,0]
; AVX-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX-NEXT:    # xmm1 = mem[1,0]
; AVX-NEXT:    callq fmodf@PLT
; AVX-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; AVX-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX-NEXT:    # xmm0 = mem[3,3,3,3]
; AVX-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX-NEXT:    # xmm1 = mem[3,3,3,3]
; AVX-NEXT:    callq fmodf@PLT
; AVX-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; AVX-NEXT:    vmovaps %xmm0, (%rbx)
; AVX-NEXT:    addq $48, %rsp
; AVX-NEXT:    popq %rbx
; AVX-NEXT:    retq
  %res = call <4 x float> @llvm.vp.frem.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.frem.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define void @vp_fabs_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_fabs_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX1-LABEL: vp_fabs_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vmovaps %xmm0, (%rdi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: vp_fabs_v4f32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN]
; AVX2-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vmovaps %xmm0, (%rdi)
; AVX2-NEXT:    retq
;
; AVX512-LABEL: vp_fabs_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpandd {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm0
; AVX512-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX512-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fabs.v4f32(<4 x float> %a0, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fabs.v4f32(<4 x float>, <4 x i1>, i32)

define void @vp_sqrt_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_sqrt_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    sqrtps %xmm0, %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX-LABEL: vp_sqrt_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vsqrtps %xmm0, %xmm0
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    retq
  %res = call <4 x float> @llvm.vp.sqrt.v4f32(<4 x float> %a0, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.sqrt.v4f32(<4 x float>, <4 x i1>, i32)

define void @vp_fneg_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i32 %vp) nounwind {
; SSE-LABEL: vp_fneg_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX1-LABEL: vp_fneg_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vxorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vmovaps %xmm0, (%rdi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: vp_fneg_v4f32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; AVX2-NEXT:    vxorps %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vmovaps %xmm0, (%rdi)
; AVX2-NEXT:    retq
;
; AVX512-LABEL: vp_fneg_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpxord {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm0
; AVX512-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX512-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fneg.v4f32(<4 x float> %a0, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 %vp)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fneg.v4f32(<4 x float>, <4 x i1>, i32)

define void @vp_fma_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i4 %a5) nounwind {
; SSE-LABEL: vp_fma_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    pushq %rbx
; SSE-NEXT:    subq $64, %rsp
; SSE-NEXT:    movq %rdi, %rbx
; SSE-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[3,3,3,3]
; SSE-NEXT:    movaps %xmm1, %xmm2
; SSE-NEXT:    callq fmaf@PLT
; SSE-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    movaps %xmm1, %xmm2
; SSE-NEXT:    callq fmaf@PLT
; SSE-NEXT:    unpcklps (%rsp), %xmm0 # 16-byte Folded Reload
; SSE-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, %xmm2
; SSE-NEXT:    callq fmaf@PLT
; SSE-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; SSE-NEXT:    movaps %xmm1, %xmm2
; SSE-NEXT:    callq fmaf@PLT
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE-NEXT:    unpcklpd (%rsp), %xmm1 # 16-byte Folded Reload
; SSE-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE-NEXT:    movaps %xmm1, (%rbx)
; SSE-NEXT:    addq $64, %rsp
; SSE-NEXT:    popq %rbx
; SSE-NEXT:    retq
;
; AVX1-LABEL: vp_fma_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    pushq %rbx
; AVX1-NEXT:    subq $48, %rsp
; AVX1-NEXT:    movq %rdi, %rbx
; AVX1-NEXT:    vmovaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX1-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX1-NEXT:    vmovaps %xmm1, %xmm2
; AVX1-NEXT:    callq fmaf@PLT
; AVX1-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX1-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX1-NEXT:    # xmm0 = mem[1,1,3,3]
; AVX1-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX1-NEXT:    # xmm1 = mem[1,1,3,3]
; AVX1-NEXT:    vmovaps %xmm1, %xmm2
; AVX1-NEXT:    callq fmaf@PLT
; AVX1-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX1-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; AVX1-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX1-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX1-NEXT:    # xmm0 = mem[1,0]
; AVX1-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX1-NEXT:    # xmm1 = mem[1,0]
; AVX1-NEXT:    vmovapd %xmm1, %xmm2
; AVX1-NEXT:    callq fmaf@PLT
; AVX1-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX1-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; AVX1-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX1-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX1-NEXT:    # xmm0 = mem[3,3,3,3]
; AVX1-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX1-NEXT:    # xmm1 = mem[3,3,3,3]
; AVX1-NEXT:    vmovaps %xmm1, %xmm2
; AVX1-NEXT:    callq fmaf@PLT
; AVX1-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX1-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; AVX1-NEXT:    vmovaps %xmm0, (%rbx)
; AVX1-NEXT:    addq $48, %rsp
; AVX1-NEXT:    popq %rbx
; AVX1-NEXT:    retq
;
; AVX2-LABEL: vp_fma_v4f32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    pushq %rbx
; AVX2-NEXT:    subq $48, %rsp
; AVX2-NEXT:    movq %rdi, %rbx
; AVX2-NEXT:    vmovaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX2-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; AVX2-NEXT:    vmovaps %xmm1, %xmm2
; AVX2-NEXT:    callq fmaf@PLT
; AVX2-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX2-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX2-NEXT:    # xmm0 = mem[1,1,3,3]
; AVX2-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX2-NEXT:    # xmm1 = mem[1,1,3,3]
; AVX2-NEXT:    vmovaps %xmm1, %xmm2
; AVX2-NEXT:    callq fmaf@PLT
; AVX2-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX2-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; AVX2-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX2-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX2-NEXT:    # xmm0 = mem[1,0]
; AVX2-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX2-NEXT:    # xmm1 = mem[1,0]
; AVX2-NEXT:    vmovapd %xmm1, %xmm2
; AVX2-NEXT:    callq fmaf@PLT
; AVX2-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX2-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; AVX2-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; AVX2-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; AVX2-NEXT:    # xmm0 = mem[3,3,3,3]
; AVX2-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; AVX2-NEXT:    # xmm1 = mem[3,3,3,3]
; AVX2-NEXT:    vmovaps %xmm1, %xmm2
; AVX2-NEXT:    callq fmaf@PLT
; AVX2-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; AVX2-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; AVX2-NEXT:    vmovaps %xmm0, (%rbx)
; AVX2-NEXT:    addq $48, %rsp
; AVX2-NEXT:    popq %rbx
; AVX2-NEXT:    retq
;
; AVX512-LABEL: vp_fma_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vfmadd213ps {{.*#+}} xmm0 = (xmm1 * xmm0) + xmm1
; AVX512-NEXT:    vmovaps %xmm0, (%rdi)
; AVX512-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fma.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 4)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fma.v4f32(<4 x float>, <4 x float>, <4 x float>, <4 x i1>, i32)

define void @vp_fmuladd_v4f32(<4 x float> %a0, <4 x float> %a1, ptr %out, i4 %a5) nounwind {
; SSE-LABEL: vp_fmuladd_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    mulps %xmm1, %xmm0
; SSE-NEXT:    addps %xmm1, %xmm0
; SSE-NEXT:    movaps %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX1-LABEL: vp_fmuladd_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vmovaps %xmm0, (%rdi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: vp_fmuladd_v4f32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vmovaps %xmm0, (%rdi)
; AVX2-NEXT:    retq
;
; AVX512-LABEL: vp_fmuladd_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vfmadd213ps {{.*#+}} xmm0 = (xmm1 * xmm0) + xmm1
; AVX512-NEXT:    vmovaps %xmm0, (%rdi)
; AVX512-NEXT:    retq
  %res = call <4 x float> @llvm.vp.fmuladd.v4f32(<4 x float> %a0, <4 x float> %a1, <4 x float> %a1, <4 x i1> <i1 -1, i1 -1, i1 -1, i1 -1>, i32 4)
  store <4 x float> %res, ptr %out
  ret void
}
declare <4 x float> @llvm.vp.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>, <4 x i1>, i32)


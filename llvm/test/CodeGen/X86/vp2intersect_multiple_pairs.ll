; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512vp2intersect -verify-machineinstrs | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vp2intersect -verify-machineinstrs | FileCheck %s --check-prefix=X64

; Test with more than four live mask pairs

define void @test(<16 x i32> %a0, <16 x i32> %b0, <16 x i32> %a1, <16 x i32> %b1, <16 x i32> %a2, <16 x i32> %b2, <16 x i32> %a3, <16 x i32> %b3, <16 x i32> %a4, <16 x i32> %b4, ptr nocapture %m0, ptr nocapture %m1) nounwind {
; X86-LABEL: test:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    andl $-64, %esp
; X86-NEXT:    subl $64, %esp
; X86-NEXT:    movl 456(%ebp), %esi
; X86-NEXT:    vmovaps 328(%ebp), %zmm3
; X86-NEXT:    vmovaps 200(%ebp), %zmm4
; X86-NEXT:    vmovaps 72(%ebp), %zmm5
; X86-NEXT:    vp2intersectd %zmm1, %zmm0, %k0
; X86-NEXT:    kmovw %k0, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    kmovw %k1, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    vp2intersectd 8(%ebp), %zmm2, %k0
; X86-NEXT:    kmovw %k0, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    kmovw %k1, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    vp2intersectd 136(%ebp), %zmm5, %k0
; X86-NEXT:    kmovw %k0, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    kmovw %k1, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    vp2intersectd 264(%ebp), %zmm4, %k0
; X86-NEXT:    kmovw %k0, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    kmovw %k1, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    vp2intersectd 392(%ebp), %zmm3, %k0
; X86-NEXT:    kmovw %k0, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    kmovw %k1, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; X86-NEXT:    vzeroupper
; X86-NEXT:    calll dummy@PLT
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k0 # 2-byte Reload
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k1 # 2-byte Reload
; X86-NEXT:    kmovw %k0, %eax
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k0 # 2-byte Reload
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k1 # 2-byte Reload
; X86-NEXT:    kmovw %k0, %ecx
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k0 # 2-byte Reload
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k1 # 2-byte Reload
; X86-NEXT:    kmovw %k0, %edx
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k0 # 2-byte Reload
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k1 # 2-byte Reload
; X86-NEXT:    kmovw %k0, %edi
; X86-NEXT:    addl %edi, %eax
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k2 # 2-byte Reload
; X86-NEXT:    kmovw {{[-0-9]+}}(%e{{[sb]}}p), %k3 # 2-byte Reload
; X86-NEXT:    kmovw %k2, %edi
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    kmovw %k1, %ecx
; X86-NEXT:    addl %edi, %ecx
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    addl %edx, %eax
; X86-NEXT:    movw %ax, (%esi)
; X86-NEXT:    leal -8(%ebp), %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: test:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pushq %rbp
; X64-NEXT:    movq %rsp, %rbp
; X64-NEXT:    pushq %rbx
; X64-NEXT:    andq $-64, %rsp
; X64-NEXT:    subq $64, %rsp
; X64-NEXT:    movq %rdi, %rbx
; X64-NEXT:    vmovaps 16(%rbp), %zmm8
; X64-NEXT:    vp2intersectd %zmm1, %zmm0, %k0
; X64-NEXT:    kmovw %k0, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    kmovw %k1, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    vp2intersectd %zmm3, %zmm2, %k0
; X64-NEXT:    kmovw %k0, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    kmovw %k1, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    vp2intersectd %zmm5, %zmm4, %k0
; X64-NEXT:    kmovw %k0, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    kmovw %k1, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    vp2intersectd %zmm7, %zmm6, %k0
; X64-NEXT:    kmovw %k0, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    kmovw %k1, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    vp2intersectd 80(%rbp), %zmm8, %k0
; X64-NEXT:    kmovw %k0, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    kmovw %k1, {{[-0-9]+}}(%r{{[sb]}}p) # 2-byte Spill
; X64-NEXT:    vzeroupper
; X64-NEXT:    callq dummy@PLT
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k0 # 2-byte Reload
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k1 # 2-byte Reload
; X64-NEXT:    kmovw %k0, %eax
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k0 # 2-byte Reload
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k1 # 2-byte Reload
; X64-NEXT:    kmovw %k0, %ecx
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k0 # 2-byte Reload
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k1 # 2-byte Reload
; X64-NEXT:    kmovw %k0, %edx
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k0 # 2-byte Reload
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k1 # 2-byte Reload
; X64-NEXT:    kmovw %k0, %esi
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k0 # 2-byte Reload
; X64-NEXT:    kmovw {{[-0-9]+}}(%r{{[sb]}}p), %k1 # 2-byte Reload
; X64-NEXT:    kmovw %k0, %edi
; X64-NEXT:    kmovw %k1, %r8d
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    addl %ecx, %edx
; X64-NEXT:    addl %eax, %edx
; X64-NEXT:    addl %r8d, %edx
; X64-NEXT:    addl %esi, %edx
; X64-NEXT:    movw %dx, (%rbx)
; X64-NEXT:    leaq -8(%rbp), %rsp
; X64-NEXT:    popq %rbx
; X64-NEXT:    popq %rbp
; X64-NEXT:    retq
entry:
  %0 = call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %a0, <16 x i32> %b0)
  %1 = call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %a1, <16 x i32> %b1)
  %2 = call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %a2, <16 x i32> %b2)
  %3 = call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %a3, <16 x i32> %b3)
  %4 = call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %a4, <16 x i32> %b4)

  %5 = extractvalue { <16 x i1>, <16 x i1> } %0, 0
  %6 = extractvalue { <16 x i1>, <16 x i1> } %1, 0
  %7 = extractvalue { <16 x i1>, <16 x i1> } %2, 0
  %8 = extractvalue { <16 x i1>, <16 x i1> } %3, 0
  %9 = extractvalue { <16 x i1>, <16 x i1> } %4, 0
  %10 = extractvalue { <16 x i1>, <16 x i1> } %0, 1
  %11 = extractvalue { <16 x i1>, <16 x i1> } %1, 1

  call void @dummy()

  %12 = bitcast <16 x i1> %5 to i16
  %13 = bitcast <16 x i1> %6 to i16
  %14 = bitcast <16 x i1> %7 to i16
  %15 = bitcast <16 x i1> %8 to i16
  %16 = bitcast <16 x i1> %9 to i16
  %17 = bitcast <16 x i1> %10 to i16
  %18 = bitcast <16 x i1> %11 to i16

  %19 = add i16 %12, %13
  %20 = add i16 %14, %15
  %21 = add i16 %16, %17
  %22 = add i16 %19, %21
  %23 = add i16 %22, %20

  store i16 %23, ptr %m0, align 16
  ret void
}

declare { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32>, <16 x i32>)
declare void @dummy()

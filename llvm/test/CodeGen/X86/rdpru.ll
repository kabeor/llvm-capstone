; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -mattr=+rdpru | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=i686-- -mattr=+rdpru -fast-isel | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-- -mattr=+rdpru | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-- -mattr=+rdpru -fast-isel | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-- -mcpu=znver2 | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-- -mcpu=znver3 -fast-isel | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-- -mcpu=znver4 -fast-isel | FileCheck %s --check-prefix=X64

define void @rdpru_asm() {
; X86-LABEL: rdpru_asm:
; X86:       # %bb.0: # %entry
; X86-NEXT:    #APP
; X86-NEXT:    rdpru
; X86-NEXT:    #NO_APP
; X86-NEXT:    retl
;
; X64-LABEL: rdpru_asm:
; X64:       # %bb.0: # %entry
; X64-NEXT:    #APP
; X64-NEXT:    rdpru
; X64-NEXT:    #NO_APP
; X64-NEXT:    retq
entry:
  call void asm sideeffect "rdpru", "~{dirflag},~{fpsr},~{flags}"()
  ret void
}

define i64 @rdpru_param(i32 %regid) local_unnamed_addr {
; X86-LABEL: rdpru_param:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    rdpru
; X86-NEXT:    retl
;
; X64-LABEL: rdpru_param:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    rdpru
; X64-NEXT:    shlq $32, %rdx
; X64-NEXT:    orq %rdx, %rax
; X64-NEXT:    retq
entry:
  %0 = tail call i64 @llvm.x86.rdpru(i32 %regid)
  ret i64 %0
}

define i64 @rdpru_mperf() local_unnamed_addr {
; X86-LABEL: rdpru_mperf:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    rdpru
; X86-NEXT:    retl
;
; X64-LABEL: rdpru_mperf:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    rdpru
; X64-NEXT:    shlq $32, %rdx
; X64-NEXT:    orq %rdx, %rax
; X64-NEXT:    retq
entry:
  %0 = tail call i64 @llvm.x86.rdpru(i32 0)
  ret i64 %0
}

define i64 @rdpru_aperf() local_unnamed_addr {
; X86-LABEL: rdpru_aperf:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl $1, %ecx
; X86-NEXT:    rdpru
; X86-NEXT:    retl
;
; X64-LABEL: rdpru_aperf:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl $1, %ecx
; X64-NEXT:    rdpru
; X64-NEXT:    shlq $32, %rdx
; X64-NEXT:    orq %rdx, %rax
; X64-NEXT:    retq
entry:
  %0 = tail call i64 @llvm.x86.rdpru(i32 1)
  ret i64 %0
}

declare i64 @llvm.x86.rdpru(i32)

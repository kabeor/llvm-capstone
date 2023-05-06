; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s


define i32 @foo(ptr nocapture %perm, i32 %n) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    movaps {{.*#+}} xmm0 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    andl $1, %ecx
; CHECK-NEXT:    movaps {{.*#+}} xmm1 = [2,3]
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_1: # %body
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq -24(%rsp,%rcx,8), %rdx
; CHECK-NEXT:    movups %xmm0, (%rdi,%rdx,8)
; CHECK-NEXT:    testq %rdx, %rdx
; CHECK-NEXT:    movaps %xmm1, %xmm0
; CHECK-NEXT:    jne .LBB0_1
; CHECK-NEXT:  # %bb.2: # %exit
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  br label %body

body:
  %vec.ind = phi <2 x i64> [ <i64 0, i64 1>, %entry ], [ <i64 2, i64 3>, %body ]
  %l13 = extractelement <2 x i64> %vec.ind, i32 %n
  %l14 = getelementptr inbounds i64, ptr %perm, i64 %l13
  store <2 x i64> %vec.ind, ptr %l14, align 8
  %niter.ncmp.3 = icmp eq i64 %l13, 0
  br i1 %niter.ncmp.3, label %exit, label %body

exit:
  ret i32 %n

}


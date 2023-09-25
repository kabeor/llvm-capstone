; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=-slow-incdec | FileCheck %s --check-prefixes=X64,X64-FASTINC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+slow-incdec | FileCheck %s --check-prefixes=X64,X64-SLOWINC

; Select of constants: control flow / conditional moves can always be replaced by logic+math (but may not be worth it?).
; Test the zeroext/signext variants of each pattern to see if that makes a difference.

; select Cond, 0, 1 --> zext (!Cond)

define i32 @select_0_or_1(i1 %cond) {
; X86-LABEL: select_0_or_1:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    notb %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_0_or_1:
; X64:       # %bb.0:
; X64-NEXT:    notb %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 0, i32 1
  ret i32 %sel
}

define i32 @select_0_or_1_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_0_or_1_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorb $1, %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_0_or_1_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    xorb $1, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 0, i32 1
  ret i32 %sel
}

define i32 @select_0_or_1_signext(i1 signext %cond) {
; X86-LABEL: select_0_or_1_signext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    notb %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_0_or_1_signext:
; X64:       # %bb.0:
; X64-NEXT:    notb %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 0, i32 1
  ret i32 %sel
}

; select Cond, 1, 0 --> zext (Cond)

define i32 @select_1_or_0(i1 %cond) {
; X86-LABEL: select_1_or_0:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_1_or_0:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 1, i32 0
  ret i32 %sel
}

define i32 @select_1_or_0_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_1_or_0_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_1_or_0_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 1, i32 0
  ret i32 %sel
}

define i32 @select_1_or_0_signext(i1 signext %cond) {
; X86-LABEL: select_1_or_0_signext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_1_or_0_signext:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 1, i32 0
  ret i32 %sel
}

; select Cond, 0, -1 --> sext (!Cond)

define i32 @select_0_or_neg1(i1 %cond) {
; X86-LABEL: select_0_or_neg1:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    decl %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_0_or_neg1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $1, %edi
; X64-NEXT:    leal -1(%rdi), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 0, i32 -1
  ret i32 %sel
}

define i32 @select_0_or_neg1_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_0_or_neg1_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    decl %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_0_or_neg1_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal -1(%rdi), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 0, i32 -1
  ret i32 %sel
}

define i32 @select_0_or_neg1_signext(i1 signext %cond) {
; X86-LABEL: select_0_or_neg1_signext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    decl %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_0_or_neg1_signext:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    notl %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 0, i32 -1
  ret i32 %sel
}

; select Cond, -1, 0 --> sext (Cond)

define i32 @select_neg1_or_0(i1 %cond) {
; X86-LABEL: select_neg1_or_0:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_neg1_or_0:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 -1, i32 0
  ret i32 %sel
}

define i32 @select_neg1_or_0_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_neg1_or_0_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_neg1_or_0_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 -1, i32 0
  ret i32 %sel
}

define i32 @select_neg1_or_0_signext(i1 signext %cond) {
; X86-LABEL: select_neg1_or_0_signext:
; X86:       # %bb.0:
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_neg1_or_0_signext:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 -1, i32 0
  ret i32 %sel
}

; select Cond, C+1, C --> add (zext Cond), C

define i32 @select_Cplus1_C(i1 %cond) {
; X86-LABEL: select_Cplus1_C:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    addl $41, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_Cplus1_C:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $1, %edi
; X64-NEXT:    leal 41(%rdi), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 42, i32 41
  ret i32 %sel
}

define i32 @select_Cplus1_C_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_Cplus1_C_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl $41, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_Cplus1_C_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal 41(%rdi), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 42, i32 41
  ret i32 %sel
}

define i32 @select_Cplus1_C_signext(i1 signext %cond) {
; X86-LABEL: select_Cplus1_C_signext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    addl $41, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_Cplus1_C_signext:
; X64:       # %bb.0:
; X64-NEXT:    movl $41, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 42, i32 41
  ret i32 %sel
}

; select Cond, C, C+1 --> add (sext Cond), C

define i32 @select_C_Cplus1(i1 %cond) {
; X86-LABEL: select_C_Cplus1:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    movl $42, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_C_Cplus1:
; X64:       # %bb.0:
; X64-NEXT:    andl $1, %edi
; X64-NEXT:    movl $42, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 41, i32 42
  ret i32 %sel
}

define i32 @select_C_Cplus1_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_C_Cplus1_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $42, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_C_Cplus1_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    movl $42, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 41, i32 42
  ret i32 %sel
}

define i32 @select_C_Cplus1_signext(i1 signext %cond) {
; X86-LABEL: select_C_Cplus1_signext:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    movl $42, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_C_Cplus1_signext:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal 42(%rdi), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 41, i32 42
  ret i32 %sel
}

; If the constants differ by a small multiplier, use LEA.
; select Cond, C1, C2 --> add (mul (zext Cond), C1-C2), C2 --> LEA C2(Cond * (C1-C2))

define i32 @select_lea_2(i1 zeroext %cond) {
; X86-LABEL: select_lea_2:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    orl $1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_lea_2:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    orl $1, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 -1, i32 1
  ret i32 %sel
}

define i64 @select_lea_3(i1 zeroext %cond) {
; X86-LABEL: select_lea_3:
; X86:       # %bb.0:
; X86-NEXT:    cmpb $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $-2, %eax
; X86-NEXT:    je .LBB19_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    je .LBB19_3
; X86-NEXT:  .LBB19_4:
; X86-NEXT:    retl
; X86-NEXT:  .LBB19_1:
; X86-NEXT:    movl $1, %eax
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    jne .LBB19_4
; X86-NEXT:  .LBB19_3:
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: select_lea_3:
; X64:       # %bb.0:
; X64-NEXT:    xorb $1, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    leaq -2(%rax,%rax,2), %rax
; X64-NEXT:    retq
  %sel = select i1 %cond, i64 -2, i64 1
  ret i64 %sel
}

define i32 @select_lea_5(i1 zeroext %cond) {
; X86-LABEL: select_lea_5:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorb $1, %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    leal -2(%eax,%eax,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_lea_5:
; X64:       # %bb.0:
; X64-NEXT:    xorb $1, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    leal -2(%rax,%rax,4), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 -2, i32 3
  ret i32 %sel
}

define i64 @select_lea_9(i1 zeroext %cond) {
; X86-LABEL: select_lea_9:
; X86:       # %bb.0:
; X86-NEXT:    cmpb $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $-7, %eax
; X86-NEXT:    je .LBB21_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    je .LBB21_3
; X86-NEXT:  .LBB21_4:
; X86-NEXT:    retl
; X86-NEXT:  .LBB21_1:
; X86-NEXT:    movl $2, %eax
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    jne .LBB21_4
; X86-NEXT:  .LBB21_3:
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: select_lea_9:
; X64:       # %bb.0:
; X64-NEXT:    xorb $1, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    leaq -7(%rax,%rax,8), %rax
; X64-NEXT:    retq
  %sel = select i1 %cond, i64 -7, i64 2
  ret i64 %sel
}

; Should this be 'sbb x,x' or 'sbb 0,x' with simpler LEA or add?

define i64 @sel_1_2(i64 %x, i64 %y) {
; X86-LABEL: sel_1_2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmpl $42, {{[0-9]+}}(%esp)
; X86-NEXT:    sbbl $0, %ecx
; X86-NEXT:    sbbl $0, %eax
; X86-NEXT:    sbbl $0, %edx
; X86-NEXT:    addl $2, %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; X64-LABEL: sel_1_2:
; X64:       # %bb.0:
; X64-NEXT:    cmpq $42, %rdi
; X64-NEXT:    sbbq $0, %rsi
; X64-NEXT:    leaq 2(%rsi), %rax
; X64-NEXT:    retq
  %cmp = icmp ult i64 %x, 42
  %sel = select i1 %cmp, i64 1, i64 2
  %sub = add i64 %sel, %y
  ret i64 %sub
}

; No LEA with 8-bit, but this shouldn't need branches or cmov.

define i8 @sel_1_neg1(i32 %x) {
; X86-LABEL: sel_1_neg1:
; X86:       # %bb.0:
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    negb %al
; X86-NEXT:    orb $3, %al
; X86-NEXT:    retl
;
; X64-LABEL: sel_1_neg1:
; X64:       # %bb.0:
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    negb %al
; X64-NEXT:    orb $3, %al
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sel = select i1 %cmp, i8 3, i8 -1
  ret i8 %sel
}

; We get an LEA for 16-bit because we ignore the high-bits.

define i16 @sel_neg1_1(i32 %x) {
; X86-LABEL: sel_neg1_1:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(,%eax,4), %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: sel_neg1_1:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(,%rax,4), %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sel = select i1 %cmp, i16 -1, i16 3
  ret i16 %sel
}

; If the comparison is available, the predicate can be inverted.

define i32 @sel_1_neg1_32(i32 %x) {
; X86-LABEL: sel_1_neg1_32:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setge %al
; X86-NEXT:    leal -1(%eax,%eax,8), %eax
; X86-NEXT:    retl
;
; X64-LABEL: sel_1_neg1_32:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setge %al
; X64-NEXT:    leal -1(%rax,%rax,8), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sel = select i1 %cmp, i32 8, i32 -1
  ret i32 %sel
}

define i32 @sel_neg1_1_32(i32 %x) {
; X86-LABEL: sel_neg1_1_32:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -7(%eax,%eax,8), %eax
; X86-NEXT:    retl
;
; X64-LABEL: sel_neg1_1_32:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -7(%rax,%rax,8), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sel = select i1 %cmp, i32 -7, i32 2
  ret i32 %sel
}


; If the constants differ by a large power-of-2, that can be a shift of the difference plus the smaller constant.
; select Cond, C1, C2 --> add (mul (zext Cond), C1-C2), C2

define i8 @select_pow2_diff(i1 zeroext %cond) {
; X86-LABEL: select_pow2_diff:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shlb $4, %al
; X86-NEXT:    orb $3, %al
; X86-NEXT:    retl
;
; X64-LABEL: select_pow2_diff:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shlb $4, %dil
; X64-NEXT:    leal 3(%rdi), %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i8 19, i8 3
  ret i8 %sel
}

define i16 @select_pow2_diff_invert(i1 zeroext %cond) {
; X86-LABEL: select_pow2_diff_invert:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorb $1, %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    shll $6, %eax
; X86-NEXT:    orl $7, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: select_pow2_diff_invert:
; X64:       # %bb.0:
; X64-NEXT:    xorb $1, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    shll $6, %eax
; X64-NEXT:    orl $7, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i16 7, i16 71
  ret i16 %sel
}

define i32 @select_pow2_diff_neg(i1 zeroext %cond) {
; X86-LABEL: select_pow2_diff_neg:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $4, %eax
; X86-NEXT:    orl $-25, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_pow2_diff_neg:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shll $4, %edi
; X64-NEXT:    leal -25(%rdi), %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 -9, i32 -25
  ret i32 %sel
}

define i64 @select_pow2_diff_neg_invert(i1 zeroext %cond) {
; X86-LABEL: select_pow2_diff_neg_invert:
; X86:       # %bb.0:
; X86-NEXT:    cmpb $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $-99, %eax
; X86-NEXT:    je .LBB30_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    je .LBB30_3
; X86-NEXT:  .LBB30_4:
; X86-NEXT:    retl
; X86-NEXT:  .LBB30_1:
; X86-NEXT:    movl $29, %eax
; X86-NEXT:    movl $-1, %edx
; X86-NEXT:    jne .LBB30_4
; X86-NEXT:  .LBB30_3:
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: select_pow2_diff_neg_invert:
; X64:       # %bb.0:
; X64-NEXT:    xorb $1, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    shlq $7, %rax
; X64-NEXT:    addq $-99, %rax
; X64-NEXT:    retq
  %sel = select i1 %cond, i64 -99, i64 29
  ret i64 %sel
}

; This doesn't need a branch, but don't do the wrong thing if subtraction of the constants overflows.

define i8 @sel_67_neg125(i32 %x) {
; X86-LABEL: sel_67_neg125:
; X86:       # %bb.0:
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    movb $67, %al
; X86-NEXT:    jge .LBB31_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movb $-125, %al
; X86-NEXT:  .LBB31_2:
; X86-NEXT:    retl
;
; X64-LABEL: sel_67_neg125:
; X64:       # %bb.0:
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    movl $67, %ecx
; X64-NEXT:    movl $131, %eax
; X64-NEXT:    cmovgel %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sel = select i1 %cmp, i8 67, i8 -125
  ret i8 %sel
}


; In general, select of 2 constants could be:
; select Cond, C1, C2 --> add (mul (zext Cond), C1-C2), C2 --> add (and (sext Cond), C1-C2), C2

define i32 @select_C1_C2(i1 %cond) {
; X86-LABEL: select_C1_C2:
; X86:       # %bb.0:
; X86-NEXT:    testb $1, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $421, %eax # imm = 0x1A5
; X86-NEXT:    jne .LBB32_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl $42, %eax
; X86-NEXT:  .LBB32_2:
; X86-NEXT:    retl
;
; X64-LABEL: select_C1_C2:
; X64:       # %bb.0:
; X64-NEXT:    testb $1, %dil
; X64-NEXT:    movl $421, %ecx # imm = 0x1A5
; X64-NEXT:    movl $42, %eax
; X64-NEXT:    cmovnel %ecx, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 421, i32 42
  ret i32 %sel
}

define i32 @select_C1_C2_zeroext(i1 zeroext %cond) {
; X86-LABEL: select_C1_C2_zeroext:
; X86:       # %bb.0:
; X86-NEXT:    cmpb $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $421, %eax # imm = 0x1A5
; X86-NEXT:    jne .LBB33_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl $42, %eax
; X86-NEXT:  .LBB33_2:
; X86-NEXT:    retl
;
; X64-LABEL: select_C1_C2_zeroext:
; X64:       # %bb.0:
; X64-NEXT:    testl %edi, %edi
; X64-NEXT:    movl $421, %ecx # imm = 0x1A5
; X64-NEXT:    movl $42, %eax
; X64-NEXT:    cmovnel %ecx, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 421, i32 42
  ret i32 %sel
}

define i32 @select_C1_C2_signext(i1 signext %cond) {
; X86-LABEL: select_C1_C2_signext:
; X86:       # %bb.0:
; X86-NEXT:    testb $1, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $421, %eax # imm = 0x1A5
; X86-NEXT:    jne .LBB34_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl $42, %eax
; X86-NEXT:  .LBB34_2:
; X86-NEXT:    retl
;
; X64-LABEL: select_C1_C2_signext:
; X64:       # %bb.0:
; X64-NEXT:    testb $1, %dil
; X64-NEXT:    movl $421, %ecx # imm = 0x1A5
; X64-NEXT:    movl $42, %eax
; X64-NEXT:    cmovnel %ecx, %eax
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 421, i32 42
  ret i32 %sel
}

define i32 @select_n_or_minus1(i1 signext %cond) {
; X86-LABEL: select_n_or_minus1:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    decl %eax
; X86-NEXT:    orl $12414, %eax # imm = 0x307E
; X86-NEXT:    retl
;
; X64-LABEL: select_n_or_minus1:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    notl %eax
; X64-NEXT:    orl $12414, %eax # imm = 0x307E
; X64-NEXT:    retq
  %sel = select i1 %cond, i32 12414, i32 -1
  ret i32 %sel
}

; select (x == 2), 2, (x + 1) --> select (x == 2), x, (x + 1)

define i64 @select_2_or_inc(i64 %x) {
; X86-LABEL: select_2_or_inc:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    .cfi_offset %esi, -12
; X86-NEXT:    .cfi_offset %edi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %ecx, %edi
; X86-NEXT:    xorl $2, %edi
; X86-NEXT:    addl $1, %ecx
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    adcl $0, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    orl %esi, %edi
; X86-NEXT:    je .LBB36_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:  .LBB36_2:
; X86-NEXT:    movl $2, %eax
; X86-NEXT:    je .LBB36_4
; X86-NEXT:  # %bb.3:
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB36_4:
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: select_2_or_inc:
; X64:       # %bb.0:
; X64-NEXT:    leaq 1(%rdi), %rax
; X64-NEXT:    cmpq $2, %rdi
; X64-NEXT:    cmoveq %rdi, %rax
; X64-NEXT:    retq
  %cmp = icmp eq i64 %x, 2
  %add = add i64 %x, 1
  %retval.0 = select i1 %cmp, i64 2, i64 %add
  ret i64 %retval.0
}

define <4 x i32> @sel_constants_add_constant_vec(i1 %cond) {
; X86-LABEL: sel_constants_add_constant_vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    .cfi_offset %esi, -16
; X86-NEXT:    .cfi_offset %edi, -12
; X86-NEXT:    .cfi_offset %ebx, -8
; X86-NEXT:    testb $1, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $-3, %ecx
; X86-NEXT:    jne .LBB37_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl $12, %ecx
; X86-NEXT:  .LBB37_2:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $4, %esi
; X86-NEXT:    movl $4, %edx
; X86-NEXT:    jne .LBB37_4
; X86-NEXT:  # %bb.3:
; X86-NEXT:    movl $14, %edx
; X86-NEXT:  .LBB37_4:
; X86-NEXT:    jne .LBB37_6
; X86-NEXT:  # %bb.5:
; X86-NEXT:    movl $15, %esi
; X86-NEXT:  .LBB37_6:
; X86-NEXT:    setne %bl
; X86-NEXT:    movzbl %bl, %edi
; X86-NEXT:    addl $13, %edi
; X86-NEXT:    movl %esi, 12(%eax)
; X86-NEXT:    movl %edx, 8(%eax)
; X86-NEXT:    movl %edi, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl $4
;
; X64-LABEL: sel_constants_add_constant_vec:
; X64:       # %bb.0:
; X64-NEXT:    testb $1, %dil
; X64-NEXT:    jne .LBB37_1
; X64-NEXT:  # %bb.2:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [12,13,14,15]
; X64-NEXT:    retq
; X64-NEXT:  .LBB37_1:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [4294967293,14,4,4]
; X64-NEXT:    retq
  %sel = select i1 %cond, <4 x i32> <i32 -4, i32 12, i32 1, i32 0>, <4 x i32> <i32 11, i32 11, i32 11, i32 11>
  %bo = add <4 x i32> %sel, <i32 1, i32 2, i32 3, i32 4>
  ret <4 x i32> %bo
}

define <2 x double> @sel_constants_fmul_constant_vec(i1 %cond) {
; X86-LABEL: sel_constants_fmul_constant_vec:
; X86:       # %bb.0:
; X86-NEXT:    testb $1, {{[0-9]+}}(%esp)
; X86-NEXT:    fldl {{\.?LCPI[0-9]+_[0-9]+}}
; X86-NEXT:    fldl {{\.?LCPI[0-9]+_[0-9]+}}
; X86-NEXT:    jne .LBB38_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    fstp %st(1)
; X86-NEXT:    fldz
; X86-NEXT:  .LBB38_2:
; X86-NEXT:    fstp %st(0)
; X86-NEXT:    fldl {{\.?LCPI[0-9]+_[0-9]+}}
; X86-NEXT:    fldl {{\.?LCPI[0-9]+_[0-9]+}}
; X86-NEXT:    jne .LBB38_4
; X86-NEXT:  # %bb.3:
; X86-NEXT:    fstp %st(1)
; X86-NEXT:    fldz
; X86-NEXT:  .LBB38_4:
; X86-NEXT:    fstp %st(0)
; X86-NEXT:    retl
;
; X64-LABEL: sel_constants_fmul_constant_vec:
; X64:       # %bb.0:
; X64-NEXT:    testb $1, %dil
; X64-NEXT:    jne .LBB38_1
; X64-NEXT:  # %bb.2:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [1.1883E+2,3.4539999999999999E+1]
; X64-NEXT:    retq
; X64-NEXT:  .LBB38_1:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [-2.0399999999999999E+1,3.768E+1]
; X64-NEXT:    retq
  %sel = select i1 %cond, <2 x double> <double -4.0, double 12.0>, <2 x double> <double 23.3, double 11.0>
  %bo = fmul <2 x double> %sel, <double 5.1, double 3.14>
  ret <2 x double> %bo
}

; 4294967297 = 0x100000001.
; This becomes an opaque constant via ConstantHoisting, so we don't fold it into the select.

define i64 @opaque_constant(i1 %cond, i64 %x) {
; X86-LABEL: opaque_constant:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    .cfi_offset %esi, -12
; X86-NEXT:    .cfi_offset %ebx, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    testb $1, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $-4, %eax
; X86-NEXT:    jne .LBB39_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl $23, %eax
; X86-NEXT:  .LBB39_2:
; X86-NEXT:    setne %dl
; X86-NEXT:    movzbl %dl, %edx
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    xorl $1, %esi
; X86-NEXT:    xorl $1, %ecx
; X86-NEXT:    xorl %ebx, %ebx
; X86-NEXT:    orl %esi, %ecx
; X86-NEXT:    sete %bl
; X86-NEXT:    subl %ebx, %eax
; X86-NEXT:    sbbl $0, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: opaque_constant:
; X64:       # %bb.0:
; X64-NEXT:    testb $1, %dil
; X64-NEXT:    movq $-4, %rcx
; X64-NEXT:    movl $23, %eax
; X64-NEXT:    cmovneq %rcx, %rax
; X64-NEXT:    movabsq $4294967297, %rcx # imm = 0x100000001
; X64-NEXT:    andq %rcx, %rax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    cmpq %rcx, %rsi
; X64-NEXT:    sete %dl
; X64-NEXT:    subq %rdx, %rax
; X64-NEXT:    retq
  %sel = select i1 %cond, i64 -4, i64 23
  %bo = and i64 %sel, 4294967297
  %cmp = icmp eq i64 %x, 4294967297
  %sext = sext i1 %cmp to i64
  %add = add i64 %bo, %sext
  ret i64 %add
}

define float @select_undef_fp(float %x) {
; X86-LABEL: select_undef_fp:
; X86:       # %bb.0:
; X86-NEXT:    flds {{\.?LCPI[0-9]+_[0-9]+}}
; X86-NEXT:    retl
;
; X64-LABEL: select_undef_fp:
; X64:       # %bb.0:
; X64-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-NEXT:    retq
  %f = select i1 undef, float 4.0, float %x
  ret float %f
}

define i32 @select_eq0_3_2(i32 %X) {
; X86-LABEL: select_eq0_3_2:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $1, {{[0-9]+}}(%esp)
; X86-NEXT:    adcl $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_eq0_3_2:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $1, %edi
; X64-NEXT:    adcl $2, %eax
; X64-NEXT:    retq
  %cmp = icmp eq i32 %X, 0
  %sel = select i1 %cmp, i32 3, i32 2
  ret i32 %sel
}

define i32 @select_ugt3_2_3(i32 %X) {
; X86-LABEL: select_ugt3_2_3:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $4, {{[0-9]+}}(%esp)
; X86-NEXT:    adcl $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_ugt3_2_3:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $4, %edi
; X64-NEXT:    adcl $2, %eax
; X64-NEXT:    retq
  %cmp = icmp ugt i32 %X, 3
  %sel = select i1 %cmp, i32 2, i32 3
  ret i32 %sel
}

define i32 @select_ult9_7_6(i32 %X) {
; X86-LABEL: select_ult9_7_6:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $9, {{[0-9]+}}(%esp)
; X86-NEXT:    adcl $6, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_ult9_7_6:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $9, %edi
; X64-NEXT:    adcl $6, %eax
; X64-NEXT:    retq
  %cmp = icmp ult i32 %X, 9
  %sel = select i1 %cmp, i32 7, i32 6
  ret i32 %sel
}

define i32 @select_ult2_2_3(i32 %X) {
; X86-LABEL: select_ult2_2_3:
; X86:       # %bb.0:
; X86-NEXT:    cmpl $2, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $3, %eax
; X86-NEXT:    sbbl $0, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_ult2_2_3:
; X64:       # %bb.0:
; X64-NEXT:    cmpl $2, %edi
; X64-NEXT:    movl $3, %eax
; X64-NEXT:    sbbl $0, %eax
; X64-NEXT:    retq
  %cmp = icmp ult i32 %X, 2
  %cond = select i1 %cmp, i32 2, i32 3
  ret i32 %cond
}

define i32 @select_ugt3_3_2(i32 %X) {
; X86-LABEL: select_ugt3_3_2:
; X86:       # %bb.0:
; X86-NEXT:    cmpl $4, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $2, %eax
; X86-NEXT:    sbbl $-1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: select_ugt3_3_2:
; X64:       # %bb.0:
; X64-NEXT:    cmpl $4, %edi
; X64-NEXT:    movl $2, %eax
; X64-NEXT:    sbbl $-1, %eax
; X64-NEXT:    retq
  %cmp.inv = icmp ugt i32 %X, 3
  %cond = select i1 %cmp.inv, i32 3, i32 2
  ret i32 %cond
}

define i32 @select_eq_1_2(i32 %a, i32 %b) {
; X86-LABEL: select_eq_1_2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    setne %al
; X86-NEXT:    incl %eax
; X86-NEXT:    retl
;
; X64-FASTINC-LABEL: select_eq_1_2:
; X64-FASTINC:       # %bb.0:
; X64-FASTINC-NEXT:    xorl %eax, %eax
; X64-FASTINC-NEXT:    cmpl %esi, %edi
; X64-FASTINC-NEXT:    setne %al
; X64-FASTINC-NEXT:    incl %eax
; X64-FASTINC-NEXT:    retq
;
; X64-SLOWINC-LABEL: select_eq_1_2:
; X64-SLOWINC:       # %bb.0:
; X64-SLOWINC-NEXT:    xorl %eax, %eax
; X64-SLOWINC-NEXT:    cmpl %esi, %edi
; X64-SLOWINC-NEXT:    setne %al
; X64-SLOWINC-NEXT:    addl $1, %eax
; X64-SLOWINC-NEXT:    retq

  %cmp = icmp eq i32 %a, %b
  %cond = select i1 %cmp, i32 1, i32 2
  ret i32 %cond
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+xventanacondops < %s | FileCheck %s

define i64 @zero1(i64 %rs1, i1 zeroext %rc) {
; CHECK-LABEL: zero1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a0, a1
; CHECK-NEXT:    ret
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2(i64 %rs1, i1 zeroext %rc) {
; CHECK-LABEL: zero2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a0, a1
; CHECK-NEXT:    ret
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @add1(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: add1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    ret
  %add = add i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %add, i64 %rs1
  ret i64 %sel
}

define i64 @add2(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: add2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    add a0, a2, a0
; CHECK-NEXT:    ret
  %add = add i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %add, i64 %rs2
  ret i64 %sel
}

define i64 @add3(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: add3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    ret
  %add = add i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs1, i64 %add
  ret i64 %sel
}

define i64 @add4(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: add4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    add a0, a2, a0
; CHECK-NEXT:    ret
  %add = add i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs2, i64 %add
  ret i64 %sel
}

define i64 @sub1(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: sub1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    ret
  %sub = sub i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %sub, i64 %rs1
  ret i64 %sel
}

define i64 @sub2(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: sub2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    ret
  %sub = sub i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs1, i64 %sub
  ret i64 %sel
}

define i64 @or1(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: or1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %or = or i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %or, i64 %rs1
  ret i64 %sel
}

define i64 @or2(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: or2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    or a0, a2, a0
; CHECK-NEXT:    ret
  %or = or i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %or, i64 %rs2
  ret i64 %sel
}

define i64 @or3(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: or3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %or = or i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs1, i64 %or
  ret i64 %sel
}

define i64 @or4(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: or4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    or a0, a2, a0
; CHECK-NEXT:    ret
  %or = or i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs2, i64 %or
  ret i64 %sel
}

define i64 @xor1(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: xor1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %xor = xor i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %xor, i64 %rs1
  ret i64 %sel
}

define i64 @xor2(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: xor2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    xor a0, a2, a0
; CHECK-NEXT:    ret
  %xor = xor i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %xor, i64 %rs2
  ret i64 %sel
}

define i64 @xor3(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: xor3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %xor = xor i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs1, i64 %xor
  ret i64 %sel
}

define i64 @xor4(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: xor4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    xor a0, a2, a0
; CHECK-NEXT:    ret
  %xor = xor i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs2, i64 %xor
  ret i64 %sel
}

define i64 @and1(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: and1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    and a1, a1, a2
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %and = and i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %and, i64 %rs1
  ret i64 %sel
}

define i64 @and2(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: and2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    and a1, a2, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %and = and i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %and, i64 %rs2
  ret i64 %sel
}

define i64 @and3(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: and3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    and a1, a1, a2
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %and = and i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs1, i64 %and
  ret i64 %sel
}

define i64 @and4(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: and4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    and a1, a2, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %and = and i64 %rs1, %rs2
  %sel = select i1 %rc, i64 %rs2, i64 %and
  ret i64 %sel
}

define i64 @basic(i1 zeroext %rc, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: basic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a2, a2, a0
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    or a0, a0, a2
; CHECK-NEXT:    ret
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @seteq(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: seteq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    vt.maskcn a1, a2, a0
; CHECK-NEXT:    vt.maskc a0, a3, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setne(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    vt.maskcn a1, a3, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setgt(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slt a0, a1, a0
; CHECK-NEXT:    vt.maskcn a1, a3, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp sgt i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setge(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slt a0, a0, a1
; CHECK-NEXT:    vt.maskcn a1, a2, a0
; CHECK-NEXT:    vt.maskc a0, a3, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp sge i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setlt(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setlt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slt a0, a0, a1
; CHECK-NEXT:    vt.maskcn a1, a3, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp slt i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setle(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slt a0, a1, a0
; CHECK-NEXT:    vt.maskcn a1, a2, a0
; CHECK-NEXT:    vt.maskc a0, a3, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp sle i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setugt(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    vt.maskcn a1, a3, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp ugt i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setuge(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setuge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    vt.maskcn a1, a2, a0
; CHECK-NEXT:    vt.maskc a0, a3, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp uge i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setult(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    vt.maskcn a1, a3, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp ult i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setule(i64 %a, i64 %b, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    vt.maskcn a1, a2, a0
; CHECK-NEXT:    vt.maskc a0, a3, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp ule i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @seteq_zero(i64 %a, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: seteq_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a1, a1, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, 0
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setne_zero(i64 %a, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setne_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a2, a2, a0
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    or a0, a0, a2
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, 0
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @seteq_constant(i64 %a, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: seteq_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, -123
; CHECK-NEXT:    vt.maskcn a1, a1, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, 123
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setne_constant(i64 %a, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setne_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, -456
; CHECK-NEXT:    vt.maskcn a2, a2, a0
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    or a0, a0, a2
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, 456
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @seteq_neg2048(i64 %a, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: seteq_neg2048:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xori a0, a0, -2048
; CHECK-NEXT:    vt.maskcn a1, a1, a0
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    or a0, a0, a1
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, -2048
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @setne_neg2048(i64 %a, i64 %rs1, i64 %rs2) {
; CHECK-LABEL: setne_neg2048:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xori a0, a0, -2048
; CHECK-NEXT:    vt.maskcn a2, a2, a0
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    or a0, a0, a2
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, -2048
  %sel = select i1 %rc, i64 %rs1, i64 %rs2
  ret i64 %sel
}

define i64 @zero1_seteq(i64 %a, i64 %b, i64 %rs1) {
; CHECK-LABEL: zero1_seteq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_seteq(i64 %a, i64 %b, i64 %rs1) {
; CHECK-LABEL: zero2_seteq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, %b
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_setne(i64 %a, i64 %b, i64 %rs1) {
; CHECK-LABEL: zero1_setne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    vt.maskc a0, a2, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, %b
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_setne(i64 %a, i64 %b, i64 %rs1) {
; CHECK-LABEL: zero2_setne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    vt.maskcn a0, a2, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, %b
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_seteq_zero(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero1_seteq_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, 0
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_seteq_zero(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero2_seteq_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, 0
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_setne_zero(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero1_setne_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, 0
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_setne_zero(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero2_setne_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, 0
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_seteq_constant(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero1_seteq_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, 231
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, -231
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_seteq_constant(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero2_seteq_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, -546
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, 546
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_setne_constant(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero1_setne_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, -321
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, 321
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_setne_constant(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero2_setne_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, 654
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, -654
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_seteq_neg2048(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero1_seteq_neg2048:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xori a0, a0, -2048
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, -2048
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_seteq_neg2048(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero2_seteq_neg2048:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xori a0, a0, -2048
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp eq i64 %a, -2048
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

define i64 @zero1_setne_neg2048(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero1_setne_neg2048:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xori a0, a0, -2048
; CHECK-NEXT:    vt.maskc a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, -2048
  %sel = select i1 %rc, i64 %rs1, i64 0
  ret i64 %sel
}

define i64 @zero2_setne_neg2048(i64 %a, i64 %rs1) {
; CHECK-LABEL: zero2_setne_neg2048:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xori a0, a0, -2048
; CHECK-NEXT:    vt.maskcn a0, a1, a0
; CHECK-NEXT:    ret
  %rc = icmp ne i64 %a, -2048
  %sel = select i1 %rc, i64 0, i64 %rs1
  ret i64 %sel
}

; Test that we are able to convert the sext.w int he loop to mv.
define void @sextw_removal_maskc(i1 %c, i32 signext %arg, i32 signext %arg1) nounwind {
; CHECK-LABEL: sextw_removal_maskc:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    mv s0, a2
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    vt.maskc s1, a1, a0
; CHECK-NEXT:  .LBB53_1: # %bb2
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mv a0, s1
; CHECK-NEXT:    call bar@plt
; CHECK-NEXT:    sllw s1, s1, s0
; CHECK-NEXT:    bnez a0, .LBB53_1
; CHECK-NEXT:  # %bb.2: # %bb7
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
bb:
  %i = select i1 %c, i32 %arg, i32 0
  br label %bb2

bb2:                                              ; preds = %bb2, %bb
  %i3 = phi i32 [ %i, %bb ], [ %i5, %bb2 ]
  %i4 = tail call signext i32 @bar(i32 signext %i3)
  %i5 = shl i32 %i3, %arg1
  %i6 = icmp eq i32 %i4, 0
  br i1 %i6, label %bb7, label %bb2

bb7:                                              ; preds = %bb2
  ret void
}
declare signext i32 @bar(i32 signext)

define void @sextw_removal_maskcn(i1 %c, i32 signext %arg, i32 signext %arg1) nounwind {
; CHECK-LABEL: sextw_removal_maskcn:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    mv s0, a2
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    vt.maskcn s1, a1, a0
; CHECK-NEXT:  .LBB54_1: # %bb2
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mv a0, s1
; CHECK-NEXT:    call bar@plt
; CHECK-NEXT:    sllw s1, s1, s0
; CHECK-NEXT:    bnez a0, .LBB54_1
; CHECK-NEXT:  # %bb.2: # %bb7
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
bb:
  %i = select i1 %c, i32 0, i32 %arg
  br label %bb2

bb2:                                              ; preds = %bb2, %bb
  %i3 = phi i32 [ %i, %bb ], [ %i5, %bb2 ]
  %i4 = tail call signext i32 @bar(i32 signext %i3)
  %i5 = shl i32 %i3, %arg1
  %i6 = icmp eq i32 %i4, 0
  br i1 %i6, label %bb7, label %bb2

bb7:                                              ; preds = %bb2
  ret void
}

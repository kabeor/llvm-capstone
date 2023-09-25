; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx1030 < %s | FileCheck %s

; SelectionDAG generates a setcc node with multiple uses:
;
;  t21: i1 = setcc t3, Constant:i32<0>, setne:ch
;      t15: i32,i1 = subcarry Constant:i32<1>, Constant:i32<0>, t21
;    t23: i32 = select t21, t15, Constant:i32<0>

define i32 @f() {
; CHECK-LABEL: f:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:    ds_read_b32 v0, v0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    v_cmp_eq_u32_e32 vcc_lo, 0, v0
; CHECK-NEXT:    v_cndmask_b32_e64 v1, 0, 1, vcc_lo
; CHECK-NEXT:    v_cmp_ne_u32_e32 vcc_lo, 0, v0
; CHECK-NEXT:    v_cndmask_b32_e32 v0, 0, v1, vcc_lo
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = load i32, ptr addrspace(3) null, align 16
  %i6 = icmp ult i32 0, %i
  %i7 = sext i1 %i6 to i32
  %i8 = add i32 %i7, 1
  %i9 = and i32 %i8, %i7
  ret i32 %i9
}

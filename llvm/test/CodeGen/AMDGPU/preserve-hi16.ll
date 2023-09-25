; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -march=amdgcn -mcpu=gfx803 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX8 %s
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX9ALL,GFX900 %s
; RUN: llc -march=amdgcn -mcpu=gfx906 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX9ALL,GFX906 %s
; RUN: llc -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX10 %s
; RUN: llc -march=amdgcn -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX11 %s

define i16 @shl_i16(i16 %x, i16 %y) {
; GFX8-LABEL: shl_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b16_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: shl_i16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_lshlrev_b16_e32 v0, v1, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: shl_i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshlrev_b16 v0, v1, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: shl_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_lshlrev_b16 v0, v1, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = shl i16 %x, %y
  ret i16 %res
}

define i16 @lshr_i16(i16 %x, i16 %y) {
; GFX8-LABEL: lshr_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshrrev_b16_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: lshr_i16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_lshrrev_b16_e32 v0, v1, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: lshr_i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshrrev_b16 v0, v1, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: lshr_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_lshrrev_b16 v0, v1, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = lshr i16 %x, %y
  ret i16 %res
}

define i16 @ashr_i16(i16 %x, i16 %y) {
; GFX8-LABEL: ashr_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_ashrrev_i16_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: ashr_i16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_ashrrev_i16_e32 v0, v1, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: ashr_i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_ashrrev_i16 v0, v1, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: ashr_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_ashrrev_i16 v0, v1, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = ashr i16 %x, %y
  ret i16 %res
}

define i16 @add_u16(i16 %x, i16 %y) {
; GFX8-LABEL: add_u16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_add_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: add_u16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_add_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: add_u16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_add_nc_u16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: add_u16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_add_nc_u16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = add i16 %x, %y
  ret i16 %res
}

define i16 @sub_u16(i16 %x, i16 %y) {
; GFX8-LABEL: sub_u16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_sub_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: sub_u16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_sub_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: sub_u16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_sub_nc_u16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: sub_u16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_sub_nc_u16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = sub i16 %x, %y
  ret i16 %res
}

define i16 @mul_lo_u16(i16 %x, i16 %y) {
; GFX8-LABEL: mul_lo_u16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_mul_lo_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: mul_lo_u16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_mul_lo_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: mul_lo_u16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_mul_lo_u16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: mul_lo_u16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_mul_lo_u16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = mul i16 %x, %y
  ret i16 %res
}

define i16 @min_u16(i16 %x, i16 %y) {
; GFX8-LABEL: min_u16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_min_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: min_u16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_min_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: min_u16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_min_u16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: min_u16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_min_u16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp ule i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  ret i16 %res
}

define i16 @min_i16(i16 %x, i16 %y) {
; GFX8-LABEL: min_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_min_i16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: min_i16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_min_i16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: min_i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_min_i16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: min_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_min_i16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp sle i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  ret i16 %res
}

define i16 @max_u16(i16 %x, i16 %y) {
; GFX8-LABEL: max_u16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_max_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: max_u16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_max_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: max_u16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_max_u16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: max_u16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_max_u16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp uge i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  ret i16 %res
}

define i16 @max_i16(i16 %x, i16 %y) {
; GFX8-LABEL: max_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_max_i16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: max_i16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_max_i16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: max_i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_max_i16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: max_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_max_i16 v0, v0, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp sge i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  ret i16 %res
}

define i32 @shl_i16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: shl_i16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b16_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: shl_i16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_lshlrev_b16_e32 v0, v1, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: shl_i16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshlrev_b16 v0, v1, v0
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: shl_i16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_lshlrev_b16 v0, v1, v0
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = shl i16 %x, %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @lshr_i16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: lshr_i16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshrrev_b16_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: lshr_i16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_lshrrev_b16_e32 v0, v1, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: lshr_i16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshrrev_b16 v0, v1, v0
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: lshr_i16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_lshrrev_b16 v0, v1, v0
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = lshr i16 %x, %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @ashr_i16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: ashr_i16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_ashrrev_i16_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: ashr_i16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_ashrrev_i16_e32 v0, v1, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: ashr_i16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_ashrrev_i16 v0, v1, v0
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: ashr_i16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_ashrrev_i16 v0, v1, v0
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = ashr i16 %x, %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @add_u16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: add_u16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_add_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: add_u16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_add_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: add_u16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_add_nc_u16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: add_u16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_add_nc_u16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = add i16 %x, %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @sub_u16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: sub_u16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_sub_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: sub_u16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_sub_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: sub_u16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_sub_nc_u16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: sub_u16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_sub_nc_u16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = sub i16 %x, %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @mul_lo_u16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: mul_lo_u16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_mul_lo_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: mul_lo_u16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_mul_lo_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: mul_lo_u16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_mul_lo_u16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: mul_lo_u16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_mul_lo_u16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %res = mul i16 %x, %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @min_u16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: min_u16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_min_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: min_u16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_min_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: min_u16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_min_u16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: min_u16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_min_u16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp ule i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @min_i16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: min_i16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_min_i16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: min_i16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_min_i16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: min_i16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_min_i16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: min_i16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_min_i16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp sle i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @max_u16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: max_u16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_max_u16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: max_u16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_max_u16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: max_u16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_max_u16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: max_u16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_max_u16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp uge i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @max_i16_zext_i32(i16 %x, i16 %y) {
; GFX8-LABEL: max_i16_zext_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_max_i16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: max_i16_zext_i32:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_max_i16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: max_i16_zext_i32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_max_i16 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: max_i16_zext_i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_max_i16 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp sge i16 %x, %y
  %res = select i1 %cmp, i16 %x, i16 %y
  %zext = zext i16 %res to i32
  ret i32 %zext
}

define i32 @zext_fadd_f16(half %x, half %y) {
; GFX8-LABEL: zext_fadd_f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_add_f16_e32 v0, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: zext_fadd_f16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_add_f16_e32 v0, v0, v1
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: zext_fadd_f16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_add_f16_e32 v0, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: zext_fadd_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_add_f16_e32 v0, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %add = fadd half %x, %y
  %cast = bitcast half %add to i16
  %zext = zext i16 %cast to i32
  ret i32 %zext
}

define i32 @zext_fma_f16(half %x, half %y, half %z) {
; GFX8-LABEL: zext_fma_f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: zext_fma_f16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX9ALL-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: zext_fma_f16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fmac_f16_e32 v2, v0, v1
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: zext_fma_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_fmac_f16_e32 v2, v0, v1
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v2
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %fma = call half @llvm.fma.f16(half %x, half %y, half %z)
  %cast = bitcast half %fma to i16
  %zext = zext i16 %cast to i32
  ret i32 %zext
}

define i32 @zext_div_fixup_f16(half %x, half %y, half %z) {
; GFX8-LABEL: zext_div_fixup_f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_div_fixup_f16 v0, v0, v1, v2
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: zext_div_fixup_f16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_div_fixup_f16 v0, v0, v1, v2
; GFX9ALL-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: zext_div_fixup_f16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_div_fixup_f16 v0, v0, v1, v2
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: zext_div_fixup_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_div_fixup_f16 v0, v0, v1, v2
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %div.fixup = call half @llvm.amdgcn.div.fixup.f16(half %x, half %y, half %z)
  %cast = bitcast half %div.fixup to i16
  %zext = zext i16 %cast to i32
  ret i32 %zext
}

; We technically could eliminate the and on gfx9 here but we don't try
; to inspect the source of the fptrunc. We're only worried about cases
; that lower to v_fma_mix* instructions.
define i32 @zext_fptrunc_f16(float %x) {
; GFX8-LABEL: zext_fptrunc_f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9ALL-LABEL: zext_fptrunc_f16:
; GFX9ALL:       ; %bb.0:
; GFX9ALL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9ALL-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX9ALL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: zext_fptrunc_f16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: zext_fptrunc_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %fptrunc = fptrunc float %x to half
  %cast = bitcast half %fptrunc to i16
  %zext = zext i16 %cast to i32
  ret i32 %zext
}

define i32 @zext_fptrunc_fma_f16(float %x, float %y, float %z) {
; GFX8-LABEL: zext_fptrunc_fma_f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_fma_f32 v0, v0, v1, v2
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX900-LABEL: zext_fptrunc_fma_f16:
; GFX900:       ; %bb.0:
; GFX900-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX900-NEXT:    v_fma_f32 v0, v0, v1, v2
; GFX900-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX900-NEXT:    s_setpc_b64 s[30:31]
;
; GFX906-LABEL: zext_fptrunc_fma_f16:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_fma_mixlo_f16 v0, v0, v1, v2
; GFX906-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: zext_fptrunc_fma_f16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_mixlo_f16 v0, v0, v1, v2
; GFX10-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: zext_fptrunc_fma_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_fma_mixlo_f16 v0, v0, v1, v2
; GFX11-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %fma = call float @llvm.fma.f32(float %x, float %y, float %z)
  %fptrunc = fptrunc float %fma to half
  %cast = bitcast half %fptrunc to i16
  %zext = zext i16 %cast to i32
  ret i32 %zext
}

declare half @llvm.amdgcn.div.fixup.f16(half, half, half)
declare half @llvm.fma.f16(half, half, half)
declare float @llvm.fma.f32(float, float, float)

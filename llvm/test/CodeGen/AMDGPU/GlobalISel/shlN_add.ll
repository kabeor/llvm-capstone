; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX9 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=fiji -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX8 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX10 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX10 %s

; Test gfx9+ s_shl[1-4]_add_u32 pattern matching

define amdgpu_ps i32 @s_shl1_add_u32(i32 inreg %src0, i32 inreg %src1) {
; GFX9-LABEL: s_shl1_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl1_add_u32 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl1_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 1
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl1_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl1_add_u32 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 1
  %add = add i32 %shl, %src1
  ret i32 %add
}

define amdgpu_ps i32 @s_shl2_add_u32(i32 inreg %src0, i32 inreg %src1) {
; GFX9-LABEL: s_shl2_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl2_add_u32 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl2_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 2
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl2_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl2_add_u32 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 2
  %add = add i32 %shl, %src1
  ret i32 %add
}

define amdgpu_ps i32 @s_shl3_add_u32(i32 inreg %src0, i32 inreg %src1) {
; GFX9-LABEL: s_shl3_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl3_add_u32 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl3_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 3
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl3_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl3_add_u32 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 3
  %add = add i32 %shl, %src1
  ret i32 %add
}

define amdgpu_ps i32 @s_shl4_add_u32(i32 inreg %src0, i32 inreg %src1) {
; GFX9-LABEL: s_shl4_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl4_add_u32 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl4_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 4
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl4_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl4_add_u32 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 4
  %add = add i32 %shl, %src1
  ret i32 %add
}

define amdgpu_ps i32 @s_shl5_add_u32(i32 inreg %src0, i32 inreg %src1) {
; GCN-LABEL: s_shl5_add_u32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_lshl_b32 s0, s0, 5
; GCN-NEXT:    s_add_i32 s0, s0, s1
; GCN-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 5
  %add = add i32 %shl, %src1
  ret i32 %add
}

define i32 @v_shl1_add_u32(i32 %src0, i32 %src1) {
; GFX9-LABEL: v_shl1_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_lshl_add_u32 v0, v0, 1, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_shl1_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_shl1_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshl_add_u32 v0, v0, 1, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i32 %src0, 1
  %add = add i32 %shl, %src1
  ret i32 %add
}

define i32 @v_shl2_add_u32(i32 %src0, i32 %src1) {
; GFX9-LABEL: v_shl2_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_lshl_add_u32 v0, v0, 2, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_shl2_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_shl2_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshl_add_u32 v0, v0, 2, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i32 %src0, 2
  %add = add i32 %shl, %src1
  ret i32 %add
}

define i32 @v_shl3_add_u32(i32 %src0, i32 %src1) {
; GFX9-LABEL: v_shl3_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_lshl_add_u32 v0, v0, 3, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_shl3_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_shl3_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshl_add_u32 v0, v0, 3, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i32 %src0, 3
  %add = add i32 %shl, %src1
  ret i32 %add
}

define i32 @v_shl4_add_u32(i32 %src0, i32 %src1) {
; GFX9-LABEL: v_shl4_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_lshl_add_u32 v0, v0, 4, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_shl4_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 4, v0
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_shl4_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshl_add_u32 v0, v0, 4, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i32 %src0, 4
  %add = add i32 %shl, %src1
  ret i32 %add
}

define i32 @v_shl5_add_u32(i32 %src0, i32 %src1) {
; GFX9-LABEL: v_shl5_add_u32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_lshl_add_u32 v0, v0, 5, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_shl5_add_u32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 5, v0
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_shl5_add_u32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshl_add_u32 v0, v0, 5, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i32 %src0, 5
  %add = add i32 %shl, %src1
  ret i32 %add
}

; FIXME: Use v_lshl_add_u32
; shift is scalar, but add is vector.
define amdgpu_ps float @shl1_add_u32_vgpr1(i32 inreg %src0, i32 %src1) {
; GFX9-LABEL: shl1_add_u32_vgpr1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl_b32 s0, s0, 1
; GFX9-NEXT:    v_add_u32_e32 v0, s0, v0
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: shl1_add_u32_vgpr1:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 1
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: shl1_add_u32_vgpr1:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl_b32 s0, s0, 1
; GFX10-NEXT:    v_add_nc_u32_e32 v0, s0, v0
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 1
  %add = add i32 %shl, %src1
  %cast = bitcast i32 %add to float
  ret float %cast
}

define amdgpu_ps float @shl2_add_u32_vgpr1(i32 inreg %src0, i32 %src1) {
; GFX9-LABEL: shl2_add_u32_vgpr1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl_b32 s0, s0, 2
; GFX9-NEXT:    v_add_u32_e32 v0, s0, v0
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: shl2_add_u32_vgpr1:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 2
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: shl2_add_u32_vgpr1:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl_b32 s0, s0, 2
; GFX10-NEXT:    v_add_nc_u32_e32 v0, s0, v0
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 2
  %add = add i32 %shl, %src1
  %cast = bitcast i32 %add to float
  ret float %cast
}

define amdgpu_ps float @shl3_add_u32_vgpr1(i32 inreg %src0, i32 %src1) {
; GFX9-LABEL: shl3_add_u32_vgpr1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl_b32 s0, s0, 3
; GFX9-NEXT:    v_add_u32_e32 v0, s0, v0
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: shl3_add_u32_vgpr1:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 3
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: shl3_add_u32_vgpr1:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl_b32 s0, s0, 3
; GFX10-NEXT:    v_add_nc_u32_e32 v0, s0, v0
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 3
  %add = add i32 %shl, %src1
  %cast = bitcast i32 %add to float
  ret float %cast
}

define amdgpu_ps float @shl4_add_u32_vgpr1(i32 inreg %src0, i32 %src1) {
; GFX9-LABEL: shl4_add_u32_vgpr1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl_b32 s0, s0, 4
; GFX9-NEXT:    v_add_u32_e32 v0, s0, v0
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: shl4_add_u32_vgpr1:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 4
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: shl4_add_u32_vgpr1:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl_b32 s0, s0, 4
; GFX10-NEXT:    v_add_nc_u32_e32 v0, s0, v0
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 4
  %add = add i32 %shl, %src1
  %cast = bitcast i32 %add to float
  ret float %cast
}

define amdgpu_ps float @shl5_add_u32_vgpr1(i32 inreg %src0, i32 %src1) {
; GFX9-LABEL: shl5_add_u32_vgpr1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl_b32 s0, s0, 5
; GFX9-NEXT:    v_add_u32_e32 v0, s0, v0
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: shl5_add_u32_vgpr1:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 5
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: shl5_add_u32_vgpr1:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl_b32 s0, s0, 5
; GFX10-NEXT:    v_add_nc_u32_e32 v0, s0, v0
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 5
  %add = add i32 %shl, %src1
  %cast = bitcast i32 %add to float
  ret float %cast
}

define amdgpu_ps <2 x i32> @s_shl1_add_u32_v2(<2 x i32> inreg %src0, <2 x i32> inreg %src1) {
; GFX9-LABEL: s_shl1_add_u32_v2:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl1_add_u32 s0, s0, s2
; GFX9-NEXT:    s_lshl1_add_u32 s1, s1, s3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl1_add_u32_v2:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 1
; GFX8-NEXT:    s_lshl_b32 s1, s1, 1
; GFX8-NEXT:    s_add_i32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s1, s1, s3
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl1_add_u32_v2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl1_add_u32 s0, s0, s2
; GFX10-NEXT:    s_lshl1_add_u32 s1, s1, s3
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl <2 x i32> %src0, <i32 1, i32 1>
  %add = add <2 x i32> %shl, %src1
  ret <2 x i32> %add
}

define amdgpu_ps <2 x i32> @s_shl2_add_u32_v2(<2 x i32> inreg %src0, <2 x i32> inreg %src1) {
; GFX9-LABEL: s_shl2_add_u32_v2:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl2_add_u32 s0, s0, s2
; GFX9-NEXT:    s_lshl2_add_u32 s1, s1, s3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl2_add_u32_v2:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 2
; GFX8-NEXT:    s_lshl_b32 s1, s1, 2
; GFX8-NEXT:    s_add_i32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s1, s1, s3
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl2_add_u32_v2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl2_add_u32 s0, s0, s2
; GFX10-NEXT:    s_lshl2_add_u32 s1, s1, s3
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl <2 x i32> %src0, <i32 2, i32 2>
  %add = add <2 x i32> %shl, %src1
  ret <2 x i32> %add
}

define amdgpu_ps <2 x i32> @s_shl3_add_u32_v2(<2 x i32> inreg %src0, <2 x i32> inreg %src1) {
; GFX9-LABEL: s_shl3_add_u32_v2:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl3_add_u32 s0, s0, s2
; GFX9-NEXT:    s_lshl3_add_u32 s1, s1, s3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl3_add_u32_v2:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 3
; GFX8-NEXT:    s_lshl_b32 s1, s1, 3
; GFX8-NEXT:    s_add_i32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s1, s1, s3
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl3_add_u32_v2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl3_add_u32 s0, s0, s2
; GFX10-NEXT:    s_lshl3_add_u32 s1, s1, s3
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl <2 x i32> %src0, <i32 3, i32 3>
  %add = add <2 x i32> %shl, %src1
  ret <2 x i32> %add
}

define amdgpu_ps <2 x i32> @s_shl4_add_u32_v2(<2 x i32> inreg %src0, <2 x i32> inreg %src1) {
; GFX9-LABEL: s_shl4_add_u32_v2:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl4_add_u32 s0, s0, s2
; GFX9-NEXT:    s_lshl4_add_u32 s1, s1, s3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl4_add_u32_v2:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 4
; GFX8-NEXT:    s_lshl_b32 s1, s1, 4
; GFX8-NEXT:    s_add_i32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s1, s1, s3
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl4_add_u32_v2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl4_add_u32 s0, s0, s2
; GFX10-NEXT:    s_lshl4_add_u32 s1, s1, s3
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl <2 x i32> %src0, <i32 4, i32 4>
  %add = add <2 x i32> %shl, %src1
  ret <2 x i32> %add
}

define amdgpu_ps <2 x i32> @s_shl_2_4_add_u32_v2(<2 x i32> inreg %src0, <2 x i32> inreg %src1) {
; GFX9-LABEL: s_shl_2_4_add_u32_v2:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshl2_add_u32 s0, s0, s2
; GFX9-NEXT:    s_lshl4_add_u32 s1, s1, s3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_shl_2_4_add_u32_v2:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_lshl_b32 s0, s0, 2
; GFX8-NEXT:    s_lshl_b32 s1, s1, 4
; GFX8-NEXT:    s_add_i32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s1, s1, s3
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_shl_2_4_add_u32_v2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshl2_add_u32 s0, s0, s2
; GFX10-NEXT:    s_lshl4_add_u32 s1, s1, s3
; GFX10-NEXT:    ; return to shader part epilog
  %shl = shl <2 x i32> %src0, <i32 2, i32 4>
  %add = add <2 x i32> %shl, %src1
  ret <2 x i32> %add
}

define amdgpu_ps { i32, i32 } @s_shl4_add_u32_multi_use(i32 inreg %src0, i32 inreg %src1) {
; GCN-LABEL: s_shl4_add_u32_multi_use:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_lshl_b32 s0, s0, 4
; GCN-NEXT:    s_add_i32 s1, s0, s1
; GCN-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 4
  %add = add i32 %shl, %src1
  %insert0 = insertvalue { i32, i32 } undef, i32 %shl, 0
  %insert1 = insertvalue { i32, i32 } %insert0, i32 %add, 1
  ret { i32, i32 } %insert1
}

define amdgpu_ps { i32, i32 } @s_shl3_add_u32_multi_use(i32 inreg %src0, i32 inreg %src1) {
; GCN-LABEL: s_shl3_add_u32_multi_use:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_lshl_b32 s0, s0, 3
; GCN-NEXT:    s_add_i32 s1, s0, s1
; GCN-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 3
  %add = add i32 %shl, %src1
  %insert0 = insertvalue { i32, i32 } undef, i32 %shl, 0
  %insert1 = insertvalue { i32, i32 } %insert0, i32 %add, 1
  ret { i32, i32 } %insert1
}

define amdgpu_ps { i32, i32 } @s_shl2_add_u32_multi_use(i32 inreg %src0, i32 inreg %src1) {
; GCN-LABEL: s_shl2_add_u32_multi_use:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_lshl_b32 s0, s0, 2
; GCN-NEXT:    s_add_i32 s1, s0, s1
; GCN-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 2
  %add = add i32 %shl, %src1
  %insert0 = insertvalue { i32, i32 } undef, i32 %shl, 0
  %insert1 = insertvalue { i32, i32 } %insert0, i32 %add, 1
  ret { i32, i32 } %insert1
}


define amdgpu_ps { i32, i32 } @s_shl1_add_u32_multi_use(i32 inreg %src0, i32 inreg %src1) {
; GCN-LABEL: s_shl1_add_u32_multi_use:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_lshl_b32 s0, s0, 1
; GCN-NEXT:    s_add_i32 s1, s0, s1
; GCN-NEXT:    ; return to shader part epilog
  %shl = shl i32 %src0, 1
  %add = add i32 %shl, %src1
  %insert0 = insertvalue { i32, i32 } undef, i32 %shl, 0
  %insert1 = insertvalue { i32, i32 } %insert0, i32 %add, 1
  ret { i32, i32 } %insert1
}

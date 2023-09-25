; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -amdgpu-scalarize-global-loads=false -march=amdgcn -mcpu=verde -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GFX6 %s
; RUN: llc -amdgpu-scalarize-global-loads=false -march=amdgcn -mcpu=fiji -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GFX8 %s
; RUN: llc -amdgpu-scalarize-global-loads=false -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GFX9 %s

declare i32 @llvm.amdgcn.workitem.id.x() nounwind readnone speculatable

define amdgpu_kernel void @s_sub_i32(ptr addrspace(1) %out, i32 %a, i32 %b) {
; GFX6-LABEL: s_sub_i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_sub_i32 s0, s2, s3
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    v_mov_b32_e32 v0, s0
; GFX6-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: s_sub_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_sub_i32 s2, s2, s3
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_mov_b32_e32 v2, s2
; GFX8-NEXT:    flat_store_dword v[0:1], v2
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: s_sub_i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_sub_i32 s2, s2, s3
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %result = sub i32 %a, %b
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @s_sub_imm_i32(ptr addrspace(1) %out, i32 %a) {
; GFX6-LABEL: s_sub_imm_i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dword s4, s[0:1], 0xb
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_sub_i32 s4, 0x4d2, s4
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: s_sub_imm_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dword s2, s[0:1], 0x2c
; GFX8-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_sub_i32 s2, 0x4d2, s2
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_mov_b32_e32 v2, s2
; GFX8-NEXT:    flat_store_dword v[0:1], v2
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: s_sub_imm_i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_sub_i32 s0, 0x4d2, s4
; GFX9-NEXT:    v_mov_b32_e32 v1, s0
; GFX9-NEXT:    global_store_dword v0, v1, s[2:3]
; GFX9-NEXT:    s_endpgm
  %result = sub i32 1234, %a
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_i32(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s10, s6
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b32 s8, s2
; GFX6-NEXT:    s_mov_b32 s9, s3
; GFX6-NEXT:    buffer_load_dwordx2 v[0:1], off, s[8:11], 0
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v1
; GFX6-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s2
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; GFX8-NEXT:    v_mov_b32_e32 v2, s0
; GFX8-NEXT:    v_mov_b32_e32 v3, s1
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u32_e32 v0, vcc, v0, v1
; GFX8-NEXT:    flat_store_dword v[2:3], v0
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_u32_e32 v0, v0, v1
; GFX9-NEXT:    global_store_dword v2, v0, s[0:1]
; GFX9-NEXT:    s_endpgm
  %b_ptr = getelementptr i32, ptr addrspace(1) %in, i32 1
  %a = load i32, ptr addrspace(1) %in
  %b = load i32, ptr addrspace(1) %b_ptr
  %result = sub i32 %a, %b
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_imm_i32(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_imm_i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s10, s6
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b32 s8, s2
; GFX6-NEXT:    s_mov_b32 s9, s3
; GFX6-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, 0x7b, v0
; GFX6-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_imm_i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s2
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    flat_load_dword v2, v[0:1]
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u32_e32 v2, vcc, 0x7b, v2
; GFX8-NEXT:    flat_store_dword v[0:1], v2
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_imm_i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_u32_e32 v1, 0x7b, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %a = load i32, ptr addrspace(1) %in
  %result = sub i32 123, %a
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_v2i32(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_v2i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s10, s6
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b32 s8, s2
; GFX6-NEXT:    s_mov_b32 s9, s3
; GFX6-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v1, vcc, v1, v3
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v2
; GFX6-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_v2i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s2
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; GFX8-NEXT:    v_mov_b32_e32 v4, s0
; GFX8-NEXT:    v_mov_b32_e32 v5, s1
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u32_e32 v1, vcc, v1, v3
; GFX8-NEXT:    v_sub_u32_e32 v0, vcc, v0, v2
; GFX8-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_v2i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v4, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx4 v[0:3], v4, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_u32_e32 v1, v1, v3
; GFX9-NEXT:    v_sub_u32_e32 v0, v0, v2
; GFX9-NEXT:    global_store_dwordx2 v4, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
  %b_ptr = getelementptr <2 x i32>, ptr addrspace(1) %in, i32 1
  %a = load <2 x i32>, ptr addrspace(1) %in
  %b = load <2 x i32>, ptr addrspace(1) %b_ptr
  %result = sub <2 x i32> %a, %b
  store <2 x i32> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_v4i32(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_v4i32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s10, s6
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b32 s8, s2
; GFX6-NEXT:    s_mov_b32 s9, s3
; GFX6-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; GFX6-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v3, vcc, v3, v7
; GFX6-NEXT:    v_sub_i32_e32 v2, vcc, v2, v6
; GFX6-NEXT:    v_sub_i32_e32 v1, vcc, v1, v5
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v4
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_v4i32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s2
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    s_add_u32 s2, s2, 16
; GFX8-NEXT:    s_addc_u32 s3, s3, 0
; GFX8-NEXT:    v_mov_b32_e32 v5, s3
; GFX8-NEXT:    v_mov_b32_e32 v4, s2
; GFX8-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; GFX8-NEXT:    flat_load_dwordx4 v[4:7], v[4:5]
; GFX8-NEXT:    v_mov_b32_e32 v8, s0
; GFX8-NEXT:    v_mov_b32_e32 v9, s1
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u32_e32 v3, vcc, v3, v7
; GFX8-NEXT:    v_sub_u32_e32 v2, vcc, v2, v6
; GFX8-NEXT:    v_sub_u32_e32 v1, vcc, v1, v5
; GFX8-NEXT:    v_sub_u32_e32 v0, vcc, v0, v4
; GFX8-NEXT:    flat_store_dwordx4 v[8:9], v[0:3]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_v4i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v8, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx4 v[0:3], v8, s[2:3] offset:16
; GFX9-NEXT:    global_load_dwordx4 v[4:7], v8, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_u32_e32 v3, v7, v3
; GFX9-NEXT:    v_sub_u32_e32 v2, v6, v2
; GFX9-NEXT:    v_sub_u32_e32 v1, v5, v1
; GFX9-NEXT:    v_sub_u32_e32 v0, v4, v0
; GFX9-NEXT:    global_store_dwordx4 v8, v[0:3], s[0:1]
; GFX9-NEXT:    s_endpgm
  %b_ptr = getelementptr <4 x i32>, ptr addrspace(1) %in, i32 1
  %a = load <4 x i32>, ptr addrspace(1) %in
  %b = load <4 x i32>, ptr addrspace(1) %b_ptr
  %result = sub <4 x i32> %a, %b
  store <4 x i32> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_i16(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_i16:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s10, 0
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[8:9], s[2:3]
; GFX6-NEXT:    v_mov_b32_e32 v1, 0
; GFX6-NEXT:    buffer_load_ushort v2, v[0:1], s[8:11], 0 addr64 glc
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    buffer_load_ushort v0, v[0:1], s[8:11], 0 addr64 offset:2 glc
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v2, v0
; GFX6-NEXT:    buffer_store_short v0, off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; GFX8-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; GFX8-NEXT:    v_add_u32_e32 v2, vcc, 2, v0
; GFX8-NEXT:    v_addc_u32_e32 v3, vcc, 0, v1, vcc
; GFX8-NEXT:    flat_load_ushort v4, v[0:1] glc
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    flat_load_ushort v2, v[2:3] glc
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_sub_u16_e32 v2, v4, v2
; GFX8-NEXT:    flat_store_short v[0:1], v2
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_ushort v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_ushort v2, v0, s[2:3] offset:2 glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    v_sub_u16_e32 v1, v1, v2
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr i16, ptr addrspace(1) %in, i32 %tid
  %b_ptr = getelementptr i16, ptr addrspace(1) %gep, i32 1
  %a = load volatile i16, ptr addrspace(1) %gep
  %b = load volatile i16, ptr addrspace(1) %b_ptr
  %result = sub i16 %a, %b
  store i16 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_v2i16:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s10, 0
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[8:9], s[2:3]
; GFX6-NEXT:    v_mov_b32_e32 v1, 0
; GFX6-NEXT:    buffer_load_dwordx2 v[0:1], v[0:1], s[8:11], 0 addr64
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX6-NEXT:    v_lshrrev_b32_e32 v3, 16, v1
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v1
; GFX6-NEXT:    v_sub_i32_e32 v1, vcc, v2, v3
; GFX6-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX6-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX6-NEXT:    v_or_b32_e32 v0, v0, v1
; GFX6-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_v2i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; GFX8-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; GFX8-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; GFX8-NEXT:    v_mov_b32_e32 v2, s0
; GFX8-NEXT:    v_mov_b32_e32 v3, s1
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u16_e32 v4, v0, v1
; GFX8-NEXT:    v_sub_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_or_b32_e32 v0, v4, v0
; GFX8-NEXT:    flat_store_dword v[2:3], v0
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, v1
; GFX9-NEXT:    global_store_dword v2, v0, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr <2 x i16>, ptr addrspace(1) %in, i32 %tid
  %b_ptr = getelementptr <2 x i16>, ptr addrspace(1) %gep, i16 1
  %a = load <2 x i16>, ptr addrspace(1) %gep
  %b = load <2 x i16>, ptr addrspace(1) %b_ptr
  %result = sub <2 x i16> %a, %b
  store <2 x i16> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_sub_v4i16(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; GFX6-LABEL: test_sub_v4i16:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s7, 0xf000
; GFX6-NEXT:    s_mov_b32 s10, 0
; GFX6-NEXT:    s_mov_b32 s11, s7
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[8:9], s[2:3]
; GFX6-NEXT:    v_mov_b32_e32 v1, 0
; GFX6-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; GFX6-NEXT:    s_mov_b32 s6, -1
; GFX6-NEXT:    s_mov_b32 s4, s0
; GFX6-NEXT:    s_mov_b32 s5, s1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_lshrrev_b32_e32 v4, 16, v0
; GFX6-NEXT:    v_lshrrev_b32_e32 v5, 16, v1
; GFX6-NEXT:    v_lshrrev_b32_e32 v6, 16, v2
; GFX6-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; GFX6-NEXT:    v_sub_i32_e32 v1, vcc, v1, v3
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v2
; GFX6-NEXT:    v_sub_i32_e32 v2, vcc, v5, v7
; GFX6-NEXT:    v_sub_i32_e32 v3, vcc, v4, v6
; GFX6-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; GFX6-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX6-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX6-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX6-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX6-NEXT:    v_or_b32_e32 v0, v0, v3
; GFX6-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: test_sub_v4i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, s3
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; GFX8-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; GFX8-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; GFX8-NEXT:    v_mov_b32_e32 v4, s0
; GFX8-NEXT:    v_mov_b32_e32 v5, s1
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u16_e32 v6, v1, v3
; GFX8-NEXT:    v_sub_u16_sdwa v1, v1, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_sub_u16_e32 v3, v0, v2
; GFX8-NEXT:    v_sub_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_or_b32_e32 v1, v6, v1
; GFX8-NEXT:    v_or_b32_e32 v0, v3, v0
; GFX8-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sub_v4i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX9-NEXT:    v_mov_b32_e32 v4, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx4 v[0:3], v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v1, v1, v3
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, v2
; GFX9-NEXT:    global_store_dwordx2 v4, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr <4 x i16>, ptr addrspace(1) %in, i32 %tid
  %b_ptr = getelementptr <4 x i16>, ptr addrspace(1) %gep, i16 1
  %a = load <4 x i16>, ptr addrspace(1) %gep
  %b = load <4 x i16>, ptr addrspace(1) %b_ptr
  %result = sub <4 x i16> %a, %b
  store <4 x i16> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @s_sub_i64(ptr addrspace(1) noalias %out, i64 %a, i64 %b) nounwind {
; GFX6-LABEL: s_sub_i64:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0xb
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_sub_u32 s4, s4, s6
; GFX6-NEXT:    s_subb_u32 s5, s5, s7
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: s_sub_i64:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x2c
; GFX8-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_sub_u32 s2, s4, s6
; GFX8-NEXT:    s_subb_u32 s3, s5, s7
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v2, s2
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_mov_b32_e32 v3, s3
; GFX8-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: s_sub_i64:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x2c
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GFX9-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_sub_u32 s0, s4, s6
; GFX9-NEXT:    s_subb_u32 s1, s5, s7
; GFX9-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-NEXT:    v_mov_b32_e32 v1, s1
; GFX9-NEXT:    global_store_dwordx2 v2, v[0:1], s[2:3]
; GFX9-NEXT:    s_endpgm
  %result = sub i64 %a, %b
  store i64 %result, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @v_sub_i64(ptr addrspace(1) noalias %out, ptr addrspace(1) noalias %inA, ptr addrspace(1) noalias %inB) nounwind {
; GFX6-LABEL: v_sub_i64:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; GFX6-NEXT:    s_mov_b32 s11, 0xf000
; GFX6-NEXT:    s_mov_b32 s14, 0
; GFX6-NEXT:    s_mov_b32 s15, s11
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX6-NEXT:    v_mov_b32_e32 v1, 0
; GFX6-NEXT:    s_mov_b64 s[2:3], s[14:15]
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[12:13], s[6:7]
; GFX6-NEXT:    buffer_load_dwordx2 v[2:3], v[0:1], s[0:3], 0 addr64
; GFX6-NEXT:    buffer_load_dwordx2 v[0:1], v[0:1], s[12:15], 0 addr64
; GFX6-NEXT:    s_mov_b32 s10, -1
; GFX6-NEXT:    s_mov_b32 s8, s4
; GFX6-NEXT:    s_mov_b32 s9, s5
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v2
; GFX6-NEXT:    v_subb_u32_e32 v1, vcc, v1, v3, vcc
; GFX6-NEXT:    buffer_store_dwordx2 v[0:1], off, s[8:11], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: v_sub_i64:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX8-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; GFX8-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, s7
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; GFX8-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; GFX8-NEXT:    v_mov_b32_e32 v3, s1
; GFX8-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; GFX8-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; GFX8-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; GFX8-NEXT:    flat_load_dwordx2 v[2:3], v[2:3]
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u32_e32 v0, vcc, v0, v2
; GFX8-NEXT:    v_subb_u32_e32 v1, vcc, v1, v3, vcc
; GFX8-NEXT:    v_mov_b32_e32 v2, s4
; GFX8-NEXT:    v_mov_b32_e32 v3, s5
; GFX8-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: v_sub_i64:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v4, s[6:7]
; GFX9-NEXT:    global_load_dwordx2 v[2:3], v4, s[2:3]
; GFX9-NEXT:    v_mov_b32_e32 v4, 0
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v2
; GFX9-NEXT:    v_subb_co_u32_e32 v1, vcc, v1, v3, vcc
; GFX9-NEXT:    global_store_dwordx2 v4, v[0:1], s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() readnone
  %a_ptr = getelementptr i64, ptr addrspace(1) %inA, i32 %tid
  %b_ptr = getelementptr i64, ptr addrspace(1) %inB, i32 %tid
  %a = load i64, ptr addrspace(1) %a_ptr
  %b = load i64, ptr addrspace(1) %b_ptr
  %result = sub i64 %a, %b
  store i64 %result, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @v_test_sub_v2i64(ptr addrspace(1) %out, ptr addrspace(1) noalias %inA, ptr addrspace(1) noalias %inB) {
; GFX6-LABEL: v_test_sub_v2i64:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; GFX6-NEXT:    s_mov_b32 s11, 0xf000
; GFX6-NEXT:    s_mov_b32 s14, 0
; GFX6-NEXT:    s_mov_b32 s15, s11
; GFX6-NEXT:    v_lshlrev_b32_e32 v4, 4, v0
; GFX6-NEXT:    v_mov_b32_e32 v5, 0
; GFX6-NEXT:    s_mov_b64 s[2:3], s[14:15]
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[12:13], s[6:7]
; GFX6-NEXT:    buffer_load_dwordx4 v[0:3], v[4:5], s[0:3], 0 addr64
; GFX6-NEXT:    buffer_load_dwordx4 v[4:7], v[4:5], s[12:15], 0 addr64
; GFX6-NEXT:    s_mov_b32 s10, -1
; GFX6-NEXT:    s_mov_b32 s8, s4
; GFX6-NEXT:    s_mov_b32 s9, s5
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v2, vcc, v6, v2
; GFX6-NEXT:    v_subb_u32_e32 v3, vcc, v7, v3, vcc
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v4, v0
; GFX6-NEXT:    v_subb_u32_e32 v1, vcc, v5, v1, vcc
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[8:11], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: v_test_sub_v2i64:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX8-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; GFX8-NEXT:    v_lshlrev_b32_e32 v2, 4, v0
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, s7
; GFX8-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; GFX8-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; GFX8-NEXT:    v_mov_b32_e32 v3, s1
; GFX8-NEXT:    v_add_u32_e32 v4, vcc, s0, v2
; GFX8-NEXT:    v_addc_u32_e32 v5, vcc, 0, v3, vcc
; GFX8-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; GFX8-NEXT:    flat_load_dwordx4 v[4:7], v[4:5]
; GFX8-NEXT:    s_waitcnt vmcnt(0)
; GFX8-NEXT:    v_sub_u32_e32 v2, vcc, v2, v6
; GFX8-NEXT:    v_subb_u32_e32 v3, vcc, v3, v7, vcc
; GFX8-NEXT:    v_sub_u32_e32 v0, vcc, v0, v4
; GFX8-NEXT:    v_subb_u32_e32 v1, vcc, v1, v5, vcc
; GFX8-NEXT:    v_mov_b32_e32 v4, s4
; GFX8-NEXT:    v_mov_b32_e32 v5, s5
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_sub_v2i64:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v8, 4, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx4 v[0:3], v8, s[6:7]
; GFX9-NEXT:    global_load_dwordx4 v[4:7], v8, s[2:3]
; GFX9-NEXT:    v_mov_b32_e32 v8, 0
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_co_u32_e32 v2, vcc, v2, v6
; GFX9-NEXT:    v_subb_co_u32_e32 v3, vcc, v3, v7, vcc
; GFX9-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v4
; GFX9-NEXT:    v_subb_co_u32_e32 v1, vcc, v1, v5, vcc
; GFX9-NEXT:    global_store_dwordx4 v8, v[0:3], s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() readnone
  %a_ptr = getelementptr <2 x i64>, ptr addrspace(1) %inA, i32 %tid
  %b_ptr = getelementptr <2 x i64>, ptr addrspace(1) %inB, i32 %tid
  %a = load <2 x i64>, ptr addrspace(1) %a_ptr
  %b = load <2 x i64>, ptr addrspace(1) %b_ptr
  %result = sub <2 x i64> %a, %b
  store <2 x i64> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @v_test_sub_v4i64(ptr addrspace(1) %out, ptr addrspace(1) noalias %inA, ptr addrspace(1) noalias %inB) {
; GFX6-LABEL: v_test_sub_v4i64:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; GFX6-NEXT:    s_mov_b32 s11, 0xf000
; GFX6-NEXT:    s_mov_b32 s14, 0
; GFX6-NEXT:    s_mov_b32 s15, s11
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[12:13], s[6:7]
; GFX6-NEXT:    v_lshlrev_b32_e32 v12, 5, v0
; GFX6-NEXT:    v_mov_b32_e32 v13, 0
; GFX6-NEXT:    s_mov_b64 s[2:3], s[14:15]
; GFX6-NEXT:    buffer_load_dwordx4 v[0:3], v[12:13], s[12:15], 0 addr64
; GFX6-NEXT:    buffer_load_dwordx4 v[4:7], v[12:13], s[0:3], 0 addr64
; GFX6-NEXT:    buffer_load_dwordx4 v[8:11], v[12:13], s[0:3], 0 addr64 offset:16
; GFX6-NEXT:    buffer_load_dwordx4 v[12:15], v[12:13], s[12:15], 0 addr64 offset:16
; GFX6-NEXT:    s_mov_b32 s10, -1
; GFX6-NEXT:    s_mov_b32 s8, s4
; GFX6-NEXT:    s_mov_b32 s9, s5
; GFX6-NEXT:    s_waitcnt vmcnt(2)
; GFX6-NEXT:    v_sub_i32_e32 v2, vcc, v2, v6
; GFX6-NEXT:    v_subb_u32_e32 v3, vcc, v3, v7, vcc
; GFX6-NEXT:    v_sub_i32_e32 v0, vcc, v0, v4
; GFX6-NEXT:    v_subb_u32_e32 v1, vcc, v1, v5, vcc
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    v_sub_i32_e32 v6, vcc, v14, v10
; GFX6-NEXT:    v_subb_u32_e32 v7, vcc, v15, v11, vcc
; GFX6-NEXT:    v_sub_i32_e32 v4, vcc, v12, v8
; GFX6-NEXT:    v_subb_u32_e32 v5, vcc, v13, v9, vcc
; GFX6-NEXT:    buffer_store_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[8:11], 0
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: v_test_sub_v4i64:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX8-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; GFX8-NEXT:    v_lshlrev_b32_e32 v0, 5, v0
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, s7
; GFX8-NEXT:    v_add_u32_e32 v8, vcc, s6, v0
; GFX8-NEXT:    v_addc_u32_e32 v9, vcc, 0, v1, vcc
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_add_u32_e32 v12, vcc, s0, v0
; GFX8-NEXT:    v_addc_u32_e32 v13, vcc, 0, v1, vcc
; GFX8-NEXT:    flat_load_dwordx4 v[0:3], v[8:9]
; GFX8-NEXT:    flat_load_dwordx4 v[4:7], v[12:13]
; GFX8-NEXT:    v_add_u32_e32 v8, vcc, 16, v8
; GFX8-NEXT:    v_addc_u32_e32 v9, vcc, 0, v9, vcc
; GFX8-NEXT:    v_add_u32_e32 v12, vcc, 16, v12
; GFX8-NEXT:    v_addc_u32_e32 v13, vcc, 0, v13, vcc
; GFX8-NEXT:    flat_load_dwordx4 v[8:11], v[8:9]
; GFX8-NEXT:    flat_load_dwordx4 v[12:15], v[12:13]
; GFX8-NEXT:    v_mov_b32_e32 v17, s5
; GFX8-NEXT:    v_mov_b32_e32 v16, s4
; GFX8-NEXT:    s_add_u32 s0, s4, 16
; GFX8-NEXT:    s_addc_u32 s1, s5, 0
; GFX8-NEXT:    s_waitcnt vmcnt(2)
; GFX8-NEXT:    v_sub_u32_e32 v2, vcc, v2, v6
; GFX8-NEXT:    v_subb_u32_e32 v3, vcc, v3, v7, vcc
; GFX8-NEXT:    v_sub_u32_e32 v0, vcc, v0, v4
; GFX8-NEXT:    v_subb_u32_e32 v1, vcc, v1, v5, vcc
; GFX8-NEXT:    flat_store_dwordx4 v[16:17], v[0:3]
; GFX8-NEXT:    s_waitcnt vmcnt(1)
; GFX8-NEXT:    v_sub_u32_e32 v6, vcc, v10, v14
; GFX8-NEXT:    v_subb_u32_e32 v7, vcc, v11, v15, vcc
; GFX8-NEXT:    v_sub_u32_e32 v4, vcc, v8, v12
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_subb_u32_e32 v5, vcc, v9, v13, vcc
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_sub_v4i64:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v16, 5, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx4 v[0:3], v16, s[6:7]
; GFX9-NEXT:    global_load_dwordx4 v[4:7], v16, s[2:3]
; GFX9-NEXT:    global_load_dwordx4 v[8:11], v16, s[6:7] offset:16
; GFX9-NEXT:    global_load_dwordx4 v[12:15], v16, s[2:3] offset:16
; GFX9-NEXT:    v_mov_b32_e32 v16, 0
; GFX9-NEXT:    s_waitcnt vmcnt(2)
; GFX9-NEXT:    v_sub_co_u32_e32 v2, vcc, v2, v6
; GFX9-NEXT:    v_subb_co_u32_e32 v3, vcc, v3, v7, vcc
; GFX9-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v4
; GFX9-NEXT:    v_subb_co_u32_e32 v1, vcc, v1, v5, vcc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_co_u32_e32 v6, vcc, v10, v14
; GFX9-NEXT:    v_subb_co_u32_e32 v7, vcc, v11, v15, vcc
; GFX9-NEXT:    v_sub_co_u32_e32 v4, vcc, v8, v12
; GFX9-NEXT:    v_subb_co_u32_e32 v5, vcc, v9, v13, vcc
; GFX9-NEXT:    global_store_dwordx4 v16, v[4:7], s[4:5] offset:16
; GFX9-NEXT:    global_store_dwordx4 v16, v[0:3], s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() readnone
  %a_ptr = getelementptr <4 x i64>, ptr addrspace(1) %inA, i32 %tid
  %b_ptr = getelementptr <4 x i64>, ptr addrspace(1) %inB, i32 %tid
  %a = load <4 x i64>, ptr addrspace(1) %a_ptr
  %b = load <4 x i64>, ptr addrspace(1) %b_ptr
  %result = sub <4 x i64> %a, %b
  store <4 x i64> %result, ptr addrspace(1) %out
  ret void
}

; Make sure the VOP3 form of sub is initially selected. Otherwise pair
; of opies from/to VCC would be necessary

define amdgpu_ps void @sub_select_vop3(i32 inreg %s, i32 %v) {
; GFX6-LABEL: sub_select_vop3:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_subrev_i32_e64 v0, s[0:1], s0, v0
; GFX6-NEXT:    s_mov_b32 m0, -1
; GFX6-NEXT:    ;;#ASMSTART
; GFX6-NEXT:    ; def vcc
; GFX6-NEXT:    ;;#ASMEND
; GFX6-NEXT:    ds_write_b32 v0, v0
; GFX6-NEXT:    ;;#ASMSTART
; GFX6-NEXT:    ; use vcc
; GFX6-NEXT:    ;;#ASMEND
; GFX6-NEXT:    s_endpgm
;
; GFX8-LABEL: sub_select_vop3:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_subrev_u32_e64 v0, s[0:1], s0, v0
; GFX8-NEXT:    s_mov_b32 m0, -1
; GFX8-NEXT:    ;;#ASMSTART
; GFX8-NEXT:    ; def vcc
; GFX8-NEXT:    ;;#ASMEND
; GFX8-NEXT:    ds_write_b32 v0, v0
; GFX8-NEXT:    ;;#ASMSTART
; GFX8-NEXT:    ; use vcc
; GFX8-NEXT:    ;;#ASMEND
; GFX8-NEXT:    s_endpgm
;
; GFX9-LABEL: sub_select_vop3:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_subrev_u32_e32 v0, s0, v0
; GFX9-NEXT:    ;;#ASMSTART
; GFX9-NEXT:    ; def vcc
; GFX9-NEXT:    ;;#ASMEND
; GFX9-NEXT:    ds_write_b32 v0, v0
; GFX9-NEXT:    ;;#ASMSTART
; GFX9-NEXT:    ; use vcc
; GFX9-NEXT:    ;;#ASMEND
; GFX9-NEXT:    s_endpgm
  %vcc = call i64 asm sideeffect "; def vcc", "={vcc}"()
  %sub = sub i32 %v, %s
  store i32 %sub, ptr addrspace(3) undef
  call void asm sideeffect "; use vcc", "{vcc}"(i64 %vcc)
  ret void
}

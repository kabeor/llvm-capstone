; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX10 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX11 %s

define amdgpu_kernel void @v_insert_v64i32_37(ptr addrspace(1) %ptr.in, ptr addrspace(1) %ptr.out) #0 {
; GCN-LABEL: v_insert_v64i32_37:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GCN-NEXT:    v_lshlrev_b32_e32 v64, 8, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_dwordx4 v[4:7], v64, s[0:1] offset:144
; GCN-NEXT:    global_load_dwordx4 v[0:3], v64, s[0:1]
; GCN-NEXT:    global_load_dwordx4 v[8:11], v64, s[0:1] offset:16
; GCN-NEXT:    global_load_dwordx4 v[12:15], v64, s[0:1] offset:32
; GCN-NEXT:    global_load_dwordx4 v[16:19], v64, s[0:1] offset:48
; GCN-NEXT:    global_load_dwordx4 v[20:23], v64, s[0:1] offset:64
; GCN-NEXT:    global_load_dwordx4 v[24:27], v64, s[0:1] offset:80
; GCN-NEXT:    global_load_dwordx4 v[28:31], v64, s[0:1] offset:96
; GCN-NEXT:    global_load_dwordx4 v[32:35], v64, s[0:1] offset:112
; GCN-NEXT:    global_load_dwordx4 v[36:39], v64, s[0:1] offset:128
; GCN-NEXT:    global_load_dwordx4 v[40:43], v64, s[0:1] offset:160
; GCN-NEXT:    global_load_dwordx4 v[44:47], v64, s[0:1] offset:176
; GCN-NEXT:    global_load_dwordx4 v[48:51], v64, s[0:1] offset:192
; GCN-NEXT:    global_load_dwordx4 v[52:55], v64, s[0:1] offset:208
; GCN-NEXT:    global_load_dwordx4 v[56:59], v64, s[0:1] offset:224
; GCN-NEXT:    global_load_dwordx4 v[60:63], v64, s[0:1] offset:240
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    v_mov_b32_e32 v5, 0x3e7
; GCN-NEXT:    global_store_dwordx4 v64, v[4:7], s[2:3] offset:144
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[0:3], s[2:3]
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[8:11], s[2:3] offset:16
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[12:15], s[2:3] offset:32
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[16:19], s[2:3] offset:48
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[20:23], s[2:3] offset:64
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[24:27], s[2:3] offset:80
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[28:31], s[2:3] offset:96
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[32:35], s[2:3] offset:112
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[36:39], s[2:3] offset:128
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[40:43], s[2:3] offset:160
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[44:47], s[2:3] offset:176
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[48:51], s[2:3] offset:192
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[52:55], s[2:3] offset:208
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[56:59], s[2:3] offset:224
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[60:63], s[2:3] offset:240
; GCN-NEXT:    s_endpgm
;
; GFX10-LABEL: v_insert_v64i32_37:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX10-NEXT:    v_lshlrev_b32_e32 v64, 8, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_clause 0xf
; GFX10-NEXT:    global_load_dwordx4 v[0:3], v64, s[0:1]
; GFX10-NEXT:    global_load_dwordx4 v[8:11], v64, s[0:1] offset:16
; GFX10-NEXT:    global_load_dwordx4 v[12:15], v64, s[0:1] offset:32
; GFX10-NEXT:    global_load_dwordx4 v[16:19], v64, s[0:1] offset:48
; GFX10-NEXT:    global_load_dwordx4 v[20:23], v64, s[0:1] offset:64
; GFX10-NEXT:    global_load_dwordx4 v[24:27], v64, s[0:1] offset:80
; GFX10-NEXT:    global_load_dwordx4 v[28:31], v64, s[0:1] offset:96
; GFX10-NEXT:    global_load_dwordx4 v[32:35], v64, s[0:1] offset:112
; GFX10-NEXT:    global_load_dwordx4 v[36:39], v64, s[0:1] offset:160
; GFX10-NEXT:    global_load_dwordx4 v[40:43], v64, s[0:1] offset:176
; GFX10-NEXT:    global_load_dwordx4 v[44:47], v64, s[0:1] offset:192
; GFX10-NEXT:    global_load_dwordx4 v[48:51], v64, s[0:1] offset:208
; GFX10-NEXT:    global_load_dwordx4 v[52:55], v64, s[0:1] offset:224
; GFX10-NEXT:    global_load_dwordx4 v[56:59], v64, s[0:1] offset:240
; GFX10-NEXT:    global_load_dwordx4 v[60:63], v64, s[0:1] offset:128
; GFX10-NEXT:    global_load_dwordx4 v[4:7], v64, s[0:1] offset:144
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v5, 0x3e7
; GFX10-NEXT:    global_store_dwordx4 v64, v[0:3], s[2:3]
; GFX10-NEXT:    global_store_dwordx4 v64, v[8:11], s[2:3] offset:16
; GFX10-NEXT:    global_store_dwordx4 v64, v[12:15], s[2:3] offset:32
; GFX10-NEXT:    global_store_dwordx4 v64, v[16:19], s[2:3] offset:48
; GFX10-NEXT:    global_store_dwordx4 v64, v[20:23], s[2:3] offset:64
; GFX10-NEXT:    global_store_dwordx4 v64, v[24:27], s[2:3] offset:80
; GFX10-NEXT:    global_store_dwordx4 v64, v[28:31], s[2:3] offset:96
; GFX10-NEXT:    global_store_dwordx4 v64, v[32:35], s[2:3] offset:112
; GFX10-NEXT:    global_store_dwordx4 v64, v[60:63], s[2:3] offset:128
; GFX10-NEXT:    global_store_dwordx4 v64, v[4:7], s[2:3] offset:144
; GFX10-NEXT:    global_store_dwordx4 v64, v[36:39], s[2:3] offset:160
; GFX10-NEXT:    global_store_dwordx4 v64, v[40:43], s[2:3] offset:176
; GFX10-NEXT:    global_store_dwordx4 v64, v[44:47], s[2:3] offset:192
; GFX10-NEXT:    global_store_dwordx4 v64, v[48:51], s[2:3] offset:208
; GFX10-NEXT:    global_store_dwordx4 v64, v[52:55], s[2:3] offset:224
; GFX10-NEXT:    global_store_dwordx4 v64, v[56:59], s[2:3] offset:240
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_insert_v64i32_37:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x0
; GFX11-NEXT:    v_lshlrev_b32_e32 v64, 8, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_clause 0xf
; GFX11-NEXT:    global_load_b128 v[0:3], v64, s[0:1]
; GFX11-NEXT:    global_load_b128 v[8:11], v64, s[0:1] offset:16
; GFX11-NEXT:    global_load_b128 v[12:15], v64, s[0:1] offset:32
; GFX11-NEXT:    global_load_b128 v[16:19], v64, s[0:1] offset:48
; GFX11-NEXT:    global_load_b128 v[20:23], v64, s[0:1] offset:64
; GFX11-NEXT:    global_load_b128 v[24:27], v64, s[0:1] offset:80
; GFX11-NEXT:    global_load_b128 v[28:31], v64, s[0:1] offset:96
; GFX11-NEXT:    global_load_b128 v[32:35], v64, s[0:1] offset:112
; GFX11-NEXT:    global_load_b128 v[36:39], v64, s[0:1] offset:128
; GFX11-NEXT:    global_load_b128 v[4:7], v64, s[0:1] offset:144
; GFX11-NEXT:    global_load_b128 v[40:43], v64, s[0:1] offset:160
; GFX11-NEXT:    global_load_b128 v[44:47], v64, s[0:1] offset:176
; GFX11-NEXT:    global_load_b128 v[48:51], v64, s[0:1] offset:192
; GFX11-NEXT:    global_load_b128 v[52:55], v64, s[0:1] offset:208
; GFX11-NEXT:    global_load_b128 v[56:59], v64, s[0:1] offset:224
; GFX11-NEXT:    global_load_b128 v[60:63], v64, s[0:1] offset:240
; GFX11-NEXT:    s_waitcnt vmcnt(6)
; GFX11-NEXT:    v_mov_b32_e32 v5, 0x3e7
; GFX11-NEXT:    s_clause 0x9
; GFX11-NEXT:    global_store_b128 v64, v[0:3], s[2:3]
; GFX11-NEXT:    global_store_b128 v64, v[8:11], s[2:3] offset:16
; GFX11-NEXT:    global_store_b128 v64, v[12:15], s[2:3] offset:32
; GFX11-NEXT:    global_store_b128 v64, v[16:19], s[2:3] offset:48
; GFX11-NEXT:    global_store_b128 v64, v[20:23], s[2:3] offset:64
; GFX11-NEXT:    global_store_b128 v64, v[24:27], s[2:3] offset:80
; GFX11-NEXT:    global_store_b128 v64, v[28:31], s[2:3] offset:96
; GFX11-NEXT:    global_store_b128 v64, v[32:35], s[2:3] offset:112
; GFX11-NEXT:    global_store_b128 v64, v[36:39], s[2:3] offset:128
; GFX11-NEXT:    global_store_b128 v64, v[4:7], s[2:3] offset:144
; GFX11-NEXT:    s_waitcnt vmcnt(5)
; GFX11-NEXT:    global_store_b128 v64, v[40:43], s[2:3] offset:160
; GFX11-NEXT:    s_waitcnt vmcnt(4)
; GFX11-NEXT:    global_store_b128 v64, v[44:47], s[2:3] offset:176
; GFX11-NEXT:    s_waitcnt vmcnt(3)
; GFX11-NEXT:    global_store_b128 v64, v[48:51], s[2:3] offset:192
; GFX11-NEXT:    s_waitcnt vmcnt(2)
; GFX11-NEXT:    global_store_b128 v64, v[52:55], s[2:3] offset:208
; GFX11-NEXT:    s_waitcnt vmcnt(1)
; GFX11-NEXT:    global_store_b128 v64, v[56:59], s[2:3] offset:224
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_store_b128 v64, v[60:63], s[2:3] offset:240
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %id = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr <64 x i32>, ptr addrspace(1) %ptr.in, i32 %id
  %vec = load <64 x i32>, ptr addrspace(1) %gep.in
  %insert = insertelement <64 x i32> %vec, i32 999, i32 37
  %gep.out = getelementptr <64 x i32>, ptr addrspace(1) %ptr.out, i32 %id
  store <64 x i32> %insert, ptr addrspace(1) %gep.out
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { "amdgpu-flat-work-group-size"="1,256" "amdgpu-waves-per-eu"="1,10" }
attributes #1 = { nounwind readnone speculatable willreturn }

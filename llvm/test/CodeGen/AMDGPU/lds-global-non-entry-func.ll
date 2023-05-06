; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -o - -amdgpu-enable-lower-module-lds=false %s 2> %t | FileCheck -check-prefixes=GFX8 %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -o - -amdgpu-enable-lower-module-lds=false %s 2> %t | FileCheck -check-prefixes=GFX9 %s
; RUN: FileCheck -check-prefix=ERR %s < %t

@lds = internal addrspace(3) global float undef, align 4

; ERR: warning: <unknown>:0:0: in function func_use_lds_global void (): local memory global used by non-kernel function
define void @func_use_lds_global() {
; GFX8-LABEL: func_use_lds_global:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-NEXT:    s_mov_b32 m0, -1
; GFX8-NEXT:    ds_write_b32 v0, v0
; GFX8-NEXT:    s_mov_b64 s[0:1], s[6:7]
; GFX8-NEXT:    s_trap 2
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: func_use_lds_global:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    ds_write_b32 v0, v0
; GFX9-NEXT:    s_trap 2
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  store float 0.0, ptr addrspace(3) @lds, align 4
  ret void
}

; ERR: warning: <unknown>:0:0: in function func_use_lds_global_constexpr_cast void (): local memory global used by non-kernel function
define void @func_use_lds_global_constexpr_cast() {
; GFX8-LABEL: func_use_lds_global_constexpr_cast:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    s_mov_b64 s[0:1], s[6:7]
; GFX8-NEXT:    s_trap 2
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: func_use_lds_global_constexpr_cast:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_trap 2
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  store i32 ptrtoint (ptr addrspace(3) @lds to i32), ptr addrspace(1) undef, align 4
  ret void
}

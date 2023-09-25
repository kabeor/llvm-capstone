; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -global-isel=0 -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefixes=GFX10,GFX10-SDAG
; RUN: llc < %s -global-isel=1 -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefixes=GFX10,GFX10-GISEL

declare double @llvm.amdgcn.global.atomic.fmin.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
declare double @llvm.amdgcn.global.atomic.fmax.f64.p1.f64(ptr addrspace(1) %ptr, double %data)

define amdgpu_cs void @global_atomic_fmin_f64_noret(ptr addrspace(1) %ptr, double %data) {
; GFX10-LABEL: global_atomic_fmin_f64_noret:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    global_atomic_fmin_x2 v[0:1], v[2:3], off
; GFX10-NEXT:    s_endpgm
  %ret = call double @llvm.amdgcn.global.atomic.fmin.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  ret void
}

define amdgpu_cs void @global_atomic_fmax_f64_noret(ptr addrspace(1) %ptr, double %data) {
; GFX10-LABEL: global_atomic_fmax_f64_noret:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    global_atomic_fmax_x2 v[0:1], v[2:3], off
; GFX10-NEXT:    s_endpgm
  %ret = call double @llvm.amdgcn.global.atomic.fmax.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  ret void
}

define amdgpu_cs void @global_atomic_fmin_f64_rtn(ptr addrspace(1) %ptr, double %data, ptr addrspace(1) %out) {
; GFX10-LABEL: global_atomic_fmin_f64_rtn:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    global_atomic_fmin_x2 v[0:1], v[0:1], v[2:3], off glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX10-NEXT:    s_endpgm
  %ret = call double @llvm.amdgcn.global.atomic.fmin.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  store double %ret, ptr addrspace(1) %out
  ret void
}

define amdgpu_cs void @global_atomic_fmax_f64_rtn(ptr addrspace(1) %ptr, double %data, ptr addrspace(1) %out) {
; GFX10-LABEL: global_atomic_fmax_f64_rtn:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    global_atomic_fmax_x2 v[0:1], v[0:1], v[2:3], off glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX10-NEXT:    s_endpgm
  %ret = call double @llvm.amdgcn.global.atomic.fmax.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  store double %ret, ptr addrspace(1) %out
  ret void
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; GFX10-GISEL: {{.*}}
; GFX10-SDAG: {{.*}}

; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck -check-prefix=UNPACKED %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx810 -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck -check-prefix=PACKED %s

define amdgpu_ps void @raw_tbuffer_store_i8__sgpr_rsrc__vgpr_voffset__sgpr_soffset(i8 %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_i8__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; UNPACKED-NEXT:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_i8__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; PACKED-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.i8(i8 %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 94, i32 0)
  ret void
}

; Waterfall for rsrc
define amdgpu_ps void @raw_tbuffer_store_i8__vgpr_rsrc__vgpr_voffset__sgpr_soffset(i8 %val, <4 x i32> %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_i8__vgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   successors: %bb.2(0x80000000)
  ; UNPACKED-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.2:
  ; UNPACKED-NEXT:   successors: %bb.3(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED-NEXT:   [[COPY9:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY10:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY9]], [[COPY7]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY10]], [[COPY8]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def $scc
  ; UNPACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.3:
  ; UNPACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE1]], [[COPY6]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; UNPACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.4:
  ; UNPACKED-NEXT:   successors: %bb.5(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.5:
  ; UNPACKED-NEXT:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_i8__vgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   successors: %bb.2(0x80000000)
  ; PACKED-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.2:
  ; PACKED-NEXT:   successors: %bb.3(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED-NEXT:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED-NEXT:   [[COPY9:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; PACKED-NEXT:   [[COPY10:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY9]], [[COPY7]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY10]], [[COPY8]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def $scc
  ; PACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.3:
  ; PACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE1]], [[COPY6]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; PACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.4:
  ; PACKED-NEXT:   successors: %bb.5(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.5:
  ; PACKED-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.i8(i8 %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 94, i32 0)
  ret void
}

; Waterfall for rsrc and soffset
define amdgpu_ps void @raw_tbuffer_store_i8__vgpr_rsrc__vgpr_voffset__vgpr_soffset(i8 %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_i8__vgpr_rsrc__vgpr_voffset__vgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   successors: %bb.2(0x80000000)
  ; UNPACKED-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr6
  ; UNPACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.2:
  ; UNPACKED-NEXT:   successors: %bb.3(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED-NEXT:   [[COPY9:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY10:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY9]], [[COPY7]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY10]], [[COPY8]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def $scc
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def $scc
  ; UNPACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.3:
  ; UNPACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; UNPACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.4:
  ; UNPACKED-NEXT:   successors: %bb.5(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.5:
  ; UNPACKED-NEXT:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_i8__vgpr_rsrc__vgpr_voffset__vgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   successors: %bb.2(0x80000000)
  ; PACKED-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr6
  ; PACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.2:
  ; PACKED-NEXT:   successors: %bb.3(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED-NEXT:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED-NEXT:   [[COPY9:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; PACKED-NEXT:   [[COPY10:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY9]], [[COPY7]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY10]], [[COPY8]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def $scc
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def $scc
  ; PACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.3:
  ; PACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; PACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.4:
  ; PACKED-NEXT:   successors: %bb.5(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.5:
  ; PACKED-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.i8(i8 %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 94, i32 0)
  ret void
}

; Waterfall for rsrc and soffset, copy for voffset
define amdgpu_ps void @raw_tbuffer_store_i8__vgpr_rsrc__sgpr_voffset__vgpr_soffset(i8 %val, <4 x i32> %rsrc, i32 inreg %voffset, i32 %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_i8__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   successors: %bb.2(0x80000000)
  ; UNPACKED-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; UNPACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; UNPACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.2:
  ; UNPACKED-NEXT:   successors: %bb.3(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED-NEXT:   [[COPY10:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY11:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY10]], [[COPY8]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY11]], [[COPY9]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def $scc
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def $scc
  ; UNPACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.3:
  ; UNPACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY7]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; UNPACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.4:
  ; UNPACKED-NEXT:   successors: %bb.5(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.5:
  ; UNPACKED-NEXT:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_i8__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   successors: %bb.2(0x80000000)
  ; PACKED-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; PACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; PACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.2:
  ; PACKED-NEXT:   successors: %bb.3(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED-NEXT:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED-NEXT:   [[COPY10:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; PACKED-NEXT:   [[COPY11:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY10]], [[COPY8]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY11]], [[COPY9]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def $scc
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def $scc
  ; PACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.3:
  ; PACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   TBUFFER_STORE_FORMAT_X_OFFEN_exact [[COPY]], [[COPY7]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 94, 0, 0, implicit $exec :: (dereferenceable store (s8), addrspace 8)
  ; PACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.4:
  ; PACKED-NEXT:   successors: %bb.5(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.5:
  ; PACKED-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.i8(i8 %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 94, i32 0)
  ret void
}

declare void @llvm.amdgcn.raw.tbuffer.store.i8(i8, <4 x i32>, i32, i32, i32 immarg, i32 immarg)

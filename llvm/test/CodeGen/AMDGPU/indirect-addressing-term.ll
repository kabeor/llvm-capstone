; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -amdgpu-scalarize-global-loads=false -march=amdgcn -mcpu=gfx900 -mattr=-flat-for-global -verify-machineinstrs -stop-after=regallocfast < %s | FileCheck -check-prefixes=GCN %s

; Verify that we consider the xor at the end of the waterfall loop emitted for
; divergent indirect addressing as a terminator.

declare i32 @llvm.amdgcn.workitem.id.x() #1

; There should be no spill code inserted between the xor and the real terminator
define amdgpu_kernel void @extract_w_offset_vgpr(ptr addrspace(1) %out) {
  ; GCN-LABEL: name: extract_w_offset_vgpr
  ; GCN: bb.0.entry:
  ; GCN-NEXT:   successors: %bb.1(0x80000000)
  ; GCN-NEXT:   liveins: $vgpr0, $sgpr4_sgpr5
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32(s32) = COPY killed $vgpr0
  ; GCN-NEXT:   renamable $sgpr0_sgpr1 = S_LOAD_DWORDX2_IMM killed renamable $sgpr4_sgpr5, 36, 0 :: (dereferenceable invariant load (s64) from %ir.out.kernarg.offset, align 4, addrspace 4)
  ; GCN-NEXT:   renamable $sgpr6 = COPY renamable $sgpr1
  ; GCN-NEXT:   renamable $sgpr0 = COPY renamable $sgpr0, implicit killed $sgpr0_sgpr1
  ; GCN-NEXT:   renamable $sgpr4 = S_MOV_B32 61440
  ; GCN-NEXT:   renamable $sgpr5 = S_MOV_B32 -1
  ; GCN-NEXT:   undef renamable $sgpr0 = COPY killed renamable $sgpr0, implicit-def $sgpr0_sgpr1_sgpr2_sgpr3
  ; GCN-NEXT:   renamable $sgpr1 = COPY killed renamable $sgpr6
  ; GCN-NEXT:   renamable $sgpr2 = COPY killed renamable $sgpr5
  ; GCN-NEXT:   renamable $sgpr3 = COPY killed renamable $sgpr4
  ; GCN-NEXT:   SI_SPILL_S128_SAVE killed $sgpr0_sgpr1_sgpr2_sgpr3, %stack.1, implicit $exec, implicit $sgpr32 :: (store (s128) into %stack.1, align 4, addrspace 5)
  ; GCN-NEXT:   renamable $sgpr0 = S_MOV_B32 16
  ; GCN-NEXT:   renamable $sgpr1 = S_MOV_B32 15
  ; GCN-NEXT:   renamable $sgpr2 = S_MOV_B32 14
  ; GCN-NEXT:   renamable $sgpr3 = S_MOV_B32 13
  ; GCN-NEXT:   renamable $sgpr4 = S_MOV_B32 12
  ; GCN-NEXT:   renamable $sgpr5 = S_MOV_B32 11
  ; GCN-NEXT:   renamable $sgpr6 = S_MOV_B32 10
  ; GCN-NEXT:   renamable $sgpr7 = S_MOV_B32 9
  ; GCN-NEXT:   renamable $sgpr8 = S_MOV_B32 8
  ; GCN-NEXT:   renamable $sgpr9 = S_MOV_B32 7
  ; GCN-NEXT:   renamable $sgpr10 = S_MOV_B32 6
  ; GCN-NEXT:   renamable $sgpr11 = S_MOV_B32 5
  ; GCN-NEXT:   renamable $sgpr12 = S_MOV_B32 3
  ; GCN-NEXT:   renamable $sgpr13 = S_MOV_B32 2
  ; GCN-NEXT:   renamable $sgpr14 = S_MOV_B32 1
  ; GCN-NEXT:   renamable $sgpr15 = S_MOV_B32 0
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr15
  ; GCN-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr14
  ; GCN-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr13
  ; GCN-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr12
  ; GCN-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr11
  ; GCN-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr10
  ; GCN-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr9
  ; GCN-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr8
  ; GCN-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr7
  ; GCN-NEXT:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr6
  ; GCN-NEXT:   [[COPY11:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr5
  ; GCN-NEXT:   [[COPY12:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr4
  ; GCN-NEXT:   [[COPY13:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr3
  ; GCN-NEXT:   [[COPY14:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr2
  ; GCN-NEXT:   [[COPY15:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr1
  ; GCN-NEXT:   [[COPY16:%[0-9]+]]:vgpr_32 = COPY killed renamable $sgpr0
  ; GCN-NEXT:   undef %35.sub0:vreg_512 = COPY [[COPY1]]
  ; GCN-NEXT:   %35.sub1:vreg_512 = COPY [[COPY2]]
  ; GCN-NEXT:   %35.sub2:vreg_512 = COPY [[COPY3]]
  ; GCN-NEXT:   %35.sub3:vreg_512 = COPY [[COPY4]]
  ; GCN-NEXT:   %35.sub4:vreg_512 = COPY [[COPY5]]
  ; GCN-NEXT:   %35.sub5:vreg_512 = COPY [[COPY6]]
  ; GCN-NEXT:   %35.sub6:vreg_512 = COPY [[COPY7]]
  ; GCN-NEXT:   %35.sub7:vreg_512 = COPY [[COPY8]]
  ; GCN-NEXT:   %35.sub8:vreg_512 = COPY [[COPY9]]
  ; GCN-NEXT:   %35.sub9:vreg_512 = COPY [[COPY10]]
  ; GCN-NEXT:   %35.sub10:vreg_512 = COPY [[COPY11]]
  ; GCN-NEXT:   %35.sub11:vreg_512 = COPY [[COPY12]]
  ; GCN-NEXT:   %35.sub12:vreg_512 = COPY [[COPY13]]
  ; GCN-NEXT:   %35.sub13:vreg_512 = COPY [[COPY14]]
  ; GCN-NEXT:   %35.sub14:vreg_512 = COPY [[COPY15]]
  ; GCN-NEXT:   %35.sub15:vreg_512 = COPY [[COPY16]]
  ; GCN-NEXT:   renamable $sgpr0_sgpr1 = S_MOV_B64 $exec
  ; GCN-NEXT:   SI_SPILL_S64_SAVE killed $sgpr0_sgpr1, %stack.0, implicit $exec, implicit $sgpr32 :: (store (s64) into %stack.0, align 4, addrspace 5)
  ; GCN-NEXT:   [[DEF:%[0-9]+]]:vgpr_32 = IMPLICIT_DEF
  ; GCN-NEXT:   renamable $sgpr0_sgpr1 = IMPLICIT_DEF
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT: bb.1:
  ; GCN-NEXT:   successors: %bb.1(0x40000000), %bb.3(0x40000000)
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   $sgpr0_sgpr1 = SI_SPILL_S64_RESTORE %stack.2, implicit $exec, implicit $sgpr32 :: (load (s64) from %stack.2, align 4, addrspace 5)
  ; GCN-NEXT:   dead [[COPY17:%[0-9]+]]:vgpr_32 = COPY [[DEF]]
  ; GCN-NEXT:   renamable $sgpr2 = V_READFIRSTLANE_B32 [[COPY]](s32), implicit $exec
  ; GCN-NEXT:   renamable $sgpr0_sgpr1 = V_CMP_EQ_U32_e64 $sgpr2, [[COPY]](s32), implicit $exec
  ; GCN-NEXT:   renamable $sgpr0_sgpr1 = S_AND_SAVEEXEC_B64 killed renamable $sgpr0_sgpr1, implicit-def $exec, implicit-def dead $scc, implicit $exec
  ; GCN-NEXT:   [[V_INDIRECT_REG_READ_GPR_IDX_B32_V16_:%[0-9]+]]:vgpr_32 = V_INDIRECT_REG_READ_GPR_IDX_B32_V16 %35, killed $sgpr2, 11, implicit-def $m0, implicit $m0, implicit $exec
  ; GCN-NEXT:   [[COPY18:%[0-9]+]]:vgpr_32 = COPY [[V_INDIRECT_REG_READ_GPR_IDX_B32_V16_]]
  ; GCN-NEXT:   renamable $sgpr2_sgpr3 = COPY renamable $sgpr0_sgpr1
  ; GCN-NEXT:   SI_SPILL_S64_SAVE killed $sgpr2_sgpr3, %stack.2, implicit $exec, implicit $sgpr32 :: (store (s64) into %stack.2, align 4, addrspace 5)
  ; GCN-NEXT:   $exec = S_XOR_B64_term $exec, killed renamable $sgpr0_sgpr1, implicit-def dead $scc
  ; GCN-NEXT:   S_CBRANCH_EXECNZ %bb.1, implicit $exec
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT: bb.3:
  ; GCN-NEXT:   successors: %bb.2(0x80000000)
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   $sgpr0_sgpr1 = SI_SPILL_S64_RESTORE %stack.0, implicit $exec, implicit $sgpr32 :: (load (s64) from %stack.0, align 4, addrspace 5)
  ; GCN-NEXT:   $exec = S_MOV_B64 renamable $sgpr0_sgpr1
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT: bb.2:
  ; GCN-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = SI_SPILL_S128_RESTORE %stack.1, implicit $exec, implicit $sgpr32 :: (load (s128) from %stack.1, align 4, addrspace 5)
  ; GCN-NEXT:   BUFFER_STORE_DWORD_OFFSET [[V_INDIRECT_REG_READ_GPR_IDX_B32_V16_]], killed renamable $sgpr0_sgpr1_sgpr2_sgpr3, 0, 0, 0, 0, implicit $exec :: (store (s32) into %ir.out.load, addrspace 1)
  ; GCN-NEXT:   S_ENDPGM 0
entry:
  %id = call i32 @llvm.amdgcn.workitem.id.x() #1
  %index = add i32 %id, 1
  %value = extractelement <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16>, i32 %index
  store i32 %value, ptr addrspace(1) %out
  ret void
}

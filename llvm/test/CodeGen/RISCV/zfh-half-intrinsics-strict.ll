; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+zfh \
; RUN:   -verify-machineinstrs -target-abi ilp32f -disable-strictnode-mutation \
; RUN:   | FileCheck -check-prefix=RV32IZFH %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+zfh \
; RUN:   -verify-machineinstrs -target-abi lp64f -disable-strictnode-mutation \
; RUN:   | FileCheck -check-prefix=RV64IZFH %s
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+d \
; RUN:   -mattr=+zfh -verify-machineinstrs -target-abi ilp32d \
; RUN:   -disable-strictnode-mutation | FileCheck -check-prefix=RV32IZFH %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+d \
; RUN:   -mattr=+zfh -verify-machineinstrs -target-abi lp64d \
; RUN:   -disable-strictnode-mutation | FileCheck -check-prefix=RV64IZFH %s
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+zhinx \
; RUN:   -verify-machineinstrs -target-abi ilp32 -disable-strictnode-mutation \
; RUN:   | FileCheck -check-prefix=RV32IZHINX %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+zhinx \
; RUN:   -verify-machineinstrs -target-abi lp64 -disable-strictnode-mutation \
; RUN:   | FileCheck -check-prefix=RV64IZHINX %s
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+zdinx \
; RUN:   -mattr=+zhinx -verify-machineinstrs -target-abi ilp32 | \
; RUN:   FileCheck -check-prefix=RV32IZDINXZHINX %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+zdinx \
; RUN:   -mattr=+zhinx -verify-machineinstrs -target-abi lp64 | \
; RUN:   FileCheck -check-prefix=RV64IZDINXZHINX %s

declare half @llvm.experimental.constrained.sqrt.f16(half, metadata, metadata)

define half @sqrt_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: sqrt_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fsqrt.h fa0, fa0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: sqrt_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fsqrt.h fa0, fa0
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: sqrt_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    fsqrt.h a0, a0
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: sqrt_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fsqrt.h a0, a0
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: sqrt_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    fsqrt.h a0, a0
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: sqrt_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    fsqrt.h a0, a0
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.sqrt.f16(half %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.floor.f16(half, metadata)

define half @floor_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: floor_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call floorf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: floor_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call floorf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: floor_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call floorf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: floor_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call floorf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: floor_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call floorf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: floor_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call floorf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.floor.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.ceil.f16(half, metadata)

define half @ceil_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: ceil_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call ceilf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: ceil_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call ceilf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: ceil_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call ceilf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: ceil_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call ceilf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: ceil_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call ceilf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: ceil_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call ceilf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.ceil.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.trunc.f16(half, metadata)

define half @trunc_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: trunc_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call truncf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: trunc_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call truncf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: trunc_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call truncf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: trunc_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call truncf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: trunc_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call truncf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: trunc_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call truncf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.trunc.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.rint.f16(half, metadata, metadata)

define half @rint_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: rint_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call rintf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: rint_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call rintf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: rint_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call rintf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: rint_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call rintf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: rint_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call rintf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: rint_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call rintf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.rint.f16(half %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.nearbyint.f16(half, metadata, metadata)

define half @nearbyint_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: nearbyint_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call nearbyintf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: nearbyint_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call nearbyintf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: nearbyint_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call nearbyintf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: nearbyint_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call nearbyintf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: nearbyint_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call nearbyintf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: nearbyint_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call nearbyintf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.nearbyint.f16(half %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.round.f16(half, metadata)

define half @round_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: round_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call roundf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: round_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call roundf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: round_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call roundf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: round_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call roundf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: round_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call roundf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: round_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call roundf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.round.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare half @llvm.experimental.constrained.roundeven.f16(half, metadata)

define half @roundeven_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: roundeven_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call roundevenf@plt
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: roundeven_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call roundevenf@plt
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: roundeven_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call roundevenf@plt
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: roundeven_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    call roundevenf@plt
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: roundeven_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call roundevenf@plt
; RV32IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: roundeven_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV64IZDINXZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZDINXZHINX-NEXT:    call roundevenf@plt
; RV64IZDINXZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZDINXZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.roundeven.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret half %1
}

declare iXLen @llvm.experimental.constrained.lrint.iXLen.f16(half, metadata, metadata)

define iXLen @lrint_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: lrint_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.w.h a0, fa0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: lrint_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: lrint_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    fcvt.w.h a0, a0
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: lrint_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.l.h a0, a0
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: lrint_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    fcvt.w.h a0, a0
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: lrint_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    fcvt.l.h a0, a0
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call iXLen @llvm.experimental.constrained.lrint.iXLen.f16(half %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret iXLen %1
}

declare iXLen @llvm.experimental.constrained.lround.iXLen.f16(half, metadata)

define iXLen @lround_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: lround_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.w.h a0, fa0, rmm
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: lround_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rmm
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: lround_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    fcvt.w.h a0, a0, rmm
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: lround_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.l.h a0, a0, rmm
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: lround_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    fcvt.w.h a0, a0, rmm
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: lround_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    fcvt.l.h a0, a0, rmm
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call iXLen @llvm.experimental.constrained.lround.iXLen.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret iXLen %1
}

declare i64 @llvm.experimental.constrained.llrint.i64.f16(half, metadata, metadata)

define i64 @llrint_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: llrint_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call llrintf@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: llrint_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: llrint_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call llrintf@plt
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: llrint_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.l.h a0, a0
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: llrint_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call llrintf@plt
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: llrint_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    fcvt.l.h a0, a0
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call i64 @llvm.experimental.constrained.llrint.i64.f16(half %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret i64 %1
}

declare i64 @llvm.experimental.constrained.llround.i64.f16(half, metadata)

define i64 @llround_f16(half %a) nounwind strictfp {
; RV32IZFH-LABEL: llround_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call llroundf@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: llround_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rmm
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: llround_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    call llroundf@plt
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: llround_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.l.h a0, a0, rmm
; RV64IZHINX-NEXT:    ret
;
; RV32IZDINXZHINX-LABEL: llround_f16:
; RV32IZDINXZHINX:       # %bb.0:
; RV32IZDINXZHINX-NEXT:    addi sp, sp, -16
; RV32IZDINXZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZDINXZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZDINXZHINX-NEXT:    call llroundf@plt
; RV32IZDINXZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZDINXZHINX-NEXT:    addi sp, sp, 16
; RV32IZDINXZHINX-NEXT:    ret
;
; RV64IZDINXZHINX-LABEL: llround_f16:
; RV64IZDINXZHINX:       # %bb.0:
; RV64IZDINXZHINX-NEXT:    fcvt.l.h a0, a0, rmm
; RV64IZDINXZHINX-NEXT:    ret
  %1 = call i64 @llvm.experimental.constrained.llround.i64.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i64 %1
}

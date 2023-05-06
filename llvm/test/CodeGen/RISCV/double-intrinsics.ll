; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+d \
; RUN:   -verify-machineinstrs -target-abi=ilp32d \
; RUN:   | FileCheck -check-prefixes=CHECKIFD,RV32IFD %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+d \
; RUN:   -verify-machineinstrs -target-abi=lp64d \
; RUN:   | FileCheck -check-prefixes=CHECKIFD,RV64IFD %s
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 \
; RUN:   -verify-machineinstrs | FileCheck -check-prefix=RV32I %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 \
; RUN:   -verify-machineinstrs | FileCheck -check-prefix=RV64I %s

declare double @llvm.sqrt.f64(double)

define double @sqrt_f64(double %a) nounwind {
; CHECKIFD-LABEL: sqrt_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fsqrt.d fa0, fa0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: sqrt_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call sqrt@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sqrt_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call sqrt@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.sqrt.f64(double %a)
  ret double %1
}

declare double @llvm.powi.f64.i32(double, i32)

define double @powi_f64(double %a, i32 %b) nounwind {
; RV32IFD-LABEL: powi_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail __powidf2@plt
;
; RV64IFD-LABEL: powi_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    addi sp, sp, -16
; RV64IFD-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    sext.w a0, a0
; RV64IFD-NEXT:    call __powidf2@plt
; RV64IFD-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    addi sp, sp, 16
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: powi_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __powidf2@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: powi_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    call __powidf2@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.powi.f64.i32(double %a, i32 %b)
  ret double %1
}

declare double @llvm.sin.f64(double)

define double @sin_f64(double %a) nounwind {
; CHECKIFD-LABEL: sin_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail sin@plt
;
; RV32I-LABEL: sin_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call sin@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sin_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call sin@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.sin.f64(double %a)
  ret double %1
}

declare double @llvm.cos.f64(double)

define double @cos_f64(double %a) nounwind {
; CHECKIFD-LABEL: cos_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail cos@plt
;
; RV32I-LABEL: cos_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call cos@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: cos_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call cos@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.cos.f64(double %a)
  ret double %1
}

; The sin+cos combination results in an FSINCOS SelectionDAG node.
define double @sincos_f64(double %a) nounwind {
; RV32IFD-LABEL: sincos_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    fsd fs0, 16(sp) # 8-byte Folded Spill
; RV32IFD-NEXT:    fsd fs1, 8(sp) # 8-byte Folded Spill
; RV32IFD-NEXT:    fmv.d fs0, fa0
; RV32IFD-NEXT:    call sin@plt
; RV32IFD-NEXT:    fmv.d fs1, fa0
; RV32IFD-NEXT:    fmv.d fa0, fs0
; RV32IFD-NEXT:    call cos@plt
; RV32IFD-NEXT:    fadd.d fa0, fs1, fa0
; RV32IFD-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    fld fs0, 16(sp) # 8-byte Folded Reload
; RV32IFD-NEXT:    fld fs1, 8(sp) # 8-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: sincos_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    addi sp, sp, -32
; RV64IFD-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    fsd fs0, 16(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    fsd fs1, 8(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    fmv.d fs0, fa0
; RV64IFD-NEXT:    call sin@plt
; RV64IFD-NEXT:    fmv.d fs1, fa0
; RV64IFD-NEXT:    fmv.d fa0, fs0
; RV64IFD-NEXT:    call cos@plt
; RV64IFD-NEXT:    fadd.d fa0, fs1, fa0
; RV64IFD-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    fld fs0, 16(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    fld fs1, 8(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    addi sp, sp, 32
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: sincos_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    call sin@plt
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    mv s3, a1
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    mv a1, s0
; RV32I-NEXT:    call cos@plt
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:    mv a0, s2
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __adddf3@plt
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sincos_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    call sin@plt
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    call cos@plt
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __adddf3@plt
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %1 = call double @llvm.sin.f64(double %a)
  %2 = call double @llvm.cos.f64(double %a)
  %3 = fadd double %1, %2
  ret double %3
}

declare double @llvm.pow.f64(double, double)

define double @pow_f64(double %a, double %b) nounwind {
; CHECKIFD-LABEL: pow_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail pow@plt
;
; RV32I-LABEL: pow_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call pow@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: pow_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call pow@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.pow.f64(double %a, double %b)
  ret double %1
}

declare double @llvm.exp.f64(double)

define double @exp_f64(double %a) nounwind {
; CHECKIFD-LABEL: exp_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail exp@plt
;
; RV32I-LABEL: exp_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call exp@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: exp_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call exp@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.exp.f64(double %a)
  ret double %1
}

declare double @llvm.exp2.f64(double)

define double @exp2_f64(double %a) nounwind {
; CHECKIFD-LABEL: exp2_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail exp2@plt
;
; RV32I-LABEL: exp2_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call exp2@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: exp2_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call exp2@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.exp2.f64(double %a)
  ret double %1
}

declare double @llvm.log.f64(double)

define double @log_f64(double %a) nounwind {
; CHECKIFD-LABEL: log_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail log@plt
;
; RV32I-LABEL: log_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call log@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: log_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call log@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.log.f64(double %a)
  ret double %1
}

declare double @llvm.log10.f64(double)

define double @log10_f64(double %a) nounwind {
; CHECKIFD-LABEL: log10_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail log10@plt
;
; RV32I-LABEL: log10_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call log10@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: log10_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call log10@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.log10.f64(double %a)
  ret double %1
}

declare double @llvm.log2.f64(double)

define double @log2_f64(double %a) nounwind {
; CHECKIFD-LABEL: log2_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail log2@plt
;
; RV32I-LABEL: log2_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call log2@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: log2_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call log2@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.log2.f64(double %a)
  ret double %1
}

declare double @llvm.fma.f64(double, double, double)

define double @fma_f64(double %a, double %b, double %c) nounwind {
; CHECKIFD-LABEL: fma_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fmadd.d fa0, fa0, fa1, fa2
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fma_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call fma@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fma_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fma@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.fma.f64(double %a, double %b, double %c)
  ret double %1
}

declare double @llvm.fmuladd.f64(double, double, double)

define double @fmuladd_f64(double %a, double %b, double %c) nounwind {
; CHECKIFD-LABEL: fmuladd_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fmadd.d fa0, fa0, fa1, fa2
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fmuladd_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a5
; RV32I-NEXT:    mv s1, a4
; RV32I-NEXT:    call __muldf3@plt
; RV32I-NEXT:    mv a2, s1
; RV32I-NEXT:    mv a3, s0
; RV32I-NEXT:    call __adddf3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fmuladd_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a2
; RV64I-NEXT:    call __muldf3@plt
; RV64I-NEXT:    mv a1, s0
; RV64I-NEXT:    call __adddf3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.fmuladd.f64(double %a, double %b, double %c)
  ret double %1
}

declare double @llvm.fabs.f64(double)

define double @fabs_f64(double %a) nounwind {
; CHECKIFD-LABEL: fabs_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fabs.d fa0, fa0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fabs_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    srli a1, a1, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fabs_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 1
; RV64I-NEXT:    srli a0, a0, 1
; RV64I-NEXT:    ret
  %1 = call double @llvm.fabs.f64(double %a)
  ret double %1
}

declare double @llvm.minnum.f64(double, double)

define double @minnum_f64(double %a, double %b) nounwind {
; CHECKIFD-LABEL: minnum_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fmin.d fa0, fa0, fa1
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: minnum_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call fmin@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: minnum_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fmin@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.minnum.f64(double %a, double %b)
  ret double %1
}

declare double @llvm.maxnum.f64(double, double)

define double @maxnum_f64(double %a, double %b) nounwind {
; CHECKIFD-LABEL: maxnum_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fmax.d fa0, fa0, fa1
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: maxnum_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call fmax@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: maxnum_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fmax@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.maxnum.f64(double %a, double %b)
  ret double %1
}

; TODO: FMINNAN and FMAXNAN aren't handled in
; SelectionDAGLegalize::ExpandNode.

; declare double @llvm.minimum.f64(double, double)

; define double @fminimum_f64(double %a, double %b) nounwind {
;   %1 = call double @llvm.minimum.f64(double %a, double %b)
;   ret double %1
; }

; declare double @llvm.maximum.f64(double, double)

; define double @fmaximum_f64(double %a, double %b) nounwind {
;   %1 = call double @llvm.maximum.f64(double %a, double %b)
;   ret double %1
; }

declare double @llvm.copysign.f64(double, double)

define double @copysign_f64(double %a, double %b) nounwind {
; CHECKIFD-LABEL: copysign_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fsgnj.d fa0, fa0, fa1
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: copysign_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a2, 524288
; RV32I-NEXT:    and a2, a3, a2
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    srli a1, a1, 1
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: copysign_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srli a1, a1, 63
; RV64I-NEXT:    slli a1, a1, 63
; RV64I-NEXT:    slli a0, a0, 1
; RV64I-NEXT:    srli a0, a0, 1
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %1 = call double @llvm.copysign.f64(double %a, double %b)
  ret double %1
}

declare double @llvm.floor.f64(double)

define double @floor_f64(double %a) nounwind {
; RV32IFD-LABEL: floor_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail floor@plt
;
; RV64IFD-LABEL: floor_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a0, %hi(.LCPI17_0)
; RV64IFD-NEXT:    fld ft0, %lo(.LCPI17_0)(a0)
; RV64IFD-NEXT:    fabs.d ft1, fa0
; RV64IFD-NEXT:    flt.d a0, ft1, ft0
; RV64IFD-NEXT:    beqz a0, .LBB17_2
; RV64IFD-NEXT:  # %bb.1:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rdn
; RV64IFD-NEXT:    fcvt.d.l ft0, a0, rdn
; RV64IFD-NEXT:    fsgnj.d fa0, ft0, fa0
; RV64IFD-NEXT:  .LBB17_2:
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: floor_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call floor@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: floor_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call floor@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.floor.f64(double %a)
  ret double %1
}

declare double @llvm.ceil.f64(double)

define double @ceil_f64(double %a) nounwind {
; RV32IFD-LABEL: ceil_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail ceil@plt
;
; RV64IFD-LABEL: ceil_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a0, %hi(.LCPI18_0)
; RV64IFD-NEXT:    fld ft0, %lo(.LCPI18_0)(a0)
; RV64IFD-NEXT:    fabs.d ft1, fa0
; RV64IFD-NEXT:    flt.d a0, ft1, ft0
; RV64IFD-NEXT:    beqz a0, .LBB18_2
; RV64IFD-NEXT:  # %bb.1:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rup
; RV64IFD-NEXT:    fcvt.d.l ft0, a0, rup
; RV64IFD-NEXT:    fsgnj.d fa0, ft0, fa0
; RV64IFD-NEXT:  .LBB18_2:
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: ceil_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call ceil@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ceil_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call ceil@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.ceil.f64(double %a)
  ret double %1
}

declare double @llvm.trunc.f64(double)

define double @trunc_f64(double %a) nounwind {
; RV32IFD-LABEL: trunc_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail trunc@plt
;
; RV64IFD-LABEL: trunc_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a0, %hi(.LCPI19_0)
; RV64IFD-NEXT:    fld ft0, %lo(.LCPI19_0)(a0)
; RV64IFD-NEXT:    fabs.d ft1, fa0
; RV64IFD-NEXT:    flt.d a0, ft1, ft0
; RV64IFD-NEXT:    beqz a0, .LBB19_2
; RV64IFD-NEXT:  # %bb.1:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rtz
; RV64IFD-NEXT:    fcvt.d.l ft0, a0, rtz
; RV64IFD-NEXT:    fsgnj.d fa0, ft0, fa0
; RV64IFD-NEXT:  .LBB19_2:
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: trunc_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call trunc@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: trunc_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call trunc@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.trunc.f64(double %a)
  ret double %1
}

declare double @llvm.rint.f64(double)

define double @rint_f64(double %a) nounwind {
; RV32IFD-LABEL: rint_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail rint@plt
;
; RV64IFD-LABEL: rint_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a0, %hi(.LCPI20_0)
; RV64IFD-NEXT:    fld ft0, %lo(.LCPI20_0)(a0)
; RV64IFD-NEXT:    fabs.d ft1, fa0
; RV64IFD-NEXT:    flt.d a0, ft1, ft0
; RV64IFD-NEXT:    beqz a0, .LBB20_2
; RV64IFD-NEXT:  # %bb.1:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0
; RV64IFD-NEXT:    fcvt.d.l ft0, a0
; RV64IFD-NEXT:    fsgnj.d fa0, ft0, fa0
; RV64IFD-NEXT:  .LBB20_2:
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: rint_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call rint@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: rint_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call rint@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.rint.f64(double %a)
  ret double %1
}

declare double @llvm.nearbyint.f64(double)

define double @nearbyint_f64(double %a) nounwind {
; CHECKIFD-LABEL: nearbyint_f64:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    tail nearbyint@plt
;
; RV32I-LABEL: nearbyint_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call nearbyint@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: nearbyint_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call nearbyint@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.nearbyint.f64(double %a)
  ret double %1
}

declare double @llvm.round.f64(double)

define double @round_f64(double %a) nounwind {
; RV32IFD-LABEL: round_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail round@plt
;
; RV64IFD-LABEL: round_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a0, %hi(.LCPI22_0)
; RV64IFD-NEXT:    fld ft0, %lo(.LCPI22_0)(a0)
; RV64IFD-NEXT:    fabs.d ft1, fa0
; RV64IFD-NEXT:    flt.d a0, ft1, ft0
; RV64IFD-NEXT:    beqz a0, .LBB22_2
; RV64IFD-NEXT:  # %bb.1:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rmm
; RV64IFD-NEXT:    fcvt.d.l ft0, a0, rmm
; RV64IFD-NEXT:    fsgnj.d fa0, ft0, fa0
; RV64IFD-NEXT:  .LBB22_2:
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: round_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call round@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: round_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call round@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.round.f64(double %a)
  ret double %1
}

declare double @llvm.roundeven.f64(double)

define double @roundeven_f64(double %a) nounwind {
; RV32IFD-LABEL: roundeven_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail roundeven@plt
;
; RV64IFD-LABEL: roundeven_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a0, %hi(.LCPI23_0)
; RV64IFD-NEXT:    fld ft0, %lo(.LCPI23_0)(a0)
; RV64IFD-NEXT:    fabs.d ft1, fa0
; RV64IFD-NEXT:    flt.d a0, ft1, ft0
; RV64IFD-NEXT:    beqz a0, .LBB23_2
; RV64IFD-NEXT:  # %bb.1:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rne
; RV64IFD-NEXT:    fcvt.d.l ft0, a0, rne
; RV64IFD-NEXT:    fsgnj.d fa0, ft0, fa0
; RV64IFD-NEXT:  .LBB23_2:
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: roundeven_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call roundeven@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: roundeven_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call roundeven@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call double @llvm.roundeven.f64(double %a)
  ret double %1
}

declare iXLen @llvm.lrint.iXLen.f64(double)

define iXLen @lrint_f64(double %a) nounwind {
; RV32IFD-LABEL: lrint_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    fcvt.w.d a0, fa0
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: lrint_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: lrint_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call lrint@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lrint_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call lrint@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call iXLen @llvm.lrint.iXLen.f64(double %a)
  ret iXLen %1
}

declare iXLen @llvm.lround.iXLen.f64(double)

define iXLen @lround_f64(double %a) nounwind {
; RV32IFD-LABEL: lround_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    fcvt.w.d a0, fa0, rmm
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: lround_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rmm
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: lround_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call lround@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lround_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call lround@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call iXLen @llvm.lround.iXLen.f64(double %a)
  ret iXLen %1
}

declare i64 @llvm.llrint.i64.f64(double)

define i64 @llrint_f64(double %a) nounwind {
; RV32IFD-LABEL: llrint_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    call llrint@plt
; RV32IFD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: llrint_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: llrint_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call llrint@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: llrint_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llrint@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call i64 @llvm.llrint.i64.f64(double %a)
  ret i64 %1
}

declare i64 @llvm.llround.i64.f64(double)

define i64 @llround_f64(double %a) nounwind {
; RV32IFD-LABEL: llround_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    call llround@plt
; RV32IFD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: llround_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rmm
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: llround_f64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call llround@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: llround_f64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llround@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call i64 @llvm.llround.i64.f64(double %a)
  ret i64 %1
}

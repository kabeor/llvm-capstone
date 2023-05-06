; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I-FPELIM %s
; RUN: llc -mtriple=riscv32 -frame-pointer=all -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I-WITHFP %s

%struct.key_t = type { i32, [16 x i8] }

define i32 @test() nounwind {
; RV32I-FPELIM-LABEL: test:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -32
; RV32I-FPELIM-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-FPELIM-NEXT:    sw zero, 24(sp)
; RV32I-FPELIM-NEXT:    sw zero, 20(sp)
; RV32I-FPELIM-NEXT:    sw zero, 16(sp)
; RV32I-FPELIM-NEXT:    sw zero, 12(sp)
; RV32I-FPELIM-NEXT:    sw zero, 8(sp)
; RV32I-FPELIM-NEXT:    addi a0, sp, 12
; RV32I-FPELIM-NEXT:    call test1@plt
; RV32I-FPELIM-NEXT:    li a0, 0
; RV32I-FPELIM-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-FPELIM-NEXT:    addi sp, sp, 32
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: test:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -32
; RV32I-WITHFP-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 32
; RV32I-WITHFP-NEXT:    sw zero, -16(s0)
; RV32I-WITHFP-NEXT:    sw zero, -20(s0)
; RV32I-WITHFP-NEXT:    sw zero, -24(s0)
; RV32I-WITHFP-NEXT:    sw zero, -28(s0)
; RV32I-WITHFP-NEXT:    sw zero, -32(s0)
; RV32I-WITHFP-NEXT:    addi a0, s0, -28
; RV32I-WITHFP-NEXT:    call test1@plt
; RV32I-WITHFP-NEXT:    li a0, 0
; RV32I-WITHFP-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 32
; RV32I-WITHFP-NEXT:    ret
  %key = alloca %struct.key_t, align 4
  call void @llvm.memset.p0.i64(ptr align 4 %key, i8 0, i64 20, i1 false)
  %1 = getelementptr inbounds %struct.key_t, ptr %key, i64 0, i32 1, i64 0
  call void @test1(ptr %1)
  ret i32 0
}

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1)

declare void @test1(ptr)

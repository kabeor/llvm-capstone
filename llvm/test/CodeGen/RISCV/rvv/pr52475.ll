; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=4 \
; RUN:   -pre-RA-sched=list-burr -disable-machine-cse -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=4 \
; RUN:   -pre-RA-sched=list-burr -disable-machine-cse -verify-machineinstrs < %s | FileCheck %s

define <128 x i32> @ret_split_v128i32(ptr %x) {
; CHECK-LABEL: ret_split_v128i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    addi a2, a1, 448
; CHECK-NEXT:    vle32.v v8, (a2)
; CHECK-NEXT:    addi a2, a0, 448
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    addi a2, a1, 384
; CHECK-NEXT:    vle32.v v8, (a2)
; CHECK-NEXT:    addi a2, a0, 384
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    addi a2, a1, 320
; CHECK-NEXT:    vle32.v v8, (a2)
; CHECK-NEXT:    addi a2, a0, 320
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    addi a2, a1, 256
; CHECK-NEXT:    vle32.v v8, (a2)
; CHECK-NEXT:    addi a2, a0, 256
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    addi a2, a1, 192
; CHECK-NEXT:    vle32.v v8, (a2)
; CHECK-NEXT:    addi a2, a0, 192
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    addi a2, a1, 128
; CHECK-NEXT:    vle32.v v8, (a2)
; CHECK-NEXT:    addi a2, a0, 128
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    addi a1, a1, 64
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <128 x i32>, ptr %x
  ret <128 x i32> %v
}

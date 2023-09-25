; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --extra_scrub --version 3
; REQUIRES: asserts
; RUN: llc -verify-machineinstrs -max-registers-for-gc-values=256 -mtriple=aarch64-none-linux-gnu < %s | FileCheck %s

; Verify that FixupStatepointCallerSaved pass uses correct intruction for spilling a register after copyprop
define dso_local ptr addrspace(1) @foo(ptr addrspace(1) %arg) gc "statepoint-example" personality ptr null {
; CHECK-LABEL: foo:
; CHECK:       .Lfunc_begin0:
; CHECK-NEXT:    .cfi_startproc
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    stp x30, x19, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    str d0, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    str q0, [sp, #16]
; CHECK-NEXT:    bl baz // 8-byte Folded Reload
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    ldp x19, x0, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    ldp x30, x19, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %load = load <2 x ptr addrspace(1)>, ptr addrspace(1) %arg, align 8
  %extractelement = extractelement <2 x ptr addrspace(1)> %load, i64 0
  %call = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr nonnull elementtype(void ()) @baz, i32 0, i32 0, i32 0, i32 0) [ "deopt"(ptr addrspace(1) %extractelement), "gc-live"(<2 x ptr addrspace(1)> %load) ]
  %relocate = call coldcc <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token %call, i32 0, i32 0)
  %extractelement2 = extractelement <2 x ptr addrspace(1)> %relocate, i64 0
  ret ptr addrspace(1) %extractelement2
}

declare void @baz()
declare token @llvm.experimental.gc.statepoint.p0(i64, i32, ptr, i32, i32, ...)
; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token, i32, i32) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(none) }

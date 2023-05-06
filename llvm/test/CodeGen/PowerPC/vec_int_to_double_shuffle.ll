; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64le-unknown-unknown \
; RUN:   -verify-machineinstrs < %s | FileCheck --check-prefix=CHECK-LE %s
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64-unknown-unknown \
; RUN:   -verify-machineinstrs < %s | FileCheck --check-prefix=CHECK-BE %s

define <2 x double> @foo(<4 x i32> %s) {
; CHECK-LE-LABEL: foo:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xvcvsxwdp 34, 34
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: foo:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi 0, 34, 34, 1
; CHECK-BE-NEXT:    xvcvsxwdp 34, 0
; CHECK-BE-NEXT:    blr
entry:
  %0 = shufflevector <4 x i32> %s, <4 x i32> undef, <2 x i32> <i32 1, i32 3>
  %1 = sitofp <2 x i32> %0 to <2 x double>
  ret <2 x double> %1
}

define <2 x double> @bar(<4 x i32> %s) {
; CHECK-LE-LABEL: bar:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xvcvuxwdp 34, 34
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: bar:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi 0, 34, 34, 1
; CHECK-BE-NEXT:    xvcvuxwdp 34, 0
; CHECK-BE-NEXT:    blr
entry:
  %0 = shufflevector <4 x i32> %s, <4 x i32> undef, <2 x i32> <i32 1, i32 3>
  %1 = uitofp <2 x i32> %0 to <2 x double>
  ret <2 x double> %1
}

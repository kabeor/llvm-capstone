; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s

define <4 x float> @foo(ptr %p) nounwind {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movups (%rdi), %xmm0
; CHECK-NEXT:    retq
  %t = load <4 x float>, ptr %p, align 4
  ret <4 x float> %t
}

define <2 x double> @bar(ptr %p) nounwind {
; CHECK-LABEL: bar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movups (%rdi), %xmm0
; CHECK-NEXT:    retq
  %t = load <2 x double>, ptr %p, align 8
  ret <2 x double> %t
}

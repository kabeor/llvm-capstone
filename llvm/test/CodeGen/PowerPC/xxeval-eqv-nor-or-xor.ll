; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mcpu=pwr10 -mtriple=powerpc64le-unknown-unknown \
; RUN:   -ppc-asm-full-reg-names --ppc-vsr-nums-as-vr < %s | FileCheck %s

; (eqv A, (and B, C)) 225
define dso_local <2 x i64> @eqvA_andB_C(<2 x i64> %A, <2 x i64> %B, <2 x i64> %C) local_unnamed_addr #0 {
; CHECK-LABEL: eqvA_andB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 225
; CHECK-NEXT:    blr
entry:
  %and = and <2 x i64> %B, %C
  %xor = xor <2 x i64> %A, %and
  %neg = xor <2 x i64> %xor, <i64 -1, i64 -1>
  ret <2 x i64> %neg
}

; (eqv A, (or B, C)) 135
define dso_local <4 x i32> @eqvA_orB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: eqvA_orB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 135
; CHECK-NEXT:    blr
entry:
  %or = or <4 x i32> %B, %C
  %xor = xor <4 x i32> %A, %or
  %neg = xor <4 x i32> %xor, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %neg
}

; (eqv A, B, C) 150
define dso_local <8 x i16> @eqvA_B_C(<8 x i16> %A, <8 x i16> %B, <8 x i16> %C) local_unnamed_addr #0 {
; CHECK-LABEL: eqvA_B_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 150
; CHECK-NEXT:    blr
entry:
  %and = and <8 x i16> %B, %C
  %and1 = and <8 x i16> %A, %and
  %or = or <8 x i16> %B, %C
  %or1 = or <8 x i16> %A, %or
  %neg = xor <8 x i16> %or1, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %or2 = or <8 x i16> %and1, %neg
  ret <8 x i16> %or2
}

; (nor A, (and B, C)) 224
define dso_local <16 x i8> @norA_andB_C(<16 x i8> %A, <16 x i8> %B, <16 x i8> %C) local_unnamed_addr #0 {
; CHECK-LABEL: norA_andB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 224
; CHECK-NEXT:    blr
entry:
  %and = and <16 x i8> %B, %C
  %or = or <16 x i8> %A, %and
  %neg = xor <16 x i8> %or, <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  ret <16 x i8> %neg
}

; (nor A, (eqv B, C)) 96
define dso_local <4 x i32> @norA_eqvB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: norA_eqvB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 96
; CHECK-NEXT:    blr
entry:
  %neg = xor <4 x i32> %A, <i32 -1, i32 -1, i32 -1, i32 -1>
  %xor = xor <4 x i32> %B, %C
  %and = and <4 x i32> %neg, %xor
  ret <4 x i32> %and
}

; (nor A, (nand B, C)) 16
define dso_local <4 x i32> @norA_nandB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: norA_nandB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 16
; CHECK-NEXT:    blr
entry:
  %neg = xor <4 x i32> %A, <i32 -1, i32 -1, i32 -1, i32 -1>
  %and = and <4 x i32> %B, %C
  %and1 = and <4 x i32> %neg, %and
  ret <4 x i32> %and1
}

; (nor A, (nor B, C)) 112
define dso_local <4 x i32> @norA_norB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: norA_norB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 112
; CHECK-NEXT:    blr
entry:
  %neg = xor <4 x i32> %A, <i32 -1, i32 -1, i32 -1, i32 -1>
  %or = or <4 x i32> %B, %C
  %and = and <4 x i32> %neg, %or
  ret <4 x i32> %and
}

; (nor A, (xor B, C)) 144
define dso_local <4 x i32> @norA_xorB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: norA_xorB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 144
; CHECK-NEXT:    blr
entry:
  %xor = xor <4 x i32> %B, %C
  %or = or <4 x i32> %A, %xor
  %neg = xor <4 x i32> %or, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %neg
}

; (nor A, B, C) 128
define dso_local <4 x i32> @norA_B_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: norA_B_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 128
; CHECK-NEXT:    blr
entry:
  %or = or <4 x i32> %B, %C
  %or1 = or <4 x i32> %A, %or
  %neg = xor <4 x i32> %or1, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %neg
}

; (or A, (and B, C)) 31
define dso_local <4 x i32> @orA_andB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: orA_andB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 31
; CHECK-NEXT:    blr
entry:
  %and = and <4 x i32> %B, %C
  %or = or <4 x i32> %A, %and
  ret <4 x i32> %or
}

; (or A, (eqv B, C)) 159
define dso_local <4 x i32> @orA_eqvB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: orA_eqvB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 159
; CHECK-NEXT:    blr
entry:
  %xor = xor <4 x i32> %B, %C
  %neg = xor <4 x i32> %xor, <i32 -1, i32 -1, i32 -1, i32 -1>
  %or = or <4 x i32> %A, %neg
  ret <4 x i32> %or
}

; (or A, (nand B, C)) 239
define dso_local <4 x i32> @orA_nandB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: orA_nandB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 239
; CHECK-NEXT:    blr
entry:
  %and = and <4 x i32> %B, %C
  %neg = xor <4 x i32> %and, <i32 -1, i32 -1, i32 -1, i32 -1>
  %or = or <4 x i32> %A, %neg
  ret <4 x i32> %or
}

; (or A, (nor B, C)) 143
define dso_local <4 x i32> @orA_norB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: orA_norB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 143
; CHECK-NEXT:    blr
entry:
  %or = or <4 x i32> %B, %C
  %neg = xor <4 x i32> %or, <i32 -1, i32 -1, i32 -1, i32 -1>
  %or1 = or <4 x i32> %A, %neg
  ret <4 x i32> %or1
}

; (or A, (xor B, C)) 111
define dso_local <4 x i32> @orA_xorB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: orA_xorB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 111
; CHECK-NEXT:    blr
entry:
  %xor = xor <4 x i32> %B, %C
  %or = or <4 x i32> %A, %xor
  ret <4 x i32> %or
}

; (or A, B, C) 127
define dso_local <4 x i32> @orA_B_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: orA_B_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 127
; CHECK-NEXT:    blr
entry:
  %or = or <4 x i32> %B, %C
  %or1 = or <4 x i32> %A, %or
  ret <4 x i32> %or1
}

; (xor A, (and B, C)) 30
define dso_local <4 x i32> @xorA_andB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: xorA_andB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 30
; CHECK-NEXT:    blr
entry:
  %and = and <4 x i32> %B, %C
  %xor = xor <4 x i32> %A, %and
  ret <4 x i32> %xor
}

; (xor A, (or B, C)) 120
define dso_local <4 x i32> @xorA_orB_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: xorA_orB_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 120
; CHECK-NEXT:    blr
entry:
  %or = or <4 x i32> %B, %C
  %xor = xor <4 x i32> %A, %or
  ret <4 x i32> %xor
}

; (xor A, B, C) 105
define dso_local <4 x i32> @xorA_B_C(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) local_unnamed_addr #0 {
; CHECK-LABEL: xorA_B_C:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxeval v2, v2, v3, v4, 105
; CHECK-NEXT:    blr
entry:
  %xor = xor <4 x i32> %B, %C
  %xor1 = xor <4 x i32> %A, %xor
  ret <4 x i32> %xor1
}

attributes #0 = { nounwind }

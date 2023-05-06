; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=sccp -S | FileCheck %s

define void @shift_undef_64(ptr %p) {
; CHECK-LABEL: @shift_undef_64(
; CHECK-NEXT:    store i64 0, ptr [[P:%.*]]
; CHECK-NEXT:    store i64 -1, ptr [[P]]
; CHECK-NEXT:    [[R3:%.*]] = shl i64 -1, 4294967298
; CHECK-NEXT:    store i64 [[R3]], ptr [[P]]
; CHECK-NEXT:    ret void
;
  %r1 = lshr i64 -1, 4294967296 ; 2^32
  store i64 %r1, ptr %p

  %r2 = ashr i64 -1, 4294967297 ; 2^32 + 1
  store i64 %r2, ptr %p

  %r3 = shl i64 -1, 4294967298 ; 2^32 + 2
  store i64 %r3, ptr %p

  ret void
}

define void @shift_undef_65(ptr %p) {
; CHECK-LABEL: @shift_undef_65(
; CHECK-NEXT:    store i65 0, ptr [[P:%.*]]
; CHECK-NEXT:    store i65 0, ptr [[P]]
; CHECK-NEXT:    [[R3:%.*]] = shl i65 1, -18446744073709551615
; CHECK-NEXT:    store i65 [[R3]], ptr [[P]]
; CHECK-NEXT:    ret void
;
  %r1 = lshr i65 2, 18446744073709551617
  store i65 %r1, ptr %p

  %r2 = ashr i65 4, 18446744073709551617
  store i65 %r2, ptr %p

  %r3 = shl i65 1, 18446744073709551617
  store i65 %r3, ptr %p

  ret void
}

define void @shift_undef_256(ptr %p) {
; CHECK-LABEL: @shift_undef_256(
; CHECK-NEXT:    store i256 0, ptr [[P:%.*]]
; CHECK-NEXT:    store i256 0, ptr [[P]]
; CHECK-NEXT:    [[R3:%.*]] = shl i256 1, 18446744073709551619
; CHECK-NEXT:    store i256 [[R3]], ptr [[P]]
; CHECK-NEXT:    ret void
;
  %r1 = lshr i256 2, 18446744073709551617
  store i256 %r1, ptr %p

  %r2 = ashr i256 4, 18446744073709551618
  store i256 %r2, ptr %p

  %r3 = shl i256 1, 18446744073709551619
  store i256 %r3, ptr %p

  ret void
}

define void @shift_undef_511(ptr %p) {
; CHECK-LABEL: @shift_undef_511(
; CHECK-NEXT:    store i511 0, ptr [[P:%.*]]
; CHECK-NEXT:    store i511 -1, ptr [[P]]
; CHECK-NEXT:    [[R3:%.*]] = shl i511 -3, 1208925819614629174706180
; CHECK-NEXT:    store i511 [[R3]], ptr [[P]]
; CHECK-NEXT:    ret void
;
  %r1 = lshr i511 -1, 1208925819614629174706276 ; 2^80 + 100
  store i511 %r1, ptr %p

  %r2 = ashr i511 -2, 1208925819614629174706200
  store i511 %r2, ptr %p

  %r3 = shl i511 -3, 1208925819614629174706180
  store i511 %r3, ptr %p

  ret void
}

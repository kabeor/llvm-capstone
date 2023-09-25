; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Provide legal integer types.
target datalayout = "n8:16:32:64"

define void @PR21651() {
; CHECK-LABEL: @PR21651(
; CHECK-NEXT:    switch i1 false, label [[OUT:%.*]] [
; CHECK-NEXT:    i1 false, label [[OUT]]
; CHECK-NEXT:    i1 true, label [[OUT]]
; CHECK-NEXT:    ]
; CHECK:       out:
; CHECK-NEXT:    ret void
;
  switch i2 0, label %out [
  i2 0, label %out
  i2 1, label %out
  ]

out:
  ret void
}


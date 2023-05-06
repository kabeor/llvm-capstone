; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

@g = global i32 0

; PR30486
define i32 @single_case() {
; CHECK-LABEL: @single_case(
; CHECK-NEXT:    switch i32 ptrtoint (ptr @g to i32), label %x [
; CHECK-NEXT:    ]
; CHECK:       x:
; CHECK-NEXT:    ret i32 0
;
  switch i32 add (i32 ptrtoint (ptr @g to i32), i32 -1), label %x []
x:
  ret i32 0
}

define i32 @multiple_cases() {
; CHECK-LABEL: @multiple_cases(
; CHECK-NEXT:    switch i32 ptrtoint (ptr @g to i32), label %x [
; CHECK-NEXT:    i32 2, label %one
; CHECK-NEXT:    i32 3, label %two
; CHECK-NEXT:    ]
; CHECK:       x:
; CHECK-NEXT:    ret i32 0
; CHECK:       one:
; CHECK-NEXT:    ret i32 1
; CHECK:       two:
; CHECK-NEXT:    ret i32 2
;
  switch i32 add (i32 ptrtoint (ptr @g to i32), i32 -1), label %x [
  i32 1, label %one
  i32 2, label %two
  ]
x:
  ret i32 0

one:
  ret i32 1

two:
  ret i32 2
}

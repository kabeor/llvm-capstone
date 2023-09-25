; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
;
; Verify that the result of memchr calls with past-the-end pointers used
; in equality expressions don't cause trouble and either are folded when
; they might be valid or not when they're provably undefined.

declare ptr @memchr(ptr, i32, i64)


@a5 = constant [5 x i8] c"12345"


; Fold memchr(a5 + 5, c, 1) == a5 + 5 to an arbitrary constrant.
; The call is transformed to a5[5] == c by the memchr simplifier, with
; a5[5] being indeterminate.  The equality then is the folded with
; an undefined/arbitrary result.

define i1 @call_memchr_ap5_c_1_eq_a(i32 %c, i64 %n) {
; CHECK-LABEL: @call_memchr_ap5_c_1_eq_a(
; CHECK-NEXT:    ret i1 poison
;
  %pap5 = getelementptr [5 x i8], ptr @a5, i32 0, i32 5
  %qap5 = getelementptr [5 x i8], ptr @a5, i32 1, i32 0
  %q = call ptr @memchr(ptr %pap5, i32 %c, i64 1)
  %cmp = icmp eq ptr %q, %qap5
  ret i1 %cmp
}


; Fold memchr(a5 + 5, c, 5) == a5 + 5 to an arbitrary constant.

define i1 @call_memchr_ap5_c_5_eq_a(i32 %c, i64 %n) {
; CHECK-LABEL: @call_memchr_ap5_c_5_eq_a(
; CHECK-NEXT:    ret i1 poison
;
  %pap5 = getelementptr [5 x i8], ptr @a5, i32 0, i32 5
  %qap5 = getelementptr [5 x i8], ptr @a5, i32 1, i32 0
  %q = call ptr @memchr(ptr %pap5, i32 %c, i64 5)
  %cmp = icmp eq ptr %q, %qap5
  ret i1 %cmp
}


; Fold memchr(a5 + 5, c, n) == a5 to false.

define i1 @fold_memchr_ap5_c_n_eq_a(i32 %c, i64 %n) {
; CHECK-LABEL: @fold_memchr_ap5_c_n_eq_a(
; CHECK-NEXT:    ret i1 false
;
  %pap5 = getelementptr [5 x i8], ptr @a5, i32 0, i32 5
  %q = call ptr @memchr(ptr %pap5, i32 %c, i64 %n)
  %cmp = icmp eq ptr %q, @a5
  ret i1 %cmp
}


; Fold memchr(a5 + 5, c, n) == null to true on the basis that n must
; be zero in order for the call to be valid.

define i1 @fold_memchr_ap5_c_n_eqz(i32 %c, i64 %n) {
; CHECK-LABEL: @fold_memchr_ap5_c_n_eqz(
; CHECK-NEXT:    ret i1 true
;
  %p = getelementptr [5 x i8], ptr @a5, i32 0, i32 5
  %q = call ptr @memchr(ptr %p, i32 %c, i64 %n)
  %cmp = icmp eq ptr %q, null
  ret i1 %cmp
}


; Fold memchr(a5 + 5, '\0', n) == null to true on the basis that n must
; be zero in order for the call to be valid.

define i1 @fold_memchr_a_nul_n_eqz(i64 %n) {
; CHECK-LABEL: @fold_memchr_a_nul_n_eqz(
; CHECK-NEXT:    ret i1 true
;
  %p = getelementptr [5 x i8], ptr @a5, i32 0, i32 5
  %q = call ptr @memchr(ptr %p, i32 0, i64 %n)
  %cmp = icmp eq ptr %q, null
  ret i1 %cmp
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

; Test all integer predicates with bool types and true/false constants,
; with not on LHS (icmp pred not(X), true|false).
; Use vectors to provide test coverage that is not duplicated in other folds.

define <2 x i1> @eq_t_not(<2 x i1> %a) {
; CHECK-LABEL: @eq_t_not(
; CHECK-NEXT:    [[NOT:%.*]] = xor <2 x i1> [[A:%.*]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[NOT]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp eq <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @eq_f_not(<2 x i1> %a) {
; CHECK-LABEL: @eq_f_not(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp eq <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @eq_f_not_swap(<2 x i1> %a) {
; CHECK-LABEL: @eq_f_not_swap(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> <i1 true, i1 true>, %a
  %r = icmp eq <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @eq_f_not_undef(<2 x i1> %a) {
; CHECK-LABEL: @eq_f_not_undef(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 undef, i1 true>
  %r = icmp eq <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @ne_t_not(<2 x i1> %a) {
; CHECK-LABEL: @ne_t_not(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ne <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ne_t_not_swap(<2 x i1> %a) {
; CHECK-LABEL: @ne_t_not_swap(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> <i1 true, i1 true>, %a
  %r = icmp ne <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ne_t_not_undef(<2 x i1> %a) {
; CHECK-LABEL: @ne_t_not_undef(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 undef, i1 true>
  %r = icmp ne <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ne_f_not(<2 x i1> %a) {
; CHECK-LABEL: @ne_f_not(
; CHECK-NEXT:    [[NOT:%.*]] = xor <2 x i1> [[A:%.*]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[NOT]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ne <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @ugt_t_not(<2 x i1> %a) {
; CHECK-LABEL: @ugt_t_not(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ugt <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ugt_f_not(<2 x i1> %a) {
; CHECK-LABEL: @ugt_f_not(
; CHECK-NEXT:    [[NOT:%.*]] = xor <2 x i1> [[A:%.*]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[NOT]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ugt <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @ult_t_not(<2 x i1> %a) {
; CHECK-LABEL: @ult_t_not(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ult <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ult_t_not_swap(<2 x i1> %a) {
; CHECK-LABEL: @ult_t_not_swap(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> <i1 true, i1 true>, %a
  %r = icmp ult <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ult_t_not_undef(<2 x i1> %a) {
; CHECK-LABEL: @ult_t_not_undef(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 undef, i1 true>
  %r = icmp ult <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ult_f_not(<2 x i1> %a) {
; CHECK-LABEL: @ult_f_not(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ult <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @sgt_t_not(<2 x i1> %a) {
; CHECK-LABEL: @sgt_t_not(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp sgt <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @sgt_t_not_swap(<2 x i1> %a) {
; CHECK-LABEL: @sgt_t_not_swap(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> <i1 true, i1 true>, %a
  %r = icmp sgt <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @sgt_t_not_undef(<2 x i1> %a) {
; CHECK-LABEL: @sgt_t_not_undef(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 undef, i1 true>
  %r = icmp sgt <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @sgt_f_not(<2 x i1> %a) {
; CHECK-LABEL: @sgt_f_not(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp sgt <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @slt_t_not(<2 x i1> %a) {
; CHECK-LABEL: @slt_t_not(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp slt <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @slt_f_not(<2 x i1> %a) {
; CHECK-LABEL: @slt_f_not(
; CHECK-NEXT:    [[NOT:%.*]] = xor <2 x i1> [[A:%.*]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[NOT]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp slt <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @uge_t_not(<2 x i1> %a) {
; CHECK-LABEL: @uge_t_not(
; CHECK-NEXT:    [[NOT:%.*]] = xor <2 x i1> [[A:%.*]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[NOT]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp uge <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @uge_f_not(<2 x i1> %a) {
; CHECK-LABEL: @uge_f_not(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp uge <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @ule_t_not(<2 x i1> %a) {
; CHECK-LABEL: @ule_t_not(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ule <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @ule_f_not(<2 x i1> %a) {
; CHECK-LABEL: @ule_f_not(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp ule <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @ule_f_not_swap(<2 x i1> %a) {
; CHECK-LABEL: @ule_f_not_swap(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> <i1 true, i1 true>, %a
  %r = icmp ule <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @ule_f_not_undef(<2 x i1> %a) {
; CHECK-LABEL: @ule_f_not_undef(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 undef, i1 true>
  %r = icmp ule <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @sge_t_not(<2 x i1> %a) {
; CHECK-LABEL: @sge_t_not(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp sge <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @sge_f_not(<2 x i1> %a) {
; CHECK-LABEL: @sge_f_not(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp sge <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @sge_f_not_swap(<2 x i1> %a) {
; CHECK-LABEL: @sge_f_not_swap(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> <i1 true, i1 true>, %a
  %r = icmp sge <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @sge_f_not_undef(<2 x i1> %a) {
; CHECK-LABEL: @sge_f_not_undef(
; CHECK-NEXT:    ret <2 x i1> [[A:%.*]]
;
  %not = xor <2 x i1> %a, <i1 undef, i1 true>
  %r = icmp sge <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

define <2 x i1> @sle_t_not(<2 x i1> %a) {
; CHECK-LABEL: @sle_t_not(
; CHECK-NEXT:    [[NOT:%.*]] = xor <2 x i1> [[A:%.*]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[NOT]]
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp sle <2 x i1> %not, <i1 true, i1 true>
  ret <2 x i1> %r
}

define <2 x i1> @sle_f_not(<2 x i1> %a) {
; CHECK-LABEL: @sle_f_not(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %not = xor <2 x i1> %a, <i1 true, i1 true>
  %r = icmp sle <2 x i1> %not, <i1 false, i1 false>
  ret <2 x i1> %r
}

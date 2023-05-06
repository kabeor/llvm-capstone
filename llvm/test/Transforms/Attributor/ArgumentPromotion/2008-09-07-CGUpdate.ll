; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

define internal fastcc i32 @hash(ptr %ts, i32 %mod) nounwind {
; CGSCC: Function Attrs: nofree norecurse noreturn nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@hash
; CGSCC-SAME: () #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    unreachable
;
entry:
  unreachable
}

define void @encode(ptr %m, ptr %ts, ptr %new) nounwind {
; TUNIT: Function Attrs: nofree norecurse noreturn nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@encode
; TUNIT-SAME: (ptr nocapture nofree readnone [[M:%.*]], ptr nocapture nofree readnone [[TS:%.*]], ptr nocapture nofree readnone [[NEW:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    unreachable
;
; CGSCC: Function Attrs: nofree noreturn nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@encode
; CGSCC-SAME: (ptr nocapture nofree readnone [[M:%.*]], ptr nocapture nofree readnone [[TS:%.*]], ptr nocapture nofree readnone [[NEW:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    unreachable
;
entry:
  %0 = call fastcc i32 @hash( ptr %ts, i32 0 ) nounwind		; <i32> [#uses=0]
  unreachable
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse noreturn nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree norecurse noreturn nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR1]] = { nofree noreturn nosync nounwind willreturn memory(none) }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}

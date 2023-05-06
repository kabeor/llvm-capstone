; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl

@glob = dso_local local_unnamed_addr global i64 0, align 8

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_iltsll(i64 %a, i64 %b) {
; CHECK-LABEL: test_iltsll:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r5, r3, 63
; CHECK-NEXT:    rldicl r6, r4, 1, 63
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    adde r3, r6, r5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_iltsll_sext(i64 %a, i64 %b) {
; CHECK-LABEL: test_iltsll_sext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r5, r3, 63
; CHECK-NEXT:    rldicl r6, r4, 1, 63
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    adde r3, r6, r5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_iltsll_sext_z(i64 %a) {
; CHECK-LABEL: test_iltsll_sext_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r3, r3, 63
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, 0
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind
define dso_local void @test_iltsll_store(i64 %a, i64 %b) {
; CHECK-LABEL: test_iltsll_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r6, r3, 63
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    rldicl r3, r4, 1, 63
; CHECK-NEXT:    adde r3, r3, r6
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    std r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, ptr @glob, align 8
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_iltsll_sext_store(i64 %a, i64 %b) {
; CHECK-LABEL: test_iltsll_sext_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r6, r3, 63
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    rldicl r3, r4, 1, 63
; CHECK-NEXT:    adde r3, r3, r6
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    std r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @glob, align 8
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_iltsll_sext_z_store(i64 %a) {
; CHECK-LABEL: test_iltsll_sext_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-NEXT:    sradi r3, r3, 63
; CHECK-NEXT:    std r3, glob@toc@l(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp slt i64 %a, 0
  %conv2 = sext i1 %cmp to i64
  store i64 %conv2, ptr @glob, align 8
  ret void
}

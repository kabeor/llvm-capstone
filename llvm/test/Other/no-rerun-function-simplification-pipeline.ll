; RUN: opt < %s -passes='default<O1>' -disable-output -debug-pass-manager=verbose -enable-no-rerun-simplification-pipeline=0 2>&1 | FileCheck %s --check-prefixes=CHECK,RERUNSP
; RUN: opt < %s -passes='default<O2>' -disable-output -debug-pass-manager=verbose -enable-no-rerun-simplification-pipeline=0 2>&1 | FileCheck %s --check-prefixes=CHECK,RERUNSP
; RUN: opt < %s -passes='default<O1>' -disable-output -debug-pass-manager=verbose -enable-no-rerun-simplification-pipeline=1 2>&1 | FileCheck %s --check-prefixes=CHECK,NORERUN
; RUN: opt < %s -passes='default<O2>' -disable-output -debug-pass-manager=verbose -enable-no-rerun-simplification-pipeline=1 2>&1 | FileCheck %s --check-prefixes=CHECK,NORERUN

; BDCE only runs once in the function simplification pipeline and nowhere else so we use that to check for reruns.

; CHECK: PassManager{{.*}}SCC{{.*}} on (f1)
; CHECK: Running pass: BDCEPass on f1
; CHECK: PassManager{{.*}}SCC{{.*}} on (f2, f3)
; CHECK: Running pass: BDCEPass on f2
; CHECK-NOT: BDCEPass
; CHECK: PassManager{{.*}}SCC{{.*}} on (f2)
; RERUNSP: Running pass: BDCEPass on f2
; NORERUN-NOT: Running pass: BDCEPass on f2
; CHECK: PassManager{{.*}}SCC{{.*}} on (f3)
; CHECK: Running pass: BDCEPass on f3

define void @f1(ptr %p) alwaysinline {
  call void %p()
  ret void
}

define void @f2() #0 {
  call void @f1(ptr @f2)
  call void @f3()
  ret void
}

define void @f3() #0 {
  call void @f2()
  ret void
}

attributes #0 = { nofree noreturn nosync nounwind readnone noinline }

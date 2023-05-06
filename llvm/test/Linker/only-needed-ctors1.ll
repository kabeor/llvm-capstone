; RUN: llvm-link -S                           %s %p/Inputs/only-needed-ctors.ll | FileCheck %s --check-prefix=CHECK --check-prefix=LINK-ALL    --check-prefix=NO-INTERNALIZE
; RUN: llvm-link -S              -internalize %s %p/Inputs/only-needed-ctors.ll | FileCheck %s --check-prefix=CHECK --check-prefix=LINK-ALL    --check-prefix=INTERNALIZE
; RUN: llvm-link -S -only-needed              %s %p/Inputs/only-needed-ctors.ll | FileCheck %s --check-prefix=CHECK --check-prefix=ONLY-NEEDED --check-prefix=NO-INTERNALIZE
; RUN: llvm-link -S -only-needed -internalize %s %p/Inputs/only-needed-ctors.ll | FileCheck %s --check-prefix=CHECK --check-prefix=ONLY-NEEDED --check-prefix=INTERNALIZE

; Empty destination module!


; CHECK:           @llvm.global_ctors = appending global [2 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 2, ptr @ctor1, ptr null }, { i32, ptr, ptr } { i32 7, ptr @ctor2, ptr null }]
; CHECK:           define internal void @ctor1()
; CHECK:           define internal void @ctor2()
; NO-INTERNALIZE:  define void @func1()
; INTERNALIZE:     define internal void @func1()
; LINK-ALL:        define {{(internal )?}}void @unused()
; ONLY-NEEDED-NOT: void @unused()

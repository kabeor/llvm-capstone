; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=memcpyopt,dse -S -verify-memoryssa | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"
target triple = "i686-apple-darwin9"

%0 = type { x86_fp80, x86_fp80 }
%1 = type { i32, i32 }

@C = external constant [0 x i8]

declare void @llvm.memcpy.p1.p0.i64(ptr addrspace(1) nocapture, ptr nocapture, i64, i1) nounwind
declare void @llvm.memcpy.p0.p1.i64(ptr nocapture, ptr addrspace(1) nocapture, i64, i1) nounwind
declare void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) nocapture, ptr addrspace(1) nocapture, i64, i1) nounwind
declare void @llvm.memcpy.p0.p0.i32(ptr nocapture, ptr nocapture, i32, i1) nounwind
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind
declare void @llvm.memcpy.inline.p0.p0.i32(ptr nocapture, ptr nocapture, i32, i1) nounwind
declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind

; Check that one of the memcpy's are removed.
;; FIXME: PR 8643 We should be able to eliminate the last memcpy here.
define void @test1(ptr sret(%0)  %agg.result, x86_fp80 %z.0, x86_fp80 %z.1) nounwind  {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = alloca [[TMP0:%.*]], align 16
; CHECK-NEXT:    [[MEMTMP:%.*]] = alloca [[TMP0]], align 16
; CHECK-NEXT:    [[TMP5:%.*]] = fsub x86_fp80 0xK80000000000000000000, [[Z_1:%.*]]
; CHECK-NEXT:    call void @ccoshl(ptr sret([[TMP0]]) [[TMP2]], x86_fp80 [[TMP5]], x86_fp80 [[Z_0:%.*]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 16 [[AGG_RESULT:%.*]], ptr align 16 [[TMP2]], i32 32, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %tmp2 = alloca %0
  %memtmp = alloca %0, align 16
  %tmp5 = fsub x86_fp80 0xK80000000000000000000, %z.1
  call void @ccoshl(ptr sret(%0) %memtmp, x86_fp80 %tmp5, x86_fp80 %z.0) nounwind
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %tmp2, ptr align 16 %memtmp, i32 32, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %agg.result, ptr align 16 %tmp2, i32 32, i1 false)
  ret void
}

declare void @ccoshl(ptr nocapture sret(%0), x86_fp80, x86_fp80) nounwind


; The intermediate alloca and one of the memcpy's should be eliminated, the
; other should be related with a memmove.
define void @test2(ptr %P, ptr %Q) nounwind  {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i32(ptr align 16 [[Q:%.*]], ptr align 16 [[P:%.*]], i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %memtmp = alloca %0, align 16
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %memtmp, ptr align 16 %P, i32 32, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %Q, ptr align 16 %memtmp, i32 32, i1 false)
  ret void

}

; The intermediate alloca and one of the memcpy's should be eliminated, the
; other should be related with a memcpy.
define void @test2_constant(ptr %Q) nounwind  {
; CHECK-LABEL: @test2_constant(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 16 [[Q:%.*]], ptr align 16 @C, i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %memtmp = alloca %0, align 16
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %memtmp, ptr align 16 @C, i32 32, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %Q, ptr align 16 %memtmp, i32 32, i1 false)
  ret void

}

; The intermediate alloca and one of the memcpy's should be eliminated, the
; other should be related with a memcpy.
define void @test2_memcpy(ptr noalias %P, ptr noalias %Q) nounwind  {
; CHECK-LABEL: @test2_memcpy(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 16 [[Q:%.*]], ptr align 16 [[P:%.*]], i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %memtmp = alloca %0, align 16
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %memtmp, ptr align 16 %P, i32 32, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %Q, ptr align 16 %memtmp, i32 32, i1 false)
  ret void

}

; Same as @test2_memcpy, but the remaining memcpy should remain non-inline even
; if the one eliminated was inline.
define void @test3_memcpy(ptr noalias %P, ptr noalias %Q) nounwind  {
; CHECK-LABEL: @test3_memcpy(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 16 [[Q:%.*]], ptr align 16 [[P:%.*]], i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %memtmp = alloca %0, align 16
  call void @llvm.memcpy.inline.p0.p0.i32(ptr align 16 %memtmp, ptr align 16 %P, i32 32, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %Q, ptr align 16 %memtmp, i32 32, i1 false)
  ret void

}

; Same as @test2_memcpy, but the remaining memcpy should remain inline even
; if the one eliminated was not inline.
define void @test4_memcpy(ptr noalias %P, ptr noalias %Q) nounwind  {
; CHECK-LABEL: @test4_memcpy(
; CHECK-NEXT:    call void @llvm.memcpy.inline.p0.p0.i32(ptr align 16 [[Q:%.*]], ptr align 16 [[P:%.*]], i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %memtmp = alloca %0, align 16
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %memtmp, ptr align 16 %P, i32 32, i1 false)
  call void @llvm.memcpy.inline.p0.p0.i32(ptr align 16 %Q, ptr align 16 %memtmp, i32 32, i1 false)
  ret void

}

; Same as @test2_memcpy, and the inline-ness should be preserved.
define void @test5_memcpy(ptr noalias %P, ptr noalias %Q) nounwind  {
; CHECK-LABEL: @test5_memcpy(
; CHECK-NEXT:    call void @llvm.memcpy.inline.p0.p0.i32(ptr align 16 [[Q:%.*]], ptr align 16 [[P:%.*]], i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %memtmp = alloca %0, align 16
  call void @llvm.memcpy.inline.p0.p0.i32(ptr align 16 %memtmp, ptr align 16 %P, i32 32, i1 false)
  call void @llvm.memcpy.inline.p0.p0.i32(ptr align 16 %Q, ptr align 16 %memtmp, i32 32, i1 false)
  ret void

}


@x = external global %0

define void @test3(ptr noalias sret(%0) %agg.result) nounwind  {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[X_0:%.*]] = alloca [[TMP0:%.*]], align 16
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 16 [[AGG_RESULT:%.*]], ptr align 16 @x, i32 32, i1 false)
; CHECK-NEXT:    ret void
;
  %x.0 = alloca %0
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %x.0, ptr align 16 @x, i32 32, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %agg.result, ptr align 16 %x.0, i32 32, i1 false)
  ret void
}


; PR8644
define void @test4(ptr %P) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    call void @test4a(ptr byval(i8) align 1 [[P:%.*]])
; CHECK-NEXT:    ret void
;
  %A = alloca %1
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 %P, i64 8, i1 false)
  call void @test4a(ptr align 1 byval(i8) %A)
  ret void
}

; Make sure we don't remove the memcpy if the source address space doesn't match the byval argument
define void @test4_addrspace(ptr addrspace(1) %P) {
; CHECK-LABEL: @test4_addrspace(
; CHECK-NEXT:    [[A1:%.*]] = alloca [[TMP1:%.*]], align 8
; CHECK-NEXT:    call void @llvm.memcpy.p0.p1.i64(ptr align 4 [[A1]], ptr addrspace(1) align 4 [[P:%.*]], i64 8, i1 false)
; CHECK-NEXT:    call void @test4a(ptr byval(i8) align 1 [[A1]])
; CHECK-NEXT:    ret void
;
  %a1 = alloca %1
  call void @llvm.memcpy.p0.p1.i64(ptr align 4 %a1, ptr addrspace(1) align 4 %P, i64 8, i1 false)
  call void @test4a(ptr align 1 byval(i8) %a1)
  ret void
}

define void @test4_write_between(ptr %P) {
; CHECK-LABEL: @test4_write_between(
; CHECK-NEXT:    [[A1:%.*]] = alloca [[TMP1:%.*]], align 8
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 4 [[A1]], ptr align 4 [[P:%.*]], i64 8, i1 false)
; CHECK-NEXT:    store i8 0, ptr [[A1]], align 1
; CHECK-NEXT:    call void @test4a(ptr byval(i8) align 1 [[A1]])
; CHECK-NEXT:    ret void
;
  %a1 = alloca %1
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %a1, ptr align 4 %P, i64 8, i1 false)
  store i8 0, ptr %a1
  call void @test4a(ptr align 1 byval(i8) %a1)
  ret void
}

define i8 @test4_read_between(ptr %P) {
; CHECK-LABEL: @test4_read_between(
; CHECK-NEXT:    [[A1:%.*]] = alloca [[TMP1:%.*]], align 8
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 4 [[A1]], ptr align 4 [[P:%.*]], i64 8, i1 false)
; CHECK-NEXT:    [[X:%.*]] = load i8, ptr [[A1]], align 1
; CHECK-NEXT:    call void @test4a(ptr byval(i8) align 1 [[P]])
; CHECK-NEXT:    ret i8 [[X]]
;
  %a1 = alloca %1
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %a1, ptr align 4 %P, i64 8, i1 false)
  %x = load i8, ptr %a1
  call void @test4a(ptr align 1 byval(i8) %a1)
  ret i8 %x
}

define void @test4_non_local(ptr %P, i1 %c) {
; CHECK-LABEL: @test4_non_local(
; CHECK-NEXT:    br i1 [[C:%.*]], label [[CALL:%.*]], label [[EXIT:%.*]]
; CHECK:       call:
; CHECK-NEXT:    call void @test4a(ptr byval(i8) align 1 [[P:%.*]])
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  %a1 = alloca %1
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %a1, ptr align 4 %P, i64 8, i1 false)
  br i1 %c, label %call, label %exit

call:
  call void @test4a(ptr align 1 byval(i8) %a1)
  br label %exit

exit:
  ret void
}

declare void @test4a(ptr align 1 byval(i8))

%struct.S = type { i128, [4 x i8]}

@sS = external global %struct.S, align 16

declare void @test5a(ptr align 16 byval(%struct.S)) nounwind ssp


; rdar://8713376 - This memcpy can't be eliminated.
define i32 @test5(i32 %x) nounwind ssp {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[Y:%.*]] = alloca [[STRUCT_S:%.*]], align 16
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 16 [[Y]], ptr align 16 @sS, i64 32, i1 false)
; CHECK-NEXT:    [[A:%.*]] = getelementptr [[STRUCT_S]], ptr [[Y]], i64 0, i32 1, i64 0
; CHECK-NEXT:    store i8 4, ptr [[A]], align 1
; CHECK-NEXT:    call void @test5a(ptr byval([[STRUCT_S]]) align 16 [[Y]])
; CHECK-NEXT:    ret i32 0
;
entry:
  %y = alloca %struct.S, align 16
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %y, ptr align 16 @sS, i64 32, i1 false)
  %a = getelementptr %struct.S, ptr %y, i64 0, i32 1, i64 0
  store i8 4, ptr %a
  call void @test5a(ptr align 16 byval(%struct.S) %y)
  ret i32 0
}

;; Noop memcpy should be zapped.
define void @test6(ptr %P) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %P, ptr align 4 %P, i64 8, i1 false)
  ret void
}


; PR9794 - Should forward memcpy into byval argument even though the memcpy
; isn't itself 8 byte aligned.
%struct.p = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

define i32 @test7(ptr nocapture align 8 byval(%struct.p) %q) nounwind ssp {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @g(ptr byval([[STRUCT_P:%.*]]) align 8 [[Q:%.*]]) #[[ATTR2]]
; CHECK-NEXT:    ret i32 [[CALL]]
;
entry:
  %agg.tmp = alloca %struct.p, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %agg.tmp, ptr align 4 %q, i64 48, i1 false)
  %call = call i32 @g(ptr align 8 byval(%struct.p) %agg.tmp) nounwind
  ret i32 %call
}

declare i32 @g(ptr align 8 byval(%struct.p))


; PR11142 - When looking for a memcpy-memcpy dependency, don't get stuck on
; instructions between the memcpy's that only affect the destination pointer.
@test8.str = internal constant [7 x i8] c"ABCDEF\00"

define void @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    ret void
;
  %A = tail call ptr @malloc(i32 10)
  %B = getelementptr inbounds i8, ptr %A, i64 2
  tail call void @llvm.memcpy.p0.p0.i32(ptr %B, ptr @test8.str, i32 7, i1 false)
  %C = tail call ptr @malloc(i32 10)
  %D = getelementptr inbounds i8, ptr %C, i64 2
  tail call void @llvm.memcpy.p0.p0.i32(ptr %D, ptr %B, i32 7, i1 false)
  ret void
}

declare noalias ptr @malloc(i32) willreturn allockind("alloc,uninitialized") allocsize(0)

; rdar://11341081
%struct.big = type { [50 x i32] }

define void @test9_addrspacecast() nounwind ssp uwtable {
; CHECK-LABEL: @test9_addrspacecast(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_BIG:%.*]], align 4
; CHECK-NEXT:    [[TMP:%.*]] = alloca [[STRUCT_BIG]], align 4
; CHECK-NEXT:    call void @f1(ptr sret([[STRUCT_BIG]]) [[B]])
; CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast ptr [[B]] to ptr addrspace(1)
; CHECK-NEXT:    [[TMP1:%.*]] = addrspacecast ptr [[TMP]] to ptr addrspace(1)
; CHECK-NEXT:    call void @f2(ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %b = alloca %struct.big, align 4
  %tmp = alloca %struct.big, align 4
  call void @f1(ptr sret(%struct.big) %tmp)
  %0 = addrspacecast ptr %b to ptr addrspace(1)
  %1 = addrspacecast ptr %tmp to ptr addrspace(1)
  call void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) align 4 %0, ptr addrspace(1) align 4 %1, i64 200, i1 false)
  call void @f2(ptr %b)
  ret void
}

define void @test9() nounwind ssp uwtable {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_BIG:%.*]], align 4
; CHECK-NEXT:    [[TMP:%.*]] = alloca [[STRUCT_BIG]], align 4
; CHECK-NEXT:    call void @f1(ptr sret([[STRUCT_BIG]]) [[B]])
; CHECK-NEXT:    call void @f2(ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %b = alloca %struct.big, align 4
  %tmp = alloca %struct.big, align 4
  call void @f1(ptr sret(%struct.big) %tmp)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %b, ptr align 4 %tmp, i64 200, i1 false)
  call void @f2(ptr %b)
  ret void
}

; rdar://14073661.
; Test10 triggered assertion when the compiler try to get the size of the
; opaque type of *x, where the x is the formal argument with attribute 'sret'.

%opaque = type opaque
declare void @foo(ptr noalias nocapture)

define void @test10(ptr noalias nocapture sret(%opaque) %x, i32 %y) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 [[Y:%.*]], ptr [[A]], align 4
; CHECK-NEXT:    call void @foo(ptr noalias nocapture [[A]])
; CHECK-NEXT:    [[C:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    store i32 [[C]], ptr [[X:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %a = alloca i32, align 4
  store i32 %y, ptr %a
  call void @foo(ptr noalias nocapture %a)
  %c = load i32, ptr %a
  store i32 %c, ptr %x
  ret void
}

; don't create new addressspacecasts when we don't know they're safe for the target
define void @test11(ptr addrspace(1) nocapture dereferenceable(80) %P) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    call void @llvm.memset.p1.i64(ptr addrspace(1) align 4 [[P:%.*]], i8 0, i64 80, i1 false)
; CHECK-NEXT:    ret void
;
  %A = alloca [20 x i32], align 4
  call void @llvm.memset.p0.i64(ptr align 4 %A, i8 0, i64 80, i1 false)
  call void @llvm.memcpy.p1.p0.i64(ptr addrspace(1) align 4 %P, ptr align 4 %A, i64 80, i1 false)
  ret void
}

declare void @f1(ptr nocapture sret(%struct.big))
declare void @f2(ptr)

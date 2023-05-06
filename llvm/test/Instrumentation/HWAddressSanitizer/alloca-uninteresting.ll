; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that unintersted allocas (e.g. dynamic, because we do not know
; their size) are not instrumented.
;
; RUN: opt < %s -passes=hwasan -S | FileCheck %s --check-prefixes=CHECK

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-android10000"

declare void @use32(ptr)

define void @test_dyn_alloca(i32 %n) sanitize_hwaddress !dbg !15 {
; CHECK-LABEL: @test_dyn_alloca(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[X:%.*]] = alloca i32, i32 [[N:%.*]], align 4
; CHECK-NEXT:    call void @llvm.dbg.value(metadata !DIArgList(ptr [[X]], ptr [[X]]), metadata [[META10:![0-9]+]], metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_deref)), !dbg [[DBG12:![0-9]+]]
; CHECK-NEXT:    call void @use32(ptr nonnull [[X]]), !dbg [[DBG13:![0-9]+]]
; CHECK-NEXT:    ret void, !dbg [[DBG14:![0-9]+]]
;

entry:
  %x = alloca i32, i32 %n, align 4
  call void @llvm.dbg.value(metadata !DIArgList(ptr %x, ptr %x), metadata !22, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_deref)), !dbg !21
  call void @use32(ptr nonnull %x), !dbg !23
  ret void, !dbg !24
}

declare void @llvm.dbg.value(metadata, metadata, metadata)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!14}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "alloca.cpp", directory: "/")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{!"clang version 13.0.0"}
!15 = distinct !DISubprogram(name: "test_alloca", linkageName: "_Z11test_allocav", scope: !1, file: !1, line: 4, type: !16, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{null}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocation(line: 0, scope: !15)
!22 = !DILocalVariable(name: "x", scope: !15, file: !1, line: 5, type: !20)
!23 = !DILocation(line: 7, column: 5, scope: !15)
!24 = !DILocation(line: 8, column: 1, scope: !15)

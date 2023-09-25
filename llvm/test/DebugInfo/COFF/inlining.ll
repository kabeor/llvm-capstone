; RUN: llc -mcpu=core2 -mtriple=i686-pc-win32 < %s | FileCheck %s --check-prefix=ASM
; RUN: llc -mcpu=core2 -mtriple=i686-pc-win32 < %s -filetype=obj | llvm-readobj --codeview - | FileCheck %s --check-prefix=OBJ

; This LL file was generated by running 'clang -O1 -g -gcodeview' on the
; following code:
;  1: extern volatile int x;
;  2: static inline void foo() {
;  3:   int y = 1;
;  4:   x += (int)&y;
;  5:   x += 2;
;  6:   x += 3;
;  7: }
;  8: static inline void bar() {
;  9:   x += 4;
; 10:   foo();
; 11:   x += 5;
; 12: }
; 13: void baz() {
; 14:   x += 6;
; 15:   bar();
; 16:   x += 7;
; 17: }

; ASM: .cv_func_id 0
; ASM: .cv_loc 0 1 13 0      # t.cpp:13:0
; ASM: .cv_loc 0 1 14 5                # t.cpp:14:5
; ASM: addl    $6, "?x@@3HC"
; ASM: .cv_inline_site_id 1 within 0 inlined_at 1 15 3
; ASM: .cv_loc 1 1 9 5                 # t.cpp:9:5
; ASM: addl    $4, "?x@@3HC"
; ASM: .cv_inline_site_id 2 within 1 inlined_at 1 10 3
; ASM: .cv_loc 2 1 4 5                 # t.cpp:4:5
; ASM: addl    {{.*}}, "?x@@3HC"
; ASM: .cv_loc 2 1 5 5                 # t.cpp:5:5
; ASM: addl    $2, "?x@@3HC"
; ASM: .cv_loc 2 1 6 5                 # t.cpp:6:5
; ASM: addl    $3, "?x@@3HC"
; ASM: .cv_loc 1 1 11 5                # t.cpp:11:5
; ASM: addl    $5, "?x@@3HC"
; ASM: .cv_loc 0 1 16 5                # t.cpp:16:5
; ASM: addl    $7, "?x@@3HC"
; ASM: .cv_loc 0 1 17 1                # t.cpp:17:1

; ASM: .section .debug$S,"dr"
; ASM: .long   246                     # Inlinee lines subsection
; ASM: .long   [[inline_end:.*]]-[[inline_beg:.*]] #
; ASM: [[inline_beg]]:
; ASM: .long   0
; ASM: # Inlined function bar starts at t.cpp:8
; ASM: .long   4098                    # Type index of inlined function
; ASM: .cv_filechecksumoffset 1        # Offset into filechecksum table
; ASM: .long   8                       # Starting line number
; ASM: # Inlined function foo starts at t.cpp:2
; ASM: .long   4099
; ASM: .cv_filechecksumoffset 1        # Offset into filechecksum table
; ASM: .long   2
; ASM: [[inline_end]]:

; ASM: .long   241                     # Symbol subsection for baz
; ASM: .long   {{.*}} # Subsection size
; ASM: .short 4429
; ASM: .long
; ASM: .long
; ASM: .long
; ASM: .cv_inline_linetable 1 1 8 Lfunc_begin0 Lfunc_end0
; ASM: .short 4429
; ASM: .long
; ASM: .long
; ASM: .long
; ASM: .cv_inline_linetable 2 1 2 Lfunc_begin0 Lfunc_end0
; ASM: .short  4430
; ASM: .short  4430

; ASM: .cv_filechecksums

; ASM: .section .debug$T,"dr"
; ASM: .long 4 # Debug section magic
; ASM: # ArgList (0x1000)
; ASM: .short	0x6                     # Record length
; ASM: .short	0x1201                  # Record kind: LF_ARGLIST
; ASM: .long	0x0                     # NumArgs
; ASM: # Procedure (0x1001)
; ASM: .short	0xe                     # Record length
; ASM: .short	0x1008                  # Record kind: LF_PROCEDURE
; ASM: .long	0x3                     # ReturnType: void
; ASM: .byte	0x0                     # CallingConvention: NearC
; ASM: .byte	0x0                     # FunctionOptions
; ASM: .short	0x0                     # NumParameters
; ASM: .long	0x1000                  # ArgListType: ()
; ASM: # FuncId (0x1002)
; ASM: .short	0xe                     # Record length
; ASM: .short	0x1601                  # Record kind: LF_FUNC_ID
; ASM: .long	0x0                     # ParentScope
; ASM: .long	0x1001                  # FunctionType: void ()
; ASM: .asciz	"bar"                   # Name
; ASM: # FuncId (0x1003)
; ASM: .short	0xe                     # Record length
; ASM: .short	0x1601                  # Record kind: LF_FUNC_ID
; ASM: .long	0x0                     # ParentScope
; ASM: .long	0x1001                  # FunctionType: void ()
; ASM: .asciz	"foo"                   # Name

; We should only the LF_FUNC_ID records that we needed to reference.
; OBJ: CodeViewTypes [
; OBJ:   Section: .debug$T
; OBJ:   ArgList (0x1000) {
; OBJ:     TypeLeafKind: LF_ARGLIST (0x1201)
; OBJ:     NumArgs: 0
; OBJ:   }
; OBJ:   Procedure (0x1001) {
; OBJ:     TypeLeafKind: LF_PROCEDURE (0x1008)
; OBJ:     ReturnType: void (0x3)
; OBJ:     NumParameters: 0
; OBJ:     ArgListType: () (0x1000)
; OBJ:   }
; OBJ:   FuncId (0x1002) {
; OBJ:     TypeLeafKind: LF_FUNC_ID (0x1601)
; OBJ:     ParentScope: 0x0
; OBJ:     FunctionType: void () (0x1001)
; OBJ:     Name: bar
; OBJ:   }
; OBJ:   FuncId (0x1003) {
; OBJ:     TypeLeafKind: LF_FUNC_ID (0x1601)
; OBJ:     ParentScope: 0x0
; OBJ:     FunctionType: void () (0x1001)
; OBJ:     Name: foo
; OBJ:   }
; OBJ:   FuncId (0x1004) {
; OBJ:     TypeLeafKind: LF_FUNC_ID (0x1601)
; OBJ:     ParentScope: 0x0
; OBJ:     FunctionType: void () (0x1001)
; OBJ:     Name: baz
; OBJ:   }
; OBJ-NOT: TypeLeafKind: LF_FUNC_ID
; OBJ: ]

; OBJ: Subsection [
; OBJ:   SubSectionType: InlineeLines (0xF6)
; OBJ:   SubSectionSize: 0x1C
; OBJ:   InlineeSourceLine {
; OBJ:     Inlinee: bar (0x1002)
; OBJ:     FileID: D:\src\llvm\build\t.cpp (0x0)
; OBJ:     SourceLineNum: 8
; OBJ:   }
; OBJ:   InlineeSourceLine {
; OBJ:     Inlinee: foo (0x1003)
; OBJ:     FileID: D:\src\llvm\build\t.cpp (0x0)
; OBJ:     SourceLineNum: 2
; OBJ:   }
; OBJ: ]
; OBJ: Subsection [
; OBJ:   SubSectionType: Symbols (0xF1)
; OBJ:   {{.*}}Proc{{.*}}Sym {
; OBJ:     PtrParent: 0x0
; OBJ:     PtrEnd: 0x0
; OBJ:     PtrNext: 0x0
; OBJ:     CodeSize: 0x35
; OBJ:     DbgStart: 0x0
; OBJ:     DbgEnd: 0x0
; OBJ:     FunctionType: baz (0x1004)
; OBJ:     CodeOffset: ?baz@@YAXXZ+0x0
; OBJ:     Segment: 0x0
; OBJ:     Flags [ (0x80)
; OBJ:       HasOptimizedDebugInfo (0x80)
; OBJ:     ]
; OBJ:     DisplayName: baz
; OBJ:     LinkageName: ?baz@@YAXXZ
; OBJ:   }
; OBJ:   InlineSiteSym {
; OBJ:     PtrParent: 0x0
; OBJ:     PtrEnd: 0x0
; OBJ:     Inlinee: bar (0x1002)
; OBJ:      BinaryAnnotations [
; OBJ-NEXT:   ChangeCodeOffsetAndLineOffset: {CodeOffset: 0x8, LineOffset: 1}
; OBJ-NEXT:   ChangeCodeOffsetAndLineOffset: {CodeOffset: 0x9, LineOffset: 1}
; OBJ-NEXT:   ChangeLineOffset: 1
; OBJ-NEXT:   ChangeCodeOffset: 0x14
; OBJ-NEXT:   ChangeCodeLength: 0x7
; OBJ:      ]
; OBJ:   }
; OBJ:   InlineSiteSym {
; OBJ:     PtrParent: 0x0
; OBJ:     PtrEnd: 0x0
; OBJ:     Inlinee: foo (0x1003)
; OBJ:     BinaryAnnotations [
; OBJ-NEXT:  ChangeLineOffset: 2
; OBJ-NEXT:  ChangeCodeOffset: 0x11
; OBJ-NEXT:  ChangeCodeOffsetAndLineOffset: {CodeOffset: 0x6, LineOffset: 1}
; OBJ-NEXT:  ChangeCodeOffsetAndLineOffset: {CodeOffset: 0x7, LineOffset: 1}
; OBJ-NEXT:  ChangeCodeLength: 0x7
; OBJ:     ]
; OBJ:   }
; OBJ:   InlineSiteEnd {
; OBJ:   }
; OBJ:   InlineSiteEnd {
; OBJ:   }
; OBJ:   ProcEnd
; OBJ: ]

; ModuleID = 't.cpp'
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc18.0.0"

@"\01?x@@3HC" = external global i32, align 4

; Function Attrs: norecurse nounwind uwtable
define void @"\01?baz@@YAXXZ"() #0 !dbg !4 {
entry:
  %y.i.i = alloca i32, align 4
  %0 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !12, !tbaa !13
  %add = add nsw i32 %0, 6, !dbg !12
  store volatile i32 %add, ptr @"\01?x@@3HC", align 4, !dbg !12, !tbaa !13
  %1 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !17, !tbaa !13
  %add.i = add nsw i32 %1, 4, !dbg !17
  store volatile i32 %add.i, ptr @"\01?x@@3HC", align 4, !dbg !17, !tbaa !13
  call void @llvm.lifetime.start(i64 4, ptr %y.i.i) #2, !dbg !19
  store i32 1, ptr %y.i.i, align 4, !dbg !21, !tbaa !13
  %2 = ptrtoint ptr %y.i.i to i64, !dbg !22
  %3 = trunc i64 %2 to i32, !dbg !22
  %4 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !23, !tbaa !13
  %add.i.i = add nsw i32 %4, %3, !dbg !23
  store volatile i32 %add.i.i, ptr @"\01?x@@3HC", align 4, !dbg !23, !tbaa !13
  %5 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !24, !tbaa !13
  %add1.i.i = add nsw i32 %5, 2, !dbg !24
  store volatile i32 %add1.i.i, ptr @"\01?x@@3HC", align 4, !dbg !24, !tbaa !13
  %6 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !25, !tbaa !13
  %add2.i.i = add nsw i32 %6, 3, !dbg !25
  store volatile i32 %add2.i.i, ptr @"\01?x@@3HC", align 4, !dbg !25, !tbaa !13
  call void @llvm.lifetime.end(i64 4, ptr %y.i.i) #2, !dbg !26
  %7 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !27, !tbaa !13
  %add1.i = add nsw i32 %7, 5, !dbg !27
  store volatile i32 %add1.i, ptr @"\01?x@@3HC", align 4, !dbg !27, !tbaa !13
  %8 = load volatile i32, ptr @"\01?x@@3HC", align 4, !dbg !28, !tbaa !13
  %add1 = add nsw i32 %8, 7, !dbg !28
  store volatile i32 %add1, ptr @"\01?x@@3HC", align 4, !dbg !28, !tbaa !13
  ret void, !dbg !29
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, ptr nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, ptr nocapture) #1

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "frame-pointer"="none" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 3.9.0 ", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2)
!1 = !DIFile(filename: "t.cpp", directory: "D:\5Csrc\5Cllvm\5Cbuild")
!2 = !{}
!4 = distinct !DISubprogram(name: "baz", scope: !1, file: !1, line: 13, type: !5, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!5 = !DISubroutineType(types: !2)
!6 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 8, type: !5, isLocal: true, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 2, type: !5, isLocal: true, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !{i32 2, !"CodeView", i32 1}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"PIC Level", i32 2}
!11 = !{!"clang version 3.9.0 "}
!12 = !DILocation(line: 14, column: 5, scope: !4)
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !15, i64 0}
!15 = !{!"omnipotent char", !16, i64 0}
!16 = !{!"Simple C/C++ TBAA"}
!17 = !DILocation(line: 9, column: 5, scope: !6, inlinedAt: !18)
!18 = distinct !DILocation(line: 15, column: 3, scope: !4)
!19 = !DILocation(line: 3, column: 3, scope: !7, inlinedAt: !20)
!20 = distinct !DILocation(line: 10, column: 3, scope: !6, inlinedAt: !18)
!21 = !DILocation(line: 3, column: 7, scope: !7, inlinedAt: !20)
!22 = !DILocation(line: 4, column: 8, scope: !7, inlinedAt: !20)
!23 = !DILocation(line: 4, column: 5, scope: !7, inlinedAt: !20)
!24 = !DILocation(line: 5, column: 5, scope: !7, inlinedAt: !20)
!25 = !DILocation(line: 6, column: 5, scope: !7, inlinedAt: !20)
!26 = !DILocation(line: 7, column: 1, scope: !7, inlinedAt: !20)
!27 = !DILocation(line: 11, column: 5, scope: !6, inlinedAt: !18)
!28 = !DILocation(line: 16, column: 5, scope: !4)
!29 = !DILocation(line: 17, column: 1, scope: !4)

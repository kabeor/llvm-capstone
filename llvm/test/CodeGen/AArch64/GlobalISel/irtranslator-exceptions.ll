; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -mtriple=aarch64-apple-ios -global-isel -stop-after=irtranslator %s -o - | FileCheck %s

@_ZTIi = external global ptr

declare i32 @foo(i32)
declare i32 @__gxx_personality_v0(...)
declare i32 @llvm.eh.typeid.for(ptr)

define { ptr, i32 } @bar() personality ptr @__gxx_personality_v0 {
  ; CHECK-LABEL: name: bar
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 42
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(p0) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[DEF1:%[0-9]+]]:_(s32) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   G_INVOKE_REGION_START
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   BL @foo, csr_darwin_aarch64_aapcs, implicit-def $lr, implicit $sp, implicit $w0, implicit-def $w0
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   G_BR %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.broken (landing-pad):
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   [[DEF2:%[0-9]+]]:_(s128) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s32) = G_PTRTOINT [[COPY2]](p0)
  ; CHECK-NEXT:   $x0 = COPY [[COPY1]](p0)
  ; CHECK-NEXT:   $w1 = COPY [[PTRTOINT]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0, implicit $w1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.continue:
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   $x0 = COPY [[DEF]](p0)
  ; CHECK-NEXT:   $w1 = COPY [[C1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0, implicit $w1
  %res32 = invoke i32 @foo(i32 42) to label %continue unwind label %broken


broken:
  %ptr.sel = landingpad { ptr, i32 } catch ptr @_ZTIi
  ret { ptr, i32 } %ptr.sel

continue:
  %sel.int = tail call i32 @llvm.eh.typeid.for(ptr @_ZTIi)
  %res.good = insertvalue { ptr, i32 } undef, i32 %sel.int, 1
  ret { ptr, i32 } %res.good
}

define void @test_invoke_indirect(ptr %callee) personality ptr @__gxx_personality_v0 {
  ; CHECK-LABEL: name: test_invoke_indirect
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT:   liveins: $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:gpr64(p0) = COPY $x0
  ; CHECK-NEXT:   G_INVOKE_REGION_START
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   BLR [[COPY]](p0), csr_darwin_aarch64_aapcs, implicit-def $lr, implicit $sp
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   G_BR %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.broken (landing-pad):
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(s128) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s32) = G_PTRTOINT [[COPY2]](p0)
  ; CHECK-NEXT:   RET_ReallyLR
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.continue:
  ; CHECK-NEXT:   RET_ReallyLR
  invoke void %callee() to label %continue unwind label %broken

broken:
  landingpad { ptr, i32 } catch ptr @_ZTIi
  ret void

continue:
  ret void
}

declare void @printf(ptr, ...)
define void @test_invoke_varargs() personality ptr @__gxx_personality_v0 {
  ; CHECK-LABEL: name: test_invoke_varargs
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 42
  ; CHECK-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_FCONSTANT float 1.000000e+00
  ; CHECK-NEXT:   G_INVOKE_REGION_START
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $sp
  ; CHECK-NEXT:   [[C3:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C3]](s64)
  ; CHECK-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C1]](s32)
  ; CHECK-NEXT:   G_STORE [[ANYEXT]](s64), [[PTR_ADD]](p0) :: (store (s64) into stack, align 1)
  ; CHECK-NEXT:   [[C4:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; CHECK-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C4]](s64)
  ; CHECK-NEXT:   G_STORE [[C2]](s32), [[PTR_ADD1]](p0) :: (store (s32) into stack + 8, align 1)
  ; CHECK-NEXT:   $x0 = COPY [[C]](p0)
  ; CHECK-NEXT:   BL @printf, csr_darwin_aarch64_aapcs, implicit-def $lr, implicit $sp, implicit $x0
  ; CHECK-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   G_BR %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.broken (landing-pad):
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(s128) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s32) = G_PTRTOINT [[COPY2]](p0)
  ; CHECK-NEXT:   RET_ReallyLR
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.continue:
  ; CHECK-NEXT:   RET_ReallyLR
  invoke void(ptr, ...) @printf(ptr null, i32 42, float 1.0) to label %continue unwind label %broken

broken:
  landingpad { ptr, i32 } catch ptr @_ZTIi
  ret void

continue:
  ret void
}

@global_var = external global i32

declare void @may_throw()
define i32 @test_lpad_phi() personality ptr @__gxx_personality_v0 {
  ; CHECK-LABEL: name: test_lpad_phi
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 42
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @global_var
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 11
  ; CHECK-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 13
  ; CHECK-NEXT:   [[C3:%[0-9]+]]:_(s32) = G_CONSTANT i32 55
  ; CHECK-NEXT:   G_STORE [[C]](s32), [[GV]](p0) :: (store (s32) into @global_var)
  ; CHECK-NEXT:   G_INVOKE_REGION_START
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   BL @may_throw, csr_darwin_aarch64_aapcs, implicit-def $lr, implicit $sp
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   G_BR %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.lpad (landing-pad):
  ; CHECK-NEXT:   successors: %bb.3(0x80000000)
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PHI:%[0-9]+]]:_(s32) = G_PHI [[C1]](s32), %bb.1
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(s128) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s32) = G_PTRTOINT [[COPY1]](p0)
  ; CHECK-NEXT:   G_STORE [[PHI]](s32), [[GV]](p0) :: (store (s32) into @global_var)
  ; CHECK-NEXT:   G_BR %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.continue:
  ; CHECK-NEXT:   [[PHI1:%[0-9]+]]:_(s32) = G_PHI [[C2]](s32), %bb.1, [[C3]](s32), %bb.2
  ; CHECK-NEXT:   $w0 = COPY [[PHI1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
  store i32 42, ptr @global_var
  invoke void @may_throw()
          to label %continue unwind label %lpad

lpad:                                             ; preds = %entry
  %p = phi i32 [ 11, %0 ]  ; Trivial, but -O0 keeps it
  %1 = landingpad { ptr, i32 }
          catch ptr null
  store i32 %p, ptr @global_var
  br label %continue

continue:                                         ; preds = %entry, %lpad
  %r.0 = phi i32 [ 13, %0 ], [ 55, %lpad ]
  ret i32 %r.0
}

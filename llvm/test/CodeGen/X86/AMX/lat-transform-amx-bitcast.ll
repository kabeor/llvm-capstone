; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt --codegen-opt-level=2 -mtriple=x86_64 -lower-amx-type %s -S | FileCheck %s

%struct.__tile_str = type { i16, i16, <256 x i32> }

@buf = dso_local global [1024 x i8] zeroinitializer, align 64
@buf2 = dso_local global [1024 x i8] zeroinitializer, align 64

; test bitcast x86_amx to <256 x i32>
define dso_local void @test_user_empty(i16 %m, i16 %n, ptr%buf, i64 %s) {
; CHECK-LABEL: @test_user_empty(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T1:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[N:%.*]], ptr [[BUF:%.*]], i64 [[S:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  %t1 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %m, i16 %n, ptr %buf, i64 %s)
  %t2 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t1)
  ret void
}

; test bitcast <256 x i32> to x86_amx
define dso_local void @test_user_empty2(<256 x i32> %in) {
; CHECK-LABEL: @test_user_empty2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  %t = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %in)
  ret void
}

define dso_local <256 x i32> @test_amx_load_bitcast_v256i32(ptr %in, i16 %m, i16 %n, ptr%buf, i64 %s) {
; CHECK-LABEL: @test_amx_load_bitcast_v256i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <256 x i32>, align 64
; CHECK-NEXT:    [[T1:%.*]] = load <256 x i32>, ptr [[IN:%.*]], align 64
; CHECK-NEXT:    store <256 x i32> [[T1]], ptr [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP1:%.*]] = sext i16 [[N:%.*]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[N]], ptr [[TMP0]], i64 [[TMP1]])
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[N]], ptr [[BUF:%.*]], i64 [[S:%.*]], x86_amx [[TMP2]])
; CHECK-NEXT:    ret <256 x i32> [[T1]]
;
entry:
  %t1 = load <256 x i32>, ptr %in, align 64
  %t2 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t1)
  call void @llvm.x86.tilestored64.internal(i16 %m, i16 %n, ptr %buf, i64 %s, x86_amx %t2)
  ret <256 x i32> %t1
}

define dso_local <225 x i32> @test_amx_load_bitcast_v225i32(ptr %in, i16 %m, i16 %n, ptr%buf, i64 %s) {
; CHECK-LABEL: @test_amx_load_bitcast_v225i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <225 x i32>, align 64
; CHECK-NEXT:    [[T1:%.*]] = load <225 x i32>, ptr [[IN:%.*]], align 64
; CHECK-NEXT:    store <225 x i32> [[T1]], ptr [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP1:%.*]] = sext i16 [[N:%.*]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[N]], ptr [[TMP0]], i64 [[TMP1]])
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[N]], ptr [[BUF:%.*]], i64 [[S:%.*]], x86_amx [[TMP2]])
; CHECK-NEXT:    ret <225 x i32> [[T1]]
;
entry:
  %t1 = load <225 x i32>, ptr %in, align 64
  %t2 = call x86_amx @llvm.x86.cast.vector.to.tile.v225i32(<225 x i32> %t1)
  call void @llvm.x86.tilestored64.internal(i16 %m, i16 %n, ptr %buf, i64 %s, x86_amx %t2)
  ret <225 x i32> %t1
}

define dso_local <256 x i32> @test_amx_bitcast_store(ptr %out, i16 %m, i16 %n, ptr%buf, i64 %s) {
; CHECK-LABEL: @test_amx_bitcast_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <256 x i32>, align 64
; CHECK-NEXT:    [[T1:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[M]], ptr [[BUF:%.*]], i64 [[S:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = sext i16 [[M]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[M]], ptr [[TMP0]], i64 [[TMP1]], x86_amx [[T1]])
; CHECK-NEXT:    [[TMP2:%.*]] = load <256 x i32>, ptr [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP3:%.*]] = sext i16 [[M]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[M]], ptr [[OUT:%.*]], i64 [[TMP3]], x86_amx [[T1]])
; CHECK-NEXT:    ret <256 x i32> [[TMP2]]
;
entry:
  %t1 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %m, i16 %m, ptr %buf, i64 %s)
  %t2 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t1)
  store <256 x i32> %t2, ptr %out
  ret <256 x i32> %t2
}

define dso_local void @test_src_add(<256 x i32> %x, <256 x i32> %y, i16 %r, i16 %c, ptr %buf, i64 %s) {
; CHECK-LABEL: @test_src_add(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <256 x i32>, align 64
; CHECK-NEXT:    [[ADD:%.*]] = add <256 x i32> [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    store <256 x i32> [[ADD]], ptr [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP1:%.*]] = sext i16 [[C:%.*]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[R:%.*]], i16 [[C]], ptr [[TMP0]], i64 [[TMP1]])
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[R]], i16 [[C]], ptr [[BUF:%.*]], i64 [[S:%.*]], x86_amx [[TMP2]])
; CHECK-NEXT:    ret void
;
entry:
  %add = add <256 x i32> %y, %x
  %t = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %add)
  call void @llvm.x86.tilestored64.internal(i16 %r, i16 %c, ptr %buf, i64 %s, x86_amx %t)
  ret void
}

define dso_local void @test_src_add2(<256 x i32> %x, i16 %r, i16 %c, ptr %buf, i64 %s) {
; CHECK-LABEL: @test_src_add2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <256 x i32>, align 64
; CHECK-NEXT:    [[T1:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[R:%.*]], i16 [[C:%.*]], ptr [[BUF:%.*]], i64 [[S:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = sext i16 [[C]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[R]], i16 [[C]], ptr [[TMP0]], i64 [[TMP1]], x86_amx [[T1]])
; CHECK-NEXT:    [[TMP2:%.*]] = load <256 x i32>, ptr [[TMP0]], align 1024
; CHECK-NEXT:    [[ADD:%.*]] = add <256 x i32> [[TMP2]], [[X:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  %t1 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %r, i16 %c, ptr %buf, i64 %s)
  %t2 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t1)
  %add = add <256 x i32> %t2, %x
  ret void
}

define dso_local void @__tile_loadd(ptr nocapture %0, ptr %1, i64 %2) local_unnamed_addr {
; CHECK-LABEL: @__tile_loadd(
; CHECK-NEXT:    [[TMP4:%.*]] = load i16, ptr [[TMP0:%.*]], align 64
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR:%.*]], ptr [[TMP0]], i64 0, i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = load i16, ptr [[TMP5]], align 2
; CHECK-NEXT:    [[TMP7:%.*]] = shl i64 [[TMP2:%.*]], 32
; CHECK-NEXT:    [[TMP8:%.*]] = ashr exact i64 [[TMP7]], 32
; CHECK-NEXT:    [[TMP9:%.*]] = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP4]], i16 [[TMP6]], ptr [[TMP1:%.*]], i64 [[TMP8]])
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR]], ptr [[TMP0]], i64 0, i32 2
; CHECK-NEXT:    [[TMP11:%.*]] = sext i16 [[TMP6]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[TMP4]], i16 [[TMP6]], ptr [[TMP10]], i64 [[TMP11]], x86_amx [[TMP9]])
; CHECK-NEXT:    ret void
;
  %4 = load i16, ptr %0, align 64
  %5 = getelementptr inbounds %struct.__tile_str, ptr %0, i64 0, i32 1
  %6 = load i16, ptr %5, align 2
  %7 = shl i64 %2, 32
  %8 = ashr exact i64 %7, 32
  %9 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %4, i16 %6, ptr %1, i64 %8)
  %10 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %9)
  %11 = getelementptr inbounds %struct.__tile_str, ptr %0, i64 0, i32 2
  store <256 x i32> %10, ptr %11, align 64
  ret void
}

define dso_local void @__tile_dpbssd(ptr nocapture %0, ptr nocapture readonly byval(%struct.__tile_str) align 64 %1, ptr nocapture readonly byval(%struct.__tile_str) align 64 %2) local_unnamed_addr {
; CHECK-LABEL: @__tile_dpbssd(
; CHECK-NEXT:    [[TMP4:%.*]] = load i16, ptr [[TMP1:%.*]], align 64
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR:%.*]], ptr [[TMP2:%.*]], i64 0, i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = load i16, ptr [[TMP5]], align 2
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR]], ptr [[TMP1]], i64 0, i32 1
; CHECK-NEXT:    [[TMP8:%.*]] = load i16, ptr [[TMP7]], align 2
; CHECK-NEXT:    [[TMP9:%.*]] = udiv i16 [[TMP8]], 4
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR]], ptr [[TMP0:%.*]], i64 0, i32 2
; CHECK-NEXT:    [[TMP11:%.*]] = sext i16 [[TMP6]] to i64
; CHECK-NEXT:    [[TMP12:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP4]], i16 [[TMP6]], ptr [[TMP10]], i64 [[TMP11]])
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR]], ptr [[TMP1]], i64 0, i32 2
; CHECK-NEXT:    [[TMP14:%.*]] = sext i16 [[TMP8]] to i64
; CHECK-NEXT:    [[TMP15:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP4]], i16 [[TMP8]], ptr [[TMP13]], i64 [[TMP14]])
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR]], ptr [[TMP2]], i64 0, i32 2
; CHECK-NEXT:    [[TMP17:%.*]] = sext i16 [[TMP6]] to i64
; CHECK-NEXT:    [[TMP18:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP9]], i16 [[TMP6]], ptr [[TMP16]], i64 [[TMP17]])
; CHECK-NEXT:    [[TMP19:%.*]] = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 [[TMP4]], i16 [[TMP6]], i16 [[TMP8]], x86_amx [[TMP12]], x86_amx [[TMP15]], x86_amx [[TMP18]])
; CHECK-NEXT:    [[TMP20:%.*]] = sext i16 [[TMP6]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[TMP4]], i16 [[TMP6]], ptr [[TMP10]], i64 [[TMP20]], x86_amx [[TMP19]])
; CHECK-NEXT:    ret void
;
  %4 = load i16, ptr %1, align 64
  %5 = getelementptr inbounds %struct.__tile_str, ptr %2, i64 0, i32 1
  %6 = load i16, ptr %5, align 2
  %7 = getelementptr inbounds %struct.__tile_str, ptr %1, i64 0, i32 1
  %8 = load i16, ptr %7, align 2
  %9 = getelementptr inbounds %struct.__tile_str, ptr %0, i64 0, i32 2
  %10 = load <256 x i32>, ptr %9, align 64
  %11 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %10)
  %12 = getelementptr inbounds %struct.__tile_str, ptr %1, i64 0, i32 2
  %13 = load <256 x i32>, ptr %12, align 64
  %14 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %13)
  %15 = getelementptr inbounds %struct.__tile_str, ptr %2, i64 0, i32 2
  %16 = load <256 x i32>, ptr %15, align 64
  %17 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %16)
  %18 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %4, i16 %6, i16 %8, x86_amx %11, x86_amx %14, x86_amx %17)
  %19 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %18)
  store <256 x i32> %19, ptr %9, align 64
  ret void
}

define dso_local void @__tile_dpbsud(i16 %m, i16 %n, i16 %k, ptr %pc, ptr %pa, ptr %pb) {
; CHECK-LABEL: @__tile_dpbsud(
; CHECK-NEXT:    [[TMP1:%.*]] = udiv i16 [[K:%.*]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = sext i16 [[K]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[K]], ptr [[PA:%.*]], i64 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = sext i16 [[N:%.*]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP1]], i16 [[N]], ptr [[PB:%.*]], i64 [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M]], i16 [[N]], ptr [[PC:%.*]], i64 [[TMP6]])
; CHECK-NEXT:    [[T6:%.*]] = tail call x86_amx @llvm.x86.tdpbsud.internal(i16 [[M]], i16 [[N]], i16 [[K]], x86_amx [[TMP7]], x86_amx [[TMP3]], x86_amx [[TMP5]])
; CHECK-NEXT:    [[TMP8:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[N]], ptr [[PC]], i64 [[TMP8]], x86_amx [[T6]])
; CHECK-NEXT:    ret void
;
  %t0 = load <256 x i32>, ptr %pa, align 64
  %t1 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t0)
  %t2 = load <256 x i32>, ptr %pb, align 64
  %t3 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t2)
  %t4 = load <256 x i32>, ptr %pc, align 64
  %t5 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t4)
  %t6 = tail call x86_amx @llvm.x86.tdpbsud.internal(i16 %m, i16 %n, i16 %k, x86_amx %t5, x86_amx %t1, x86_amx %t3)
  %t7 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t6)
  store <256 x i32> %t7, ptr %pc, align 64
  ret void
}

define dso_local void @__tile_dpbusd(i16 %m, i16 %n, i16 %k, ptr %pc, ptr %pa, ptr %pb) {
; CHECK-LABEL: @__tile_dpbusd(
; CHECK-NEXT:    [[TMP1:%.*]] = udiv i16 [[K:%.*]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = sext i16 [[K]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[K]], ptr [[PA:%.*]], i64 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = sext i16 [[N:%.*]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP1]], i16 [[N]], ptr [[PB:%.*]], i64 [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M]], i16 [[N]], ptr [[PC:%.*]], i64 [[TMP6]])
; CHECK-NEXT:    [[T6:%.*]] = tail call x86_amx @llvm.x86.tdpbusd.internal(i16 [[M]], i16 [[N]], i16 [[K]], x86_amx [[TMP7]], x86_amx [[TMP3]], x86_amx [[TMP5]])
; CHECK-NEXT:    [[TMP8:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[N]], ptr [[PC]], i64 [[TMP8]], x86_amx [[T6]])
; CHECK-NEXT:    ret void
;
  %t0 = load <256 x i32>, ptr %pa, align 64
  %t1 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t0)
  %t2 = load <256 x i32>, ptr %pb, align 64
  %t3 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t2)
  %t4 = load <256 x i32>, ptr %pc, align 64
  %t5 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t4)
  %t6 = tail call x86_amx @llvm.x86.tdpbusd.internal(i16 %m, i16 %n, i16 %k, x86_amx %t5, x86_amx %t1, x86_amx %t3)
  %t7 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t6)
  store <256 x i32> %t7, ptr %pc, align 64
  ret void
}

define dso_local void @__tile_dpbuud(i16 %m, i16 %n, i16 %k, ptr %pc, ptr %pa, ptr %pb) {
; CHECK-LABEL: @__tile_dpbuud(
; CHECK-NEXT:    [[TMP1:%.*]] = udiv i16 [[K:%.*]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = sext i16 [[K]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[K]], ptr [[PA:%.*]], i64 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = sext i16 [[N:%.*]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP1]], i16 [[N]], ptr [[PB:%.*]], i64 [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M]], i16 [[N]], ptr [[PC:%.*]], i64 [[TMP6]])
; CHECK-NEXT:    [[T6:%.*]] = tail call x86_amx @llvm.x86.tdpbuud.internal(i16 [[M]], i16 [[N]], i16 [[K]], x86_amx [[TMP7]], x86_amx [[TMP3]], x86_amx [[TMP5]])
; CHECK-NEXT:    [[TMP8:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[N]], ptr [[PC]], i64 [[TMP8]], x86_amx [[T6]])
; CHECK-NEXT:    ret void
;
  %t0 = load <256 x i32>, ptr %pa, align 64
  %t1 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t0)
  %t2 = load <256 x i32>, ptr %pb, align 64
  %t3 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t2)
  %t4 = load <256 x i32>, ptr %pc, align 64
  %t5 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t4)
  %t6 = tail call x86_amx @llvm.x86.tdpbuud.internal(i16 %m, i16 %n, i16 %k, x86_amx %t5, x86_amx %t1, x86_amx %t3)
  %t7 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t6)
  store <256 x i32> %t7, ptr %pc, align 64
  ret void
}

define dso_local void @__tile_dpbf16ps(i16 %m, i16 %n, i16 %k, ptr %pc, ptr %pa, ptr %pb) {
; CHECK-LABEL: @__tile_dpbf16ps(
; CHECK-NEXT:    [[TMP1:%.*]] = udiv i16 [[K:%.*]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = sext i16 [[K]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M:%.*]], i16 [[K]], ptr [[PA:%.*]], i64 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = sext i16 [[N:%.*]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP1]], i16 [[N]], ptr [[PB:%.*]], i64 [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[M]], i16 [[N]], ptr [[PC:%.*]], i64 [[TMP6]])
; CHECK-NEXT:    [[T6:%.*]] = tail call x86_amx @llvm.x86.tdpbf16ps.internal(i16 [[M]], i16 [[N]], i16 [[K]], x86_amx [[TMP7]], x86_amx [[TMP3]], x86_amx [[TMP5]])
; CHECK-NEXT:    [[TMP8:%.*]] = sext i16 [[N]] to i64
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 [[M]], i16 [[N]], ptr [[PC]], i64 [[TMP8]], x86_amx [[T6]])
; CHECK-NEXT:    ret void
;
  %t0 = load <256 x i32>, ptr %pa, align 64
  %t1 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t0)
  %t2 = load <256 x i32>, ptr %pb, align 64
  %t3 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t2)
  %t4 = load <256 x i32>, ptr %pc, align 64
  %t5 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t4)
  %t6 = tail call x86_amx @llvm.x86.tdpbf16ps.internal(i16 %m, i16 %n, i16 %k, x86_amx %t5, x86_amx %t1, x86_amx %t3)
  %t7 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t6)
  store <256 x i32> %t7, ptr %pc, align 64
  ret void
}

define dso_local void @__tile_stored(ptr %0, i64 %1, ptr nocapture readonly byval(%struct.__tile_str) align 64 %2) local_unnamed_addr {
; CHECK-LABEL: @__tile_stored(
; CHECK-NEXT:    [[TMP4:%.*]] = load i16, ptr [[TMP2:%.*]], align 64
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR:%.*]], ptr [[TMP2]], i64 0, i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = load i16, ptr [[TMP5]], align 2
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT___TILE_STR]], ptr [[TMP2]], i64 0, i32 2
; CHECK-NEXT:    [[TMP8:%.*]] = sext i16 [[TMP6]] to i64
; CHECK-NEXT:    [[TMP9:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 [[TMP4]], i16 [[TMP6]], ptr [[TMP7]], i64 [[TMP8]])
; CHECK-NEXT:    [[TMP10:%.*]] = shl i64 [[TMP1:%.*]], 32
; CHECK-NEXT:    [[TMP11:%.*]] = ashr exact i64 [[TMP10]], 32
; CHECK-NEXT:    tail call void @llvm.x86.tilestored64.internal(i16 [[TMP4]], i16 [[TMP6]], ptr [[TMP0:%.*]], i64 [[TMP11]], x86_amx [[TMP9]])
; CHECK-NEXT:    ret void
;
  %4 = load i16, ptr %2, align 64
  %5 = getelementptr inbounds %struct.__tile_str, ptr %2, i64 0, i32 1
  %6 = load i16, ptr %5, align 2
  %7 = getelementptr inbounds %struct.__tile_str, ptr %2, i64 0, i32 2
  %8 = load <256 x i32>, ptr %7, align 64
  %9 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %8)
  %10 = shl i64 %1, 32
  %11 = ashr exact i64 %10, 32
  tail call void @llvm.x86.tilestored64.internal(i16 %4, i16 %6, ptr %0, i64 %11, x86_amx %9)
  ret void
}

define void @dead_code(ptr%buf) {
; CHECK-LABEL: @dead_code(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <256 x i32>, align 64
; CHECK-NEXT:    br i1 undef, label [[L1:%.*]], label [[L2:%.*]]
; CHECK:       l1:
; CHECK-NEXT:    [[T1:%.*]] = call x86_amx @llvm.x86.tilezero.internal(i16 8, i16 32)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 8, i16 32, ptr [[TMP0]], i64 32, x86_amx [[T1]])
; CHECK-NEXT:    [[TMP1:%.*]] = load <256 x i32>, ptr [[TMP0]], align 1024
; CHECK-NEXT:    br i1 undef, label [[L2]], label [[EXIT:%.*]]
; CHECK:       l2:
; CHECK-NEXT:    [[T3:%.*]] = phi <256 x i32> [ undef, [[ENTRY:%.*]] ], [ [[TMP1]], [[L1]] ]
; CHECK-NEXT:    store <256 x i32> [[T3]], ptr [[BUF:%.*]], align 1024
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br i1 undef, label %l1, label %l2

l1:
  %t1 = call x86_amx @llvm.x86.tilezero.internal(i16 8, i16 32)
  %t2 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t1)
  br i1 undef, label %l2, label %exit

l2:
  %t3 = phi <256 x i32> [ undef, %entry ], [ %t2, %l1 ]
  %t4 = call x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32> %t3)
  %t5 = call <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx %t4)
  store <256 x i32> %t5, ptr %buf
  br label %exit

exit:
  ret void
}

declare x86_amx @llvm.x86.tilezero.internal(i16, i16)
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, ptr, i64)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare x86_amx @llvm.x86.tdpbsud.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare x86_amx @llvm.x86.tdpbusd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare x86_amx @llvm.x86.tdpbuud.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare x86_amx @llvm.x86.tdpbf16ps.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare void @llvm.x86.tilestored64.internal(i16, i16, ptr, i64, x86_amx)

declare x86_amx @llvm.x86.cast.vector.to.tile.v256i32(<256 x i32>)
declare x86_amx @llvm.x86.cast.vector.to.tile.v225i32(<225 x i32>)
declare <256 x i32> @llvm.x86.cast.tile.to.vector.v256i32(x86_amx)
declare <225 x i32> @llvm.x86.cast.tile.to.vector.v225i32(x86_amx)

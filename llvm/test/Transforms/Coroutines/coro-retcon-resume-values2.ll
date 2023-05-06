; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -opaque-pointers=0 < %s -passes='cgscc(coro-split),simplifycfg,early-cse,simplifycfg,coro-cleanup' -S | FileCheck %s

define i8* @f(i8* %buffer, i32 %n) presplitcoroutine {
entry:
  %id = call token @llvm.coro.id.retcon(i32 8, i32 4, i8* %buffer, i8* bitcast (i8* (i8*, i32)* @prototype to i8*), i8* bitcast (i8* (i32)* @allocate to i8*), i8* bitcast (void (i8*)* @deallocate to i8*))
  %hdl = call i8* @llvm.coro.begin(token %id, i8* null)
  %value0 = call i32 (...) @llvm.coro.suspend.retcon.i32()
  %sum0 = call i32 @add(i32 %n, i32 %value0)
  %value1 = call i32 (...) @llvm.coro.suspend.retcon.i32()
  %sum1 = call i32 @add(i32 %sum0, i32 %value0)
  %sum2 = call i32 @add(i32 %sum1, i32 %value1)
  %value2 = call i32 (...) @llvm.coro.suspend.retcon.i32()
  %sum3 = call i32 @add(i32 %sum2, i32 %value0)
  %sum4 = call i32 @add(i32 %sum3, i32 %value1)
  %sum5 = call i32 @add(i32 %sum4, i32 %value2)
  call void @print(i32 %sum5)
  call i1 @llvm.coro.end(i8* %hdl, i1 0)
  unreachable
}

declare token @llvm.coro.id.retcon(i32, i32, i8*, i8*, i8*, i8*)
declare i8* @llvm.coro.begin(token, i8*)
declare i32 @llvm.coro.suspend.retcon.i32(...)
declare i1 @llvm.coro.end(i8*, i1)
declare i8* @llvm.coro.prepare.retcon(i8*)

declare i8* @prototype(i8*, i32)

declare noalias i8* @allocate(i32 %size)
declare void @deallocate(i8* %ptr)

declare i32 @add(i32, i32)
declare void @print(i32)

; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i8* @allocate(i32 20)
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BUFFER:%.*]] to i8**
; CHECK-NEXT:    store i8* [[TMP0]], i8** [[TMP1]], align 8
; CHECK-NEXT:    [[FRAMEPTR:%.*]] = bitcast i8* [[TMP0]] to %f.Frame*
; CHECK-NEXT:    [[N_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME:%.*]], %f.Frame* [[FRAMEPTR]], i32 0, i32 0
; CHECK-NEXT:    store i32 [[N:%.*]], i32* [[N_SPILL_ADDR]], align 4
; CHECK-NEXT:    ret i8* bitcast (i8* (i8*, i32)* @f.resume.0 to i8*)
;
;
; CHECK-LABEL: @f.resume.0(
; CHECK-NEXT:  entryresume.0:
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i8* [[TMP0:%.*]] to %f.Frame**
; CHECK-NEXT:    [[FRAMEPTR:%.*]] = load %f.Frame*, %f.Frame** [[TMP2]], align 8
; CHECK-NEXT:    [[VALUE0_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME:%.*]], %f.Frame* [[FRAMEPTR]], i32 0, i32 1
; CHECK-NEXT:    store i32 [[TMP1:%.*]], i32* [[VALUE0_SPILL_ADDR]], align 4
; CHECK-NEXT:    [[N_RELOAD_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 0
; CHECK-NEXT:    [[N_RELOAD:%.*]] = load i32, i32* [[N_RELOAD_ADDR]], align 4
; CHECK-NEXT:    [[SUM0:%.*]] = call i32 @add(i32 [[N_RELOAD]], i32 [[TMP1]])
; CHECK-NEXT:    [[SUM0_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 2
; CHECK-NEXT:    store i32 [[SUM0]], i32* [[SUM0_SPILL_ADDR]], align 4
; CHECK-NEXT:    ret i8* bitcast (i8* (i8*, i32)* @f.resume.1 to i8*)
;
;
; CHECK-LABEL: @f.resume.1(
; CHECK-NEXT:  entryresume.1:
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i8* [[TMP0:%.*]] to %f.Frame**
; CHECK-NEXT:    [[FRAMEPTR:%.*]] = load %f.Frame*, %f.Frame** [[TMP2]], align 8
; CHECK-NEXT:    [[VALUE1_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME:%.*]], %f.Frame* [[FRAMEPTR]], i32 0, i32 3
; CHECK-NEXT:    store i32 [[TMP1:%.*]], i32* [[VALUE1_SPILL_ADDR]], align 4
; CHECK-NEXT:    [[SUM0_RELOAD_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 2
; CHECK-NEXT:    [[SUM0_RELOAD:%.*]] = load i32, i32* [[SUM0_RELOAD_ADDR]], align 4
; CHECK-NEXT:    [[VALUE0_RELOAD_ADDR5:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 1
; CHECK-NEXT:    [[VALUE0_RELOAD6:%.*]] = load i32, i32* [[VALUE0_RELOAD_ADDR5]], align 4
; CHECK-NEXT:    [[SUM1:%.*]] = call i32 @add(i32 [[SUM0_RELOAD]], i32 [[VALUE0_RELOAD6]])
; CHECK-NEXT:    [[SUM2:%.*]] = call i32 @add(i32 [[SUM1]], i32 [[TMP1]])
; CHECK-NEXT:    [[SUM2_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 4
; CHECK-NEXT:    store i32 [[SUM2]], i32* [[SUM2_SPILL_ADDR]], align 4
; CHECK-NEXT:    ret i8* bitcast (i8* (i8*, i32)* @f.resume.2 to i8*)
;
;
; CHECK-LABEL: @f.resume.2(
; CHECK-NEXT:  entryresume.2:
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i8* [[TMP0:%.*]] to %f.Frame**
; CHECK-NEXT:    [[FRAMEPTR:%.*]] = load %f.Frame*, %f.Frame** [[TMP2]], align 8
; CHECK-NEXT:    [[SUM2_RELOAD_ADDR:%.*]] = getelementptr inbounds [[F_FRAME:%.*]], %f.Frame* [[FRAMEPTR]], i32 0, i32 4
; CHECK-NEXT:    [[SUM2_RELOAD:%.*]] = load i32, i32* [[SUM2_RELOAD_ADDR]], align 4
; CHECK-NEXT:    [[VALUE1_RELOAD_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 3
; CHECK-NEXT:    [[VALUE1_RELOAD:%.*]] = load i32, i32* [[VALUE1_RELOAD_ADDR]], align 4
; CHECK-NEXT:    [[VALUE0_RELOAD_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], %f.Frame* [[FRAMEPTR]], i32 0, i32 1
; CHECK-NEXT:    [[VALUE0_RELOAD:%.*]] = load i32, i32* [[VALUE0_RELOAD_ADDR]], align 4
; CHECK-NEXT:    [[SUM3:%.*]] = call i32 @add(i32 [[SUM2_RELOAD]], i32 [[VALUE0_RELOAD]])
; CHECK-NEXT:    [[SUM4:%.*]] = call i32 @add(i32 [[SUM3]], i32 [[VALUE1_RELOAD]])
; CHECK-NEXT:    [[SUM5:%.*]] = call i32 @add(i32 [[SUM4]], i32 [[TMP1:%.*]])
; CHECK-NEXT:    call void @print(i32 [[SUM5]])
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast %f.Frame* [[FRAMEPTR]] to i8*
; CHECK-NEXT:    call void @deallocate(i8* [[TMP3]])
; CHECK-NEXT:    ret i8* null
;

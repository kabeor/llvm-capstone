; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 < %s | FileCheck %s

;; Perform tail call optimization for duplicate returns.
declare i32 @test()
declare i32 @test1()
declare i32 @test2()
declare i32 @test3()
define i32 @duplicate_returns(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: duplicate_returns:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    bstrpick.d $a2, $a0, 31, 0
; CHECK-NEXT:    beqz $a2, .LBB0_4
; CHECK-NEXT:  # %bb.1: # %if.else
; CHECK-NEXT:    bstrpick.d $a2, $a1, 31, 0
; CHECK-NEXT:    beqz $a2, .LBB0_5
; CHECK-NEXT:  # %bb.2: # %if.else2
; CHECK-NEXT:    addi.w $a0, $a0, 0
; CHECK-NEXT:    addi.w $a1, $a1, 0
; CHECK-NEXT:    bge $a1, $a0, .LBB0_6
; CHECK-NEXT:  # %bb.3: # %if.then3
; CHECK-NEXT:    b %plt(test2)
; CHECK-NEXT:  .LBB0_4: # %if.then
; CHECK-NEXT:    b %plt(test)
; CHECK-NEXT:  .LBB0_5: # %if.then2
; CHECK-NEXT:    b %plt(test1)
; CHECK-NEXT:  .LBB0_6: # %if.else3
; CHECK-NEXT:    b %plt(test3)
entry:
  %cmp = icmp eq i32 %a, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:
  %call = tail call i32 @test()
  br label %return

if.else:
  %cmp1 = icmp eq i32 %b, 0
  br i1 %cmp1, label %if.then2, label %if.else2

if.then2:
  %call1 = tail call i32 @test1()
  br label %return

if.else2:
  %cmp5 = icmp sgt i32 %a, %b
  br i1 %cmp5, label %if.then3, label %if.else3

if.then3:
  %call2 = tail call i32 @test2()
  br label %return

if.else3:
  %call3 = tail call i32 @test3()
  br label %return

return:
  %retval = phi i32 [ %call, %if.then ], [ %call1, %if.then2 ], [ %call2, %if.then3 ], [ %call3, %if.else3 ]
  ret i32 %retval
}

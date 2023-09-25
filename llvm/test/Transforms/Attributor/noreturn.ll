; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
;
; Test cases specifically designed for the "no-return" function attribute.
; We use FIXME's to indicate problems and missing attributes.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"


; TEST 1, singleton SCC void return type
;
; void srec0() {
;   return srec0();
; }
;
define void @srec0() #0 {
; CHECK: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@srec0
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  call void @srec0()
  ret void
}


; TEST 2: singleton SCC int return type with a lot of recursive calls
;
; int srec16(int a) {
;   return srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(srec16(a))))))))))))))));
; }
;
define i32 @srec16(i32 %a) #0 {
; CHECK: Function Attrs: mustprogress nofree noinline noreturn nosync nounwind willreturn memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@srec16
; CHECK-SAME: (i32 [[A:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
; CHECK:       exit:
; CHECK-NEXT:    unreachable
;
entry:
  %call = call i32 @srec16(i32 %a)
  %call1 = call i32 @srec16(i32 %call)
  %call2 = call i32 @srec16(i32 %call1)
  %call3 = call i32 @srec16(i32 %call2)
  %call4 = call i32 @srec16(i32 %call3)
  %call5 = call i32 @srec16(i32 %call4)
  %call6 = call i32 @srec16(i32 %call5)
  %call7 = call i32 @srec16(i32 %call6)
  %call8 = call i32 @srec16(i32 %call7)
  %call9 = call i32 @srec16(i32 %call8)
  %call10 = call i32 @srec16(i32 %call9)
  %call11 = call i32 @srec16(i32 %call10)
  %call12 = call i32 @srec16(i32 %call11)
  %call13 = call i32 @srec16(i32 %call12)
  %call14 = call i32 @srec16(i32 %call13)
  %call15 = call i32 @srec16(i32 %call14)
  br label %exit

exit:
  ret i32 %call15
}


; TEST 3: endless loop, no return instruction
;
; int endless_loop(int a) {
;   while (1);
; }
;
define i32 @endless_loop(i32 %a) #0 {
; CHECK: Function Attrs: nofree noinline norecurse noreturn nosync nounwind memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@endless_loop
; CHECK-SAME: (i32 [[A:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    br label [[WHILE_BODY]]
;
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  br label %while.body
}


; TEST 4: endless loop, dead return instruction
;
; int endless_loop(int a) {
;   while (1);
;   return a;
; }
;
; FIXME: no-return missing (D65243 should fix this)
define i32 @dead_return(i32 %a) #0 {
; CHECK: Function Attrs: nofree noinline norecurse noreturn nosync nounwind memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@dead_return
; CHECK-SAME: (i32 [[A:%.*]]) #[[ATTR2]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    br label [[WHILE_BODY]]
; CHECK:       return:
; CHECK-NEXT:    unreachable
;
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  br label %while.body

return:                                           ; No predecessors!
  ret i32 %a
}


; TEST 5: all paths contain a no-return function call
;
; int multiple_noreturn_calls(int a) {
;   return a == 0 ? endless_loop(a) : srec16(a);
; }
;
define i32 @multiple_noreturn_calls(i32 %a) #0 {
; TUNIT: Function Attrs: mustprogress nofree noinline norecurse noreturn nosync nounwind willreturn memory(none) uwtable
; TUNIT-LABEL: define {{[^@]+}}@multiple_noreturn_calls
; TUNIT-SAME: (i32 [[A:%.*]]) #[[ATTR3:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A]], 0
; TUNIT-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
; TUNIT:       cond.true:
; TUNIT-NEXT:    unreachable
; TUNIT:       cond.false:
; TUNIT-NEXT:    unreachable
; TUNIT:       cond.end:
; TUNIT-NEXT:    unreachable
;
; CGSCC: Function Attrs: mustprogress nofree noinline noreturn nosync nounwind willreturn memory(none) uwtable
; CGSCC-LABEL: define {{[^@]+}}@multiple_noreturn_calls
; CGSCC-SAME: (i32 [[A:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A]], 0
; CGSCC-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
; CGSCC:       cond.true:
; CGSCC-NEXT:    unreachable
; CGSCC:       cond.false:
; CGSCC-NEXT:    unreachable
; CGSCC:       cond.end:
; CGSCC-NEXT:    unreachable
;
entry:
  %cmp = icmp eq i32 %a, 0
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %call = call i32 @endless_loop(i32 %a)
  br label %cond.end

cond.false:                                       ; preds = %entry
  %call1 = call i32 @srec16(i32 %a)
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call, %cond.true ], [ %call1, %cond.false ]
  ret i32 %cond
}


; TEST 6a: willreturn means *not* no-return or UB
; FIXME: we should derive "UB" as an argument and report it to the user on request.

define i32 @endless_loop_but_willreturn() willreturn {
; TUNIT: Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@endless_loop_but_willreturn
; TUNIT-SAME: () #[[ATTR4:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    br label [[WHILE_BODY:%.*]]
; TUNIT:       while.body:
; TUNIT-NEXT:    br label [[WHILE_BODY]]
;
; CGSCC: Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@endless_loop_but_willreturn
; CGSCC-SAME: () #[[ATTR3:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    br label [[WHILE_BODY:%.*]]
; CGSCC:       while.body:
; CGSCC-NEXT:    br label [[WHILE_BODY]]
;
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  br label %while.body
}

; TEST 6b: willreturn means *not* no-return or UB
define i32 @UB_and_willreturn() willreturn {
; TUNIT: Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@UB_and_willreturn
; TUNIT-SAME: () #[[ATTR4]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    unreachable
;
; CGSCC: Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@UB_and_willreturn
; CGSCC-SAME: () #[[ATTR3]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    unreachable
;
entry:
  unreachable
}

attributes #0 = { noinline nounwind uwtable }
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable }
; TUNIT: attributes #[[ATTR1]] = { mustprogress nofree noinline noreturn nosync nounwind willreturn memory(none) uwtable }
; TUNIT: attributes #[[ATTR2]] = { nofree noinline norecurse noreturn nosync nounwind memory(none) uwtable }
; TUNIT: attributes #[[ATTR3]] = { mustprogress nofree noinline norecurse noreturn nosync nounwind willreturn memory(none) uwtable }
; TUNIT: attributes #[[ATTR4]] = { mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree noinline noreturn nosync nounwind willreturn memory(none) uwtable }
; CGSCC: attributes #[[ATTR2]] = { nofree noinline norecurse noreturn nosync nounwind memory(none) uwtable }
; CGSCC: attributes #[[ATTR3]] = { mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) }
;.

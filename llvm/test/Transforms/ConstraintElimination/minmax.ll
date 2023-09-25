; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

; Test from PR63896
define i1 @umax_ugt(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @umax_ugt
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MAX:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[Y]], [[MAX]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp uge i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 true, true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %max = call i32 @llvm.umax.i32(i32 %x, i32 1)
  %cmp = icmp ugt i32 %y, %max
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp ugt i32 %y, %x
  %cmp3 = icmp uge i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @umax_uge(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @umax_uge
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MAX:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[Y]], [[MAX]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp uge i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 [[CMP2]], true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %max = call i32 @llvm.umax.i32(i32 %x, i32 1)
  %cmp = icmp uge i32 %y, %max
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp ugt i32 %y, %x
  %cmp3 = icmp uge i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @umin_ult(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @umin_ult
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MIN:%.*]] = call i32 @llvm.umin.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[Y]], [[MIN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ule i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 true, true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %min = call i32 @llvm.umin.i32(i32 %x, i32 1)
  %cmp = icmp ult i32 %y, %min
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp ult i32 %y, %x
  %cmp3 = icmp ule i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @umin_ule(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @umin_ule
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MIN:%.*]] = call i32 @llvm.umin.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i32 [[Y]], [[MIN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ule i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 [[CMP2]], true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %min = call i32 @llvm.umin.i32(i32 %x, i32 1)
  %cmp = icmp ule i32 %y, %min
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp ult i32 %y, %x
  %cmp3 = icmp ule i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @smax_sgt(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @smax_sgt
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MAX:%.*]] = call i32 @llvm.smax.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[Y]], [[MAX]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sgt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sge i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 true, true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %max = call i32 @llvm.smax.i32(i32 %x, i32 1)
  %cmp = icmp sgt i32 %y, %max
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp sgt i32 %y, %x
  %cmp3 = icmp sge i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @smax_sge(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @smax_sge
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MAX:%.*]] = call i32 @llvm.smax.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i32 [[Y]], [[MAX]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sgt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sge i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 [[CMP2]], true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %max = call i32 @llvm.smax.i32(i32 %x, i32 1)
  %cmp = icmp sge i32 %y, %max
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp sgt i32 %y, %x
  %cmp3 = icmp sge i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @smin_slt(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @smin_slt
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MIN:%.*]] = call i32 @llvm.smin.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[Y]], [[MIN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sle i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 true, true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %min = call i32 @llvm.smin.i32(i32 %x, i32 1)
  %cmp = icmp slt i32 %y, %min
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp slt i32 %y, %x
  %cmp3 = icmp sle i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @smin_sle(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @smin_sle
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MIN:%.*]] = call i32 @llvm.smin.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[Y]], [[MIN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sle i32 [[Y]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 [[CMP2]], true
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %min = call i32 @llvm.smin.i32(i32 %x, i32 1)
  %cmp = icmp sle i32 %y, %min
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp slt i32 %y, %x
  %cmp3 = icmp sle i32 %y, %x
  %ret = xor i1 %cmp2, %cmp3
  ret i1 %ret

end:
  ret i1 false
}

define i1 @umax_uge_ugt_with_add_nuw(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @umax_uge_ugt_with_add_nuw
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MAX:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[SUM:%.*]] = add nuw i32 [[MAX]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[Y]], [[SUM]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[Y]], [[X]]
; CHECK-NEXT:    ret i1 true
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %max = call i32 @llvm.umax.i32(i32 %x, i32 1)
  %sum = add nuw i32 %max, 1
  %cmp = icmp uge i32 %y, %sum
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp ugt i32 %y, %x
  ret i1 %cmp2

end:
  ret i1 false
}

define i1 @smin_ule_mixed(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @smin_ule_mixed
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[MIN:%.*]] = call i32 @llvm.smin.i32(i32 [[X]], i32 1)
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i32 [[Y]], [[MIN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sle i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP4:%.*]] = icmp ult i32 [[Y]], [[X]]
; CHECK-NEXT:    [[CMP5:%.*]] = icmp ule i32 [[Y]], [[X]]
; CHECK-NEXT:    [[XOR1:%.*]] = xor i1 [[CMP2]], [[CMP3]]
; CHECK-NEXT:    [[XOR2:%.*]] = xor i1 [[CMP4]], [[CMP5]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 [[XOR1]], [[XOR2]]
; CHECK-NEXT:    ret i1 [[RET]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %min = call i32 @llvm.smin.i32(i32 %x, i32 1)
  %cmp = icmp ule i32 %y, %min
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp slt i32 %y, %x
  %cmp3 = icmp sle i32 %y, %x
  %cmp4 = icmp ult i32 %y, %x
  %cmp5 = icmp ule i32 %y, %x
  %xor1 = xor i1 %cmp2, %cmp3
  %xor2 = xor i1 %cmp4, %cmp5
  %ret = xor i1 %xor1, %xor2
  ret i1 %ret

end:
  ret i1 false
}

define i1 @umax_ugt_ugt_both(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: define i1 @umax_ugt_ugt_both
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]], i32 [[Z:%.*]]) {
; CHECK-NEXT:    [[MAX:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[Z]], [[MAX]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[Z]], [[X]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ugt i32 [[Z]], [[Y]]
; CHECK-NEXT:    [[AND:%.*]] = xor i1 true, true
; CHECK-NEXT:    ret i1 [[AND]]
; CHECK:       end:
; CHECK-NEXT:    ret i1 false
;
  %max = call i32 @llvm.umax.i32(i32 %x, i32 %y)
  %cmp = icmp ugt i32 %z, %max
  br i1 %cmp, label %if, label %end

if:
  %cmp2 = icmp ugt i32 %z, %x
  %cmp3 = icmp ugt i32 %z, %y
  %and = xor i1 %cmp2, %cmp3
  ret i1 %and

end:
  ret i1 false
}

define i1 @smin_branchless(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @smin_branchless
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN:%.*]] = call i32 @llvm.smin.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sle i32 [[MIN]], [[X]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sgt i32 [[MIN]], [[X]]
; CHECK-NEXT:    [[RET:%.*]] = xor i1 true, false
; CHECK-NEXT:    ret i1 [[RET]]
;
entry:
  %min = call i32 @llvm.smin.i32(i32 %x, i32 %y)
  %cmp1 = icmp sle i32 %min, %x
  %cmp2 = icmp sgt i32 %min, %x
  %ret = xor i1 %cmp1, %cmp2
  ret i1 %ret
}

define i32 @simplify_smax(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: define i32 @simplify_smax
; CHECK-SAME: (i32 [[X:%.*]], i32 [[Y:%.*]], i32 [[Z:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[MAX1:%.*]] = call i32 @llvm.smax.i32(i32 [[X]], i32 [[Z]])
; CHECK-NEXT:    [[MAX2:%.*]] = call i32 @llvm.smax.i32(i32 [[Y]], i32 [[MAX1]])
; CHECK-NEXT:    ret i32 [[MAX2]]
; CHECK:       end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp slt i32 %x, %y
  br i1 %cmp, label %if, label %end
if:
  %max1 = call i32 @llvm.smax.i32(i32 %x, i32 %z)
  %max2 = call i32 @llvm.smax.i32(i32 %y, i32 %max1)
  ret i32 %max2
end:
  ret i32 0
}

declare i32 @llvm.smin.i32(i32, i32)
declare i32 @llvm.smax.i32(i32, i32)
declare i32 @llvm.umin.i32(i32, i32)
declare i32 @llvm.umax.i32(i32, i32)

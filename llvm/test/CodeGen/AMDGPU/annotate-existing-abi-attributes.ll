; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -mtriple=amdgcn-unknown-amdhsa -S -amdgpu-attributor %s | FileCheck %s

; Check handling for pre-existing attributes on function declarations

declare void @marked_no_workitem_id_x() "amdgpu-no-workitem-id-x"
declare void @marked_no_workitem_id_y() "amdgpu-no-workitem-id-y"
declare void @marked_no_workitem_id_z() "amdgpu-no-workitem-id-z"

declare void @marked_no_workgroup_id_x() "amdgpu-no-workgroup-id-x"
declare void @marked_no_workgroup_id_y() "amdgpu-no-workgroup-id-y"
declare void @marked_no_workgroup_id_z() "amdgpu-no-workgroup-id-z"

declare void @marked_no_dispatch_ptr() "amdgpu-no-dispatch-ptr"
declare void @marked_no_queue_ptr() "amdgpu-no-queue-ptr"
declare void @marked_no_implicitarg_ptr() "amdgpu-no-implicitarg-ptr"
declare void @marked_no_dispatch_id() "amdgpu-no-dispatch-id"


define void @call_no_workitem_id_x() {
; CHECK-LABEL: define {{[^@]+}}@call_no_workitem_id_x
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_workitem_id_x()
; CHECK-NEXT:    ret void
;
  call void @marked_no_workitem_id_x()
  ret void
}

define void @call_no_workitem_id_y() {
; CHECK-LABEL: define {{[^@]+}}@call_no_workitem_id_y
; CHECK-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_workitem_id_y()
; CHECK-NEXT:    ret void
;
  call void @marked_no_workitem_id_y()
  ret void
}

define void @call_no_workitem_id_z() {
; CHECK-LABEL: define {{[^@]+}}@call_no_workitem_id_z
; CHECK-SAME: () #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_workitem_id_z()
; CHECK-NEXT:    ret void
;
  call void @marked_no_workitem_id_z()
  ret void
}

define void @call_no_workgroup_id_x() {
; CHECK-LABEL: define {{[^@]+}}@call_no_workgroup_id_x
; CHECK-SAME: () #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_workgroup_id_x()
; CHECK-NEXT:    ret void
;
  call void @marked_no_workgroup_id_x()
  ret void
}

define void @call_no_workgroup_id_y() {
; CHECK-LABEL: define {{[^@]+}}@call_no_workgroup_id_y
; CHECK-SAME: () #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_workgroup_id_y()
; CHECK-NEXT:    ret void
;
  call void @marked_no_workgroup_id_y()
  ret void
}

define void @call_no_workgroup_id_z() {
; CHECK-LABEL: define {{[^@]+}}@call_no_workgroup_id_z
; CHECK-SAME: () #[[ATTR5:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_workgroup_id_z()
; CHECK-NEXT:    ret void
;
  call void @marked_no_workgroup_id_z()
  ret void
}

define void @call_no_dispatch_ptr() {
; CHECK-LABEL: define {{[^@]+}}@call_no_dispatch_ptr
; CHECK-SAME: () #[[ATTR6:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_dispatch_ptr()
; CHECK-NEXT:    ret void
;
  call void @marked_no_dispatch_ptr()
  ret void
}

define void @call_no_queue_ptr() {
; CHECK-LABEL: define {{[^@]+}}@call_no_queue_ptr
; CHECK-SAME: () #[[ATTR7:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_queue_ptr()
; CHECK-NEXT:    ret void
;
  call void @marked_no_queue_ptr()
  ret void
}

define void @call_no_implicitarg_ptr() {
; CHECK-LABEL: define {{[^@]+}}@call_no_implicitarg_ptr
; CHECK-SAME: () #[[ATTR8:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_implicitarg_ptr()
; CHECK-NEXT:    ret void
;
  call void @marked_no_implicitarg_ptr()
  ret void
}

define void @call_no_dispatch_id() {
; CHECK-LABEL: define {{[^@]+}}@call_no_dispatch_id
; CHECK-SAME: () #[[ATTR9:[0-9]+]] {
; CHECK-NEXT:    call void @marked_no_dispatch_id()
; CHECK-NEXT:    ret void
;
  call void @marked_no_dispatch_id()
  ret void
}
;.
; CHECK: attributes #[[ATTR0]] = { "amdgpu-no-workitem-id-x" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR1]] = { "amdgpu-no-workitem-id-y" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR2]] = { "amdgpu-no-workitem-id-z" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR3]] = { "amdgpu-no-workgroup-id-x" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR4]] = { "amdgpu-no-workgroup-id-y" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR5]] = { "amdgpu-no-workgroup-id-z" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR6]] = { "amdgpu-no-dispatch-ptr" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR7]] = { "amdgpu-no-queue-ptr" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR8]] = { "amdgpu-no-implicitarg-ptr" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR9]] = { "amdgpu-no-dispatch-id" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
;.

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -amdgpu-attributor %s | FileCheck %s

; Check propagation of amdgpu-flat-work-group-size attribute.

; Called from a single kernel with 1,256
define internal void @default_to_1_256() {
; CHECK-LABEL: define {{[^@]+}}@default_to_1_256
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

define amdgpu_kernel void @kernel_1_256() #0 {
; CHECK-LABEL: define {{[^@]+}}@kernel_1_256
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void @default_to_1_256()
; CHECK-NEXT:    ret void
;
  call void @default_to_1_256()
  ret void
}

; Called from a single kernel with 64,128
define internal void @default_to_64_128() {
; CHECK-LABEL: define {{[^@]+}}@default_to_64_128
; CHECK-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

define amdgpu_kernel void @kernel_64_128() #1 {
; CHECK-LABEL: define {{[^@]+}}@kernel_64_128
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    call void @default_to_64_128()
; CHECK-NEXT:    call void @flat_group_64_64()
; CHECK-NEXT:    call void @default_to_64_256()
; CHECK-NEXT:    call void @flat_group_128_256()
; CHECK-NEXT:    ret void
;
  call void @default_to_64_128()
  call void @flat_group_64_64()
  call void @default_to_64_256()
  call void @flat_group_128_256()
  ret void
}

; Called from kernels with 128,512 and 512,512
define internal void @default_to_128_512() {
; CHECK-LABEL: define {{[^@]+}}@default_to_128_512
; CHECK-SAME: () #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

; This already has a strict bounds, but called from kernels with wider
; bounds, and should not be changed.
define internal void @flat_group_64_64() #2 {
; CHECK-LABEL: define {{[^@]+}}@flat_group_64_64
; CHECK-SAME: () #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

; 128,256 -> 128,128
define internal void @flat_group_128_256() #3 {
; CHECK-LABEL: define {{[^@]+}}@flat_group_128_256
; CHECK-SAME: () #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

define internal void @flat_group_512_1024() #4 {
; CHECK-LABEL: define {{[^@]+}}@flat_group_512_1024
; CHECK-SAME: () #[[ATTR5:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

define amdgpu_kernel void @kernel_128_512() #5 {
; CHECK-LABEL: define {{[^@]+}}@kernel_128_512
; CHECK-SAME: () #[[ATTR2]] {
; CHECK-NEXT:    call void @default_to_128_512()
; CHECK-NEXT:    call void @flat_group_64_64()
; CHECK-NEXT:    ret void
;
  call void @default_to_128_512()
  call void @flat_group_64_64()
  ret void
}

define amdgpu_kernel void @kernel_512_512() #6 {
; CHECK-LABEL: define {{[^@]+}}@kernel_512_512
; CHECK-SAME: () #[[ATTR5]] {
; CHECK-NEXT:    call void @default_to_128_512()
; CHECK-NEXT:    call void @flat_group_512_1024()
; CHECK-NEXT:    ret void
;
  call void @default_to_128_512()
  call void @flat_group_512_1024()
  ret void
}

; Called from kernels with 128,256 and 64,128 => 64,256
define internal void @default_to_64_256() {
; CHECK-LABEL: define {{[^@]+}}@default_to_64_256
; CHECK-SAME: () #[[ATTR6:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

; The kernel's lower bound is higher than the callee's lower bound, so
; this should probably be illegal.
define amdgpu_kernel void @kernel_128_256() #3 {
; CHECK-LABEL: define {{[^@]+}}@kernel_128_256
; CHECK-SAME: () #[[ATTR7:[0-9]+]] {
; CHECK-NEXT:    call void @default_to_64_256()
; CHECK-NEXT:    ret void
;
  call void @default_to_64_256()
  ret void
}

; 64,128 -> 64,128
define internal void @merge_cycle_0() #1 {
; CHECK-LABEL: define {{[^@]+}}@merge_cycle_0
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    call void @merge_cycle_1()
; CHECK-NEXT:    ret void
;
  call void @merge_cycle_1()
  ret void
}

; 128,256 -> 128,128
define internal void @merge_cycle_1() #3 {
; CHECK-LABEL: define {{[^@]+}}@merge_cycle_1
; CHECK-SAME: () #[[ATTR4]] {
; CHECK-NEXT:    call void @merge_cycle_0()
; CHECK-NEXT:    ret void
;
  call void @merge_cycle_0()
  ret void
}

define amdgpu_kernel void @kernel_64_256() #7 {
; CHECK-LABEL: define {{[^@]+}}@kernel_64_256
; CHECK-SAME: () #[[ATTR6]] {
; CHECK-NEXT:    call void @merge_cycle_0()
; CHECK-NEXT:    call void @default_captured_address()
; CHECK-NEXT:    call void @externally_visible_default()
; CHECK-NEXT:    [[F32:%.*]] = call float @bitcasted_function()
; CHECK-NEXT:    ret void
;
  call void @merge_cycle_0()
  call void @default_captured_address()
  call void @externally_visible_default()
  %f32 = call float @bitcasted_function()
  ret void
}

define internal void @default_captured_address() {
; CHECK-LABEL: define {{[^@]+}}@default_captured_address
; CHECK-SAME: () #[[ATTR8:[0-9]+]] {
; CHECK-NEXT:    store volatile ptr @default_captured_address, ptr undef, align 8
; CHECK-NEXT:    ret void
;
  store volatile ptr @default_captured_address, ptr undef, align 8
  ret void
}

define void @externally_visible_default() {
; CHECK-LABEL: define {{[^@]+}}@externally_visible_default
; CHECK-SAME: () #[[ATTR8]] {
; CHECK-NEXT:    ret void
;
  ret void
}

; 1,1024 -> 64,256
define internal i32 @bitcasted_function() {
; CHECK-LABEL: define {{[^@]+}}@bitcasted_function
; CHECK-SAME: () #[[ATTR6]] {
; CHECK-NEXT:    ret i32 0
;
  ret i32 0
}

attributes #0 = { "amdgpu-flat-work-group-size"="1,256" }
attributes #1 = { "amdgpu-flat-work-group-size"="64,128" }
attributes #2 = { "amdgpu-flat-work-group-size"="64,64" }
attributes #3 = { "amdgpu-flat-work-group-size"="128,256" }
attributes #4 = { "amdgpu-flat-work-group-size"="512,1024" }
attributes #5 = { "amdgpu-flat-work-group-size"="128,512" }
attributes #6 = { "amdgpu-flat-work-group-size"="512,512" }
attributes #7 = { "amdgpu-flat-work-group-size"="64,256" }
;.
; CHECK: attributes #[[ATTR0]] = { "amdgpu-flat-work-group-size"="1,256" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR1]] = { "amdgpu-flat-work-group-size"="64,128" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR2]] = { "amdgpu-flat-work-group-size"="128,512" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "amdgpu-waves-per-eu"="2,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR3]] = { "amdgpu-flat-work-group-size"="64,64" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR4]] = { "amdgpu-flat-work-group-size"="128,128" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR5]] = { "amdgpu-flat-work-group-size"="512,512" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "amdgpu-waves-per-eu"="2,10" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR6]] = { "amdgpu-flat-work-group-size"="64,256" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR7]] = { "amdgpu-flat-work-group-size"="128,256" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; CHECK: attributes #[[ATTR8]] = { "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "amdgpu-waves-per-eu"="4,10" "uniform-work-group-size"="false" }
;.

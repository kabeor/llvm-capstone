; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=r600 -mcpu=cypress -verify-machineinstrs < %s | FileCheck -check-prefix=EG %s

; This test just checks that the compiler doesn't crash.

define amdgpu_kernel void @i8ptr_v16i8ptr(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; EG-LABEL: i8ptr_v16i8ptr:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
entry:
  %0 = load <16 x i8>, ptr addrspace(1) %in
  store <16 x i8> %0, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @f32_to_v2i16(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; EG-LABEL: f32_to_v2i16:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %load = load float, ptr addrspace(1) %in, align 4
  %bc = bitcast float %load to <2 x i16>
  store <2 x i16> %bc, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @v2i16_to_f32(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; EG-LABEL: v2i16_to_f32:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %load = load <2 x i16>, ptr addrspace(1) %in, align 4
  %bc = bitcast <2 x i16> %load to float
  store float %bc, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @v4i8_to_i32(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; EG-LABEL: v4i8_to_i32:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %load = load <4 x i8>, ptr addrspace(1) %in, align 4
  %bc = bitcast <4 x i8> %load to i32
  store i32 %bc, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @i32_to_v4i8(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; EG-LABEL: i32_to_v4i8:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %load = load i32, ptr addrspace(1) %in, align 4
  %bc = bitcast i32 %load to <4 x i8>
  store <4 x i8> %bc, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @v2i16_to_v4i8(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; EG-LABEL: v2i16_to_v4i8:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %load = load <2 x i16>, ptr  addrspace(1) %in, align 4
  %bc = bitcast <2 x i16> %load to <4 x i8>
  store <4 x i8> %bc, ptr addrspace(1) %out, align 4
  ret void
}

; This just checks for crash in BUILD_VECTOR/EXTRACT_ELEMENT combine
; the stack manipulation is tricky to follow
; TODO: This should only use one load
define amdgpu_kernel void @v4i16_extract_i8(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; EG-LABEL: v4i16_extract_i8:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @10, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 1 @6
; EG-NEXT:    ALU 17, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT MSKOR T5.XW, T6.X
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_16 T6.X, T5.X, 6, #1
; EG-NEXT:     VTX_READ_16 T5.X, T5.X, 4, #1
; EG-NEXT:    ALU clause starting at 10:
; EG-NEXT:     MOV * T5.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     LSHL * T0.W, T6.X, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     OR_INT * T0.W, PV.W, T5.X,
; EG-NEXT:     MOV * T3.X, PV.W,
; EG-NEXT:     MOV T0.Y, PV.X,
; EG-NEXT:     AND_INT T0.W, KC0[2].Y, literal.x,
; EG-NEXT:     MOV * T1.W, literal.y,
; EG-NEXT:    3(4.203895e-45), 8(1.121039e-44)
; EG-NEXT:     BFE_UINT T1.W, PV.Y, literal.x, PS,
; EG-NEXT:     LSHL * T0.W, PV.W, literal.y,
; EG-NEXT:    8(1.121039e-44), 3(4.203895e-45)
; EG-NEXT:     LSHL T5.X, PV.W, PS,
; EG-NEXT:     LSHL * T5.W, literal.x, PS,
; EG-NEXT:    255(3.573311e-43), 0(0.000000e+00)
; EG-NEXT:     MOV T5.Y, 0.0,
; EG-NEXT:     MOV * T5.Z, 0.0,
; EG-NEXT:     LSHR * T6.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %load = load <4 x i16>, ptr  addrspace(1) %in, align 2
  %bc = bitcast <4 x i16> %load to <8 x i8>
  %element = extractelement <8 x i8> %bc, i32 5
  store i8 %element, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @bitcast_v2i32_to_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; EG-LABEL: bitcast_v2i32_to_f64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %val = load <2 x i32>, ptr addrspace(1) %in, align 8
  %bc = bitcast <2 x i32> %val to double
  store double %bc, ptr addrspace(1) %out, align 8
  ret void
}


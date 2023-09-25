; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -march=amdgcn -mcpu=gfx900 < %s | FileCheck %s

declare { float, i32 } @llvm.frexp.f32.i32(float)
declare { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float>)
declare { <4 x float>, <4 x i32> } @llvm.frexp.v4f32.v4i32(<4 x float>)


define { float, i32 } @frexp_frexp(float %x) {
; CHECK-LABEL: frexp_frexp:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_frexp_mant_f32_e32 v2, v0
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v1, v0
; CHECK-NEXT:    v_mov_b32_e32 v0, v2
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %frexp0 = call { float, i32 } @llvm.frexp.f32.i32(float %x)
  %frexp0.0 = extractvalue { float, i32 } %frexp0, 0
  %frexp1 = call { float, i32 } @llvm.frexp.f32.i32(float %frexp0.0)
  ret { float, i32 } %frexp1
}

define { <2 x float>, <2 x i32> } @frexp_frexp_vector(<2 x float> %x) {
; CHECK-LABEL: frexp_frexp_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_frexp_mant_f32_e32 v4, v0
; CHECK-NEXT:    v_frexp_mant_f32_e32 v5, v1
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v2, v0
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v3, v1
; CHECK-NEXT:    v_mov_b32_e32 v0, v4
; CHECK-NEXT:    v_mov_b32_e32 v1, v5
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %frexp0 = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> %x)
  %frexp0.0 = extractvalue { <2 x float>, <2 x i32> } %frexp0, 0
  %frexp1 = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> %frexp0.0)
  ret { <2 x float>, <2 x i32> } %frexp1
}

define { float, i32 } @frexp_frexp_const(float %x) {
; CHECK-LABEL: frexp_frexp_const:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x3f280000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %frexp0 = call { float, i32 } @llvm.frexp.f32.i32(float 42.0)
  %frexp0.0 = extractvalue { float, i32 } %frexp0, 0
  %frexp1 = call { float, i32 } @llvm.frexp.f32.i32(float %frexp0.0)
  ret { float, i32 } %frexp1
}

define { float, i32 } @frexp_poison() {
; CHECK-LABEL: frexp_poison:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float poison)
  ret { float, i32 } %ret
}

define { <2 x float>, <2 x i32> } @frexp_poison_vector() {
; CHECK-LABEL: frexp_poison_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> poison)
  ret { <2 x float>, <2 x i32> } %ret
}

define { float, i32 } @frexp_undef() {
; CHECK-LABEL: frexp_undef:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_frexp_mant_f32_e32 v0, s4
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v1, s4
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float undef)
  ret { float, i32 } %ret
}
define { <2 x float>, <2 x i32> } @frexp_undef_vector() {
; CHECK-LABEL: frexp_undef_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_frexp_mant_f32_e32 v0, s4
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v2, s4
; CHECK-NEXT:    v_mov_b32_e32 v1, v0
; CHECK-NEXT:    v_mov_b32_e32 v3, v2
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> undef)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_zero_vector() {
; CHECK-LABEL: frexp_zero_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> zeroinitializer)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_zero_negzero_vector() {
; CHECK-LABEL: frexp_zero_negzero_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_bfrev_b32_e32 v1, 1
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0.0, float -0.0>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <4 x float>, <4 x i32> } @frexp_nonsplat_vector() {
; CHECK-LABEL: frexp_nonsplat_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_frexp_mant_f32_e32 v2, s4
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v6, s4
; CHECK-NEXT:    v_mov_b32_e32 v0, 0.5
; CHECK-NEXT:    v_mov_b32_e32 v1, -0.5
; CHECK-NEXT:    v_mov_b32_e32 v3, 0x3f1c3c00
; CHECK-NEXT:    v_mov_b32_e32 v4, 5
; CHECK-NEXT:    v_mov_b32_e32 v5, 6
; CHECK-NEXT:    v_mov_b32_e32 v7, 14
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <4 x float>, <4 x i32> } @llvm.frexp.v4f32.v4i32(<4 x float> <float 16.0, float -32.0, float undef, float 9999.0>)
  ret { <4 x float>, <4 x i32> } %ret
}

define { float, i32 } @frexp_zero() {
; CHECK-LABEL: frexp_zero:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_negzero() {
; CHECK-LABEL: frexp_negzero:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_bfrev_b32_e32 v0, 1
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float -0.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_one() {
; CHECK-LABEL: frexp_one:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0.5
; CHECK-NEXT:    v_mov_b32_e32 v1, 1
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 1.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_negone() {
; CHECK-LABEL: frexp_negone:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, -0.5
; CHECK-NEXT:    v_mov_b32_e32 v1, 1
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float -1.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_two() {
; CHECK-LABEL: frexp_two:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0.5
; CHECK-NEXT:    v_mov_b32_e32 v1, 2
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 2.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_negtwo() {
; CHECK-LABEL: frexp_negtwo:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, -0.5
; CHECK-NEXT:    v_mov_b32_e32 v1, 2
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float -2.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_inf() {
; CHECK-LABEL: frexp_inf:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x7f800000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0x7FF0000000000000)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_neginf() {
; CHECK-LABEL: frexp_neginf:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0xff800000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0xFFF0000000000000)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_qnan() {
; CHECK-LABEL: frexp_qnan:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x7fc00000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0x7FF8000000000000)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_snan() {
; CHECK-LABEL: frexp_snan:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x7fc00001
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float bitcast (i32 2139095041 to float))
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_pos_denorm() {
; CHECK-LABEL: frexp_pos_denorm:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x3f7ffffe
; CHECK-NEXT:    v_mov_b32_e32 v1, 0xffffff82
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float bitcast (i32 8388607 to float))
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_neg_denorm() {
; CHECK-LABEL: frexp_neg_denorm:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0xbf7ffffe
; CHECK-NEXT:    v_mov_b32_e32 v1, 0xffffff82
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float bitcast (i32 -2139095041 to float))
  ret { float, i32 } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_4() {
; CHECK-LABEL: frexp_splat_4:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0.5
; CHECK-NEXT:    v_mov_b32_e32 v1, 0.5
; CHECK-NEXT:    v_mov_b32_e32 v2, 3
; CHECK-NEXT:    v_mov_b32_e32 v3, 3
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 4.0, float 4.0>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_qnan() {
; CHECK-LABEL: frexp_splat_qnan:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x7fc00000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0x7fc00000
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0x7FF8000000000000, float 0x7FF8000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_inf() {
; CHECK-LABEL: frexp_splat_inf:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0x7f800000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0x7f800000
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0x7FF0000000000000, float 0x7FF0000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_neginf() {
; CHECK-LABEL: frexp_splat_neginf:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 0xff800000
; CHECK-NEXT:    v_mov_b32_e32 v1, 0xff800000
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0xFFF0000000000000, float 0xFFF0000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_undef_inf() {
; CHECK-LABEL: frexp_splat_undef_inf:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_frexp_mant_f32_e32 v0, s4
; CHECK-NEXT:    v_frexp_exp_i32_f32_e32 v2, s4
; CHECK-NEXT:    v_mov_b32_e32 v1, 0x7f800000
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float undef, float 0x7FF0000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

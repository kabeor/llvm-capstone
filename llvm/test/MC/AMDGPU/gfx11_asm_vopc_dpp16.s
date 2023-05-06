// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s | FileCheck --check-prefix=W32 %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s | FileCheck --check-prefix=W64 %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 %s 2>&1 | FileCheck --check-prefix=W32-ERR --implicit-check-not=error: %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 %s 2>&1 | FileCheck --check-prefix=W64-ERR --implicit-check-not=error: %s

v_cmp_class_f16_dpp vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, -|v127|, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0xfa,0x7c,0x7f,0x6f,0x3d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0xfa,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, -|v127|, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0xfa,0x7c,0x7f,0x6f,0x3d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, -|v255|, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0xfd,0x7c,0xff,0x6f,0x3d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0xfc,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, -|v255|, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0xfd,0x7c,0xff,0x6f,0x3d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x04,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x04,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x04,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x25,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x24,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x25,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x64,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x64,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x64,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x85,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x84,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x85,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x74,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x74,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x74,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x95,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x94,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x95,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x00,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x00,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x00,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x21,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x20,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x21,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x81,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x80,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x81,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x91,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x90,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_f_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x91,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x0c,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x0c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x0c,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x2d,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x2c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x2d,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x6c,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x6c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x6c,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x8d,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x8c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x8d,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x7c,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x7c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x7c,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x9d,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x9c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x9d,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x08,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x08,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x08,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x29,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x28,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x29,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x68,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x68,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x68,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x89,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x88,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x89,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x78,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x78,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x78,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x99,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x98,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x99,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x06,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x06,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x06,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x27,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x27,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x66,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x66,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x66,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x87,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x86,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x87,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x76,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x76,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x76,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x97,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x96,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x97,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x0a,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x0a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x0a,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x2b,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x2a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x2b,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x02,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x02,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x02,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x23,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x22,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x23,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x62,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x62,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x62,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x83,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x82,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x83,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x72,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x72,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x72,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x93,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x92,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x93,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x6a,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x6a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x6a,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x8b,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x8a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x8b,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x7a,0x7c,0x7f,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x7a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v127, v127 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x7a,0x7c,0x7f,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x9b,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x9a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x9b,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x1a,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x1a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x1a,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x3b,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x3a,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x3b,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x12,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x12,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x12,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x33,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x32,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x33,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x16,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x16,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x16,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x37,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x36,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x37,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x18,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x18,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x18,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x39,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x38,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x39,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x14,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x14,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x14,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x35,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x34,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x35,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x1c,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x1c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x1c,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x3d,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x3c,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x3d,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x0e,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x0e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x0e,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x2f,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x2e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x2f,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x1e,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x1e,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x3f,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x3f,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x8f,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x8e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_i32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x8f,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc_lo, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x9f,0x7c,0xff,0x6f,0x0d,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x9e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_t_u32 vcc, v255, v255 row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x9f,0x7c,0xff,0x6f,0x0d,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x1e,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x1e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x1e,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x3f,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x3e,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_tru_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x3f,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x10,0x7c,0x7f,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x10,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, -|v127|, -|v127| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x10,0x7c,0x7f,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 quad_perm:[3,2,1,0]
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x1b,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 quad_perm:[0,1,2,3]
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0xe4,0x00,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_mirror
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x40,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_half_mirror
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x41,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_shl:1
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x01,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_shl:15
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x0f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_shr:1
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x11,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_shr:15
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x1f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_ror:1
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x21,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_ror:15
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x2f,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x50,0x01,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x5f,0x01,0x01]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W32: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x60,0x09,0x13]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W32: encoding: [0xfa,0xfe,0x31,0x7c,0xff,0x6f,0xfd,0x30]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 quad_perm:[3,2,1,0]
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x1b,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 quad_perm:[0,1,2,3]
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0xe4,0x00,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_mirror
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x40,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_half_mirror
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x41,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_shl:1
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x01,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_shl:15
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x0f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_shr:1
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x11,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_shr:15
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x1f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_ror:1
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x21,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_ror:15
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x2f,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_share:0 row_mask:0xf bank_mask:0xf
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x50,0x01,0xff]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_share:15 row_mask:0x0 bank_mask:0x1
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x5f,0x01,0x01]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2 row_xmask:0 row_mask:0x1 bank_mask:0x3 bound_ctrl:1 fi:0
// W64: encoding: [0xfa,0x04,0x30,0x7c,0x01,0x60,0x09,0x13]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, -|v255|, -|v255| row_xmask:15 row_mask:0x3 bank_mask:0x0 bound_ctrl:0 fi:1
// W64: encoding: [0xfa,0xfe,0x31,0x7c,0xff,0x6f,0xfd,0x30]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

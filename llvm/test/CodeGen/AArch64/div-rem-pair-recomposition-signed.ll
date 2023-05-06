; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s --check-prefix=ALL

; If the target does not have a single div/rem operation,
; -div-rem-pairs pass will decompose the remainder calculation as:
;   X % Y --> X - ((X / Y) * Y)
; But if the target does have a single div/rem operation,
; the opposite transform is likely beneficial.

define i8 @scalar_i8(i8 %x, i8 %y, ptr %divdst) nounwind {
; ALL-LABEL: scalar_i8:
; ALL:       // %bb.0:
; ALL-NEXT:    sxtb w8, w1
; ALL-NEXT:    sxtb w9, w0
; ALL-NEXT:    sdiv w8, w9, w8
; ALL-NEXT:    msub w0, w8, w1, w0
; ALL-NEXT:    strb w8, [x2]
; ALL-NEXT:    ret
  %div = sdiv i8 %x, %y
  store i8 %div, ptr %divdst, align 4
  %t1 = mul i8 %div, %y
  %t2 = sub i8 %x, %t1
  ret i8 %t2
}

define i16 @scalar_i16(i16 %x, i16 %y, ptr %divdst) nounwind {
; ALL-LABEL: scalar_i16:
; ALL:       // %bb.0:
; ALL-NEXT:    sxth w8, w1
; ALL-NEXT:    sxth w9, w0
; ALL-NEXT:    sdiv w8, w9, w8
; ALL-NEXT:    msub w0, w8, w1, w0
; ALL-NEXT:    strh w8, [x2]
; ALL-NEXT:    ret
  %div = sdiv i16 %x, %y
  store i16 %div, ptr %divdst, align 4
  %t1 = mul i16 %div, %y
  %t2 = sub i16 %x, %t1
  ret i16 %t2
}

define i32 @scalar_i32(i32 %x, i32 %y, ptr %divdst) nounwind {
; ALL-LABEL: scalar_i32:
; ALL:       // %bb.0:
; ALL-NEXT:    sdiv w8, w0, w1
; ALL-NEXT:    msub w0, w8, w1, w0
; ALL-NEXT:    str w8, [x2]
; ALL-NEXT:    ret
  %div = sdiv i32 %x, %y
  store i32 %div, ptr %divdst, align 4
  %t1 = mul i32 %div, %y
  %t2 = sub i32 %x, %t1
  ret i32 %t2
}

define i64 @scalar_i64(i64 %x, i64 %y, ptr %divdst) nounwind {
; ALL-LABEL: scalar_i64:
; ALL:       // %bb.0:
; ALL-NEXT:    sdiv x8, x0, x1
; ALL-NEXT:    msub x0, x8, x1, x0
; ALL-NEXT:    str x8, [x2]
; ALL-NEXT:    ret
  %div = sdiv i64 %x, %y
  store i64 %div, ptr %divdst, align 4
  %t1 = mul i64 %div, %y
  %t2 = sub i64 %x, %t1
  ret i64 %t2
}

define <16 x i8> @vector_i128_i8(<16 x i8> %x, <16 x i8> %y, ptr %divdst) nounwind {
; ALL-LABEL: vector_i128_i8:
; ALL:       // %bb.0:
; ALL-NEXT:    smov w8, v1.b[1]
; ALL-NEXT:    smov w9, v0.b[1]
; ALL-NEXT:    smov w10, v0.b[0]
; ALL-NEXT:    smov w11, v0.b[2]
; ALL-NEXT:    smov w12, v0.b[3]
; ALL-NEXT:    smov w13, v0.b[4]
; ALL-NEXT:    smov w14, v0.b[5]
; ALL-NEXT:    smov w15, v0.b[6]
; ALL-NEXT:    sdiv w8, w9, w8
; ALL-NEXT:    smov w9, v1.b[0]
; ALL-NEXT:    smov w16, v0.b[7]
; ALL-NEXT:    smov w17, v0.b[8]
; ALL-NEXT:    sdiv w9, w10, w9
; ALL-NEXT:    smov w10, v1.b[2]
; ALL-NEXT:    sdiv w10, w11, w10
; ALL-NEXT:    smov w11, v1.b[3]
; ALL-NEXT:    fmov s2, w9
; ALL-NEXT:    smov w9, v1.b[9]
; ALL-NEXT:    mov v2.b[1], w8
; ALL-NEXT:    sdiv w11, w12, w11
; ALL-NEXT:    smov w12, v1.b[4]
; ALL-NEXT:    mov v2.b[2], w10
; ALL-NEXT:    smov w10, v0.b[10]
; ALL-NEXT:    sdiv w12, w13, w12
; ALL-NEXT:    smov w13, v1.b[5]
; ALL-NEXT:    mov v2.b[3], w11
; ALL-NEXT:    smov w11, v0.b[11]
; ALL-NEXT:    sdiv w13, w14, w13
; ALL-NEXT:    smov w14, v1.b[6]
; ALL-NEXT:    mov v2.b[4], w12
; ALL-NEXT:    smov w12, v0.b[12]
; ALL-NEXT:    sdiv w14, w15, w14
; ALL-NEXT:    smov w15, v1.b[7]
; ALL-NEXT:    mov v2.b[5], w13
; ALL-NEXT:    smov w13, v0.b[13]
; ALL-NEXT:    sdiv w15, w16, w15
; ALL-NEXT:    smov w16, v1.b[8]
; ALL-NEXT:    mov v2.b[6], w14
; ALL-NEXT:    sdiv w16, w17, w16
; ALL-NEXT:    smov w17, v0.b[9]
; ALL-NEXT:    mov v2.b[7], w15
; ALL-NEXT:    sdiv w8, w17, w9
; ALL-NEXT:    smov w9, v1.b[10]
; ALL-NEXT:    mov v2.b[8], w16
; ALL-NEXT:    sdiv w9, w10, w9
; ALL-NEXT:    smov w10, v1.b[11]
; ALL-NEXT:    mov v2.b[9], w8
; ALL-NEXT:    sdiv w10, w11, w10
; ALL-NEXT:    smov w11, v1.b[12]
; ALL-NEXT:    mov v2.b[10], w9
; ALL-NEXT:    smov w9, v1.b[14]
; ALL-NEXT:    sdiv w11, w12, w11
; ALL-NEXT:    smov w12, v1.b[13]
; ALL-NEXT:    mov v2.b[11], w10
; ALL-NEXT:    smov w10, v1.b[15]
; ALL-NEXT:    sdiv w8, w13, w12
; ALL-NEXT:    smov w12, v0.b[14]
; ALL-NEXT:    mov v2.b[12], w11
; ALL-NEXT:    smov w11, v0.b[15]
; ALL-NEXT:    sdiv w9, w12, w9
; ALL-NEXT:    mov v2.b[13], w8
; ALL-NEXT:    sdiv w8, w11, w10
; ALL-NEXT:    mov v2.b[14], w9
; ALL-NEXT:    mov v2.b[15], w8
; ALL-NEXT:    mls v0.16b, v2.16b, v1.16b
; ALL-NEXT:    str q2, [x0]
; ALL-NEXT:    ret
  %div = sdiv <16 x i8> %x, %y
  store <16 x i8> %div, ptr %divdst, align 16
  %t1 = mul <16 x i8> %div, %y
  %t2 = sub <16 x i8> %x, %t1
  ret <16 x i8> %t2
}

define <8 x i16> @vector_i128_i16(<8 x i16> %x, <8 x i16> %y, ptr %divdst) nounwind {
; ALL-LABEL: vector_i128_i16:
; ALL:       // %bb.0:
; ALL-NEXT:    smov w8, v1.h[1]
; ALL-NEXT:    smov w9, v0.h[1]
; ALL-NEXT:    smov w10, v0.h[0]
; ALL-NEXT:    smov w11, v0.h[2]
; ALL-NEXT:    smov w12, v0.h[3]
; ALL-NEXT:    smov w13, v0.h[4]
; ALL-NEXT:    sdiv w8, w9, w8
; ALL-NEXT:    smov w9, v1.h[0]
; ALL-NEXT:    sdiv w9, w10, w9
; ALL-NEXT:    smov w10, v1.h[2]
; ALL-NEXT:    sdiv w10, w11, w10
; ALL-NEXT:    smov w11, v1.h[3]
; ALL-NEXT:    fmov s2, w9
; ALL-NEXT:    smov w9, v1.h[5]
; ALL-NEXT:    mov v2.h[1], w8
; ALL-NEXT:    sdiv w11, w12, w11
; ALL-NEXT:    smov w12, v1.h[4]
; ALL-NEXT:    mov v2.h[2], w10
; ALL-NEXT:    smov w10, v0.h[6]
; ALL-NEXT:    sdiv w12, w13, w12
; ALL-NEXT:    smov w13, v0.h[5]
; ALL-NEXT:    mov v2.h[3], w11
; ALL-NEXT:    smov w11, v0.h[7]
; ALL-NEXT:    sdiv w8, w13, w9
; ALL-NEXT:    smov w9, v1.h[6]
; ALL-NEXT:    mov v2.h[4], w12
; ALL-NEXT:    sdiv w9, w10, w9
; ALL-NEXT:    smov w10, v1.h[7]
; ALL-NEXT:    mov v2.h[5], w8
; ALL-NEXT:    sdiv w8, w11, w10
; ALL-NEXT:    mov v2.h[6], w9
; ALL-NEXT:    mov v2.h[7], w8
; ALL-NEXT:    mls v0.8h, v2.8h, v1.8h
; ALL-NEXT:    str q2, [x0]
; ALL-NEXT:    ret
  %div = sdiv <8 x i16> %x, %y
  store <8 x i16> %div, ptr %divdst, align 16
  %t1 = mul <8 x i16> %div, %y
  %t2 = sub <8 x i16> %x, %t1
  ret <8 x i16> %t2
}

define <4 x i32> @vector_i128_i32(<4 x i32> %x, <4 x i32> %y, ptr %divdst) nounwind {
; ALL-LABEL: vector_i128_i32:
; ALL:       // %bb.0:
; ALL-NEXT:    mov w8, v1.s[1]
; ALL-NEXT:    mov w9, v0.s[1]
; ALL-NEXT:    fmov w10, s0
; ALL-NEXT:    mov w11, v0.s[2]
; ALL-NEXT:    mov w12, v0.s[3]
; ALL-NEXT:    sdiv w8, w9, w8
; ALL-NEXT:    fmov w9, s1
; ALL-NEXT:    sdiv w9, w10, w9
; ALL-NEXT:    mov w10, v1.s[2]
; ALL-NEXT:    sdiv w10, w11, w10
; ALL-NEXT:    mov w11, v1.s[3]
; ALL-NEXT:    fmov s2, w9
; ALL-NEXT:    mov v2.s[1], w8
; ALL-NEXT:    sdiv w8, w12, w11
; ALL-NEXT:    mov v2.s[2], w10
; ALL-NEXT:    mov v2.s[3], w8
; ALL-NEXT:    mls v0.4s, v2.4s, v1.4s
; ALL-NEXT:    str q2, [x0]
; ALL-NEXT:    ret
  %div = sdiv <4 x i32> %x, %y
  store <4 x i32> %div, ptr %divdst, align 16
  %t1 = mul <4 x i32> %div, %y
  %t2 = sub <4 x i32> %x, %t1
  ret <4 x i32> %t2
}

define <2 x i64> @vector_i128_i64(<2 x i64> %x, <2 x i64> %y, ptr %divdst) nounwind {
; ALL-LABEL: vector_i128_i64:
; ALL:       // %bb.0:
; ALL-NEXT:    fmov x8, d1
; ALL-NEXT:    fmov x9, d0
; ALL-NEXT:    mov x10, v1.d[1]
; ALL-NEXT:    mov x11, v0.d[1]
; ALL-NEXT:    sdiv x9, x9, x8
; ALL-NEXT:    mul x8, x9, x8
; ALL-NEXT:    sdiv x11, x11, x10
; ALL-NEXT:    fmov d2, x9
; ALL-NEXT:    fmov d1, x8
; ALL-NEXT:    mul x10, x11, x10
; ALL-NEXT:    mov v2.d[1], x11
; ALL-NEXT:    mov v1.d[1], x10
; ALL-NEXT:    str q2, [x0]
; ALL-NEXT:    sub v0.2d, v0.2d, v1.2d
; ALL-NEXT:    ret
  %div = sdiv <2 x i64> %x, %y
  store <2 x i64> %div, ptr %divdst, align 16
  %t1 = mul <2 x i64> %div, %y
  %t2 = sub <2 x i64> %x, %t1
  ret <2 x i64> %t2
}

; Special tests.

define i32 @scalar_i32_commutative(i32 %x, ptr %ysrc, ptr %divdst) nounwind {
; ALL-LABEL: scalar_i32_commutative:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr w8, [x1]
; ALL-NEXT:    sdiv w9, w0, w8
; ALL-NEXT:    msub w0, w8, w9, w0
; ALL-NEXT:    str w9, [x2]
; ALL-NEXT:    ret
  %y = load i32, ptr %ysrc, align 4
  %div = sdiv i32 %x, %y
  store i32 %div, ptr %divdst, align 4
  %t1 = mul i32 %y, %div ; commutative
  %t2 = sub i32 %x, %t1
  ret i32 %t2
}

; We do not care about extra uses.
define i32 @extrause(i32 %x, i32 %y, ptr %divdst, ptr %t1dst) nounwind {
; ALL-LABEL: extrause:
; ALL:       // %bb.0:
; ALL-NEXT:    sdiv w8, w0, w1
; ALL-NEXT:    mul w9, w8, w1
; ALL-NEXT:    str w8, [x2]
; ALL-NEXT:    sub w0, w0, w9
; ALL-NEXT:    str w9, [x3]
; ALL-NEXT:    ret
  %div = sdiv i32 %x, %y
  store i32 %div, ptr %divdst, align 4
  %t1 = mul i32 %div, %y
  store i32 %t1, ptr %t1dst, align 4
  %t2 = sub i32 %x, %t1
  ret i32 %t2
}

; 'rem' should appear next to 'div'.
define i32 @multiple_bb(i32 %x, i32 %y, ptr %divdst, i1 zeroext %store_srem, ptr %sremdst) nounwind {
; ALL-LABEL: multiple_bb:
; ALL:       // %bb.0:
; ALL-NEXT:    mov w8, w0
; ALL-NEXT:    sdiv w0, w0, w1
; ALL-NEXT:    str w0, [x2]
; ALL-NEXT:    cbz w3, .LBB10_2
; ALL-NEXT:  // %bb.1: // %do_srem
; ALL-NEXT:    msub w8, w0, w1, w8
; ALL-NEXT:    str w8, [x4]
; ALL-NEXT:  .LBB10_2: // %end
; ALL-NEXT:    ret
  %div = sdiv i32 %x, %y
  store i32 %div, ptr %divdst, align 4
  br i1 %store_srem, label %do_srem, label %end
do_srem:
  %t1 = mul i32 %div, %y
  %t2 = sub i32 %x, %t1
  store i32 %t2, ptr %sremdst, align 4
  br label %end
end:
  ret i32 %div
}

define i32 @negative_different_x(i32 %x0, i32 %x1, i32 %y, ptr %divdst) nounwind {
; ALL-LABEL: negative_different_x:
; ALL:       // %bb.0:
; ALL-NEXT:    sdiv w8, w0, w2
; ALL-NEXT:    msub w0, w8, w2, w1
; ALL-NEXT:    str w8, [x3]
; ALL-NEXT:    ret
  %div = sdiv i32 %x0, %y ; not %x1
  store i32 %div, ptr %divdst, align 4
  %t1 = mul i32 %div, %y
  %t2 = sub i32 %x1, %t1 ; not %x0
  ret i32 %t2
}

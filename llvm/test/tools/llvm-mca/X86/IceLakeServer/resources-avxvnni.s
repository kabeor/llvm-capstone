# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=icelake-server -instruction-tables < %s | FileCheck %s

vpdpbusd    %xmm0, %xmm1, %xmm2
vpdpbusd    (%rax), %xmm1, %xmm2

vpdpbusd    %ymm0, %ymm1, %ymm2
vpdpbusd    (%rax), %ymm1, %ymm2

vpdpbusds   %xmm0, %xmm1, %xmm2
vpdpbusds   (%rax), %xmm1, %xmm2

vpdpbusds   %ymm0, %ymm1, %ymm2
vpdpbusds   (%rax), %ymm1, %ymm2

vpdpwssd    %xmm0, %xmm1, %xmm2
vpdpwssd    (%rax), %xmm1, %xmm2

vpdpwssd    %ymm0, %ymm1, %ymm2
vpdpwssd    (%rax), %ymm1, %ymm2

vpdpwssds   %xmm0, %xmm1, %xmm2
vpdpwssds   (%rax), %xmm1, %xmm2

vpdpwssds   %ymm0, %ymm1, %ymm2
vpdpwssds   (%rax), %ymm1, %ymm2

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      5     0.50                        vpdpbusd	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  2      11    0.50    *                   vpdpbusd	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  1      5     0.50                        vpdpbusd	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  2      12    0.50    *                   vpdpbusd	(%rax), %ymm1, %ymm2
# CHECK-NEXT:  1      5     0.50                        vpdpbusds	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  2      11    0.50    *                   vpdpbusds	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  1      5     0.50                        vpdpbusds	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  2      12    0.50    *                   vpdpbusds	(%rax), %ymm1, %ymm2
# CHECK-NEXT:  1      5     0.50                        vpdpwssd	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  2      11    0.50    *                   vpdpwssd	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  1      5     0.50                        vpdpwssd	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  2      12    0.50    *                   vpdpwssd	(%rax), %ymm1, %ymm2
# CHECK-NEXT:  1      5     0.50                        vpdpwssds	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  2      11    0.50    *                   vpdpwssds	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  1      5     0.50                        vpdpwssds	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  2      12    0.50    *                   vpdpwssds	(%rax), %ymm1, %ymm2

# CHECK:      Resources:
# CHECK-NEXT: [0]   - ICXDivider
# CHECK-NEXT: [1]   - ICXFPDivider
# CHECK-NEXT: [2]   - ICXPort0
# CHECK-NEXT: [3]   - ICXPort1
# CHECK-NEXT: [4]   - ICXPort2
# CHECK-NEXT: [5]   - ICXPort3
# CHECK-NEXT: [6]   - ICXPort4
# CHECK-NEXT: [7]   - ICXPort5
# CHECK-NEXT: [8]   - ICXPort6
# CHECK-NEXT: [9]   - ICXPort7
# CHECK-NEXT: [10]  - ICXPort8
# CHECK-NEXT: [11]  - ICXPort9

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]
# CHECK-NEXT:  -      -     8.00   8.00   4.00   4.00    -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   Instructions:
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpbusd	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpbusd	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpbusd	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpbusd	(%rax), %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpbusds	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpbusds	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpbusds	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpbusds	(%rax), %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpwssd	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpwssd	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpwssd	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpwssd	(%rax), %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpwssds	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpwssds	(%rax), %xmm1, %xmm2
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -      -      -      -      -      -     vpdpwssds	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  -      -     0.50   0.50   0.50   0.50    -      -      -      -      -      -     vpdpwssds	(%rax), %ymm1, %ymm2

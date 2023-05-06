// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump --no-print-imm-hex -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump --no-print-imm-hex -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN

addpl   x21, x21, #0
// CHECK-INST: addpl   x21, x21, #0
// CHECK-ENCODING: [0x15,0x50,0x75,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04755015 <unknown>

addpl   x23, x8, #-1
// CHECK-INST: addpl   x23, x8, #-1
// CHECK-ENCODING: [0xf7,0x57,0x68,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 046857f7 <unknown>

addpl   sp, sp, #31
// CHECK-INST: addpl   sp, sp, #31
// CHECK-ENCODING: [0xff,0x53,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 047f53ff <unknown>

addpl   x0, x0, #-32
// CHECK-INST: addpl   x0, x0, #-32
// CHECK-ENCODING: [0x00,0x54,0x60,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04605400 <unknown>

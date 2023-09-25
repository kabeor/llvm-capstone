; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

@GInt1 = internal global i32 undef, align 4
@GInt2 = internal global i32 zeroinitializer, align 4
@GInt3 = internal global i32 undef, align 4
@GInt4 = internal global i32 zeroinitializer, align 4
@GInt5 = internal global i32 undef, align 4

declare void @llvm.assume(i1)
declare void @useI32(i32) nosync nocallback
declare void @free(ptr) allockind("free") "alloc-family"="malloc"
declare noalias ptr @calloc(i64, i64) allockind("alloc,zeroed") allocsize(0, 1) "alloc-family"="malloc"

;.
; CHECK: @[[GINT1:[a-zA-Z0-9_$"\\.-]+]] = internal global i32 undef, align 4
; CHECK: @[[GINT2:[a-zA-Z0-9_$"\\.-]+]] = internal global i32 0, align 4
; CHECK: @[[GINT3:[a-zA-Z0-9_$"\\.-]+]] = internal global i32 undef, align 4
; CHECK: @[[GINT4:[a-zA-Z0-9_$"\\.-]+]] = internal global i32 0, align 4
; CHECK: @[[GINT5:[a-zA-Z0-9_$"\\.-]+]] = internal global i32 undef, align 4
;.
define internal void @write1ToGInt1() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; CHECK-LABEL: define {{[^@]+}}@write1ToGInt1
; CHECK-SAME: () #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    store i32 1, ptr @GInt1, align 4
; CHECK-NEXT:    ret void
;
  store i32 1, ptr @GInt1
  ret void
}

define internal void @write1ToGInt2() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; CHECK-LABEL: define {{[^@]+}}@write1ToGInt2
; CHECK-SAME: () #[[ATTR4]] {
; CHECK-NEXT:    store i32 1, ptr @GInt2, align 4
; CHECK-NEXT:    ret void
;
  store i32 1, ptr @GInt2
  ret void
}

define void @entry1(i1 %c, i32 %v) {
; TUNIT: Function Attrs: norecurse nosync
; TUNIT-LABEL: define {{[^@]+}}@entry1
; TUNIT-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5:[0-9]+]] {
; TUNIT-NEXT:    [[L0:%.*]] = load i32, ptr @GInt1, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L0]])
; TUNIT-NEXT:    call void @write1ToGInt1() #[[ATTR10:[0-9]+]]
; TUNIT-NEXT:    [[L1:%.*]] = load i32, ptr @GInt1, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L1]])
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       T:
; TUNIT-NEXT:    store i32 [[V]], ptr @GInt1, align 4
; TUNIT-NEXT:    [[L2:%.*]] = load i32, ptr @GInt1, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L2]])
; TUNIT-NEXT:    br label [[F]]
; TUNIT:       F:
; TUNIT-NEXT:    [[L3:%.*]] = load i32, ptr @GInt1, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L3]])
; TUNIT-NEXT:    call void @write1ToGInt1() #[[ATTR10]]
; TUNIT-NEXT:    [[L4:%.*]] = load i32, ptr @GInt1, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L4]])
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync
; CGSCC-LABEL: define {{[^@]+}}@entry1
; CGSCC-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5:[0-9]+]] {
; CGSCC-NEXT:    [[L0:%.*]] = load i32, ptr @GInt1, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L0]])
; CGSCC-NEXT:    call void @write1ToGInt1() #[[ATTR10:[0-9]+]]
; CGSCC-NEXT:    [[L1:%.*]] = load i32, ptr @GInt1, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L1]])
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       T:
; CGSCC-NEXT:    store i32 [[V]], ptr @GInt1, align 4
; CGSCC-NEXT:    [[L2:%.*]] = load i32, ptr @GInt1, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L2]])
; CGSCC-NEXT:    br label [[F]]
; CGSCC:       F:
; CGSCC-NEXT:    [[L3:%.*]] = load i32, ptr @GInt1, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L3]])
; CGSCC-NEXT:    call void @write1ToGInt1() #[[ATTR10]]
; CGSCC-NEXT:    [[L4:%.*]] = load i32, ptr @GInt1, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L4]])
; CGSCC-NEXT:    ret void
;
  %l0 = load i32, ptr @GInt1
  call void @useI32(i32 %l0)
  call void @write1ToGInt1();
  %l1 = load i32, ptr @GInt1
  call void @useI32(i32 %l1)
  br i1 %c, label %T, label %F
T:
  store i32 %v, ptr @GInt1
  %l2 = load i32, ptr @GInt1
  call void @useI32(i32 %l2)
  br label %F
F:
  %l3 = load i32, ptr @GInt1
  call void @useI32(i32 %l3)
  call void @write1ToGInt1();
  %l4 = load i32, ptr @GInt1
  call void @useI32(i32 %l4)
  ret void
}

define void @entry2(i1 %c, i32 %v) {
; TUNIT: Function Attrs: norecurse nosync
; TUNIT-LABEL: define {{[^@]+}}@entry2
; TUNIT-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5]] {
; TUNIT-NEXT:    [[L0:%.*]] = load i32, ptr @GInt2, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L0]])
; TUNIT-NEXT:    call void @write1ToGInt2() #[[ATTR10]]
; TUNIT-NEXT:    [[L1:%.*]] = load i32, ptr @GInt2, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L1]])
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       T:
; TUNIT-NEXT:    store i32 [[V]], ptr @GInt2, align 4
; TUNIT-NEXT:    [[L2:%.*]] = load i32, ptr @GInt2, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L2]])
; TUNIT-NEXT:    br label [[F]]
; TUNIT:       F:
; TUNIT-NEXT:    [[L3:%.*]] = load i32, ptr @GInt2, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L3]])
; TUNIT-NEXT:    call void @write1ToGInt2() #[[ATTR10]]
; TUNIT-NEXT:    [[L4:%.*]] = load i32, ptr @GInt2, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L4]])
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync
; CGSCC-LABEL: define {{[^@]+}}@entry2
; CGSCC-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5]] {
; CGSCC-NEXT:    [[L0:%.*]] = load i32, ptr @GInt2, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L0]])
; CGSCC-NEXT:    call void @write1ToGInt2() #[[ATTR10]]
; CGSCC-NEXT:    [[L1:%.*]] = load i32, ptr @GInt2, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L1]])
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       T:
; CGSCC-NEXT:    store i32 [[V]], ptr @GInt2, align 4
; CGSCC-NEXT:    [[L2:%.*]] = load i32, ptr @GInt2, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L2]])
; CGSCC-NEXT:    br label [[F]]
; CGSCC:       F:
; CGSCC-NEXT:    [[L3:%.*]] = load i32, ptr @GInt2, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L3]])
; CGSCC-NEXT:    call void @write1ToGInt2() #[[ATTR10]]
; CGSCC-NEXT:    [[L4:%.*]] = load i32, ptr @GInt2, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L4]])
; CGSCC-NEXT:    ret void
;
  %l0 = load i32, ptr @GInt2
  call void @useI32(i32 %l0)
  call void @write1ToGInt2();
  %l1 = load i32, ptr @GInt2
  call void @useI32(i32 %l1)
  br i1 %c, label %T, label %F
T:
  store i32 %v, ptr @GInt2
  %l2 = load i32, ptr @GInt2
  call void @useI32(i32 %l2)
  br label %F
F:
  %l3 = load i32, ptr @GInt2
  call void @useI32(i32 %l3)
  call void @write1ToGInt2();
  %l4 = load i32, ptr @GInt2
  call void @useI32(i32 %l4)
  ret void
}
define void @entry3(i1 %c, i32 %v) {
; TUNIT: Function Attrs: norecurse nosync
; TUNIT-LABEL: define {{[^@]+}}@entry3
; TUNIT-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5]] {
; TUNIT-NEXT:    call void @useI32(i32 1)
; TUNIT-NEXT:    store i32 1, ptr @GInt3, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef 1)
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       T:
; TUNIT-NEXT:    store i32 [[V]], ptr @GInt3, align 4
; TUNIT-NEXT:    [[L2:%.*]] = load i32, ptr @GInt3, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L2]])
; TUNIT-NEXT:    br label [[F]]
; TUNIT:       F:
; TUNIT-NEXT:    [[L3:%.*]] = load i32, ptr @GInt3, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L3]])
; TUNIT-NEXT:    store i32 1, ptr @GInt3, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef 1)
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: norecurse nosync
; CGSCC-LABEL: define {{[^@]+}}@entry3
; CGSCC-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR6:[0-9]+]] {
; CGSCC-NEXT:    call void @useI32(i32 1)
; CGSCC-NEXT:    store i32 1, ptr @GInt3, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef 1)
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       T:
; CGSCC-NEXT:    store i32 [[V]], ptr @GInt3, align 4
; CGSCC-NEXT:    [[L2:%.*]] = load i32, ptr @GInt3, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L2]])
; CGSCC-NEXT:    br label [[F]]
; CGSCC:       F:
; CGSCC-NEXT:    [[L3:%.*]] = load i32, ptr @GInt3, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L3]])
; CGSCC-NEXT:    store i32 1, ptr @GInt3, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef 1)
; CGSCC-NEXT:    ret void
;
  %l0 = load i32, ptr @GInt3
  call void @useI32(i32 %l0)
  store i32 1, ptr @GInt3
  %l1 = load i32, ptr @GInt3
  call void @useI32(i32 %l1)
  br i1 %c, label %T, label %F
T:
  store i32 %v, ptr @GInt3
  %l2 = load i32, ptr @GInt3
  call void @useI32(i32 %l2)
  br label %F
F:
  %l3 = load i32, ptr @GInt3
  call void @useI32(i32 %l3)
  store i32 1, ptr @GInt3
  %l4 = load i32, ptr @GInt3
  call void @useI32(i32 %l4)
  ret void
}

define void @entry4(i1 %c, i32 %v) {
; TUNIT: Function Attrs: norecurse nosync
; TUNIT-LABEL: define {{[^@]+}}@entry4
; TUNIT-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5]] {
; TUNIT-NEXT:    [[L0:%.*]] = load i32, ptr @GInt4, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef [[L0]])
; TUNIT-NEXT:    store i32 1, ptr @GInt4, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef 1)
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       T:
; TUNIT-NEXT:    store i32 [[V]], ptr @GInt4, align 4
; TUNIT-NEXT:    [[L2:%.*]] = load i32, ptr @GInt4, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L2]])
; TUNIT-NEXT:    br label [[F]]
; TUNIT:       F:
; TUNIT-NEXT:    [[L3:%.*]] = load i32, ptr @GInt4, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L3]])
; TUNIT-NEXT:    store i32 1, ptr @GInt4, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef 1)
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: norecurse nosync
; CGSCC-LABEL: define {{[^@]+}}@entry4
; CGSCC-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR6]] {
; CGSCC-NEXT:    [[L0:%.*]] = load i32, ptr @GInt4, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef [[L0]])
; CGSCC-NEXT:    store i32 1, ptr @GInt4, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef 1)
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       T:
; CGSCC-NEXT:    store i32 [[V]], ptr @GInt4, align 4
; CGSCC-NEXT:    [[L2:%.*]] = load i32, ptr @GInt4, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L2]])
; CGSCC-NEXT:    br label [[F]]
; CGSCC:       F:
; CGSCC-NEXT:    [[L3:%.*]] = load i32, ptr @GInt4, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L3]])
; CGSCC-NEXT:    store i32 1, ptr @GInt4, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef 1)
; CGSCC-NEXT:    ret void
;
  %l0 = load i32, ptr @GInt4
  call void @useI32(i32 %l0)
  store i32 1, ptr @GInt4
  %l1 = load i32, ptr @GInt4
  call void @useI32(i32 %l1)
  br i1 %c, label %T, label %F
T:
  store i32 %v, ptr @GInt4
  %l2 = load i32, ptr @GInt4
  call void @useI32(i32 %l2)
  br label %F
F:
  %l3 = load i32, ptr @GInt4
  call void @useI32(i32 %l3)
  store i32 1, ptr @GInt4
  %l4 = load i32, ptr @GInt4
  call void @useI32(i32 %l4)
  ret void
}

; TODO: In this test we can replace %l0, in the others above we cannot.
define void @entry5(i1 %c, i32 %v) {
; TUNIT: Function Attrs: norecurse nosync
; TUNIT-LABEL: define {{[^@]+}}@entry5
; TUNIT-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR5]] {
; TUNIT-NEXT:    call void @useI32(i32 1)
; TUNIT-NEXT:    store i32 1, ptr @GInt5, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef 1) #[[ATTR6:[0-9]+]]
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       T:
; TUNIT-NEXT:    store i32 [[V]], ptr @GInt5, align 4
; TUNIT-NEXT:    [[L2:%.*]] = load i32, ptr @GInt5, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L2]]) #[[ATTR6]]
; TUNIT-NEXT:    br label [[F]]
; TUNIT:       F:
; TUNIT-NEXT:    [[L3:%.*]] = load i32, ptr @GInt5, align 4
; TUNIT-NEXT:    call void @useI32(i32 [[L3]]) #[[ATTR6]]
; TUNIT-NEXT:    store i32 1, ptr @GInt5, align 4
; TUNIT-NEXT:    call void @useI32(i32 noundef 1) #[[ATTR6]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: norecurse nosync
; CGSCC-LABEL: define {{[^@]+}}@entry5
; CGSCC-SAME: (i1 [[C:%.*]], i32 [[V:%.*]]) #[[ATTR6]] {
; CGSCC-NEXT:    call void @useI32(i32 1)
; CGSCC-NEXT:    store i32 1, ptr @GInt5, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef 1) #[[ATTR7:[0-9]+]]
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       T:
; CGSCC-NEXT:    store i32 [[V]], ptr @GInt5, align 4
; CGSCC-NEXT:    [[L2:%.*]] = load i32, ptr @GInt5, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L2]]) #[[ATTR7]]
; CGSCC-NEXT:    br label [[F]]
; CGSCC:       F:
; CGSCC-NEXT:    [[L3:%.*]] = load i32, ptr @GInt5, align 4
; CGSCC-NEXT:    call void @useI32(i32 [[L3]]) #[[ATTR7]]
; CGSCC-NEXT:    store i32 1, ptr @GInt5, align 4
; CGSCC-NEXT:    call void @useI32(i32 noundef 1) #[[ATTR7]]
; CGSCC-NEXT:    ret void
;
  %l0 = load i32, ptr @GInt5
  call void @useI32(i32 %l0)
  store i32 1, ptr @GInt5
  %l1 = load i32, ptr @GInt5
  call void @useI32(i32 %l1) nocallback
  br i1 %c, label %T, label %F
T:
  store i32 %v, ptr @GInt5
  %l2 = load i32, ptr @GInt5
  call void @useI32(i32 %l2) nocallback
  br label %F
F:
  %l3 = load i32, ptr @GInt5
  call void @useI32(i32 %l3) nocallback
  store i32 1, ptr @GInt5
  %l4 = load i32, ptr @GInt5
  call void @useI32(i32 %l4) nocallback
  ret void
}


declare void @use_4_i8(i8, i8, i8, i8) nocallback

define void @exclusion_set1(i1 %c1, i1 %c2, i1 %c3) {
; CHECK-LABEL: define {{[^@]+}}@exclusion_set1
; CHECK-SAME: (i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL_H2S:%.*]] = alloca i8, i64 4, align 1
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr [[CALL_H2S]], i8 0, i64 4, i1 false)
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i8, ptr [[CALL_H2S]], i64 1
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds i8, ptr [[CALL_H2S]], i64 2
; CHECK-NEXT:    [[GEP3:%.*]] = getelementptr inbounds i8, ptr [[CALL_H2S]], i64 3
; CHECK-NEXT:    [[L0_A:%.*]] = load i8, ptr [[CALL_H2S]], align 1
; CHECK-NEXT:    [[L1_A:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[L2_A:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_A:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef [[L0_A]], i8 noundef [[L1_A]], i8 noundef [[L2_A]], i8 noundef [[L3_A]])
; CHECK-NEXT:    store i8 1, ptr [[CALL_H2S]], align 4
; CHECK-NEXT:    [[L1_B:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[L2_B:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_B:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef [[L1_B]], i8 noundef [[L2_B]], i8 noundef [[L3_B]])
; CHECK-NEXT:    br i1 [[C1]], label [[IF_MERGE1:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[L1_C:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[L2_C:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_C:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef [[L1_C]], i8 noundef [[L2_C]], i8 noundef [[L3_C]])
; CHECK-NEXT:    store i8 2, ptr [[GEP1]], align 4
; CHECK-NEXT:    [[L2_D:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_D:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef [[L2_D]], i8 noundef [[L3_D]])
; CHECK-NEXT:    br i1 [[C1]], label [[IF_MERGE1]], label [[IF_THEN2:%.*]]
; CHECK:       if.then2:
; CHECK-NEXT:    [[L2_E:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_E:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef [[L2_E]], i8 noundef [[L3_E]])
; CHECK-NEXT:    store i8 3, ptr [[GEP2]], align 4
; CHECK-NEXT:    [[L3_F:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 noundef [[L3_F]])
; CHECK-NEXT:    br i1 [[C2]], label [[IF_MERGE2:%.*]], label [[IF_THEN3:%.*]]
; CHECK:       if.merge1:
; CHECK-NEXT:    [[L1_G:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[L2_G:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_G:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef [[L1_G]], i8 noundef [[L2_G]], i8 noundef [[L3_G]])
; CHECK-NEXT:    br label [[IF_MERGE2]]
; CHECK:       if.merge2:
; CHECK-NEXT:    [[L1_H:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[L2_H:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_H:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef [[L1_H]], i8 noundef [[L2_H]], i8 noundef [[L3_H]])
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[L3_I:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 noundef [[L3_I]])
; CHECK-NEXT:    store i8 4, ptr [[GEP3]], align 4
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 noundef 4)
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[L1_K:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[L2_K:%.*]] = load i8, ptr [[GEP2]], align 1
; CHECK-NEXT:    [[L3_K:%.*]] = load i8, ptr [[GEP3]], align 1
; CHECK-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef [[L1_K]], i8 noundef [[L2_K]], i8 noundef [[L3_K]])
; CHECK-NEXT:    ret void
;
entry:
  %call = call noalias ptr @calloc(i64 1, i64 4) norecurse
  %gep0 = getelementptr inbounds i8, ptr %call, i64 0
  %gep1 = getelementptr inbounds i8, ptr %call, i64 1
  %gep2 = getelementptr inbounds i8, ptr %call, i64 2
  %gep3 = getelementptr inbounds i8, ptr %call, i64 3

  %l0_a = load i8, ptr %gep0
  %l1_a = load i8, ptr %gep1
  %l2_a = load i8, ptr %gep2
  %l3_a = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_a, i8 %l1_a, i8 %l2_a, i8 %l3_a)

  store i8 1, ptr %gep0, align 4

  %l0_b = load i8, ptr %gep0
  %l1_b = load i8, ptr %gep1
  %l2_b = load i8, ptr %gep2
  %l3_b = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_b, i8 %l1_b, i8 %l2_b, i8 %l3_b)

  br i1 %c1, label %if.merge1, label %if.then

if.then:
  %l0_c = load i8, ptr %gep0
  %l1_c = load i8, ptr %gep1
  %l2_c = load i8, ptr %gep2
  %l3_c = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_c, i8 %l1_c, i8 %l2_c, i8 %l3_c)

  store i8 2, ptr %gep1, align 4

  %l0_d = load i8, ptr %gep0
  %l1_d = load i8, ptr %gep1
  %l2_d = load i8, ptr %gep2
  %l3_d = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_d, i8 %l1_d, i8 %l2_d, i8 %l3_d)

  br i1 %c1, label %if.merge1, label %if.then2

if.then2:
  %l0_e = load i8, ptr %gep0
  %l1_e = load i8, ptr %gep1
  %l2_e = load i8, ptr %gep2
  %l3_e = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_e, i8 %l1_e, i8 %l2_e, i8 %l3_e)

  store i8 3, ptr %gep2, align 4

  %l0_f = load i8, ptr %gep0
  %l1_f = load i8, ptr %gep1
  %l2_f = load i8, ptr %gep2
  %l3_f = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_f, i8 %l1_f, i8 %l2_f, i8 %l3_f)

  br i1 %c2, label %if.merge2, label %if.then3

if.merge1:

  %l0_g = load i8, ptr %gep0
  %l1_g = load i8, ptr %gep1
  %l2_g = load i8, ptr %gep2
  %l3_g = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_g, i8 %l1_g, i8 %l2_g, i8 %l3_g)

  br label %if.merge2

if.merge2:

  %l0_h = load i8, ptr %gep0
  %l1_h = load i8, ptr %gep1
  %l2_h = load i8, ptr %gep2
  %l3_h = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_h, i8 %l1_h, i8 %l2_h, i8 %l3_h)

  br label %if.end

if.then3:

  %l0_i = load i8, ptr %gep0
  %l1_i = load i8, ptr %gep1
  %l2_i = load i8, ptr %gep2
  %l3_i = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_i, i8 %l1_i, i8 %l2_i, i8 %l3_i)

  store i8 4, ptr %gep3, align 4

  %l0_j = load i8, ptr %gep0
  %l1_j = load i8, ptr %gep1
  %l2_j = load i8, ptr %gep2
  %l3_j = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_j, i8 %l1_j, i8 %l2_j, i8 %l3_j)

  br label %if.end

if.end:
  %l0_k = load i8, ptr %gep0
  %l1_k = load i8, ptr %gep1
  %l2_k = load i8, ptr %gep2
  %l3_k = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_k, i8 %l1_k, i8 %l2_k, i8 %l3_k)

  call void @free(ptr %call) norecurse
  ret void
}

define void @exclusion_set2(i1 %c1, i1 %c2, i1 %c3) {
; TUNIT: Function Attrs: norecurse
; TUNIT-LABEL: define {{[^@]+}}@exclusion_set2
; TUNIT-SAME: (i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]]) #[[ATTR7:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    call void @use_4_i8(i8 undef, i8 undef, i8 undef, i8 undef)
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 undef, i8 undef, i8 undef)
; TUNIT-NEXT:    br i1 [[C1]], label [[IF_MERGE1:%.*]], label [[IF_THEN:%.*]]
; TUNIT:       if.then:
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 undef, i8 undef, i8 undef)
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 undef, i8 undef)
; TUNIT-NEXT:    br i1 [[C1]], label [[IF_MERGE1]], label [[IF_THEN2:%.*]]
; TUNIT:       if.then2:
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 undef, i8 undef)
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 undef)
; TUNIT-NEXT:    br i1 [[C2]], label [[IF_MERGE2:%.*]], label [[IF_THEN3:%.*]]
; TUNIT:       if.merge1:
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 2, i8 undef, i8 undef)
; TUNIT-NEXT:    br label [[IF_MERGE2]]
; TUNIT:       if.merge2:
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 2, i8 3, i8 undef)
; TUNIT-NEXT:    br label [[IF_END:%.*]]
; TUNIT:       if.then3:
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 undef)
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 noundef 4)
; TUNIT-NEXT:    br label [[IF_END]]
; TUNIT:       if.end:
; TUNIT-NEXT:    call void @use_4_i8(i8 noundef 1, i8 2, i8 3, i8 4)
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: norecurse
; CGSCC-LABEL: define {{[^@]+}}@exclusion_set2
; CGSCC-SAME: (i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]]) #[[ATTR8:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    call void @use_4_i8(i8 undef, i8 undef, i8 undef, i8 undef)
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 undef, i8 undef, i8 undef)
; CGSCC-NEXT:    br i1 [[C1]], label [[IF_MERGE1:%.*]], label [[IF_THEN:%.*]]
; CGSCC:       if.then:
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 undef, i8 undef, i8 undef)
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 undef, i8 undef)
; CGSCC-NEXT:    br i1 [[C1]], label [[IF_MERGE1]], label [[IF_THEN2:%.*]]
; CGSCC:       if.then2:
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 undef, i8 undef)
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 undef)
; CGSCC-NEXT:    br i1 [[C2]], label [[IF_MERGE2:%.*]], label [[IF_THEN3:%.*]]
; CGSCC:       if.merge1:
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 2, i8 undef, i8 undef)
; CGSCC-NEXT:    br label [[IF_MERGE2]]
; CGSCC:       if.merge2:
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 2, i8 3, i8 undef)
; CGSCC-NEXT:    br label [[IF_END:%.*]]
; CGSCC:       if.then3:
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 undef)
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 noundef 2, i8 noundef 3, i8 noundef 4)
; CGSCC-NEXT:    br label [[IF_END]]
; CGSCC:       if.end:
; CGSCC-NEXT:    call void @use_4_i8(i8 noundef 1, i8 2, i8 3, i8 4)
; CGSCC-NEXT:    ret void
;
entry:
  %alloc = alloca i8, i32 4
  %gep0 = getelementptr inbounds i8, ptr %alloc, i64 0
  %gep1 = getelementptr inbounds i8, ptr %alloc, i64 1
  %gep2 = getelementptr inbounds i8, ptr %alloc, i64 2
  %gep3 = getelementptr inbounds i8, ptr %alloc, i64 3

  %l0_a = load i8, ptr %gep0
  %l1_a = load i8, ptr %gep1
  %l2_a = load i8, ptr %gep2
  %l3_a = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_a, i8 %l1_a, i8 %l2_a, i8 %l3_a)

  store i8 1, ptr %gep0, align 4

  %l0_b = load i8, ptr %gep0
  %l1_b = load i8, ptr %gep1
  %l2_b = load i8, ptr %gep2
  %l3_b = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_b, i8 %l1_b, i8 %l2_b, i8 %l3_b)

  br i1 %c1, label %if.merge1, label %if.then

if.then:
  %l0_c = load i8, ptr %gep0
  %l1_c = load i8, ptr %gep1
  %l2_c = load i8, ptr %gep2
  %l3_c = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_c, i8 %l1_c, i8 %l2_c, i8 %l3_c)

  store i8 2, ptr %gep1, align 4

  %l0_d = load i8, ptr %gep0
  %l1_d = load i8, ptr %gep1
  %l2_d = load i8, ptr %gep2
  %l3_d = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_d, i8 %l1_d, i8 %l2_d, i8 %l3_d)

  br i1 %c1, label %if.merge1, label %if.then2

if.then2:
  %l0_e = load i8, ptr %gep0
  %l1_e = load i8, ptr %gep1
  %l2_e = load i8, ptr %gep2
  %l3_e = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_e, i8 %l1_e, i8 %l2_e, i8 %l3_e)

  store i8 3, ptr %gep2, align 4

  %l0_f = load i8, ptr %gep0
  %l1_f = load i8, ptr %gep1
  %l2_f = load i8, ptr %gep2
  %l3_f = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_f, i8 %l1_f, i8 %l2_f, i8 %l3_f)

  br i1 %c2, label %if.merge2, label %if.then3

if.merge1:

  %l0_g = load i8, ptr %gep0
  %l1_g = load i8, ptr %gep1
  %l2_g = load i8, ptr %gep2
  %l3_g = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_g, i8 %l1_g, i8 %l2_g, i8 %l3_g)

  br label %if.merge2

if.merge2:

  %l0_h = load i8, ptr %gep0
  %l1_h = load i8, ptr %gep1
  %l2_h = load i8, ptr %gep2
  %l3_h = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_h, i8 %l1_h, i8 %l2_h, i8 %l3_h)

  br label %if.end

if.then3:

  %l0_i = load i8, ptr %gep0
  %l1_i = load i8, ptr %gep1
  %l2_i = load i8, ptr %gep2
  %l3_i = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_i, i8 %l1_i, i8 %l2_i, i8 %l3_i)

  store i8 4, ptr %gep3, align 4

  %l0_j = load i8, ptr %gep0
  %l1_j = load i8, ptr %gep1
  %l2_j = load i8, ptr %gep2
  %l3_j = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_j, i8 %l1_j, i8 %l2_j, i8 %l3_j)

  br label %if.end

if.end:
  %l0_k = load i8, ptr %gep0
  %l1_k = load i8, ptr %gep1
  %l2_k = load i8, ptr %gep2
  %l3_k = load i8, ptr %gep3
  call void @use_4_i8(i8 %l0_k, i8 %l1_k, i8 %l2_k, i8 %l3_k)

  ret void
}

declare void @usei32(i32) nocallback nosync
define internal void @exclusion_set3_helper(i1 %c, ptr %p) {
; TUNIT: Function Attrs: nosync
; TUNIT-LABEL: define {{[^@]+}}@exclusion_set3_helper
; TUNIT-SAME: (i1 noundef [[C:%.*]], ptr noalias nocapture nofree noundef nonnull align 4 dereferenceable(4) [[P:%.*]]) #[[ATTR8:[0-9]+]] {
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       t:
; TUNIT-NEXT:    store i32 42, ptr [[P]], align 4
; TUNIT-NEXT:    br label [[M:%.*]]
; TUNIT:       f:
; TUNIT-NEXT:    [[L:%.*]] = load i32, ptr [[P]], align 4
; TUNIT-NEXT:    [[ADD:%.*]] = add i32 [[L]], 1
; TUNIT-NEXT:    store i32 [[ADD]], ptr [[P]], align 4
; TUNIT-NEXT:    [[CND:%.*]] = icmp eq i32 [[L]], 100
; TUNIT-NEXT:    br i1 [[CND]], label [[F2:%.*]], label [[F]]
; TUNIT:       f2:
; TUNIT-NEXT:    [[USE1:%.*]] = load i32, ptr [[P]], align 4
; TUNIT-NEXT:    call void @usei32(i32 [[USE1]])
; TUNIT-NEXT:    store i32 77, ptr [[P]], align 4
; TUNIT-NEXT:    call void @exclusion_set3_helper(i1 noundef true, ptr noalias nocapture nofree noundef nonnull align 4 dereferenceable(4) [[P]]) #[[ATTR8]]
; TUNIT-NEXT:    [[USE2:%.*]] = load i32, ptr [[P]], align 4
; TUNIT-NEXT:    call void @usei32(i32 noundef [[USE2]])
; TUNIT-NEXT:    br label [[T]]
; TUNIT:       m:
; TUNIT-NEXT:    call void @usei32(i32 noundef 42)
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync
; CGSCC-LABEL: define {{[^@]+}}@exclusion_set3_helper
; CGSCC-SAME: (i1 noundef [[C:%.*]], ptr noalias nocapture nofree noundef nonnull align 4 dereferenceable(4) [[P:%.*]]) #[[ATTR5]] {
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       t:
; CGSCC-NEXT:    store i32 42, ptr [[P]], align 4
; CGSCC-NEXT:    br label [[M:%.*]]
; CGSCC:       f:
; CGSCC-NEXT:    [[L:%.*]] = load i32, ptr [[P]], align 4
; CGSCC-NEXT:    [[ADD:%.*]] = add i32 [[L]], 1
; CGSCC-NEXT:    store i32 [[ADD]], ptr [[P]], align 4
; CGSCC-NEXT:    [[CND:%.*]] = icmp eq i32 [[L]], 100
; CGSCC-NEXT:    br i1 [[CND]], label [[F2:%.*]], label [[F]]
; CGSCC:       f2:
; CGSCC-NEXT:    [[USE1:%.*]] = load i32, ptr [[P]], align 4
; CGSCC-NEXT:    call void @usei32(i32 [[USE1]])
; CGSCC-NEXT:    store i32 77, ptr [[P]], align 4
; CGSCC-NEXT:    call void @exclusion_set3_helper(i1 noundef true, ptr noalias nocapture nofree noundef nonnull align 4 dereferenceable(4) [[P]]) #[[ATTR5]]
; CGSCC-NEXT:    [[USE2:%.*]] = load i32, ptr [[P]], align 4
; CGSCC-NEXT:    call void @usei32(i32 [[USE2]])
; CGSCC-NEXT:    br label [[T]]
; CGSCC:       m:
; CGSCC-NEXT:    [[USE3:%.*]] = load i32, ptr [[P]], align 4
; CGSCC-NEXT:    call void @usei32(i32 [[USE3]])
; CGSCC-NEXT:    ret void
;
  br i1 %c, label %t, label %f
t:
  store i32 42, ptr %p
  br label %m
f:
  %l = load i32, ptr %p
  %add = add i32 %l, 1
  store i32 %add, ptr %p
  %cnd = icmp eq i32 %l, 100
  br i1 %cnd, label %f2, label %f
f2:
  %use1 = load i32, ptr %p
  call void @usei32(i32 %use1)
  store i32 77, ptr %p
  call void @exclusion_set3_helper(i1 true, ptr %p)
  %use2 = load i32, ptr %p
  call void @usei32(i32 %use2)
  br label %t
m:
  %use3 = load i32, ptr %p
  call void @usei32(i32 %use3)
  ret void
}

define i32 @exclusion_set3(i1 %c) {
; TUNIT: Function Attrs: norecurse nosync
; TUNIT-LABEL: define {{[^@]+}}@exclusion_set3
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR5]] {
; TUNIT-NEXT:    [[A:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    store i32 3, ptr [[A]], align 4
; TUNIT-NEXT:    call void @exclusion_set3_helper(i1 noundef [[C]], ptr noalias nocapture nofree noundef nonnull align 4 dereferenceable(4) [[A]]) #[[ATTR8]]
; TUNIT-NEXT:    [[FINAL:%.*]] = load i32, ptr [[A]], align 4
; TUNIT-NEXT:    ret i32 [[FINAL]]
;
; CGSCC: Function Attrs: nosync
; CGSCC-LABEL: define {{[^@]+}}@exclusion_set3
; CGSCC-SAME: (i1 noundef [[C:%.*]]) #[[ATTR5]] {
; CGSCC-NEXT:    [[A:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store i32 3, ptr [[A]], align 4
; CGSCC-NEXT:    call void @exclusion_set3_helper(i1 noundef [[C]], ptr noalias nocapture nofree noundef nonnull align 4 dereferenceable(4) [[A]])
; CGSCC-NEXT:    [[FINAL:%.*]] = load i32, ptr [[A]], align 4
; CGSCC-NEXT:    ret i32 [[FINAL]]
;
  %a = alloca i32
  store i32 3, ptr %a
  call void @exclusion_set3_helper(i1 %c, ptr %a)
  %final = load i32, ptr %a
  ret i32 %final
}

;.
; TUNIT: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
; TUNIT: attributes #[[ATTR1:[0-9]+]] = { nocallback nosync }
; TUNIT: attributes #[[ATTR2:[0-9]+]] = { allockind("free") "alloc-family"="malloc" }
; TUNIT: attributes #[[ATTR3:[0-9]+]] = { allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc" }
; TUNIT: attributes #[[ATTR4]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write) }
; TUNIT: attributes #[[ATTR5]] = { norecurse nosync }
; TUNIT: attributes #[[ATTR6]] = { nocallback }
; TUNIT: attributes #[[ATTR7]] = { norecurse }
; TUNIT: attributes #[[ATTR8]] = { nosync }
; TUNIT: attributes #[[ATTR9:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: write) }
; TUNIT: attributes #[[ATTR10]] = { nosync nounwind memory(write) }
;.
; CGSCC: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
; CGSCC: attributes #[[ATTR1:[0-9]+]] = { nocallback nosync }
; CGSCC: attributes #[[ATTR2:[0-9]+]] = { allockind("free") "alloc-family"="malloc" }
; CGSCC: attributes #[[ATTR3:[0-9]+]] = { allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc" }
; CGSCC: attributes #[[ATTR4]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write) }
; CGSCC: attributes #[[ATTR5]] = { nosync }
; CGSCC: attributes #[[ATTR6]] = { norecurse nosync }
; CGSCC: attributes #[[ATTR7]] = { nocallback }
; CGSCC: attributes #[[ATTR8]] = { norecurse }
; CGSCC: attributes #[[ATTR9:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: write) }
; CGSCC: attributes #[[ATTR10]] = { nounwind memory(write) }
;.

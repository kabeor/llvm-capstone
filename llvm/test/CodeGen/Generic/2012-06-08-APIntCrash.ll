; RUN: llc < %s

define void @test1(ptr %ptr)
{
	%1 = load <8 x i32>, ptr %ptr, align 32
	%2 = and <8 x i32> %1, <i32 0, i32 0, i32 0, i32 -1, i32 0, i32 0, i32 0, i32 -1>
	store <8 x i32> %2, ptr %ptr, align 16
	ret void
}

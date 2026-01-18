package lc3vm

/* Memory Storage */
MEMORY_MAX :: (1 << 16)
memory := [MEMORY_MAX]u16{}

/* Registers */
R :: enum {
	R0 = 0,
	R1,
	R2,
	R3,
	R4,
	R5,
	R6,
	R7,
	PC, /* program counter */
	COND,
	COUNT,
}

/* Register Storage */
reg := [R.COUNT]u16{}

/* Opcodes */

OP :: enum {
	BR = 0, /* branch*/
	ADD,
	LD,
	ST,
	JSR,
	AND,
	LDR,
	STR,
	RTI,
	NOT,
	LDI,
	STI,
	JMP,
	RES,
	LEA,
	TRAP,
}

main :: proc() {

}

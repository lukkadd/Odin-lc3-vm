package lc3vm
import "core:fmt"
import os "core:os/os2"

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
	ADD, /* add */
	LD, /* load */
	ST, /* store */
	JSR, /* jump register */
	AND, /* bitwise and */
	LDR, /* load register */
	STR, /* store register */
	RTI, /* unused */
	NOT, /* bitwise not */
	LDI, /* load indirect */
	STI, /* store indirect */
	JMP, /* jump */
	RES, /* reserved (unused) */
	LEA, /* load effective address */
	TRAP, /* execute trap */
}

/* Conditional flags */

FL :: enum u16 {
	POS = 1 << 0, /* 1 - P */
	ZRO = 1 << 1, /* 2 - Z */
	NEG = 1 << 2, /* 4 - N */
}

/* Main Loop */

main :: proc() {

	/* Load Arguments */
	argv := os.args
	if len(os.args) < 2 {
		fmt.println("lc3 [image-file]...")
		os.exit(2)
	}

	for arg in argv {
		if (!read_image(arg)) {
			fmt.printfln("Failed to load image: %s", arg)
			os.exit(1)
		}
	}

	//TODO: Setup

	/* since exactly one condition flag should be set at any given time, set the Z flag */
	reg[R.COND] = u16(FL.ZRO)

	/* set the PC to starting position */
	/* 0x3000 is the default */
	PC_START :: 0x3000
	reg[R.PC] = PC_START

	running := true
	for running {
		/* FETCH */
		instr := mem_read(reg[R.PC])
		reg[R.PC] += 1
		op: OP =
			instr >> 12 /* out of the 16 bits, only the first 4 account for identifying the op*/

		switch (op) {
		case .ADD:
		//TODO: Implement
		case .AND:
		//TODO: Implement
		case .NOT:
		//TODO: Implement
		case .BR:
		//TODO: Implement
		case .JMP:
		//TODO: Implement
		case .JSR:
		//TODO: Implement
		case .LD:
		//TODO: Implement
		case .LDI:
		//TODO: Implement
		case .LDR:
		//TODO: Implement
		case .LEA:
		//TODO: Implement
		case .ST:
		//TODO: Implement
		case .STI:
		//TODO: Implement
		case .STR:
		//TODO: Implement
		case .TRAP:
		//TODO: Implement
		case .RES:
		case .RTI:
		case:
		//INFO: Bad Opcode
		}
	}

	//TODO: Shutdown	
}

/* Sign Extend */
sign_extend :: proc(x: u16, bit_count: u16) -> u16 {
	x := x
	if ((x >> (bit_count - 1)) & 1) != 0 {
		x |= (0xFFFF << bit_count)
	}
	return x
}

/* Update Flags */
update_flags :: proc(r: u16) {
	if reg[r] == 0 {
		reg[R.COND] = u16(FL.ZRO)
	} else if (reg[r] >> 15) != 0 {
		reg[R.COND] = u16(FL.NEG)
	} else {
		reg[R.COND] = u16(FL.POS)
	}
}

/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:31:18
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:17:15
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\TIME.asm
 * @Description:  时间文件，包含时间相关的函数(延时ms函数)
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$NOMOD51
NAME	TIME
$include(TIME.inc)
	RSEG  DT_delay_ms_TIME
_delay_ms_BYTE:
          a1:   DS   4
time_ms_start:   DS   4
	RSEG  _delay_ms_TIME
_delay_ms:
	USING	0
	MOV  	a1+03H,R7
	MOV  	a1+02H,R6
	MOV  	a1+01H,R5
	MOV  	a1,R4
	MOV  	time_ms_start+03H,time_ms+03H
	MOV  	time_ms_start+02H,time_ms+02H
	MOV  	time_ms_start+01H,time_ms+01H
	MOV  	time_ms_start,time_ms
TIME0001:
	CLR  	C
	MOV  	A,time_ms+03H
	SUBB 	A,time_ms_start+03H
	MOV  	R7,A
	MOV  	A,time_ms+02H
	SUBB 	A,time_ms_start+02H
	MOV  	R6,A
	MOV  	A,time_ms+01H
	SUBB 	A,time_ms_start+01H
	MOV  	R5,A
	MOV  	A,time_ms
	SUBB 	A,time_ms_start
	MOV  	R4,A
	MOV  	R3,a1+03H
	MOV  	R2,a1+02H
	MOV  	R1,a1+01H
	MOV  	R0,a1
	CLR  	C
	LCALL	?C?ULCMP
	JNZ  	TIME0001
TIME0004:
	RET  	
	END

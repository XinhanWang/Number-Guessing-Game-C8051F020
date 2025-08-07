/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:43:17
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-25 11:53:21
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\GUESSING_GAME.asm
 * @Description:  猜数游戏文件，包含猜数游戏相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
; 禁用51的SFR定义汇编程序的名称
$NOMOD51
NAME	GUESSING_GAME
; 包含一个包含宏定义的文件，例如GUESSING_GAME.inc
$include(GUESSING_GAME.inc) ;
; 定义一个名为DT_guess_once_GUESSING_GAME的段，用于存储程序的数据
RSEG  DT_guess_once_GUESSING_GAME

; guess_once_BYTE: 定义一个名为guess_once_BYTE的段，用于存储程序的数据
guess_once_BYTE:
     state:   DS   1  ; 定义一个名为state的寄存器，用于存储猜测状态
	RSEG  BI_guess_once_GUESSING_GAME  ; 包含一个名为BI_guess_once_GUESSING_GAME的段，用于存储程序的数据
guess_once_BIT:
         a1:   DBIT   1  ; 定义一个名为a1的寄存器，用于存储一个位
      temp:   DBIT   1  ; 定义一个名为temp的寄存器，用于存储一个位
	RSEG  BI_guess_one_level_GUESSING_GAME  ; 包含一个名为BI_guess_one_level_GUESSING_GAME的段，用于存储程序的数据
guess_one_level_BIT:
         b2:   DBIT   1  ; 定义一个名为b2的寄存器，用于存储一个位
         a2:   DBIT   1  ; 定义一个名为a2的寄存器，用于存储一个位
	RSEG  DT_mode1_GAME  ; 包含一个名为DT_mode1_GAME的段，用于存储程序的数据
mode1_BYTE:
        i:   DS   1  ; 定义一个名为i的寄存器，用于存储一个字节
    state1:   DS   1  ; 定义一个名为state1的寄存器，用于存储猜测状态
	RSEG  XD_GUESSING_GAME  ; 包含一个名为XD_GUESSING_GAME的段，用于存储程序的数据
level_display_time:   DS   20  ; 定义一个名为level_display_time的寄存器，用于存储显示时间
    level_bits:   DS   10  ; 定义一个名为level_bits的寄存器，用于存储显示的位
 random_digits:   DS   64  ; 定义一个名为random_digits的寄存器，用于存储随机数
	RSEG  DT_GUESSING_GAME  ; 包含一个名为DT_GUESSING_GAME的段，用于存储程序的数据
  display_time:   DS   2  ; 定义一个名为display_time的寄存器，用于存储显示时间
          bits:   DS   1  ; 定义一个名为bits的寄存器，用于存储一个位

    RSEG CO_GUESSING_GAME ; 包含一个名为CO_GUESSING_GAME的段，用于存储程序的数据
CODE_GUESSING_GAME:
   ; digits: 定义一个名为digits的数组，用于存储数字0-9和字母A-F
   digits:   DB  '0' ,'1' ,'2' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9' 
         DB  'A' ,'B' ,'C' ,'D' ,'E' ,'F' ,000H
	; RSEG  ?C_INITSEG: 定义一个名为?C_INITSEG的段，用于存储程序的数据
	RSEG  ?C_INITSEG
	DB	060H
	DB	040H
	DW	random_digits
	DB	000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H
	DB	001H
	DB	bits
	DB	000H
	DB	002H
	DB	display_time
	DW	00000H
	DB	04AH
	DW	level_bits
	DB	001H
	DB	002H
	DB	003H
	DB	004H
	DB	005H
	DB	006H
	DB	007H
	DB	008H
	DB	009H
	DB	00AH
	DB	054H
	DW	level_display_time
	DW	000C8H
	DW	00190H
	DW	00258H
	DW	00320H
	DW	003E8H
	DW	004B0H
	DW	00578H
	DW	00640H
	DW	00708H
	DW	007D0H
	RSEG  check_digits_GUESSING_GAME
; 定义一个名为check_digits_GUESSING_GAME的段，用于存储程序的数据
check_digits_GUESSING:
	; 定义一个名为check_digits的标签，用于跳转到该标签的位置
check_digits:
	; 使用寄存器0作为工作寄存器
	USING	0
	;将寄存器A中的值清零
	CLR  	A
	;将寄存器A中的值存储到寄存器R7中
	MOV  	R7,A
; GUSSING_GAME0001: 定义一个循环，用于检查用户输入的数字是否在随机数数组中
GUSSING_GAME0001:
	;将输入的低8位存储到寄存器A中
	MOV  	A,#LOW (inputs)
	ADD  	A,R7
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (inputs); 将输入的高8位与输入的低8位相加，结果存储到寄存器A中
	MOV  	DPH,A
	MOVX 	A,@DPTR; 将随机数数组中的数字存储到寄存器A中
	MOV  	R6,A; 将寄存器A中的值存储到寄存器R6中，用于后续比较
	MOV  	A,#LOW (random_digits); 将随机数数组中的低8位存储到寄存器A中
	ADD  	A,R7; 将随机数数组中的偏移量与输入的偏移量相加，结果存储到寄存器A中
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (random_digits); 将随机数数组中的高8位与输入的高8位相加，结果存储到寄存器A中
	MOV  	DPH,A
	MOVX 	A,@DPTR; 将随机数数组中的数字存储到寄存器A中
	CJNE 	A,AR6,GUSSING_GAME0002; 如果输入的数字与随机数数组中的数字不相等，则跳转到GUSSING_GAME0002标签
	INC  	R7; 如果输入的数字与随机数数组中的数字相等，则将随机数数组的偏移量加1
	CJNE 	R7,#040H,GUSSING_GAME0001; 如果随机数数组的偏移量大于等于40，则跳转到GUSSING_GAME0001标签

; GUSSING_GAME0002: 如果输入的数字与随机数数组中的数字不相等，则跳转到GUSSING_GAME0005标签
GUSSING_GAME0002:
	; CJNE 	R7,#040H,GUSSING_GAME0005: 如果随机数数组的偏移量大于等于40，则跳转到GUSSING_GAME0005标签
	CJNE 	R7,#040H,GUSSING_GAME0005
	; SETB 	C: 设置C位为1，表示猜测正确
	SETB 	C
	; RET  	: 返回调用处的地址
	RET  
GUSSING_GAME0005:
	; CLR  	C: 将C位清零，表示猜测错误
	CLR  	C
GUSSING_GAME0006:
	; RET  	: 返回调用处的地址
	RET  
	; RSEG  correct_GAME: 定义一个包含正确显示函数的段
	RSEG  correct_GAME
correct:
	; USING 0: 使用寄存器0作为工作寄存器
	USING	0
	; LCALL	display_correct: 调用显示正确显示的函数
	LCALL	display_correct
	; LJMP 	f_or_e: 跳转到f_or_e标签
	LJMP 	f_or_e
	; RSEG  error_GAME: 定义一个包含错误显示函数的段
	RSEG  error_GAME
error:
	; USING 0: 使用寄存器0作为工作寄存器
	USING	0
	; LCALL	display_error: 调用显示错误显示的函数
	LCALL	display_error
	; LJMP 	f_or_e: 跳转到f_or_e标签
	LJMP 	f_or_e
	; RSEG  win_GAME: 定义一个包含胜利显示函数的段
	RSEG  win_GAME
; win: 定义一个包含胜利显示函数的段
win:
	; USING 0: 使用寄存器0作为工作寄存器
	USING	0
	; LCALL	display_win: 调用显示胜利显示的函数
	LCALL	display_win
	; LJMP 	f_or_e: 跳转到f_or_e标签
	LJMP 	f_or_e
	RSEG  lose_GAME  ; 定义了一个名为 lose_GAME 的数据段
lose:  ; 汇编标签，表示一个汇编函数的开始
	USING 0  ; 表示使用寄存器0 
	LCALL display_lose  ; 调用 display_lose 函数，用于显示玩家输掉游戏的失败信息
	LJMP f_or_e  ; 跳转到 f_or_e 标签

RSEG  guess_once_GAME
guess_once:
	; 使用寄存器0作为工作寄存器
	USING	0
	; 将状态寄存器清零
	CLR  	A
	; 将状态寄存器的值存储到state变量中
	MOV  	state,A
	; 调用显示随机数数组的函数
	LCALL	display_random_digits
	; 调用显示输入提示的函数
	LCALL	display_input
	; 调用输入数字的函数
	LCALL	input_digits
	; 将状态寄存器清零
	CLR  	A
	; 将状态寄存器的值右移1位
	RLC  	A
	; 将状态寄存器的值存储到state变量中
	MOV  	state,A
	; 如果输入的数字不是1，则跳转到GUSSING_GAME0012标签
	CJNE 	A,#01H,GUSSING_GAME0012
	; 将输入的数字存储到R7寄存器中
	MOV  	R7,A
	; 返回调用处的地址
	RET  	
GUSSING_GAME0012:
	; 调用检查数字的函数
	LCALL	check_digits
	; 将结果存储到寄存器A中
	MOV  	a1,C
	; 如果输入的数字正确，则跳转到GUSSING_GAME0014标签
	JNB  	a1,GUSSING_GAME0014
	; 调用显示正确提示的函数
	LCALL	correct
	; 将输入的数字存储到寄存器R7中
	MOV  	temp,C
	; 如果输入的数字正确，则跳转到GUSSING_GAME0015标签
	JNB  	temp,GUSSING_GAME0015
	; 跳转到GUSSING_GAME0094标签
	SJMP 	GUSSING_GAME0094
GUSSING_GAME0015:
	; 将R7寄存器的值设置为0
	MOV  	R7,#00H
	; 返回调用处的地址
	RET  	
GUSSING_GAME0014:
	; 调用显示错误提示的函数
	LCALL	error
	; 将输入的数字存储到寄存器R7中
	MOV  	temp,C
	; 如果输入的数字正确，则跳转到GUSSING_GAME0017标签
	JNB  	temp,GUSSING_GAME0017
GUSSING_GAME0094:
	; 将状态寄存器的值设置为1
	MOV  	state,#01H
	; 将状态寄存器的值存储到R7寄存器中
	MOV  	R7,state
	; 返回调用处的地址
	RET  	
GUSSING_GAME0017:
	; 将R7寄存器的值设置为2
	MOV  	R7,#02H
GUSSING_GAME0013:
	; 返回调用处的地址
	RET  	
	RSEG  guess_one_level_GAME

guess_one_level:
	USING	0
	CLR  	A
	MOV  	R5,A
	LCALL	display_random_digits
	LCALL	display_input
	LCALL	input_digits
	CLR  	A
	RLC  	A
	MOV  	R5,A
	CJNE 	R5,#01H,GUSSING_GAME0018
	MOV  	R7,A
	RET  	
GUSSING_GAME0018:
	LCALL	check_digits
	MOV  	a2,C
	JNB  	a2,GUSSING_GAME0020
	JB   	b2,GUSSING_GAME0021
	LCALL	correct
	CLR  	A
	RLC  	A
	MOV  	R5,A
	CJNE 	R5,#01H,GUSSING_GAME0022
	MOV  	R7,A
	RET  	
GUSSING_GAME0022:
	MOV  	R7,#02H
	RET  	
GUSSING_GAME0021:
	LCALL	win
	CLR  	A
	RLC  	A
	MOV  	R5,A
	CJNE 	R5,#01H,GUSSING_GAME0025
	MOV  	R7,A
	RET  	
GUSSING_GAME0025:
	MOV  	R7,#00H
	RET  	
GUSSING_GAME0020:
	LCALL	lose
	CLR  	A
	RLC  	A
	MOV  	R7,A
GUSSING_GAME0019:
	RET  	
	RSEG  main_menu_GAME
main_menu:
	USING	0
	LCALL	display_main_menu
GUSSING_GAME0028:
	LCALL	kscan
	CJNE 	R7,#01H,GUSSING_GAME0031
	MOV  	R6,#01H
	SJMP 	GUSSING_GAME0032
GUSSING_GAME0031:
	MOV  	R6,#00H
GUSSING_GAME0032:
	MOV  	A,R7
	JNZ  	GUSSING_GAME0033
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0034
GUSSING_GAME0033:
	MOV  	R5,#00H
GUSSING_GAME0034:
	MOV  	A,R5
	ORL  	A,R6
	MOV  	R6,A
	CJNE 	R7,#0EH,GUSSING_GAME0035
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0036
GUSSING_GAME0035:
	MOV  	R5,#00H
GUSSING_GAME0036:
	MOV  	A,R5
	ORL  	A,R6
	JZ   	GUSSING_GAME0028
GUSSING_GAME0029:
	RET  	
	RSEG  mode_select_GAME
mode_select:
	USING	0
	LCALL	display_mode_select
GUSSING_GAME0038:
	LCALL	kscan
	CJNE 	R7,#01H,GUSSING_GAME0041
	MOV  	R6,#01H
	SJMP 	GUSSING_GAME0042
GUSSING_GAME0041:
	MOV  	R6,#00H
GUSSING_GAME0042:
	MOV  	A,R7
	JNZ  	GUSSING_GAME0043
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0044
GUSSING_GAME0043:
	MOV  	R5,#00H
GUSSING_GAME0044:
	MOV  	A,R5
	ORL  	A,R6
	MOV  	R6,A
	CJNE 	R7,#02H,GUSSING_GAME0045
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0046
GUSSING_GAME0045:
	MOV  	R5,#00H
GUSSING_GAME0046:
	MOV  	A,R5
	ORL  	A,R6
	MOV  	R6,A
	CJNE 	R7,#0EH,GUSSING_GAME0047
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0048
GUSSING_GAME0047:
	MOV  	R5,#00H
GUSSING_GAME0048:
	MOV  	A,R5
	ORL  	A,R6
	JZ   	GUSSING_GAME0038
GUSSING_GAME0039:
	RET  	
	RSEG  begin_select_GAME
begin_select:
	USING	0
	LCALL	display_begin_select
	LJMP 	f_or_e
	RSEG  mode1_GAME
mode1:
	USING	0
	CLR  	A
	MOV  	i,A
GUSSING_GAME0051:
	CLR  	A
	MOV  	i,A
GUSSING_GAME0053:
	MOV  	A,#LOW (level_bits)
	ADD  	A,i
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (level_bits)
	MOV  	DPH,A
	MOVX 	A,@DPTR
	MOV  	bits,A
	MOV  	A,i
	ADD  	A,ACC
	ADD  	A,#LOW (level_display_time)
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (level_display_time)
	MOV  	DPH,A
	MOVX 	A,@DPTR
	MOV  	display_time,A
	INC  	DPTR
	MOVX 	A,@DPTR
	MOV  	display_time+01H,A
	LCALL	begin_select
	JC   	GUSSING_GAME0057
	MOV  	A,i
	CJNE 	A,#09H,GUSSING_GAME0058
	SETB 	C
	SJMP 	GUSSING_GAME0059
GUSSING_GAME0058:
	CLR  	C
GUSSING_GAME0059:
	MOV  	guess_one_level_BIT,C
	LCALL	guess_one_level
	MOV  	state1,R7
	MOV  	A,state1
	XRL  	A,#01H
	JZ   	GUSSING_GAME0057
	MOV  	A,state1
	JZ   	GUSSING_GAME0051
	INC  	i
	MOV  	A,i
	CLR  	C
	SUBB 	A,#0AH
	JC   	GUSSING_GAME0053
	SJMP 	GUSSING_GAME0051
GUSSING_GAME0057:
	RET  	
	RSEG  mode2_GAME
mode2:
	USING	0
	LCALL	display_bits_select
	LCALL	input_bits
	JC   	GUSSING_GAME0065
	LCALL	display_time_select
	LCALL	input_display_time
	JC   	GUSSING_GAME0065
	LCALL	display_begin_select
GUSSING_GAME0067:
	LCALL	begin_select
	JC   	GUSSING_GAME0065
	LCALL	guess_once
	CJNE 	R7,#01H,GUSSING_GAME0067
GUSSING_GAME0065:
	RET  	
	RSEG  mode3_GAME
mode3:
	USING	0
GUSSING_GAME0071:
	LCALL	rand
	MOV  	R4,#00H
	MOV  	R5,#08H
	LCALL	?C?SIDIV
	MOV  	A,R5
	INC  	A
	MOV  	bits,A
	LCALL	rand
	MOV  	R4,#00H
	MOV  	R5,#065H
	LCALL	?C?SIDIV
	MOV  	A,bits
	MOV  	B,#0C8H
	MUL  	AB
	MOV  	R6,B
	ADD  	A,R5
	MOV  	display_time+01H,A
	MOV  	A,R6
	ADDC 	A,R4
	MOV  	display_time,A
	LCALL	begin_select
	JC   	GUSSING_GAME0074
	LCALL	guess_once
	CJNE 	R7,#01H,GUSSING_GAME0071
GUSSING_GAME0074:
	RET  	
	RSEG  acknowledgement_GAME
acknowledgement:
	USING	0
	LJMP 	display_acknowledgement
	RSEG  gussing_game_GAME
gussing_game:
	USING	0
GUSSING_GAME0077:
	LCALL	mode_select
	MOV  	A,R7
	XRL  	A,#0EH
	JZ   	GUSSING_GAME0085
	MOV  	A,R7
	DEC  	A
	JZ   	GUSSING_GAME0082
	DEC  	A
	JZ   	GUSSING_GAME0083
	ADD  	A,#02H
	JNZ  	GUSSING_GAME0077
GUSSING_GAME0081:
	LCALL	mode1
	SJMP 	GUSSING_GAME0077
GUSSING_GAME0082:
	LCALL	mode2
	SJMP 	GUSSING_GAME0077
GUSSING_GAME0083:
	LCALL	mode3
	SJMP 	GUSSING_GAME0077
GUSSING_GAME0085:
	RET  	
	RSEG  games_GUESSING_GAME
games:
	USING	0
	LCALL	display_gussing_game
GUSSING_GAME0086:
	LCALL	main_menu
	MOV  	A,R7
	XRL  	A,#0EH
	JZ   	GUSSING_GAME0093
	MOV  	A,R7
	DEC  	A
	JZ   	GUSSING_GAME0091
	INC  	A
	JNZ  	GUSSING_GAME0086
GUSSING_GAME0090:
	LCALL	gussing_game
	SJMP 	GUSSING_GAME0086
GUSSING_GAME0091:
	LCALL	acknowledgement
	SJMP 	GUSSING_GAME0086
GUSSING_GAME0093:
	RET  	
	END

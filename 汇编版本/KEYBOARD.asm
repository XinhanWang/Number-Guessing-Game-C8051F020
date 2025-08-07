/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:21:50
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:12:00
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\KEYBOARD.asm
 * @Description: 键盘处理文件，包含键盘检测、数据输入相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$NOMOD51 ; 禁用51的SFR
NAME	KEYBOARD ; 指定程序的名称为KEYBOARD
$include(KEYBOARD.inc) ; 包含KEYBOARD.inc文件，定义了一些常量和宏
	RSEG  DT_kscan_KEYBOARD ; 定义一个数据段，用于存储临时变量
kscan_BYTE: ; 分配字节空间的标号
       keyl:   DS   1 ; 分配一个字节的空间，用于存储临时变量
       temp:   DS   1 ; 分配一个字节的空间，用于存储临时变量
	RSEG  DT_input_digits_KEYBOARD ; 定义一个数据段，用于存储临时变量
input_digits_BYTE:  ; 分配字节空间的标号
          i:   DS   1 ; 分配一个字节的空间，用于存储循环计数器
      digit:   DS   1 ; 分配一个字节的空间，用于存储输入的数字
	RSEG  BI_input_digits_KEYBOARD  ; 定义一个位段，用于存储临时变量
input_digits_BIT: ; 分配位空间的标号
      state:   DBIT   1 ; 分配一个位的空间，用于存储输入数字的状态
	RSEG  DT_input_display_time_KEYBOARD ; 定义一个数据段，用于存储临时变量
input_display_time_BYTE: ; 分配字节空间的标号
          i1:   DS   1 ; 分配一个字节的空间，用于存储循环计数器
          j1:   DS   1 ; 分配一个字节的空间，用于存储循环计数器
      digit1:   DS   1 ; 分配一个字节的空间，用于存储输入的数字
          a1:   DS   5 ; 分配五个字节的空间，用于存储输入的显示时间的数组
       temp1:   DS   4 ; 分配四个字节的空间，用于存储临时数据
	RSEG  BI_input_display_time_KEYBOARD  ; 定义一个位段，用于存储临时变量
input_display_time_BIT: ; 分配位空间的标号
      state1:   DBIT   1 ; 分配一个位的空间，用于存储输入显示时间的状态
	RSEG  DT_input_bits_KEYBOARD ; 定义一个数据段，用于输入位的数据
input_bits_BYTE: ; 分配字节空间的标号
          i2:   DS   1 ; 分配一个字节的空间，用于存储循环计数器
      digit2:   DS   1 ; 分配一个字节的空间，用于存储输入的数字
          a2:   DS   2 ; 分配两个字节的空间，用于存储输入的显示位数的数组
	RSEG  BI_input_bits_KEYBOARD  ; 定义一个位段，用于存储临时变量
input_bits_BIT: ; 分配位空间的标号
      state2:   DBIT   1 ; 分配一个位的空间，用于存储输入显示位数函数的状态
	RSEG  BI_wait_input_KEYBOARD  ; 定义一个位段，用于存储等待键盘输入的状态变量
wait_input_BIT: ; 分配位空间的标号
      state3:   DBIT   1 ; 分配一个位的空间，用于存储等待键盘输入的状态
	RSEG  XD_KEYBOARD ; 定义一个扩展数据段，用于键盘的数据
         inputs:   DS   64 ; 分配64个字节的空间，用于存储键盘输入的内容
	RSEG  CO_KEYBOARD ; 定义一个代码段
_?ix1000: ; 定义一个标号，用于存储一个常量
	DB	000H ; 存储一个字节的数据，值为0
	DB  000H ; 存储一个字节的数据，值为0
_?ix1001: ; 定义一个标号，用于存储一个常量
	DB	000H ; 存储一个字节的数据，值为0
	DB  000H,000H,000H,000H ; 存储四个字节的数据，值都为0
	RSEG  kscan_KEYBOARD ; 定义一个代码段，用于键盘扫描的程序
kscan: ; 定义一个扫描键盘的子程序
	USING	0 ; 使用寄存器组 0
	MOV  	P1MDOUT,#0F0H ; 设置 P1 口的高四位为输出，低四位为输入
	MOV  	P1,#0FH ; 输出 0000 1111 到 P1 口
KEYBOARD0001: ; 定义一个循环标签
	MOV  	A,P1 ; 将 P1 口的值移入累加器 A
	XRL  	A,#0FH ; 将 A 与 0000 1111 异或，得到按键的行号
	JZ   	KEYBOARD0001 ; 如果 A 为 0，说明没有按键按下，跳转到 KEYBOARD0001 继续循环
	MOV  	R7,#0AH ; 将 10 移入 R7，用于延时
	MOV  	R6,#00H ; 将 0 移入 R6，用于延时
	MOV  	R5,#00H ; 将 0 移入 R5，用于延时
	MOV  	R4,#00H ; 将 0 移入 R4，用于延时
	LCALL	_delay_ms ; 调用一个延时子程序，用于消抖
	MOV  	A,P1 ; 将 P1 口的值移入累加器 A
	XRL  	A,#0FH ; 将 A 与 0000 1111 异或，得到按键的行号
	JZ   	KEYBOARD0001 ; 如果 A 为 0，说明是噪声，跳转到 KEYBOARD0001 继续循环
	MOV  	keyl,P1 ; 将 P1 口的值移入 keyl，用于保存按键的行号
	MOV  	P1MDOUT,#0FH ; 设置 P1 口的低四位为输出，高四位为输入
	MOV  	P1,#0F0H ; 输出 1111 0000 到 P1 口
	MOV  	R7,#0AH ; 将 10 移入 R7，用于延时
	MOV  	R6,#00H ; 将 0 移入 R6，用于延时
	MOV  	R5,#00H ; 将 0 移入 R5，用于延时
	MOV  	R4,#00H ; 将 0 移入 R4，用于延时
	LCALL	_delay_ms ; 调用一个延时子程序，用于消抖
	MOV  	R7,P1 ; 将 P1 口的值移入 R7，用于保存按键的列号
	MOV  	A,keyl ; 将 keyl 的值移入累加器 A
	ORL  	A,R7 ; 将 A 与 R7 或运算，得到按键的编码
	LCALL	?C?CCASE ; 调用一个分支表子程序，根据按键的编码跳转到相应的标签
	DW   	KEYBOARD0009 ; 定义一个分支表项，如果按键编码为 0111 0111，跳转到 KEYBOARD0009
	DB   	077H ; 定义按键编码为 0111 0111
	DW   	KEYBOARD0013 ; 定义一个分支表项，如果按键编码为 0111 1011，跳转到 KEYBOARD0013
	DB   	07BH ; 定义按键编码为 0111 1011
	DW   	KEYBOARD0017 ; 定义一个分支表项，如果按键编码为 0111 1101，跳转到 KEYBOARD0017
	DB   	07DH ; 定义按键编码为 0111 1101
	DW   	KEYBOARD0021 ; 定义一个分支表项，如果按键编码为 0111 1110，跳转到 KEYBOARD0021
	DB   	07EH ; 定义按键编码为 0111 1110
	DW   	KEYBOARD0008 ; 定义一个分支表项，如果按键编码为 1011 0111，跳转到 KEYBOARD0008
	DB   	0B7H ; 定义按键编码为 1011 0111
	DW   	KEYBOARD0012 ; 定义一个分支表项，如果按键编码为 1011 1011，跳转到 KEYBOARD0012
	DB   	0BBH ; 定义按键编码为 1011 1011
	DW   	KEYBOARD0016 ; 定义一个分支表项，如果按键编码为 1011 1101，跳转到 KEYBOARD0016
	DB   	0BDH ; 定义按键编码为 1011 1101
	DW   	KEYBOARD0020 ; 定义一个分支表项，如果按键编码为 1011 1110，跳转到 KEYBOARD0020
	DB   	0BEH ; 定义按键编码为 1011 1110
	DW   	KEYBOARD0007 ; 定义一个分支表项，如果按键编码为 1101 0111，跳转到 KEYBOARD0007
	DB   	0D7H ; 定义按键编码为 1101 0111
	DW   	KEYBOARD0011 ; 定义一个分支表项，如果按键编码为 1101 1011，跳转到 KEYBOARD0011
	DB   	0DBH ; 定义按键编码为 1101 1011
	DW   	KEYBOARD0015 ; 定义一个分支表项，如果按键编码为 1101 1101，跳转到 KEYBOARD0015
	DB   	0DDH ; 定义按键编码为 1101 1101
	DW   	KEYBOARD0019 ; 定义一个分支表项，如果按键编码为 1101 1110，跳转到 KEYBOARD0019
	DB   	0DEH ; 定义按键编码为 1101 1110
	DW   	KEYBOARD0006 ; 定义一个分支表项，如果按键编码为 1110 0111，跳转到 KEYBOARD0006
	DB   	0E7H ; 定义按键编码为 1110 0111
	DW   	KEYBOARD0010 ; 定义一个分支表项，如果按键编码为 1110 1011，跳转到 KEYBOARD0010
	DB   	0EBH ; 定义按键编码为 1110 1011
	DW   	KEYBOARD0014 ; 定义一个分支表项，如果按键编码为 1110 1101，跳转到 KEYBOARD0014
	DB   	0EDH ; 定义按键编码为 1110 1101
	DW   	KEYBOARD0018 ; 定义一个分支表项，如果按键编码为 1110 1110，跳转到 KEYBOARD0018
	DB   	0EEH ; 定义按键编码为 1110 1110
	DW   	00H ; 定义一个分支表项，如果按键编码为 0000 0000，跳转到 00H
	DW   	KEYBOARD0005 ; 定义一个分支表项，如果按键编码为其他值，跳转到 KEYBOARD0005
KEYBOARD0006: ; 定义一个标签，用于处理按键编码为 1110 0111 的情况
	CLR  	A ; 清除累加器 A
	MOV  	temp,A ; 将 A 的值移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0007: ; 定义一个标签，用于处理按键编码为 1101 0111 的情况
	MOV  	temp,#01H ; 将 01 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0008: ; 定义一个标签，用于处理按键编码为 10110111的情况
	MOV  	temp,#02H ; 将 02 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0009: ; 定义一个标签，用于处理按键编码为 0111 0111 的情况
	MOV  	temp,#03H ; 将 03 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0010: ; 定义一个标签，用于处理按键编码为 1110 1011 的情况
	MOV  	temp,#04H ; 将 04 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0011: ; 定义一个标签，用于处理按键编码为 1101 1011 的情况
	MOV  	temp,#05H ; 将 05 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0012: ; 定义一个标签，用于处理按键编码为 1011 1011 的情况
	MOV  	temp,#06H ; 将 06 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0013: ; 定义一个标签，用于处理按键编码为 0111 1011 的情况
	MOV  	temp,#07H ; 将 07 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0014: ; 定义一个标签，用于处理按键编码为 1110 1101 的情况
	MOV  	temp,#08H ; 将 08 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0015: ; 定义一个标签，用于处理按键编码为 1101 1101 的情况
	MOV  	temp,#09H ; 将 09 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0016: ; 定义一个标签，用于处理按键编码为 1011 1101 的情况
	MOV  	temp,#0AH ; 将 0A 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0017: ; 定义一个标签，用于处理按键编码为 0111 1101 的情况
	MOV  	temp,#0BH ; 将 0B 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0018: ; 定义一个标签，用于处理按键编码为 1110 1110 的情况
	MOV  	temp,#0CH ; 将 0C 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0019: ; 定义一个标签，用于处理按键编码为 1101 1110 的情况
	MOV  	temp,#0DH ; 将 0D 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0020: ; 定义一个标签，用于处理按键编码为 1011 1110 的情况
	MOV  	temp,#0EH ; 将 0E 移入 temp，用于保存按键的值
	SJMP 	KEYBOARD0005 ; 无条件跳转到 KEYBOARD0005
KEYBOARD0021: ; 定义一个标签，用于处理按键编码为 0111 1110 的情况
	MOV  	temp,#0FH ; 将 0F 移入 temp，用于保存按键的值
KEYBOARD0005: ; 定义一个标签，用于处理按键的值
	MOV  	P1MDOUT,#0F0H ; 设置 P1 口的高四位为输出，低四位为输入
	MOV  	P1,#0FH ; 输出 0000 1111 到 P1 口
KEYBOARD0023: ; 定义一个循环标签
	MOV  	A,P1 ; 将 P1 口的值移入累加器 A
	CJNE 	A,#0FH,KEYBOARD0023 ; 如果 A 不等于 0F，说明按键还没有松开，跳转到 KEYBOARD0023 继续循环
	MOV  	R7,#0AH ; 将 10 移入 R7，用于延时
	MOV  	R6,#00H ; 将 0 移入 R6，用于延时
	MOV  	R5,#00H ; 将 0 移入 R5，用于延时
	MOV  	R4,#00H ; 将 0 移入 R4，用于延时
	LCALL	_delay_ms ; 调用一个延时子程序，用于消抖
	MOV  	A,P1 ; 将 P1 口的值移入累加器 A
	CJNE 	A,#0FH,KEYBOARD0023 ; 如果 A 不等于 0F，说明按键还没有松开，跳转到 KEYBOARD0023 继续循环
KEYBOARD0024: ; 定义一个标签，用于返回按键的值
	MOV  	R7,temp ; 将 temp 的值移入 R7，作为返回值
	RET  	; 返回主程序
	RSEG  f_or_e_KEYBOARD ; 定义一个段，用于存放键盘的值
f_or_e: ; 定义一个判断按键是否为 F 或 E 的子程序
	USING	0 ; 使用寄存器组 0
KEYBOARD0028: ; 定义一个循环标签
	LCALL	kscan ; 调用 kscan 子程序，扫描键盘，返回按键的值到 R7
	MOV  	R6,#00H ; 将 0 移入 R6，用于比较
	MOV  	A,R7 ; 将 R7 的值移入累加器 A
	XRL  	A,#0FH ; 将 A 与 0F 异或，得到按键的值
	JNZ  	KEYBOARD0030 ; 如果 A 不为 0，说明按键不是 F，跳转到 KEYBOARD0030
	CLR  	C ; 清除进位标志位 C
	RET  	; 返回主程序，C 为 0 表示按键是 F
KEYBOARD0030: ; 定义一个标签，用于处理按键不是 F 的情况
	MOV  	A,R7 ; 将 R7 的值移入累加器 A
	XRL  	A,#0EH ; 将 A 与 0E 异或，得到按键的值
	ORL  	A,R6 ; 将 A 与 R6 或运算，得到按键的值
	JNZ  	KEYBOARD0028 ; 如果 A 不为 0，说明按键不是 E，跳转到 KEYBOARD0028 继续循环
	SETB 	C ; 置位进位标志位 C
KEYBOARD0031: ; 定义一个标签，用于返回按键的值
	RET  	; 返回主程序，C 为 1 表示按键是 E
	RSEG  input_digits_KEYBOARD ; 定义一个段，用于存放按键的值
input_digits: ; 定义一个输入数字的子程序
	USING	0 ; 使用寄存器组 0
	CLR  	A ; 清除累加器 A
	MOV  	digit,A ; 将 A 的值移入 digit，用于保存输入的数字
	CLR  	state ; 清除 state，用于保存输入的状态
	LCALL	wait_input ; 调用 wait_input 子程序，等待输入，返回输入的状态到 C
	MOV  	state,C ; 将 C 的值移入 state，用于判断输入的状态
	JNB  	state,KEYBOARD0036 ; 如果 state 为 0，说明输入不是E，跳转到 KEYBOARD0036
	SETB 	C ; 置位进位标志位 C
	RET  	; 返回主程序，如果状态为1，表示退出(输入了E)
KEYBOARD0036: ; 定义一个标签，用于处理输入不是E的情况
	LCALL	clear ; 调用 clear 子程序，清除显示屏
	CLR  	A ; 清除累加器 A
	MOV  	i,A ; 将 A 的值移入 i，用于保存输入的个数
KEYBOARD0038: ; 定义一个循环标签，用于初始化 inputs 数组
	MOV  	A,#LOW (inputs) ; 将 inputs 的低字节地址移入 A
	ADD  	A,i ; 将 A 与 i 相加，得到 inputs[i] 的低字节地址
	MOV  	DPL,A ; 将 A 的值移入 DPL，用于保存数据指针的低字节
	CLR  	A ; 清除累加器 A
	ADDC 	A,#HIGH (inputs) ; 将 A 与 inputs 的高字节地址相加，得到 inputs[i] 的高字节地址
	MOV  	DPH,A ; 将 A 的值移入 DPH，用于保存数据指针的高字节
	CLR  	A ; 清除累加器 A
	MOVX 	@DPTR,A ; 将 A 的值移入 inputs[i]，即将 inputs[i] 清零
	INC  	i ; 将 i 加 1，用于遍历 inputs 数组
	MOV  	A,i ; 将 i 的值移入 A
	CJNE 	A,#040H,KEYBOARD0038 ; 如果 A 不等于 40H，说明 inputs 数组还没有遍历完，跳转到 KEYBOARD0038 继续循环
KEYBOARD0039: ; 定义一个标签，用于开始输入数字
	CLR  	A ; 清除累加器 A
	MOV  	i,A ; 将 A 的值移入 i，用于保存输入的个数
KEYBOARD0041: ; 定义一个循环标签，用于输入数字
	MOV  	A,i ; 将 i 的值移入 A
	CLR  	C ; 清除进位标志位 C
	SUBB 	A,#041H ; 将 A 与 41H 相减，得到输入的个数与 41H 的差
	JNC  	KEYBOARD0036 ; 如果 C 为 0，说明输入的个数超过 41H，跳转到 KEYBOARD0036 重新输入
	LCALL	kscan ; 调用 kscan 子程序，扫描键盘，返回按键的值到 R7
	MOV  	digit,R7 ; 将 R7 的值移入 digit，用于保存按键的值
	MOV  	A,digit ; 将 digit 的值移入累加器 A
	CLR  	C ; 清除进位标志位 C
	SUBB 	A,#00H ; 将 A 与 00H 相减，得到按键的值与 00H 的差
	JC   	KEYBOARD0045 ; 如果 C 为 1，说明按键的值小于 00H，跳转到 KEYBOARD0045
	MOV  	R7,#01H ; 将 01H 移入 R7，用于判断按键的值是否合法
	SJMP 	KEYBOARD0046 ; 无条件跳转到 KEYBOARD0046
KEYBOARD0045: ; 定义一个标签，用于处理按键的值小于 00H 的情况
	MOV  	R7,#00H ; 将 00H 移入 R7，用于判断按键的值是否合法
KEYBOARD0046: ; 定义一个标签，用于判断按键的值是否合法
	MOV  	A,i ; 将 i 的值移入累加器 A
	CLR  	C ; 清除进位标志位 C
	SUBB 	A,#040H ; 将 A 与 40H 相减，得到输入的个数与 40H 的差
	JNC  	KEYBOARD0047 ; 如果 C 为 0，说明输入的个数等于 40H，跳转到 KEYBOARD0047
	MOV  	R6,#01H ; 将 01H 移入 R6，用于判断输入的个数是否合法
	SJMP 	KEYBOARD0048 ; 无条件跳转到 KEYBOARD0048
KEYBOARD0047: ; 定义一个标签，用于处理输入的个数等于 40H 的情况
	MOV  	R6,#00H ; 将 00H 移入 R6，用于判断输入的个数是否合法
KEYBOARD0048: ; 定义一个标签，用于判断输入的个数是否合法
	MOV  	A,R6 ; 将 R6 的值移入累加器 A
	ANL  	A,R7 ; 将 A 与 R7 与运算，得到输入的个数和按键的值是否都合法
	MOV  	R7,A ; 将 A 的值移入 R7，用于判断是否继续输入
	MOV  	A,digit ; 将 digit 的值移入累加器 A
	SETB 	C ; 置位进位标志位 C
	SUBB 	A,#09H ; 将 A 与 09H 相减，得到按键的值与 09H 的差
	JNC  	KEYBOARD0049 ; 如果 C 为 0，说明按键的值大于等于 09H，跳转到 KEYBOARD0049
	MOV  	R6,#01H ; 将 01H 移入 R6，用于判断按键的值是否合法
	SJMP 	KEYBOARD0050 ; 无条件跳转到 KEYBOARD0050
KEYBOARD0049: ; 定义一个标签，用于处理按键的值大于等于 09H 的情况
	MOV  	R6,#00H ; 将 00H 移入 R6，用于判断按键的值是否合法
KEYBOARD0050:
	MOV  	A,R6
	ANL  	A,R7
	JZ   	KEYBOARD0044
	MOV  	A,digit
	MOV  	DPTR,#digits
	MOVC 	A,@A+DPTR
	MOV  	R7,A
	MOV  	A,#LOW (inputs)
	ADD  	A,i
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (inputs)
	MOV  	DPH,A
	MOV  	A,R7
	MOVX 	@DPTR,A
	MOV  	digit,A
	MOV  	A,i
	CJNE 	A,#010H,KEYBOARD0051
	MOV  	R3,digit
	MOV  	R5,#02H
	SJMP 	KEYBOARD0169
KEYBOARD0051:
	MOV  	A,i
	CJNE 	A,#020H,KEYBOARD0053
	MOV  	R3,digit
	MOV  	R5,#03H
KEYBOARD0169:
	CLR  	A
	SJMP 	KEYBOARD0170
KEYBOARD0053:
	MOV  	A,i
	MOV  	R3,digit
	CJNE 	A,#030H,KEYBOARD0055
	MOV  	R5,#04H
	CLR  	A
	SJMP 	KEYBOARD0168
KEYBOARD0055:
	CLR  	A
	MOV  	R5,A
KEYBOARD0168:
KEYBOARD0170:
	MOV  	R7,A
	LCALL	_print_char
	SJMP 	KEYBOARD0043
KEYBOARD0044:
	MOV  	A,digit
	CJNE 	A,#0FH,KEYBOARD0059
	MOV  	R7,#01H
	SJMP 	KEYBOARD0060
KEYBOARD0059:
	MOV  	R7,#00H
KEYBOARD0060:
	MOV  	A,i
	SETB 	C
	SUBB 	A,#00H
	JC   	KEYBOARD0061
	MOV  	R6,#01H
	SJMP 	KEYBOARD0062
KEYBOARD0061:
	MOV  	R6,#00H
KEYBOARD0062:
	MOV  	A,R6
	ANL  	A,R7
	JZ   	KEYBOARD0058
	CLR  	C
	RET  	
KEYBOARD0058:
	MOV  	A,digit
	CJNE 	A,#0EH,KEYBOARD0064
	SETB 	C
	RET  	
KEYBOARD0064:
	MOV  	A,digit
	CJNE 	A,#0DH,KEYBOARD0067
	MOV  	R7,#01H
	SJMP 	KEYBOARD0068
KEYBOARD0067:
	MOV  	R7,#00H
KEYBOARD0068:
	MOV  	A,i
	SETB 	C
	SUBB 	A,#00H
	JC   	KEYBOARD0069
	MOV  	R6,#01H
	SJMP 	KEYBOARD0070
KEYBOARD0069:
	MOV  	R6,#00H
KEYBOARD0070:
	MOV  	A,R6
	ANL  	A,R7
	JZ   	$ + 5H
	LJMP 	KEYBOARD0036
	DEC  	i
KEYBOARD0043:
	INC  	i
	LJMP 	KEYBOARD0041
	RSEG  input_bits_KEYBOARD  ;定义一个段，表示输入显示位数的键盘处理
input_bits: ;定义一个标签，表示输入显示位数
	USING	0 ;使用寄存器组 0
	CLR  	A ;清除累加器 A 的内容
	MOV  	digit2,A ;将 A 的内容移动到 digit2 中，即 digit2 = 0
	MOV  	R0,#LOW (a2) ;将 a2 的低 8 位地址移动到 R0 中
	MOV  	R4,#HIGH (a2) ;将 a2 的高 8 位地址移动到 R4 中
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R3,#0FFH ;将 0FFH 移动到 R3 中，即 R3 = 255
	MOV  	R2,#HIGH (_?ix1000) ;将 _?ix1000 的高 8 位地址移动到 R2 中
	MOV  	R1,#LOW (_?ix1000) ;将 _?ix1000 的低 8 位地址移动到 R1 中
	MOV  	R6,A ;将 A 的内容移动到 R6 中，即 R6 = 0
	MOV  	R7,#02H ;将 02H 移动到 R7 中，即 R7 = 2
	LCALL	?C?COPY ;调用 ?C?COPY 子程序，将 R1-R7 中的内容复制到 a2 和 _?ix1000 中
	CLR  	state2 ;清除 state2 的内容，即 state2 = 0
	LCALL	wait_input ;调用 wait_input 子程序，等待输入
	MOV  	state2,C ;将进位标志 C 的内容移动到 state2 中
	JNB  	state2,KEYBOARD0074 ;如果 state2 为 0，即没有输入，则跳转到 KEYBOARD0074 处继续执行
	SETB 	C ;如果 state2 不为 0，即有输入，则置位 C
	RET ;返回
KEYBOARD0074: ;定义一个标签，表示键盘输入的处理
	LCALL	clear ;调用 clear 子程序，清除屏幕
	CLR  	A ;清除累加器 A 的内容
	MOV  	i2,A ;将 A 的内容移动到 i2 中，即 i2 = 0
KEYBOARD0076: ;定义一个循环的开始
	MOV  	A,#LOW (a2) ;将 a2 的低 8 位移动到 A 中
	ADD  	A,i2 ;将 A 和 i2 相加，即 A = A + i2
	MOV  	R0,A ;将 A 的内容移动到 R0 中
	CLR  	A ;清除 A 的内容
	MOV  	@R0,A ;将 A 的内容移动到 R0 指向的内存单元中，即清除 a2[i2] 的内容
	INC  	i2 ;将 i2 加 1，即 i2 = i2 + 1
	MOV  	A,i2 ;将 i2 的内容移动到 A 中
	CJNE 	A,#02H,KEYBOARD0076 ;比较 A 和 02H，如果不相等，则跳转到 KEYBOARD0076 处继续循环，否则继续执行
KEYBOARD0077: ;定义一个新的标签
	CLR  	A ;清除 A 的内容
	MOV  	i2,A ;将 A 的内容移动到 i2 中，即 i2 = 0
KEYBOARD0079: ;定义一个新的循环的开始
	MOV  	A,i2 ;将 i2 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#03H ;将 A 和 03H 相减，即 A = A - 03H
	JNC  	KEYBOARD0074 ;如果没有进位，即 A >= 03H，则跳转到 KEYBOARD0074 处继续执行
	LCALL	kscan ;如果有进位，即 A < 03H，则调用 kscan 子程序，扫描键盘输入
	MOV  	digit2,R7 ;将 R7 的内容移动到 digit2 中，即 digit2 = R7
	MOV  	A,digit2 ;将 digit2 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0083 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0083 处继续执行
	MOV  	R7,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R7 中，即 R7 = 01H
	SJMP 	KEYBOARD0084 ;无条件跳转到 KEYBOARD0084 处继续执行
KEYBOARD0083: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0084: ;定义一个新的标签
	MOV  	A,i2 ;将 i2 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#02H ;将 A 和 02H 相减，即 A = A - 02H
	JNC  	KEYBOARD0085 ;如果没有进位，即 A >= 02H，则跳转到 KEYBOARD0085 处继续执行
	MOV  	R6,#01H ;如果有进位，即 A < 02H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0086 ;无条件跳转到 KEYBOARD0086 处继续执行
KEYBOARD0085: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0086: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	MOV  	R7,A ;将 A 的内容移动到 R7 中
	MOV  	A,digit2 ;将 digit2 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#09H ;将 A 和 09H 相减，即 A = A - 09H
	JNC  	KEYBOARD0087 ;如果没有进位，即 A >= 09H，则跳转到 KEYBOARD0087 处继续执行
	MOV  	R6,#01H ;如果有进位，即 A < 09H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0088 ;无条件跳转到 KEYBOARD0088 处继续执行
KEYBOARD0087: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0088: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JZ   	KEYBOARD0082 ;如果 A 为 0，则跳转到 KEYBOARD0082 处继续执行
	MOV  	A,#LOW (a2) ;将 a2 的低 8 位移动到 A 中
	ADD  	A,i2 ;将 A 和 i2 相加，即 A = A + i2
	MOV  	R0,A ;将 A 的内容移动到 R0 中
	MOV  	@R0,digit2 ;将 digit2 的内容移动到 R0 指向的内存单元中，即 a2[i2] = digit2
	MOV  	A,digit2 ;将 digit2 的内容移动到 A 中
	ADD  	A,#030H ;将 A 和 030H 相加，即 A = A + 030H
	MOV  	R3,A ;将 A 的内容移动到 R3 中
	CLR  	A ;清除 A 的内容
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R7,A ;将 A 的内容移动到 R7 中，即 R7 = 0
	LCALL	_print_char ;调用 _print_char 子程序，打印字符
	LJMP 	KEYBOARD0081 ;无条件跳转到 KEYBOARD0081 处继续执行
KEYBOARD0082: ;定义一个新的标签
	MOV  	A,digit2 ;将 digit2 的内容移动到 A 中
	CJNE 	A,#0FH,KEYBOARD0091 ;比较 A 和 0FH，如果不相等，则跳转到 KEYBOARD0091 处继续执行
	MOV  	R7,#01H ;如果相等，则将 01H 移动到 R7 中，即 R7 = 1
	SJMP 	KEYBOARD0092 ;无条件跳转到 KEYBOARD0092 处继续执行
KEYBOARD0091: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0092: ;定义一个新的标签
	MOV  	A,i2 ;将 i2 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0093 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0093 处继续执行
	MOV  	R6,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0094 ;无条件跳转到 KEYBOARD0094 处继续执行
KEYBOARD0093: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0094: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JZ   	KEYBOARD0090 ;如果 A 为 0，则跳转到 KEYBOARD0090 处继续执行
	MOV  	A,i2 ;将 i2 的内容移动到 A 中
	CJNE 	A,#01H,KEYBOARD0095 ;比较 A 和 01H，如果不相等，则跳转到 KEYBOARD0095 处继续执行
	MOV  	bits,a2 ;如果相等，则将 a2 的内容移动到 bits 中，即 bits = a2
	SJMP 	KEYBOARD0096 ;无条件跳转到 KEYBOARD0096 处继续执行
KEYBOARD0095: ;定义一个新的标签
	MOV  	A,a2 ;将 a2 的内容移动到 A 中
	MOV  	B,#0AH ;将 0AH 移动到 B 中，即 B = 10
	MUL  	AB ;将 A 和 B 相乘，即 A = A * B
	ADD  	A,a2+01H ;将 A 和 a2+01H 相加，即 A = A + a2+01H
	MOV  	bits,A ;将 A 的内容移动到 bits 中，即 bits = A
KEYBOARD0096: ;定义一个新的标签
	MOV  	A,bits ;将 bits 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#040H ;将 A 和 040H 相减，即 A = A - 040H
	JNC  	KEYBOARD0098 ;如果没有进位，即 A >= 040H，则跳转到 KEYBOARD0098 处继续执行
	MOV  	R7,#01H ;如果有进位，即 A < 040H，则将 01H 移动到 R7 中，即 R7 = 1
	SJMP 	KEYBOARD0099 ;无条件跳转到 KEYBOARD0099 处继续执行
KEYBOARD0098: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0099: ;定义一个新的标签
	MOV  	A,bits ;将 bits 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#01H ;将 A 和 01H 相减，即 A = A - 01H
	JC   	KEYBOARD0100 ;如果有进位，即 A < 01H，则跳转到 KEYBOARD0100 处继续执行
	MOV  	R6,#01H ;如果没有进位，即 A >= 01H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0101 ;无条件跳转到 KEYBOARD0101 处继续执行
KEYBOARD0100: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0101: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JZ   	KEYBOARD0097 ;如果 A 为 0，则跳转到 KEYBOARD0097 处继续执行
	CLR  	C ;清除进位标志 C
	RET ;返回
KEYBOARD0097: ;定义一个新的标签
	LCALL	wrong_input_bits ;调用 wrong_input_bits 子程序，处理错误的输入位
	JC   	$ + 5H ;如果有进位，即输入位错误，则跳转到下面的 RET 指令
	LJMP 	KEYBOARD0074 ;如果没有进位，即输入位正确，则无条件跳转到 KEYBOARD0074 处继续执行
	RET  	;返回
KEYBOARD0090: ;定义一个新的标签
	MOV  	A,digit2 ;将 digit2 的内容移动到 A 中
	CJNE 	A,#0EH,KEYBOARD0106 ;比较 A 和 0EH，如果不相等，则跳转到 KEYBOARD0106 处继续执行
	SETB 	C ;如果相等，则置位进位标志 C
	RET  	;返回
KEYBOARD0106: ;定义一个新的标签
	MOV  	A,digit2 ;将 digit2 的内容移动到 A 中
	CJNE 	A,#0DH,KEYBOARD0109 ;比较 A 和 0DH，如果不相等，则跳转到 KEYBOARD0109 处继续执行
	MOV  	R7,#01H ;如果相等，则将 01H 移动到 R7 中，即 R7 = 1
	SJMP 	KEYBOARD0110 ;无条件跳转到 KEYBOARD0110 处继续执行
KEYBOARD0109: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0110: ;定义一个新的标签
	MOV  	A,i2 ;将 i2 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0111 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0111 处继续执行
	MOV  	R6,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0112 ;无条件跳转到 KEYBOARD0112 处继续执行
KEYBOARD0111: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0112: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JZ   	$ + 5H ;如果 A 为 0，则跳转到下面的 DEC 指令
	LJMP 	KEYBOARD0074 ;如果 A 不为 0，则无条件跳转到 KEYBOARD0074 处继续执行
	DEC  	i2 ;将 i2 减 1，即 i2 = i2 - 1
KEYBOARD0081: ;定义一个新的标签
	INC  	i2 ;将 i2 加 1，即 i2 = i2 + 1
	LJMP 	KEYBOARD0079 ;无条件跳转到 KEYBOARD0079 处继续执行
	RSEG  input_display_time_KEYBOARD ;定义一个段，表示输入显示时间的键盘处理
input_display_time: ;定义一个标签，表示输入显示时间的处理
	USING	0 ;使用寄存器组 0
	CLR  	A ;清除累加器 A 的内容
	MOV  	digit1,A ;将 A 的内容移动到 digit1 中，即 digit1 = 0
	MOV  	R0,#LOW (a1) ;将 a1 的低 8 位移动到 R0 中
	MOV  	R4,#HIGH (a1) ;将 a1 的高 8 位移动到 R4 中
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R3,#0FFH ;将 0FFH 移动到 R3 中，即 R3 = 255
	MOV  	R2,#HIGH (_?ix1001) ;将 _?ix1001 的高 8 位移动到 R2 中
	MOV  	R1,#LOW (_?ix1001) ;将 _?ix1001 的低 8 位移动到 R1 中
	MOV  	R6,A ;将 A 的内容移动到 R6 中，即 R6 = 0
	MOV  	R7,#05H ;将 05H 移动到 R7 中，即 R7 = 5
	LCALL	?C?COPY ;调用 ?C?COPY 子程序，将 R1-R7 中的内容复制到 a1 和 _?ix1001 中
	CLR  	state1 ;清除 state1 的内容，即 state1 = 0
	LCALL	wait_input ;调用 wait_input 子程序，等待输入
	MOV  	state1,C ;将进位标志 C 的内容移动到 state1 中
	JNB  	state1,KEYBOARD0116 ;如果 state1 为 0，即没有输入，则跳转到 KEYBOARD0116 处继续执行
	SETB 	C ;如果 state1 不为 0，即有输入，则置位 C
	RET  	;返回
KEYBOARD0116: ;定义一个标签，表示键盘输入的处理
	LCALL	clear ;调用 clear 子程序，清除屏幕
	CLR  	A ;清除累加器 A 的内容
	MOV  	i1,A ;将 A 的内容移动到 i1 中，即 i1 = 0
KEYBOARD0118: ;定义一个循环的开始
	MOV  	A,#LOW (a1) ;将 a1 的低 8 位移动到 A 中
	ADD  	A,i1 ;将 A 和 i1 相加，即 A = A + i1
	MOV  	R0,A ;将 A 的内容移动到 R0 中
	CLR  	A ;清除 A 的内容
	MOV  	@R0,A ;将 A 的内容移动到 R0 指向的内存单元中，即清除 a1[i1] 的内容
	INC  	i1 ;将 i1 加 1，即 i1 = i1 + 1
	MOV  	A,i1 ;将 i1 的内容移动到 A 中
	CJNE 	A,#05H,KEYBOARD0118 ;比较 A 和 05H，如果不相等，则跳转到 KEYBOARD0118 处继续循环，否则继续执行
KEYBOARD0119: ;定义一个新的标签
	CLR  	A ;清除 A 的内容
	MOV  	i1,A ;将 A 的内容移动到 i1 中，即 i1 = 0
KEYBOARD0121: ;定义一个新的循环的开始
	MOV  	A,i1 ;将 i1 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#06H ;将 A 和 06H 相减，即 A = A - 06H
	JNC  	KEYBOARD0116 ;如果没有进位，即 A >= 06H，则跳转到 KEYBOARD0116 处继续执行
	LCALL	kscan ;如果有进位，即 A < 06H，则调用 kscan 子程序，扫描键盘输入
	MOV  	digit1,R7 ;将 R7 的内容移动到 digit1 中，即 digit1 = R7
	MOV  	A,digit1 ;将 digit1 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0125 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0125 处继续执行
	MOV  	R7,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R7 中，即 R7 = 1
	SJMP 	KEYBOARD0126 ;无条件跳转到 KEYBOARD0126 处继续执行
KEYBOARD0125: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0126: ;定义一个新的标签
	MOV  	A,i1 ;将 i1 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#05H ;将 A 和 05H 相减，即 A = A - 05H
	JNC  	KEYBOARD0127 ;如果没有进位，即 A >= 05H，则跳转到 KEYBOARD0127 处继续执行
	MOV  	R6,#01H ;如果有进位，即 A < 05H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0128 ;无条件跳转到 KEYBOARD0128 处继续执行
KEYBOARD0127: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0128: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	MOV  	R7,A ;将 A 的内容移动到 R7 中
	MOV  	A,digit1 ;将 digit1 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#09H ;将 A 和 09H 相减，即 A = A - 09H
	JNC  	KEYBOARD0129 ;如果没有进位，即 A >= 09H，则跳转到 KEYBOARD0129 处继续执行
	MOV  	R6,#01H ;如果有进位，即 A < 09H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0130 ;无条件跳转到 KEYBOARD0130 处继续执行
KEYBOARD0129: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0130: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JZ   	KEYBOARD0124 ;如果 A 为 0，则跳转到 KEYBOARD0124 处继续执行
	MOV  	A,#LOW (a1) ;将 a1 的低 8 位移动到 A 中
	ADD  	A,i1 ;将 A 和 i1 相加，即 A = A + i1
	MOV  	R0,A ;将 A 的内容移动到 R0 中
	MOV  	@R0,digit1 ;将 digit1 的内容移动到 R0 指向的内存单元中，即 a1[i1] = digit1
	MOV  	A,digit1 ;将 digit1 的内容移动到 A 中
	ADD  	A,#030H ;将 A 和 030H 相加，即 A = A + 030H
	MOV  	R3,A ;将 A 的内容移动到 R3 中
	CLR  	A ;清除 A 的内容
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R7,A ;将 A 的内容移动到 R7 中，即 R7 = 0
	LCALL	_print_char ;调用 _print_char 子程序，打印字符
	LJMP 	KEYBOARD0123 ;无条件跳转到 KEYBOARD0123 处继续执行
KEYBOARD0124: ;定义一个新的标签
	MOV  	A,digit1 ;将 digit1 的内容移动到 A 中
	CJNE 	A,#0FH,KEYBOARD0133 ;比较 A 和 0FH，如果不相等，则跳转到 KEYBOARD0133 处继续执行
	MOV  	R7,#01H ;如果相等，则将 01H 移动到 R7 中，即 R7 = 1
	SJMP 	KEYBOARD0134 ;无条件跳转到 KEYBOARD0134 处继续执行
KEYBOARD0133: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0134: ;定义一个新的标签
	MOV  	A,i1 ;将 i1 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0135 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0135 处继续执行
	MOV  	R6,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0136 ;无条件跳转到 KEYBOARD0136 处继续执行
KEYBOARD0135: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0136: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JNZ  	$ + 5H ;如果 A 不为 0，则跳转到下面的 LJMP 指令
	LJMP 	KEYBOARD0132 ;如果 A 为 0，则无条件跳转到 KEYBOARD0132 处继续执行
	CLR  	A ;清除 A 的内容
	MOV  	temp1+03H,A ;将 A 的内容移动到 temp1+03H 中，即 temp1+03H = 0
	MOV  	temp1+02H,A ;将 A 的内容移动到 temp1+02H 中，即 temp1+02H = 0
	MOV  	temp1+01H,A ;将 A 的内容移动到 temp1+01H 中，即 temp1+01H = 0
	MOV  	temp1,A ;将 A 的内容移动到 temp1 中，即 temp1 = 0
	MOV  	j1,A ;将 A 的内容移动到 j1 中，即 j1 = 0
KEYBOARD0137: ;定义一个新的标签
	MOV  	A,j1 ;将 j1 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,i1 ;将 A 和 i1 相减，即 A = A - i1
	JNC  	KEYBOARD0138 ;如果没有进位，即 A >= i1，则跳转到 KEYBOARD0138 处继续执行
	CLR  	A ;清除 A 的内容
	MOV  	R7,#0AH ;将 0AH 移动到 R7 中，即 R7 = 10
	MOV  	R6,A ;将 A 的内容移动到 R6 中，即 R6 = 0
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R4,A ;将 A 的内容移动到 R4 中，即 R4 = 0
	MOV  	R3,temp1+03H ;将 temp1+03H 的内容移动到 R3 中
	MOV  	R2,temp1+02H ;将 temp1+02H 的内容移动到 R2 中
	MOV  	R1,temp1+01H ;将 temp1+01H 的内容移动到 R1 中
	MOV  	R0,temp1 ;将 temp1 的内容移动到 R0 中
	LCALL	?C?LMUL ;调用 ?C?LMUL 子程序，将 R0-R7 中的内容相乘，即 R0-R7 = R0-R3 * R4-R7
	PUSH 	AR4 ;将 R4 的内容压入堆栈
	MOV  	R1,AR5 ;将 R5 的内容移动到 R1 中
	MOV  	R2,AR6 ;将 R6 的内容移动到 R2 中
	MOV  	R3,AR7 ;将 R7 的内容移动到 R3 中
	MOV  	A,#LOW (a1) ;将 a1 的低 8 位移动到 A 中
	ADD  	A,j1 ;将 A 和 j1 相加，即 A = A + j1
	MOV  	R0,A ;将 A 的内容移动到 R0 中
	MOV  	A,@R0 ;将 R0 指向的内存单元的内容移动到 A 中，即 A = a1[j1]
	MOV  	R7,A ;将 A 的内容移动到 R7 中
	CLR  	A ;清除 A 的内容
	MOV  	R4,A ;将 A 的内容移动到 R4 中，即 R4 = 0
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R6,A ;将 A 的内容移动到 R6 中，即 R6 = 0
	POP  	AR0 ;将堆栈顶部的内容弹出到 R0 中，即 R0 = R4
	MOV  	A,R3 ;将 R3 的内容移动到 A 中
	ADD  	A,R7 ;将 A 和 R7 相加，即 A = A + R7
	MOV  	temp1+03H,A ;将 A 的内容移动到 temp1+03H 中
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ADDC 	A,R2 ;将 A 和 R2 相加，带进位，即 A = A + R2 + C
	MOV  	temp1+02H,A ;将 A 的内容移动到 temp1+02H 中
	MOV  	A,R5 ;将 R5 的内容移动到 A 中
	ADDC 	A,R1 ;将 A 和 R1 相加，带进位，即 A = A + R1 + C
	MOV  	temp1+01H,A ;将 A 的内容移动到 temp1+01H 中
	MOV  	A,R4 ;将 R4 的内容移动到 A 中
	ADDC 	A,R0 ;将 A 和 R0 相加，带进位，即 A = A + R0 + C
	MOV  	temp1,A ;将 A 的内容移动到 temp1 中
	INC  	j1 ;将 j1 加 1，即 j1 = j1 + 1
	SJMP 	KEYBOARD0137 ;无条件跳转到 KEYBOARD0137 处继续循环
KEYBOARD0138: ;定义一个新的标签
	CLR  	A ;清除 A 的内容
	MOV  	R7,#0FFH ;将 0FFH 移动到 R7 中，即 R7 = 255
	MOV  	R6,#0FFH ;将 0FFH 移动到 R6 中，即 R6 = 255
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R4,A ;将 A 的内容移动到 R4 中，即 R4 = 0
	MOV  	R3,temp1+03H ;将 temp1+03H 的内容移动到 R3 中
	MOV  	R2,temp1+02H ;将 temp1+02H 的内容移动到 R2 中
	MOV  	R1,temp1+01H ;将 temp1+01H 的内容移动到 R1 中
	MOV  	R0,temp1 ;将 temp1 的内容移动到 R0 中
	SETB 	C ;置位进位标志 C
	LCALL	?C?ULCMP ;调用 ?C?ULCMP 子程序，将 R0-R7 中的内容相比较，即 R0-R3 和 R4-R7
	JNC  	KEYBOARD0141 ;如果没有进位，即 R0-R3 >= R4-R7，则跳转到 KEYBOARD0141 处继续执行
	MOV  	R7,#01H ;如果有进位，即 R0-R3 < R4-R7，则将 01H 移动到 R7 中，即 R7 = 1
	PUSH 	AR7 ;将 R7 的内容压入堆栈
	SJMP 	KEYBOARD0142 ;无条件跳转到 KEYBOARD0142 处继续执行
KEYBOARD0141: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
	PUSH 	AR7 ;将 R7 的内容压入堆栈
KEYBOARD0142: ;定义一个新的标签
	CLR  	A ;清除 A 的内容
	MOV  	R7,#032H ;将 032H 移动到 R7 中，即 R7 = 50
	MOV  	R6,A ;将 A 的内容移动到 R6 中，即 R6 = 0
	MOV  	R5,A ;将 A 的内容移动到 R5 中，即 R5 = 0
	MOV  	R4,A ;将 A 的内容移动到 R4 中，即 R4 = 0
	MOV  	R3,temp1+03H ;将 temp1+03H 的内容移动到 R3 中
	MOV  	R2,temp1+02H ;将 temp1+02H 的内容移动到 R2 中
	MOV  	R1,temp1+01H ;将 temp1+01H 的内容移动到 R1 中
	MOV  	R0,temp1 ;将 temp1 的内容移动到 R0 中
	CLR  	C ;清除进位标志 C
	LCALL	?C?ULCMP ;调用 ?C?ULCMP 子程序，将 R0-R7 中的内容相比较，即 R0-R3 和 R4-R7
	JC   	KEYBOARD0143 ;如果有进位，即 R0-R3 < R4-R7，则跳转到 KEYBOARD0143 处继续执行
	MOV  	R6,#01H ;如果没有进位，即 R0-R3 >= R4-R7，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0144 ;无条件跳转到 KEYBOARD0144 处继续执行
KEYBOARD0143: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0144: ;定义一个新的标签
	POP  	ACC ;将堆栈顶部的内容弹出到 ACC 中，即 ACC = R7
	ANL  	A,R6 ;将 A 和 R6 进行逻辑与运算，即 A = A & R6
	JZ   	KEYBOARD0140 ;如果 A 为 0，则跳转到 KEYBOARD0140 处继续执行
	MOV  	display_time,temp1+02H ;将 temp1+02H 的内容移动到 display_time 中
	MOV  	display_time+01H,temp1+03H ;将 temp1+03H 的内容移动到 display_time+01H 中
	CLR  	C ;清除进位标志 C
	RET  	;返回
KEYBOARD0140: ;定义一个新的标签
	LCALL	wrong_display_time ;调用 wrong_display_time 子程序，显示错误的输入时间
	JC   	$ + 5H ;如果有进位，即输入时间错误，则跳转到下面的 LJMP 指令
	LJMP 	KEYBOARD0116 ;如果没有进位，即输入时间正确，则无条件跳转到 KEYBOARD0116 处继续执行
	RET  	;返回
KEYBOARD0132: ;定义一个新的标签
	MOV  	A,digit1 ;将 digit1 的内容移动到 A 中
	CJNE 	A,#0EH,KEYBOARD0149 ;比较 A 和 0EH，如果不相等，则跳转到 KEYBOARD0149 处继续执行
	SETB 	C ;如果相等，则置位 C
	RET  	;返回
KEYBOARD0149: ;定义一个新的标签
	MOV  	A,digit1 ;将 digit1 的内容移动到 A 中
	CJNE 	A,#0DH,KEYBOARD0152 ;比较 A 和 0DH，如果不相等，则跳转到 KEYBOARD0152 处继续执行
	MOV  	R7,#01H ;如果相等，则将 01H 移动到 R7 中，即 R7 = 1
	SJMP 	KEYBOARD0153 ;无条件跳转到 KEYBOARD0153 处继续执行
KEYBOARD0152: ;定义一个新的标签
	MOV  	R7,#00H ;将 00H 移动到 R7 中，即 R7 = 0
KEYBOARD0153: ;定义一个新的标签
	MOV  	A,i1 ;将 i1 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0154 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0154 处继续执行
	MOV  	R6,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0155 ;无条件跳转到 KEYBOARD0155 处继续执行
KEYBOARD0154: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0155: ;定义一个新的标签
	MOV  	A,R6 ;将 R6 的内容移动到 A 中
	ANL  	A,R7 ;将 A 和 R7 进行逻辑与运算，即 A = A & R7
	JZ   	$ + 5H ;如果 A 为 0，则跳转到下面的 DEC 指令
	LJMP 	KEYBOARD0116 ;如果 A 不为 0，则无条件跳转到 KEYBOARD0116 处继续执行
	DEC  	i1 ;将 i1 减 1，即 i1 = i1 - 1
KEYBOARD0123: ;定义一个新的标签
	INC  	i1 ;将 i1 加 1，即 i1 = i1 + 1
	LJMP 	KEYBOARD0121 ;无条件跳转到 KEYBOARD0121 处继续执行
	RSEG  wait_input_KEYBOARD ;定义一个段，表示等待输入的键盘处理
wait_input: ;定义一个标签，表示等待输入的处理
	USING	0 ;使用寄存器组 0
	CLR  	state3 ;清除 state3 的内容，即 state3 = 0
KEYBOARD0157: ;定义一个循环的开始
	LCALL	kscan ;调用 kscan 子程序，扫描键盘输入
	MOV  	A,R7 ;将 R7 的内容移动到 A 中
	SETB 	C ;置位进位标志 C
	SUBB 	A,#0FH ;将 A 和 0FH 相减，即 A = A - 0FH
	JNC  	KEYBOARD0160 ;如果没有进位，即 A >= 0FH，则跳转到 KEYBOARD0160 处继续执行
	MOV  	R6,#01H ;如果有进位，即 A < 0FH，则将 01H 移动到 R6 中，即 R6 = 1
	SJMP 	KEYBOARD0161 ;无条件跳转到 KEYBOARD0161 处继续执行
KEYBOARD0160: ;定义一个新的标签
	MOV  	R6,#00H ;将 00H 移动到 R6 中，即 R6 = 0
KEYBOARD0161: ;定义一个新的标签
	MOV  	A,R7 ;将 R7 的内容移动到 A 中
	CLR  	C ;清除进位标志 C
	SUBB 	A,#00H ;将 A 和 00H 相减，即 A = A - 00H
	JC   	KEYBOARD0162 ;如果有进位，即 A < 00H，则跳转到 KEYBOARD0162 处继续执行
	MOV  	R5,#01H ;如果没有进位，即 A >= 00H，则将 01H 移动到 R5 中，即 R5 = 1
	SJMP 	KEYBOARD0163 ;无条件跳转到 KEYBOARD0163 处继续执行
KEYBOARD0162: ; 设置R5为0
	MOV  	R5,#00H
KEYBOARD0163: ; 将R5的值移动到A中，并与R6进行逻辑与运算
	MOV  	A,R5
	ANL  	A,R6
	JZ   	KEYBOARD0157 ; 如果A为0，跳转到KEYBOARD0157
	CJNE 	R7,#0EH,KEYBOARD0164 ; 如果R7不等于0EH，跳转到KEYBOARD0164
	SETB 	state3 ; 否则，设置state3为1
KEYBOARD0164: ; 将state3的值移动到C中，并返回
	MOV  	C,state3
	RET  	
RSEG  wrong_input_bits_KEYBOARD ; 这是一个段名，表示错误的输入位
wrong_input_bits: ; 这是一个标签，表示错误的输入位的处理程序
	USING	0 ; 使用寄存器组0
	LCALL	display_wrong_input_bits ; 调用显示错误输入位的子程序
	LJMP 	f_or_e ; 长跳转到f_or_e
RSEG  wrong_display_time_KEYBOARD ; 这是一个段名，表示错误的显示时间
wrong_display_time: ; 这是一个标签，表示错误的显示时间的处理程序
	USING	0 ; 使用寄存器组0
	LCALL	display_wrong_input_display_time ; 调用显示错误输入显示时间的子程序
	LJMP 	f_or_e ; 长跳转到f_or_e
END ; 结束

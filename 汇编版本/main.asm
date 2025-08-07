/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 08:59:52
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:15:07
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\main.asm
 * @Description:  主函数文件，包括主函数和定时器0的中断服务函数，调用初始化设备函数和猜数字游戏的函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$NOMOD51 ; 禁用51的SFR
NAME	MAIN ; 程序名为MAIN
$include(main.inc) ; 包含main.inc文件
	RSEG  DT_MIAN; 选择数据段
        time_ms:   DS   4 ; 定义4字节的变量time_ms，用于存储毫秒数

	RSEG  main_MAIN; 选择主程序代码段
main: ; 主程序标号
	USING	0 ; 使用寄存器组0
	CLR  	A ; 清零A
	MOV  	time_ms+03H,A ; 清零time_ms
	MOV  	time_ms+02H,A ; 清零time_ms
	MOV  	time_ms+01H,A ; 清零time_ms
	MOV  	time_ms,A ; 清零time_ms
	MOV  	WDTCN,#0DEH ; 向看门狗控制寄存器写入0DEH，禁止看门狗
	MOV  	WDTCN,#0ADH ; 向看门狗控制寄存器写入0ADH，禁止看门狗
	LCALL	Init_Device ; 调用Init_Device函数，初始化设备

MIAN0001: ; 循环标号
	LCALL	games ; 调用games函数，执行猜数游戏
	SJMP 	MIAN0001 ; 无条件跳转到MIAN0001，形成死循环

CSEG	AT	0000BH ; 在0000BH处定义代码段，定时器T0中断入口地址
	LJMP	T0I ; 长跳转到T0I，作为定时器0中断向量

	RSEG  T0I_MIAN; 选择定时器0中断服务程序代码段
	USING	0 ; 使用寄存器组0
T0I: ; 定时器0中断服务程序入口
	PUSH 	ACC ; 将累加器压栈，保存现场
	PUSH 	PSW ; 将程序状态字压栈，保存现场
	MOV  	TL0,#030H ; 将030H赋值给TL0，设置定时器0的低字节
	MOV  	TH0,#0F8H ; 将0F8H赋值给TH0，设置定时器0的高字节
	MOV  	A,time_ms+03H ; 将time_ms的第4字节赋值给A
	ADD  	A,#01H ; 将A与01H相加，实现毫秒数加1
	MOV  	time_ms+03H,A ; 将A赋值给time_ms的第4字节
	CLR  	A ; 清零A
	ADDC 	A,time_ms+02H ; 将A与time_ms的第3字节相加，考虑进位
	MOV  	time_ms+02H,A ; 将A赋值给time_ms的第3字节
	CLR  	A ; 清零A
	ADDC 	A,time_ms+01H ; 将A与time_ms的第2字节相加，考虑进位
	MOV  	time_ms+01H,A ; 将A赋值给time_ms的第2字节
	CLR  	A ; 清零A
	ADDC 	A,time_ms ; 将A与time_ms的第1字节相加，考虑进位
	MOV  	time_ms,A ; 将A赋值给time_ms的第1字节
	POP  	PSW ; 将程序状态字出栈，恢复现场
	POP  	ACC ; 将累加器出栈，恢复现场
	RETI 	;中断返回，结束中断服务程序
	
	END ; 程序结束

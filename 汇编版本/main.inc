/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 09:10:08
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:15:26
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\main.inc
 * @Description:  主函数头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ; 包含C8051F020的头文件
main_MAIN       SEGMENT CODE ; 定义主程序代码段
T0I_MIAN        SEGMENT CODE ; 定义定时器0中断服务程序代码段
DT_MIAN            SEGMENT DATA ; 定义数据段
	EXTRN	CODE (games) ; 引用外部代码段games
	EXTRN	CODE (Init_Device) ; 引用外部代码段Init_Device
	EXTRN	CODE (?C_STARTUP) ; 引用外部代码段?C_STARTUP
	PUBLIC	time_ms ; 定义公共变量time_ms
	PUBLIC	T0I ; 定义公共函数T0I
	PUBLIC	main ; 定义公共函数main
	
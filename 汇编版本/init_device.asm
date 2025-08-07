/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 10:59:11
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:08:09
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\init_device.asm
 * @Description: 初始化设备文件，包含初始化设备相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$NOMOD51  ; 禁用51的SFR

NAME	INIT_DEVICE ; 定义程序名为 INIT_DEVICE
$include(init_device.inc) ; 包含main.inc文件

	RSEG  Timer_Init_INIT_DEVICE  ; 定义段名为 Timer_Init
Timer_Init: ; 定义 Timer_Init 子程序
	MOV  	CKCON,#08H ; 设置时钟控制寄存器，使 T0 时钟源为系统时钟
	MOV  	TCON,#010H ; 设置定时器控制寄存器，使 T0使用系统时钟
	MOV  	TMOD,#01H ; 设置定时器模式寄存器，使 T0 工作在 16 位定时器模式
	MOV  	TL0,#030H ; 设置 T0 的低 8 位初值为 30H
	MOV  	TH0,#0F8H ; 设置 T0 的高 8 位初值为 F8H
	RET  	; 返回主程序


	RSEG  Port_IO_Init_INIT_DEVICE  ; 定义段名为 Port_IO_Init
Port_IO_Init: ; 定义 Port_IO_Init 子程序
	MOV  	P0MDOUT,#0FFH ; 设置 P0 口为推挽输出
	MOV  	P2MDOUT,#0E0H ; 设置 P2.7-P2.5 为推挽输出，P2.4-P2.0 为漏开
	MOV  	XBR2,#040H ; 使能交叉开关
	RET  	; 返回主程序

	RSEG  Interrupts_Init_INIT_DEVICE  ; 定义段名为 Interrupts_Init
Interrupts_Init: ; 定义 Interrupts_Init 子程序
	MOV  	IE,#082H ; 设置中断控制寄存器，使能 T0 中断和全局中断
	MOV  	IP,#02H ; 设置中断优先级寄存器，使 T0 中断为高优先级
	RET  	; 返回主程序

	RSEG  InInit_Device_INIT_DEVICE ; 定义段名为 Init_Device
Init_Device: ; 定义 Init_Device 子程序
	USING	0 ; 使用寄存器组 0
	LCALL	Timer_Init ; 调用 Timer_Init 子程序
	LCALL	Port_IO_Init ; 调用 Port_IO_Init 子程序
	LCALL	Interrupts_Init ; 调用 Interrupts_Init 子程序
	MOV  	R7,#0AH ; 将0AH赋值给R7，作为随机数种子的低字节
	MOV  	R6,#00H ; 将00H赋值给R6，作为随机数种子的高字节
	LCALL	_srand ; 调用_srand函数，设置随机数种子
	LCALL	lcd_init ; 调用 lcd_init 子程序，初始化液晶显示器
	LCALL	display_startup_logo ; 调用 display_startup_logo 子程序，显示启动画面
	MOV  	R7,#0E8H ; 设置 R7 为 E8H，作为延时参数，延时1000毫秒
	MOV  	R6,#03H ; 设置 R6 为 03H，作为延时参数，延时1000毫秒
	MOV  	R5,#00H ; 设置 R5 为 00H，作为延时参数，延时1000毫秒
	MOV  	R4,#00H ; 设置 R4 为 00H，作为延时参数，延时1000毫秒
	LJMP 	_delay_ms ; 跳转到 _delay_ms 子程序，执行延时，延时1000毫秒
	RET  	; 返回主程序

	END ; 结束程序

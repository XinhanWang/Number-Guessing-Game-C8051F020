/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 10:59:32
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:08:40
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\init_device.inc
 * @Description: 初始化设备头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ; 包含C8051F020芯片的寄存器定义文件
Timer_Init_INIT_DEVICE                SEGMENT CODE ; 定义一个代码段，用于初始化定时器
Port_IO_Init_INIT_DEVICE            SEGMENT CODE ; 定义一个代码段，用于初始化端口输入输出
Interrupts_Init_INIT_DEVICE           SEGMENT CODE ; 定义一个代码段，用于初始化中断
InInit_Device_INIT_DEVICE              SEGMENT CODE ; 定义一个代码段，用于初始化设备
	EXTRN	CODE (display_startup_logo) ; 引用外部代码段display_startup_logo，用于显示启动画面
	EXTRN	CODE (lcd_init) ; 引用外部代码段lcd_init，用于初始化液晶显示屏
	EXTRN	CODE (_delay_ms) ; 引用外部代码段_delay_ms，用于延时毫秒
	EXTRN	CODE (_srand) ; 引用外部代码段_srand，用于设置随机数种子
	PUBLIC	Init_Device ; 声明Init_Device为公共函数，用于初始化设备
	PUBLIC	Interrupts_Init ; 声明Interrupts_Init为公共函数，用于初始化中断
	PUBLIC	Port_IO_Init ; 声明Port_IO_Init为公共函数，用于初始化端口输入输出
	PUBLIC	Timer_Init ; 声明Timer_Init为公共函数，用于初始化定时器

/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:21:38
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:13:20
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\KEYBOARD.inc
 * @Description: 键盘输入头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ; 包含C8051F020的头文件，定义了一些寄存器和位的符号名
kscan_KEYBOARD   SEGMENT CODE ; 定义一个代码段，用于键盘扫描的程序
DT_kscan_KEYBOARD   SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量，可以与其他数据段重叠
f_or_e_KEYBOARD  SEGMENT CODE ; 定义一个代码段，用于判断键盘输入的是数字还是字母
input_digits_KEYBOARD                SEGMENT CODE ; 定义一个代码段，用于输入数字
DT_input_digits_KEYBOARD                SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量，可以与其他数据段重叠
BI_input_digits_KEYBOARD                 SEGMENT BIT OVERLAYABLE ; 定义一个位段，用于存储临时变量，可以与其他位段重叠
input_bits_KEYBOARD                  SEGMENT CODE ; 定义一个代码段，用于输入位
DT_input_bits_KEYBOARD                  SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量，可以与其他数据段重叠
BI_input_bits_KEYBOARD                   SEGMENT BIT OVERLAYABLE ; 定义一个位段，用于存储临时变量，可以与其他位段重叠
input_display_time_KEYBOARD          SEGMENT CODE ; 定义一个代码段，用于输入显示时间
DT_input_display_time_KEYBOARD          SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量，可以与其他数据段重叠
BI_input_display_time_KEYBOARD           SEGMENT BIT OVERLAYABLE ; 定义一个位段，用于存储临时变量，可以与其他位段重叠
wait_input_KEYBOARD                  SEGMENT CODE ; 定义一个代码段，用于等待键盘输入
BI_wait_input_KEYBOARD                   SEGMENT BIT OVERLAYABLE ; 定义一个位段，用于存储临时变量，可以与其他位段重叠
wrong_input_bits_KEYBOARD            SEGMENT CODE ; 定义一个代码段，用于处理错误的位输入
wrong_display_time_KEYBOARD          SEGMENT CODE ; 定义一个代码段，用于处理错误的显示时间输入
CO_KEYBOARD         SEGMENT CODE ; 定义一个代码段
XD_KEYBOARD         SEGMENT XDATA ; 定义一个扩展数据段
	EXTRN	CODE (digits) ; 引用外部代码段，用于显示数字
	EXTRN	CODE (clear) ; 引用外部代码段，用于清屏
	EXTRN	DATA (display_time) ; 引用外部数据段，用于存储显示时间
	EXTRN	CODE (display_wrong_input_display_time) ; 引用外部代码段，用于显示显示时间输入错误
	EXTRN	CODE (_print_char) ; 引用外部代码段，用于打印字符
	EXTRN	DATA (bits) ; 引用外部数据段，用于存储位
	EXTRN	CODE (display_wrong_input_bits) ; 引用外部代码段，用于显示错误的位输入
	EXTRN	CODE (_delay_ms) ; 引用外部代码段，用于延时毫秒
	EXTRN	CODE (?C?CCASE) ; 引用外部代码段，用于实现C语言的switch-case语句
	EXTRN	CODE (?C?COPY) ; 引用外部代码段，用于实现C语言的内存复制函数
	EXTRN	CODE (?C?LMUL) ; 引用外部代码段，用于实现C语言的长整数乘法函数
	EXTRN	CODE (?C?ULCMP) ; 引用外部代码段，用于实现C语言的无符号长整数比较函数
	PUBLIC	inputs ; 将inputs代码段声明为公共的，可以被其他模块调用
	PUBLIC	wrong_display_time ; 将wrong_display_time代码段声明为公共的，可以被其他模块调用
	PUBLIC	wrong_input_bits ; 将wrong_input_bits代码段声明为公共的，可以被其他模块调用
	PUBLIC	wait_input ; 将wait_input代码段声明为公共的，可以被其他模块调用
	PUBLIC	input_display_time ; 将input_display_time代码段声明为公共的，可以被其他模块调用
	PUBLIC	input_bits ; 将input_bits代码段声明为公共的，可以被其他模块调用
	PUBLIC	input_digits ; 将input_digits代码段声明为公共的，可以被其他模块调用
	PUBLIC	f_or_e ; 将f_or_e代码段声明为公共的，可以被其他模块调用
	PUBLIC	kscan ; 将kscan代码段声明为公共的，可以被其他模块调用

	
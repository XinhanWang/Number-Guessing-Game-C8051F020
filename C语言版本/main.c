/*
 * @Author: 王心瀚
 * @Date: 2023-11-23 19:30:43
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:49:45
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\main.c
 * @Description: 主函数文件，包括主函数和定时器0的中断服务函数，调用初始化设备函数和猜数字游戏的函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
// 包含C8051F020芯片的头文件
#include "C8051F020.h"
// 包含LCD12864液晶显示屏的头文件
#include "LCD12864.h"
// 包含键盘输入的头文件
#include "keyboard.h"
// 包含显示的头文件
#include "display.h"
// 包含猜数字游戏的头文件
#include "guessing_game.h"
// 声明初始化设备的函数
void Init_Device(void);

// 定义一个无符号长整型变量，用于存储时间（毫秒）
unsigned long data time_ms;
// 主函数
void main(void)
{
	//当前时间初始化为0
	time_ms=0;
	// 关闭看门狗定时器
	WDTCN     = 0xDE;
  	WDTCN     = 0xAD;
	// 调用初始化设备的函数
	Init_Device();
/*WDTCN=0xA5;
WDTCN=0xA5;
	*/
	// 无限循环
	while(1)
   {
		 /*
      #WDTCN=0xA5;
		 */
		// 调用猜数字游戏的函数
		games();
   }
}

// 定时器0的中断服务函数
void T0I(void) interrupt 1
{	
	// 设置定时器0的低8位为0x30
	TL0       = 0x30;
	// 设置定时器0的高8位为0xF8
  	TH0       = 0xF8;
	// 时间变量加1
	time_ms++;
}



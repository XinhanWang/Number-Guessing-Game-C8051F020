/*
 * @Author: 王心瀚
 * @Date: 2023-12-19 11:10:32
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:56:51
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\time.c
 * @Description: 时间文件，包含时间相关的函数(延时ms函数)
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
#include "time.h" //包含时间相关的头文件
void delay_ms(unsigned long a) //定义一个函数delay_ms，用来延时a毫秒
{
	unsigned long data time_ms_start=time_ms; //定义一个变量time_ms_start，用来存储开始的时间
	while(1) //无限循环
	{
		if(time_ms-time_ms_start==a) //如果当前时间减去开始时间等于a
			break; //跳出循环
	}
}




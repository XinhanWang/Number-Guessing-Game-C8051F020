/*
 * @Author: 王心瀚
 * @Date: 2023-12-19 11:10:50
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:57:30
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\time.h
 * @Description: 时间头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
#ifndef time //如果没有定义time宏
#define time //则定义time宏
extern unsigned long time_ms; //声明一个外部变量time_ms，用来存储当前时间

void delay_ms(unsigned long); //声明一个函数delay_ms，用来延时指定的毫秒数
#endif //结束条件编译

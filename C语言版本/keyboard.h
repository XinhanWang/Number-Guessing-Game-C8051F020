/*
 * @Author: 王心瀚
 * @Date: 2023-11-23 22:02:50
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:54:13
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\keyboard.h
 * @Description: 键盘输入头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
//这种定义方式是防止头文件内容的重复定义
#ifndef KEYBOARD //如果没有定义KEYBOARD宏
#define KEYBOARD //则定义KEYBOARD宏
#include "C8051F020.h" //包含C8051F020单片机的头文件
#include "time.h" //包含时间相关的头文件
#include "LCD12864.h" //包含LCD12864液晶显示屏的头文件
#include "display.h" //包含显示相关的头文件
extern unsigned char bits; //声明一个外部变量bits，用来存储输入的位数
extern unsigned int display_time; //声明一个外部变量display_time，用来存储显示的时间
extern unsigned char code digits[]; //声明一个外部常量数组digits，用来存储数字0-F的显示码
unsigned char kscan(void); //声明一个函数kscan，用来扫描键盘输入
bit input_digits(void); //声明一个函数input_digits，用来输入位数
bit input_bits(void); //声明一个函数input_bits，用来输入显示数据位数
bit input_display_time(void); //声明一个函数input_display_time，用来输入显示时间
bit wait_input(void); //声明一个函数wait_input，用来等待用户输入
bit f_or_e(void); //声明一个函数f_or_e，用来判断用户输入的是F还是E
bit wrong_input_bits(void); //声明一个函数wrong_input_bits，用来显示输入位数错误的信息
bit wrong_display_time(void); //声明一个函数wrong_display_time，用来显示输入显示时间错误的信息
#endif //结束条件编译

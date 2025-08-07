/*
 * @Author: 王心瀚
 * @Date: 2023-12-20 11:16:05
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:52:20
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\guessing_game.h
 * @Description: 猜数游戏头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
//这种定义方式是防止头文件内容的重复定义
#ifndef GUESSING //如果没有定义GUESSING宏
#define GUESSING //则定义GUESSING宏
#include "C8051F020.h" //包含C8051F020单片机的头文件
#include "time.h" //包含时间相关的头文件
#include "LCD12864.h" //包含LCD12864液晶显示屏的头文件
#include "keyboard.h" //包含键盘相关的头文件
#include "display.h" //包含显示相关的头文件
#include <stdlib.h> //包含标准库的头文件
extern unsigned char xdata inputs[64]; //声明一个XRAM中的数据数组inputs，用来存储用户输入的数字
unsigned char guess_once(void); //声明一个函数guess_once，用来进行一次猜数游戏
void gussing_game(void); //声明一个函数gussing_game，用来进行猜数游戏
void mode3(void); //声明一个函数mode3，用来进行随机模式的游戏
unsigned char mode_select(void); //声明一个函数mode_select，用来选择游戏模式
unsigned char main_menu(void); //声明一个函数main_menu，用来显示主菜单
void games(void); //声明一个函数games，用来进行游戏
#endif //结束条件编译

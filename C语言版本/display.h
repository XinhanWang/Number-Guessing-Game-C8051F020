/*
 * @Author: 王心瀚
 * @Date: 2023-12-20 09:55:35
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:51:14
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\display.h
 * @Description: 显示头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
//这种定义方式是防止头文件内容的重复定义
#ifndef DISPLAY //如果没有定义DISPLAY宏
#define DISPLAY //则定义DISPLAY宏
#include "C8051F020.h" //包含C8051F020单片机的头文件
#include "LCD12864.h" //包含LCD12864液晶显示屏的头文件
#include <stdlib.h> //包含标准库的头文件
extern unsigned char bits; //声明一个外部变量bits，用来存储输入的显示数据位数
extern unsigned int display_time; //声明一个外部变量display_time，用来存储显示的时间
extern unsigned char code digits[]; //声明一个外部常量数组digits，用来存储0-F的显示码
extern unsigned char xdata random_digits[64]; //声明一个外部扩展数据数组random_digits，用来存储随机的数字
extern unsigned char code zhu[]; //声明一个外部常量数组zhu，用来存储可爱小猪的图片
extern unsigned char code sft[]; //声明一个外部常量数组sft，用来存储未来技术学院的院徽
extern unsigned char code hust[]; //声明一个外部常量数组hust，用来存储华中科技大学的LOGO(HUST)
extern unsigned char code csyx[]; //声明一个外部常量数组csyx，用来存储猜数游戏的LOGO
extern unsigned char code xxdj[]; //声明一个外部常量数组xxdj，用来存储谢谢大家的图片
void display_mode_select(void); //声明一个函数display_mode_select，用来显示模式选择
void display_bits_select(void); //声明一个函数display_bits_select，用来显示位数选择
void display_time_select(void); //声明一个函数display_time_select，用来显示时间选择
void display_begin_select(void); //声明一个函数display_begin_select，用来显示开始选择
void display_correct(void); //声明一个函数display_correct，用来显示正确
void display_error(void); //声明一个函数display_error，用来显示错误
void display_win(void); //声明一个函数display_win，用来显示闯关成功
void display_main_menu(void); //声明一个函数display_main_menu，用来显示主菜单
void display_startup_logo(void); //声明一个函数display_startup_logo，用来显示启动的LOGO
void display_input(void); //声明一个函数display_input，用来显示输入
void display_lose(void); //声明一个函数display_lose，用来显示闯关失败
void display_random_digits(void); //声明一个函数display_random_digits，用来显示随机的数字
void display_wrong_input_bits(void); //声明一个函数display_wrong_input_bits，用来显示输入位数非法
void display_wrong_input_display_time(void); //声明一个函数display_wrong_input_display_time，用来显示输入显示时间非法
void display_picture(const unsigned  char *ptr); //声明一个函数display_picture，传入一个常量字符指针ptr，用来显示图片
void display_gussing_game(void); //声明一个函数display_gussing_game，用来显示猜数游戏的LOGO
void print_acknowledgement(void); //声明一个函数print_acknowledgement，用来打印致谢的内容
void display_acknowledgement(void); //声明一个函数display_acknowledgement，用来显示致谢的画面
#endif //结束条件编译

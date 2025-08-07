/*
 * @Author: 王心瀚
 * @Date: 2023-11-23 21:06:54
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-25 07:59:57
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\LCD12864.h
 * @Description: LCD12864头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
//这种定义方式是防止头文件内容的重复定义
#ifndef LCD12864 //如果没有定义LCD12864这个宏
#define LCD12864 //则定义LCD12864这个宏

#include "C8051F020.h" //包含C8051F020单片机的头文件
#include "time.h" //包含时间相关的头文件
#define LCD_data P0  //定义LCD_data为P0端口，用于传输数据
#define LCD_read_write P0MDOUT //定义LCD_read_write为P0端口的输出模式
#define uchar unsigned char //定义uchar为无符号字符类型
#define uint  unsigned int //定义uint为无符号整数类型

sbit LCD_RS=P2^5; //定义LCD_RS为P2端口的第5位，用于选择指令或数据
sbit LCD_RW=P2^6; //定义LCD_RW为P2端口的第6位，用于选择读或写
sbit LCD_EN=P2^7; //定义LCD_EN为P2端口的第7位，用于使能LCD
sbit D0=LCD_data^0; //定义D0为LCD_data的第0位，用于传输第0位数据
sbit D1=LCD_data^1; //定义D1为LCD_data的第1位，用于传输第1位数据
sbit D2=LCD_data^2; //定义D2为LCD_data的第2位，用于传输第2位数据
sbit D3=LCD_data^3; //定义D3为LCD_data的第3位，用于传输第3位数据
sbit D4=LCD_data^4; //定义D4为LCD_data的第4位，用于传输第4位数据
sbit D5=LCD_data^5; //定义D5为LCD_data的第5位，用于传输第5位数据
sbit D6=LCD_data^6; //定义D6为LCD_data的第6位，用于传输第6位数据
sbit D7=LCD_data^7; //定义D7为LCD_data的第7位，用于传输第7位数据

void lcd_init(void); //声明lcd_init函数，用于初始化LCD
void Draw_PM(const unsigned  char *); //声明Draw_PM函数，用于绘制点阵图
void print(unsigned char x,unsigned char y,const unsigned char* str); //声明print函数，用于在指定位置显示字符串
void clear(void); //声明clear函数，用于清屏
void print_char(unsigned char x,unsigned char y,unsigned char a); //声明print_char函数，用于在指定位置显示字符
void cursor_shift_contorl(void);//声明cursor_shift_contorl函数，用于游标左移
#endif //结束条件编译

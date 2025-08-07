/*
 * @Author: 王心瀚
 * @Date: 2023-11-23 21:04:30
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-25 07:58:57
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\LCD12864.c
 * @Description: LCD12864文件，包含LCD12864显示相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
// 包含LCD12864液晶显示屏的头文件
#include "LCD12864.h"

// 定义设置LCD读写模式的函数
void set_LCD_read_write(void)
{
	// 如果LCD_RW为0，表示写模式，将LCD_read_write设为0xFF，推挽输出
	if(LCD_RW==0)
	{
		LCD_read_write= 0xFF;
	}
	// 否则，表示读模式，将LCD_read_write设为0x00，将LCD_data设为0xFF，漏开写1作为输入
	else
	{
		LCD_read_write= 0x00;
		LCD_data=0xFF;
	}
}

/*
* 功  能：等待LCD12864空闲
* 参  数：无
* 返回值：无
*/
void wait_lcd_not_busy()
{                          
	// 将LCD_RS设为0，表示选择指令寄存器
	LCD_RS = 0;
	// 将LCD_RW设为1，表示读取状态
	LCD_RW = 1;
	// 调用设置LCD读写模式的函数
	set_LCD_read_write();
	// 将LCD_EN设为1
	LCD_EN = 1;
	// 等待D7为0，表示LCD空闲
	while(D7);
	// 将LCD_EN设为0
	LCD_EN = 0;
}

/*
* 功  能：写指令到LCD
* 参  数：要写入的指令
* 返回值：无
*/
void lcd_wcmd(uchar cmd)
{                          
	// 调用等待LCD空闲的函数
	wait_lcd_not_busy();
	// 将LCD_RS设为0，表示选择指令寄存器
	LCD_RS = 0;
	// 将LCD_RW设为0，表示写入数据
	LCD_RW = 0;
	// 调用设置LCD读写模式的函数
	set_LCD_read_write();
	// 将要写入的指令赋值给LCD_data
	LCD_data = cmd;
	// 延时1毫秒
	delay_ms(1);
	// 将LCD_EN设为1
	LCD_EN = 1;
	// 延时1毫秒
	delay_ms(1);
	// 将LCD_EN设为0
	LCD_EN = 0;  
}

/*
* 功  能：LCD写数据
* 参  数：要写入的数据
* 返回值：无
*/
void lcd_wdat(uchar dat)
{                          
	// 调用等待LCD空闲的函数
	wait_lcd_not_busy();
	// 将LCD_RS设为1，表示选择数据寄存器
	LCD_RS = 1;
	// 将LCD_RW设为0，表示写入数据
	LCD_RW = 0;
	// 调用设置LCD读写模式的函数
	set_LCD_read_write();
	// 将要写入的数据赋值给LCD_data
	LCD_data = dat;
	// 延时1毫秒
	delay_ms(1);
	// 将LCD_EN设为1
	LCD_EN = 1;
	// 延时1毫秒
	delay_ms(1);
	// 将LCD_EN设为0
	LCD_EN = 0;
}

// 定义清除LCD显示内容的函数
void clear(void)
{
	// 写入0x01指令，表示清除LCD的显示内容
	lcd_wcmd(0x01);      
}

/*
* 功  能：LCD初始化
* 参  数：无
* 返回值：无
*/
void lcd_init(void)
{ 
	// 写入0x34指令，表示打开扩充指令操作
	lcd_wcmd(0x34);      
	// 延时5毫秒
	delay_ms(5);
	// 写入0x30指令，表示打开基本指令操作
	lcd_wcmd(0x30);      
	// 延时5毫秒
	delay_ms(5);
	// 写入0x0C指令，表示显示开，关光标
	lcd_wcmd(0x0C);     
	//lcd_wcmd(0x0E);	
	// 延时5毫秒
	delay_ms(5);
	// 写入0x01指令，表示清除LCD的显示内容
	lcd_wcmd(0x01);      
	// 延时5毫秒
	delay_ms(5);
}
/*设置显示位置  xpos(0~7),ypos(1~4)*/
void set_xy(unsigned char xpos,unsigned char ypos)
{
	// 根据ypos的值，选择不同的行地址
	switch(ypos)
	{
		case 1:
			// 写入0x80|xpos指令，表示设置第一行的显示位置
			lcd_wcmd(0X80|xpos);break;
		case 2:
			// 写入0x90|xpos指令，表示设置第二行的显示位置
			lcd_wcmd(0X90|xpos);break;
		case 3:
			// 写入0x88|xpos指令，表示设置第三行的显示位置
			lcd_wcmd(0X88|xpos);break;
		case 4:
			// 写入0x98|xpos指令，表示设置第四行的显示位置
			lcd_wcmd(0X98|xpos);break;
		default:
			// 其他情况，不做任何操作
			break;
	}
}
//设置LCD的游标左移一位的函数
void cursor_shift_contorl(void)
{
	//设置LCD的游标左移一位
	lcd_wcmd(0X10);
}
/*在指定位置显示字符串*/
void print(unsigned char x,unsigned char y,const unsigned char* str)
{ 
	// 定义一个无符号字符变量，用于存储字符串中的字符
	unsigned char lcd_temp; 
	// 调用设置显示位置的函数
	set_xy(x,y);
	// 取出字符串中的第一个字符
	lcd_temp=*str;
		// 当字符不为0x00时，表示字符串未结束
		while(lcd_temp != 0x00) 
		{ 
		// 在LCD上写入该字符
		lcd_wdat(lcd_temp);
		// 取出字符串中的下一个字符
		lcd_temp=*(++str);
		} 
}
/*在指定位置显示字符*/
void print_char(unsigned char x,unsigned char y,unsigned char a)
{ 
	// 调用设置显示位置的函数
	set_xy(x,y);
	// 在LCD上写入该字符
	lcd_wdat(a);
}
/*
* 功  能：在整个液晶屏幕上画图
* 参  数：图片的点阵数据
* 返回值：无
*/
void Draw_PM(const unsigned  char *ptr)
{
	// 定义三个无符号字符变量，用于作为循环计数器
	uchar i, j, k;
	// 写入0x34指令，表示打开扩展指令集
	lcd_wcmd(0x34);        
	// 将i设为0x80，表示从第一行开始
	i = 0x80;
	            
	// 先写上半屏
	// 对于每一行，共32行
	for(j=0; j<32; j++)
	{
		// 写入i指令，表示设置行地址
		lcd_wcmd(i++);
		// 写入0x80指令，表示设置列地址为0
		lcd_wcmd(0x80);
		// 对于每一列，共8*2=16列
		for(k=0; k<16; k++)
		{
			// 在LCD上写入图片的点阵数据
			lcd_wdat(*ptr++);
		}
	}
	// 将i设为0x80，表示从第一行开始
	i = 0x80;
	// 再写下半屏
	// 对于每一行，共32行
	for(j=0; j<32; j++)
	{
		// 写入i指令，表示设置行地址
		lcd_wcmd(i++);
		// 写入0x88指令，表示设置列地址为8
		lcd_wcmd(0x88);	   
		// 对于每一列，共8*2=16列
		for(k=0; k<16; k++)
		{
			// 在LCD上写入图片的点阵数据
			lcd_wdat(*ptr++);
		} 
	}  
	// 写入0x36指令，表示打开绘图显示
	lcd_wcmd(0x36);        
	// 写入0x30指令，表示回到基本指令集
	lcd_wcmd(0x30);        
}

/*
 * @Author: 王心瀚
 * @Date: 2023-11-23 22:02:43
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-25 10:39:36
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\keyboard.c
 * @Description: 键盘处理文件，包含键盘检测、数据输入相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
//包含键盘相关的头文件
#include "keyboard.h"
//定义一个长度为64的无符号字符数组，用于存储输入的数字
unsigned char xdata inputs[64];
//定义一个函数，用于扫描键盘按键，并返回按键对应的值
unsigned char kscan(void)
{
	//定义四个无符号字符变量，用于存储按键的高低位、按键类型和临时值
	unsigned char data keyh,keyl,keytp,temp;
	//设置P1端口的高四位为推挽输出模式
	P1MDOUT=0xF0;
	//设置P1端口的低四位为高电平，做输入
	P1=0X0F; 
	//无限循环，直到检测到按键
	while(1)
	{
	//如果P1端口的低四位不全为高电平，说明有按键按下
	if(P1!=0X0F)
	{	
		//延时10毫秒，消除抖动
		delay_ms(10);
		//再次检测P1端口的低四位，如果仍然不全为高电平，说明按键有效
		if(P1!=0x0f)
		{
			//将P1端口的低四位赋值给keyl，作为按键的低位
			keyl=P1;
			//跳出循环
			break;
		}
	}
	}
		//设置P1端口的低四位为输出模式
		P1MDOUT=0x0F;
		//设置P1端口的高四位为高电平，做输入
		P1=0xf0;
		//延时10毫秒，消除抖动
		delay_ms(10);
		//将P1端口的高四位赋值给keyh，作为按键的高位
		keyh=P1;
		//将按键的高低位进行或运算，得到按键类型
		keytp=keyh|keyl;
		//根据按键类型，用switch语句判断按键对应的值
		switch(keytp)
		{
			//如果按键类型为0xe7，对应的值为0
			case 0xe7: temp=0;break;
			//如果按键类型为0xd7，对应的值为1
			case 0xd7: temp=1;break;
			//如果按键类型为0xb7，对应的值为2
			case 0xb7: temp=2;break;
			//如果按键类型为0x77，对应的值为3
			case 0x77: temp=3;break;
			//如果按键类型为0xeb，对应的值为4
			case 0xeb: temp=4;break;
			//如果按键类型为0xdb，对应的值为5
			case 0xdb: temp=5;break;
			//如果按键类型为0xbb，对应的值为6
			case 0xbb: temp=6;break;
			//如果按键类型为0x7b，对应的值为7
			case 0x7b: temp=7;break;
			//如果按键类型为0xed，对应的值为8
			case 0xed: temp=8;break;
			//如果按键类型为0xdd，对应的值为9
			case 0xdd: temp=9;break;
			//如果按键类型为0xbd，对应的值为10
			case 0xbd: temp=10;break;
			//如果按键类型为0x7d，对应的值为11
			case 0x7d: temp=11;break;
			//如果按键类型为0xee，对应的值为12
			case 0xee: temp=12;break;
			//如果按键类型为0xde，对应的值为13
		  case 0xde: temp=13;break;
			//如果按键类型为0xbe，对应的值为14
			case 0xbe: temp=14;break;
			//如果按键类型为0x7e，对应的值为15
			case 0x7e: temp=15;break;
			//如果按键类型不在以上范围内，不做任何操作
			default:break;
		}
	//设置P1端口的高四位为输出模式
	P1MDOUT=0xF0;
	//设置P1端口的低四位为高电平，做输入
	P1=0X0F; 
	//无限循环，直到检测到按键松开
	while(1)
	{
	//如果P1端口的低四位全为高电平，说明按键松开
	if(P1==0X0F)
	{	
		//延时10毫秒，消除抖动
		delay_ms(10);
             
		//再次检测P1端口的低四位，如果仍然全为高电平，说明按键松开有效
		if(P1==0x0f)
		{
			//跳出循环
			break;
		}
	}
	}
	//返回按键对应的值
	return temp;
}
//定义一个函数，用于判断输入是F还是E
bit f_or_e(void)
{
	//定义一个无符号字符变量，用于存储按键对应的值
	unsigned temp;
	//无限循环，直到检测到有效按键
	while(1)
	{
		//调用kscan函数，获取按键对应的值
		temp=kscan();
		//如果按键对应的值为15(F)，一般情况表示继续，返回0
		if(temp==15)
		{
			//返回0
			return 0;
		}
		//如果按键对应的值为14(E)，表示退出，返回0
		else if(temp==14)
		{
			//返回1
			return 1;
		}
	}
}
//定义一个函数，用于输入数字，并存储在inputs数组中
bit input_digits(void)
{
	//定义两个无符号字符变量，用于存储循环计数和按键对应的值
	unsigned char i,digit=0;
	//定义一个位变量，用于存储是否继续或退出的状态
	bit state=0;
	//调用wait_input函数，等待输入，并获取状态
	state=wait_input();
	//如果状态为1，表示退出(输入了E)
	if(state==1)
	{
		//返回1
		return 1;
	}
	//无限循环，直到检测到有效输入
	while(1)
	{
	//调用clear函数，清屏
	clear();
	//用循环语句，将inputs数组的所有元素初始化为0
	for(i=0;i<64;i++)
	{
		inputs[i]=0;
	}
	//用循环语句，从键盘获取输入的数字，并存储在inputs数组中
	for(i=0;i<65;i++)
	{
		//调用kscan函数，获取按键对应的值
		digit=kscan();
		//如果循环计数小于64，且按键对应的值在0到9之间，表示输入的是数字
		if(i<64&digit>=0&digit<=9)
		{
			//将按键对应的值转换为ASCII码，存储在inputs数组中
			digit=inputs[i]=digits[digit];
			//根据循环计数，调用print_char函数，在不同的位置显示输入的数字
			if(i==16)
				{
					print_char(0,2,digit);
				}
			else if(i==32)
				{
					print_char(0,3,digit);
				}
			else if(i==48)
				{
					print_char(0,4,digit);
				}
			else
				{
					print_char(0,0,digit);
				}
		}
		//如果循环计数大于0，且按键对应的值为15，表示输入结束
		else if(i>0&digit==15)
		{
			//返回0
			return 0;
		}
		//如果按键对应的值为14，表示退出
		else if(digit==14)
		{
			//返回1
			return 1;
		}
		//如果循环计数大于0，且按键对应的值为13，表示重新输入
		else if(i>0&digit==13)
		{
			break;
		}
		//如果循环计数大于0，且按键对应的值为12，表示退格
		else if(i>0&digit==12)
		{
			if(i%2==1)
			{
				//如果输入的数字是12，并且输入的数字是奇数，则打印空格
				// 打印空格字符
				print_char(0, 0, 0x20);
				// 循环计数器减1
				i--;
				// 将输入数组中的第i个元素设置为0
				inputs[i] = 0;
				// 执行光标移动操作，左移一位
				cursor_shift_contorl();
				// 打印两个空格字符
				print_char(0, 0, 0x20);
				print_char(0, 0, 0x20);
				// 执行光标移动操作，左移一位
				cursor_shift_contorl();
				// 循环计数器减1
				i--;

			}
			if(i%2==0)
			{
				//如果输入的数字是12，并且输入的数字是偶数
				if(i==16)
				{
					//如果输入的数字是16
					// 循环计数器减1
					i--;
					// 将输入数组中的第i个元素设置为0
					inputs[i] = 0;
					// 循环计数器减1
					i--;
					// 获取输入数组中的第i个元素
					digit = inputs[i];
					// 在第一行第7列打印一个空格字符
					print_char(7, 1, 0x20);
					// 打印一个空格字符
					print_char(0, 0, 0x20);
					// 在第一行第7列打印数字
					print_char(7, 1, digit);
				}
				else if(i==32)
				{
					//如果输入的数字是32
					// 循环计数器减1
					i--;
					// 将输入数组中的第i个元素设置为0
					inputs[i]=0;
					// 循环计数器减1
					i--;
					// 获取输入数组中的第i个元素
					digit=inputs[i];
					// 在第2行第7列打印一个空格字符
					print_char(7,2,0x20);
					// 打印一个空格字符
					print_char(0,0,0x20);
					// 在第2行第7列打印数字
					print_char(7,2,digit);
				}
				else if(i==48)
				{
					//如果输入的数字是48
					// 循环计数器减1
					i--;
					// 将输入数组中的第i个元素设置为0
					inputs[i]=0;
					// 循环计数器减1
					i--;
					// 获取输入数组中的第i个元素
					digit=inputs[i];
					// 在第3行第7列打印一个空格字符
					print_char(7,3,0x20);
					// 打印一个空格字符
					print_char(0,0,0x20);
					// 在第3行第7列打印数字
					print_char(7,3,digit);
				}
				else
				{
					//如果输入的数字不是16，32，48
					// 循环计数器减1
					i--;
					// 将输入数组中的第i个元素设置为0
					inputs[i]=0;
					// 循环计数器减1
					i--;
					// 获取输入数组中的第i个元素
					digit=inputs[i];
					// 执行光标移动操作，左移一位
					cursor_shift_contorl();
					// 打印一个空格字符
					print_char(0,0,0x20);
					// 打印一个空格字符
					print_char(0,0,0x20);
					// 执行光标移动操作，左移一位
					cursor_shift_contorl();
					// 打印数字
					print_char(0,0,digit);
				}
			}
		}
		//如果以上条件都不满足，表示输入无效，循环计数不变
		else
		{
			i--;
		}
	}
	}
}
//定义一个函数，用于输入位数，并存储在bits变量中
bit input_bits(void)
{
	//定义两个无符号字符变量，用于存储循环计数和按键对应的值
	unsigned char i,digit=0;
	//定义一个长度为2的无符号字符数组，用于存储输入的位数
	unsigned char a[2]={0};
	//定义一个位变量，用于存储是否继续或退出的状态
	bit state=0;
	//调用wait_input函数，等待输入，并获取状态
	state=wait_input();
	//如果状态为1，表示退出
	if(state==1)
	{
		//返回1
		return 1;
	}
	//无限循环，直到检测到有效输入
	while(1)
	{
	//调用clear函数，清屏
	clear();
	//用循环语句，将a数组的所有元素初始化为0
	for(i=0;i<2;i++)
	{
		a[i]=0;
	}
	//用循环语句，从键盘获取输入的位数，并存储在a数组中
	for(i=0;i<3;i++)
	{
		//调用kscan函数，获取按键对应的值
		digit=kscan();
		//如果循环计数小于2，且按键对应的值在0到9之间，表示输入的是数字
		if(i<2&digit>=0&digit<=9)
		{
			//将按键对应的值存储在a数组中
			a[i]=digit;
			//调用print_char函数，在指定位置显示输入的数字
			print_char(0,0,digit+48);
		}
		//如果循环计数大于0，且按键对应的值为15，表示输入结束
		else if(i>0&digit==15)
		{
			//将a数组中的两个数字组合成一个位数，存储在全局变量bits中
			if(i==1)
			{
				bits=a[0];
			}
			else
			{
			bits=a[0]*10+a[1];
			}
			//如果bits变量的值在1到64之间，表示输入的位数有效
			if(bits>=1&bits<=64)
			{
			//返回0
			return 0;
			}
			//如果bits变量的值不在1到64之间，表示输入的位数无效
			else
			{
				//调用wrong_input_bits函数，显示错误信息，并获取状态
				if(wrong_input_bits())
				{
					//如果状态为1，表示退出
					return 1;
				}
				//如果状态为0，表示继续
				else
				{
					//跳出循环
					break;
				}
			}
		}
		//如果按键对应的值为14，表示退出
		else if(digit==14)
		{
			//返回1
			return 1;
		}
		//如果循环计数大于0，且按键对应的值为12，表示退格
		else if(i>0&digit==12)
		{
			if(i%2==1)
			{
				print_char(0,0,0x20);
				i--;
				a[i]=0;
				cursor_shift_contorl();
				print_char(0,0,0x20);
				print_char(0,0,0x20);
				cursor_shift_contorl();
				i--;
			}
			if(i%2==0)
			{
				i--;
				a[i]=0;
				i--;
				digit=a[i];
				cursor_shift_contorl();
				print_char(0,0,0x20);
				print_char(0,0,0x20);
				cursor_shift_contorl();
				print_char(0,0,digit+48);
			}
		}
		//如果循环计数大于0，且按键对应的值为13，表示重新输入
		else if(i>0&digit==13)
		{
			break;
		}
		//如果以上条件都不满足，表示输入无效，循环计数不变
		else
		{
			i--;
		}
	}
	}
}
//定义一个函数，用于输入显示时间，并存储在display_time变量中
bit input_display_time(void)
{
	//定义两个无符号字符变量，用于存储循环计数和按键对应的值
	unsigned char i,j,digit=0;
	//定义一个长度为5的无符号字符数组，用于存储输入的显示时间
	unsigned char a[5]={0};
	//定义一个无符号长整数变量，用于存储输入的显示时间
	unsigned long temp;
	//定义一个位变量，用于存储是否继续或退出的状态
	bit state=0;
	//调用wait_input函数，等待输入，并获取状态
	state=wait_input();
	//如果状态为1，表示退出
	if(state==1)
	{
		//返回1
		return 1;
	}
	//无限循环，直到检测到有效输入
	while(1)
	{
	//调用clear函数，清屏
	clear();
	//用循环语句，将a数组的所有元素初始化为0
	for(i=0;i<5;i++)
	{
		a[i]=0;
	}
	//用循环语句，从键盘获取输入的显示时间，并存储在a数组中
	for(i=0;i<6;i++)
	{
		//调用kscan函数，获取按键对应的值
		digit=kscan();
		//如果循环计数小于5，且按键对应的值在0到9之间，表示输入的是数字
		if(i<5&digit>=0&digit<=9)
		{
			//将按键对应的值存储在a数组中
			a[i]=digit;
			//调用print_char函数，在指定位置显示输入的数字
			print_char(0,0,digit+48);
		}
		//如果循环计数大于0，且按键对应的值为15，表示输入结束
		else if(i>0&digit==15)
		{
			//将a数组中的五个数字组合成一个显示时间，存储在temp变量中
			temp=0;
			for(j=0;j<i;j++)
			{
				temp=10*temp+a[j];
			}
			//如果temp变量的值在50到65535之间，表示输入的显示时间有效
			if(temp>=50&temp<=65535)
			{
				//将temp变量的值赋给display_time变量
				display_time=temp;
				//返回0
				return 0;
			}
			//如果temp变量的值不在50到65535之间，表示输入的显示时间无效
			else
			{
				//调用wrong_display_time函数，显示错误信息，并获取状态
				if(wrong_display_time())
				{
					//如果状态为1，表示退出
					return 1;
				}
				//如果状态为0，表示继续
				else
				{
					//跳出循环
					break;
				}
			}
		}
		//如果按键对应的值为14，表示退出
		else if(digit==14)
		{
			//返回1
			return 1;
		}
		//如果循环计数大于0，且按键对应的值为13，表示重新输入
		else if(i>0&digit==13)
		{
			break;
		}
		//如果循环计数大于0，且按键对应的值为12，表示退格
		else if(i>0&digit==12)
		{
			if(i%2==1)
			{
				print_char(0,0,0x20);
				i--;
				a[i]=0;
				cursor_shift_contorl();
				print_char(0,0,0x20);
				print_char(0,0,0x20);
				cursor_shift_contorl();
				i--;
			}
			if(i%2==0)
			{
				i--;
				a[i]=0;
				i--;
				digit=a[i];
				cursor_shift_contorl();
				print_char(0,0,0x20);
				print_char(0,0,0x20);
				cursor_shift_contorl();
				print_char(0,0,digit+48);
			}
		}
		//如果以上条件都不满足，表示输入无效，循环计数不变
		else
		{
			i--;
		}
	}
	}
}
//定义一个函数，用于等待输入，并返回是否继续或退出的状态
bit wait_input(void)
{
	//定义一个位变量，用于存储状态
	bit state=0;
	//定义一个无符号字符变量，用于存储按键对应的值
	unsigned char temp;
	//无限循环，直到检测到有效按键
	while(1)
	{
		//调用kscan函数，获取按键对应的值
		temp=kscan();
		//如果按键对应的值在0到15之间，表示输入有效
		if(temp>=0&temp<=15)
		{
			//如果按键对应的值为14，表示退出，状态为1
			if(temp==14)
			{
				state=1;
			}
			//返回状态
			return state;
		}
	}
}
//定义一个函数，用于显示输入位数错误的信息，并返回是否继续或退出的状态
bit wrong_input_bits(void)
{
	//调用display_wrong_input_bits函数，显示错误信息
	display_wrong_input_bits();
	//调用f_or_e函数，判断是否继续或退出，并返回状态
	return f_or_e();
}
//定义一个函数，用于显示输入显示时间错误的信息，并返回是否继续或退出的状态
bit wrong_display_time(void)
{
	//调用display_wrong_input_display_time函数，显示错误信息
	display_wrong_input_display_time();
	//调用f_or_e函数，判断是否继续或退出，并返回状态
	return f_or_e();
}

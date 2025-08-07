/*
 * @Author: 王心瀚
 * @Date: 2023-12-20 09:55:18
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:50:19
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\display.c
 * @Description: 显示文件，包含显示相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
#include "display.h" //包含显示相关的头文件
unsigned char code acknowledgements[]="非常感谢能有这次机会做提高实验，提高实验接近真实的工程项目，有一定的难度，但是我克服种种困难，顺利高质量地完成了猜数\xfd游戏项目，提高了我的C 语言和汇编语言编程能力，加深了对单片机和嵌入式系统的理解，感谢罗老师和助教的指导！！  MADE BY 王心瀚  2023年12月23日  Thank you again!"; //定义一个常量数组acknowledgements，用来存储致谢的内容
void display_startup_logo(void) //定义一个函数display_startup_logo，用来显示启动的LOGO
{
	display_picture(hust); //调用display_picture函数，传入hust常量指针，显示华中科技大学的LOGO(HUST)
	delay_ms(1000); //调用delay_ms函数，传入1000，延时1000毫秒
	display_picture(sft); //调用display_picture函数，传入sft常量指针，显示未来技术学院的L院徽
	delay_ms(1000); //调用delay_ms函数，传入1000，延时1000毫秒
}
void display_gussing_game(void) //定义一个函数display_gussing_game，用来显示猜数游戏的LOGO
{
	display_picture(csyx); //调用display_picture函数，传入csyx常量指针，显示猜数游戏的LOGO
	delay_ms(1500); //调用delay_ms函数，传入1500，延时1500毫秒
}
void print_acknowledgement(void) //定义一个函数print_acknowledgement，用来打印致谢的内容
{
	unsigned int i=0; //定义一个变量i，用来作为数组的索引，初始化为0
	for(i=0;;i++) //无限循环
	{
		if(i%64==0) //如果i能被64整除
		{
			clear(); //调用clear函数，清空屏幕
		}
		if(acknowledgements[i]==0) //如果数组的第i个元素为0
		{
			break; //跳出循环
		}
		if(i%64==16) //如果i对64取余为16
		{
			print_char(0,2,acknowledgements[i]); //调用print_char函数，传入0,2,acknowledgements[i]，在第0列第2行打印数组的第i个元素
		}
		else if(i%64==32) //如果i对64取余为32
		{
			print_char(0,3,acknowledgements[i]); //调用print_char函数，传入0,3,acknowledgements[i]，在第0列第3行打印数组的第i个元素
		}
		else if(i%64==48) //如果i对64取余为48
		{
			print_char(0,4,acknowledgements[i]); //调用print_char函数，传入0,4,acknowledgements[i]，在第0列第4行打印数组的第i个元素
		}
		else //其他情况
		{
			print_char(0,0,acknowledgements[i]); //调用print_char函数，传入0,0,acknowledgements[i]，在上一次输出之后打印数组的第i个元素
		}
		delay_ms(100); //调用delay_ms函数，传入100，延时100毫秒
	}
}
void display_acknowledgement(void) //定义一个函数display_acknowledgement，用来显示致谢的画面
{
	display_picture(zhu); //调用display_picture函数，传入zhu常量指针，显示可爱的小猪的图片
	delay_ms(1000); //调用delay_ms函数，传入1000，延时1000毫秒
	print_acknowledgement(); //调用print_acknowledgement函数，打印致谢的内容
	display_picture(xxdj); //调用display_picture函数，传入xxdj常量指针，显示谢谢大家的图片
	delay_ms(1000); //调用delay_ms函数，传入1000，延时1000毫秒
}
void display_picture(const unsigned  char *ptr) //定义一个函数display_picture，传入一个常量字符指针ptr，用来显示图片
{
	clear(); //调用clear函数，清空屏幕
	Draw_PM(ptr); //调用Draw_PM函数，传入ptr，绘制图片      
}
void display_main_menu(void) //定义一个函数display_main_menu，用来显示主菜单
{
	clear(); //调用clear函数，清空屏幕
	print(2,1,"猜数\xfd游戏"); //调用print函数，传入2,1,"猜数\xfd游戏"，在第2列第1行打印"猜数游戏"
	print(0,2," Guessing game"); //调用print函数，传入0,2," Guessing game"，在第0列第2行打印" Guessing game"
	print(0,3,"0:进入游戏"); //调用print函数，传入0,3,"0:进入游戏"，在第0列第3行打印"0:进入游戏"
	print(0,4,"1:致谢"); //调用print函数，传入0,4,"1:致谢"，在第0列第4行打印"1:致谢"
}
void display_mode_select(void) //定义一个函数display_mode_select，用来显示模式选择
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"按数\xfd字键选择模式"); //调用print函数，传入0,1,"按数\xfd字键选择模式"，在第0列第1行打印"按数字键选择模式"
	print(0,2,"0:闯关模式"); //调用print函数，传入0,2,"0:闯关模式"，在第0列第2行打印"0:闯关模式"
	print(0,3,"1:练习模式"); //调用print函数，传入0,3,"1:练习模式"，在第0列第3行打印"1:练习模式"
	print(0,4,"2:随机模式"); //调用print函数，传入0,4,"2:随机模式"，在第0列第4行打印"2:随机模式"
}
void display_bits_select(void) //定义一个函数display_bits_select，用来显示位数\xfd选择
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"按数\xfd字键输入位数\xfd"); //调用print函数，传入0,1,"按数\xfd字键输入位数\xfd"，在第0列第1行打印"按数字键输入位数"
	print(0,2,"按F 键确认"); //调用print函数，传入0,2,"按F 键确认"，在第0列第2行打印"按F 键确认"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"按D 重输按C 退格"); //调用print函数，传入0,4,"按D 键重输"，在第0列第4行打印"按D 重输按C 退格"
}
void display_time_select(void) //定义一个函数display_time_select，用来显示时间选择
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"按数\xfd字键输入时间"); //调用print函数，传入0,1,"按数\xfd字键输入时间"，在第0列第1行打印"按数字键输入时间"
	print(0,2,"按F 键确认"); //调用print函数，传入0,2,"按F 键确认"，在第0列第2行打印"按F 键确认"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"按D 重输按C 退格"); //调用print函数，传入0,4,"按D 键重输"，在第0列第4行打印"按D 重输按C 退格"
}
void display_begin_select(void) //定义一个函数display_begin_select，用来显示开始选择
{
	clear(); //调用clear函数，清空屏幕
	print(1,1,"你准备好了吗？"); //调用print函数，传入1,1,"你准备好了吗？"，在第1列第1行打印"你准备好了吗？"
	print(0,2,"按F 键开始游戏"); //调用print函数，传入0,2,"按F 键开始游戏"，在第0列第2行打印"按F 键开始游戏"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
}
void display_input(void) //定义一个函数display_input，用来显示输入
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"按数\xfd字键输入数\xfd字"); //调用print函数，传入0,1,"按数\xfd字键输入数\xfd字"，在第0列第1行打印"按数字键输入数字"
	print(0,2,"按F 键确认"); //调用print函数，传入0,2,"按F 键确认"，在第0列第2行打印"按F 键确认"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"按D 重输按C 退格"); //调用print函数，传入0,4,"按D 键重输"，在第0列第4行打印"按D 重输按C 退格"
}
void display_correct(void) //定义一个函数display_correct，用来显示正确
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"**恭喜你猜对了**"); //调用print函数，传入0,1,"**恭喜你猜对了**"，在第0列第1行打印"**恭喜你猜对了**"
	print(0,2,"按F 键继续游戏"); //调用print函数，传入0,2,"按F 键继续游戏"，在第0列第2行打印"按F 键继续游戏"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"****************"); //调用print函数，传入0,4,"****************"，在第0列第4行打印"****************"
}
void display_error(void) //定义一个函数display_error，用来显示错误
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"很可惜你猜错了##"); //调用print函数，传入0,1,"很可惜你猜错了##"，在第0列第1行打印"很可惜你猜错了##"
	print(0,2,"按F 键重新开始"); //调用print函数，传入0,2,"按F 键重新开始"，在第0列第2行打印"按F 键重新开始"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"################"); //调用print函数，传入0,4,"################"，在第0列第4行打印"################"
}
void display_win(void) //定义一个函数display_win，用来显示闯关成功
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"恭喜你闯关成功**"); //调用print函数，传入0,1,"恭喜你闯关成功**"，在第0列第1行打印"恭喜你闯关成功**"
	print(0,2,"按F 键再次挑战"); //调用print函数，传入0,2,"按F 键再次挑战"，在第0列第2行打印"按F 键再次挑战"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"****************"); //调用print函数，传入0,4,"****************"，在第0列第4行打印"****************"
}
void display_lose(void) //定义一个函数display_lose，用来显示闯关失败
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"很可惜闯关失败##"); //调用print函数，传入0,1,"很可惜闯关失败##"，在第0列第1行打印"很可惜闯关失败##"
	print(0,2,"按F 键再次挑战"); //调用print函数，传入0,2,"按F 键再次挑战"，在第0列第2行打印"按F 键再次挑战"
	print(0,3,"按E 键返回"); //调用print函数，传入0,3,"按E 键返回"，在第0列第3行打印"按E 键返回"
	print(0,4,"################"); //调用print函数，传入0,4,"################"，在第0列第4行打印"################"
}
void display_random_digits(void) //定义一个函数display_random_digits，用来显示随机的数字
{
	unsigned char i,digit=0; //定义两个变量i和digit，用来作为数组的索引和数字，初始化为0
	for(i=0;i<64;i++) //循环64次
	{
		random_digits[i]=0; //将数组random_digits的第i个元素赋值为0
	}
	clear(); //调用clear函数，清空屏幕
	for(i=0;i<bits;i++) //循环bits次
	{
		random_digits[i]=digit=digits[rand()%10]; //将数组random_digits的第i个元素赋值为digit，digit赋值为数组digits的随机一个元素，表示一个0-9的数字(ASCII码)
		if(i==16) //如果i等于16
		{
			print_char(0,2,digit); //调用print_char函数，传入0,2,digit，在第0列第2行打印digit
		}
		else if(i==32) //如果i等于32
		{
			print_char(0,3,digit); //调用print_char函数，传入0,3,digit，在第0列第3行打印digit
		}
		else if(i==48) //如果i等于48
		{
			print_char(0,4,digit); //调用print_char函数，传入0,4,digit，在第0列第4行打印digit
		}
		else //其他情况
		{
			print_char(0,0,digit); //调用print_char函数，传入0,0,digit，在第0列第0行打印digit
		}
	}
	delay_ms(display_time); //调用delay_ms函数，传入display_time，延时display_time
}
void display_wrong_input_bits(void) //定义一个函数display_wrong_input_bits，用来显示输入位数非法
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"输入位数\xfd非法"); //调用print函数，传入0,1,"输入位数\xfd非法"，在第0列第1行打印"输入位数非法"
	print(0,2,"1<= 输入位数\xfd<=64"); //调用print函数，传入0,2,"1<= 输入位数\xfd<=64"，在第0列第2行打印"1<= 输入位数<=64"
	print(0,3,"按F 键重输"); //调用print函数，传入0,3,"按F 键重输"，在第0列第3行打印"按F 键重输"
	print(0,4,"按E 键返回"); //调用print函数，传入0,4,"按E 键返回"，在第0列第4行打印"按E 键返回"
}
void display_wrong_input_display_time(void) //定义一个函数display_wrong_input_display_time，用来显示输入显示时间非法
{
	clear(); //调用clear函数，清空屏幕
	print(0,1,"输入显示时间非法"); //调用print函数，传入0,1,"输入显示时间非法"，在第0列第1行打印"输入显示时间非法"
	print(0,2,"50<=时间<=65535"); //调用print函数，传入0,2,"50<=时间<=65535"，在第0列第2行打印"50<=时间<=65535"
	print(0,3,"按F 键重输"); //调用print函数，传入0,3,"按F 键重输"，在第0列第3行打印"按F 键重输"
	print(0,4,"按E 键返回"); //调用print函数，传入0,4,"按E 键返回"，在第0列第4行打印"按E 键返回"
}

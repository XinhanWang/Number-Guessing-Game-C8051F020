/*
 * @Author: 王心瀚
 * @Date: 2023-12-20 11:15:50
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 22:51:48
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\C语言版本\guessing_game.c
 * @Description: 猜数游戏文件，包含猜数游戏相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
#include "guessing_game.h" //包含猜数游戏相关的头文件
unsigned char code digits[]="0123456789ABCDEF"; //定义一个常量数组digits，用来存储16进制的数字的ASCII码
unsigned char xdata random_digits[64]={0}; //定义一个扩展数据数组random_digits，用来存储随机的数字，初始化为全0
unsigned char bits=0; //定义一个变量bits，用来存储输入的位数，初始化为0
unsigned int display_time=0; //定义一个变量display_time，用来存储显示的时间，初始化为0
unsigned char xdata level_bits[10]={1,2,3,4,5,6,7,8,9,10}; //定义一个扩展数据数组level_bits，用来存储不同关卡的位数
unsigned int xdata level_display_time[10]={200,400,600,800,1000,1200,1400,1600,1800,2000}; //定义一个扩展数据数组level_display_time，用来存储不同关卡的数据显示时间
bit check_digits(void) //定义一个函数check_digits，用来检查用户输入的数字是否和随机的数字相同
{
	unsigned char i=0; //定义一个变量i，用来作为数组的索引，初始化为0
	for(i=0;i<64;i++) //循环64次
	{
		if(random_digits[i]!=inputs[i]) //如果数组random_digits的第i个元素和数组inputs的第i个元素不相等
		{
			break; //跳出循环
		}
	}
	if(i==64) //如果i等于64，表示所有的元素都相等
	{
		return 1; //返回1，表示正确
	}
	else //否则
	{
		return 0; //返回0，表示错误
	}
}
bit correct(void) //定义一个函数correct，用来显示正确的画面，并等待用户的选择
{
	display_correct(); //调用display_correct函数，显示正确的画面
	return f_or_e(); //调用f_or_e函数，返回用户的选择，F表示继续，E表示返回
}
bit error(void) //定义一个函数error，用来显示错误的画面，并等待用户的选择
{
	display_error(); //调用display_error函数，显示错误的画面
	return f_or_e(); //调用f_or_e函数，返回用户的选择，F表示重新开始，E表示返回
}
bit win(void) //定义一个函数win，用来显示闯关成功的画面，并等待用户的选择
{
	display_win(); //调用display_win函数，显示闯关成功的画面
	return f_or_e(); //调用f_or_e函数，返回用户的选择，F表示再次挑战，E表示返回
}
bit lose(void) //定义一个函数lose，用来显示闯关失败的画面，并等待用户的选择
{
	display_lose(); //调用display_lose函数，显示闯关失败的画面
	return f_or_e(); //调用f_or_e函数，返回用户的选择，F表示再次挑战，E表示返回
}
unsigned char guess_once(void) //定义一个函数guess_once，用来进行一次猜数游戏
{
	bit a,temp; //定义两个位变量a和temp，用来存储检查结果和用户选择
	unsigned char state=0; //定义一个变量state，用来存储游戏状态，初始化为0
	display_random_digits(); //调用display_random_digits函数，显示随机的数字
	display_input(); //调用display_input函数，显示输入的画面
	state=input_digits(); //调用input_digits函数，输入数字，并赋值给state
	if(state==1) //如果state等于1，表示用户选择返回
	{
		return state; //返回state
	}
	a=check_digits(); //调用check_digits函数，检查数字是否正确，并赋值给a
	if(a==1) //如果a等于1，表示正确
	{
		temp=correct(); //调用correct函数，显示正确的画面，并赋值给temp
		if(temp) //如果temp为真，表示用户选择返回
		{
			state=1; //将state赋值为1
			return state; //返回state
		}
		return 0; //否则返回0，表示继续游戏
	}
	else //如果a等于0，表示错误
	{
		temp=error(); //调用error函数，显示错误的画面，并赋值给temp
		if(temp) //如果temp为真，表示用户选择返回
		{
			state=1; //将state赋值为1
			return state; //返回state
		}
		return 2; //否则返回2，表示重新开始
	}
}
unsigned char guess_one_level(bit b) //定义一个函数guess_one_level，传入一个位变量b，用来进行一次闯关游戏
{
	bit a; //定义一个位变量a，用来存储检查结果
	unsigned char state=0; //定义一个变量state，用来存储游戏状态，初始化为0
	display_random_digits(); //调用display_random_digits函数，显示随机的数字
	display_input(); //调用display_input函数，显示输入的画面
	state=input_digits(); //调用input_digits函数，输入数字，并赋值给state
	if(state==1) //如果state等于1，表示用户选择返回
	{
		return state; //返回state
	}
	a=check_digits(); //调用check_digits函数，检查数字是否正确，并赋值给a
	if(a==1) //如果a等于1，表示正确
	{
		if(b==0) //如果b等于0，表示不是最后一关
		{
			state=correct(); //调用correct函数，显示正确的画面，并赋值给state
			if(state==1) //如果state等于1，表示用户选择返回
			{
				return state; //返回state
			}
			else //否则
			{
				return 2; //返回2，表示继续游戏
			}
		}
		else //如果b等于1，表示是最后一关
		{
			state=win(); //调用win函数，显示闯关成功的画面，并赋值给state
			if(state==1) //如果state等于1，表示用户选择返回
			{
				return state; //返回state
			}
			else //否则
			{
				return 0; //返回0，表示再次挑战
			}
		}
	}
	else //如果a等于0，表示错误
	{
		state=lose(); //调用lose函数，显示闯关失败的画面，并赋值给state
		return state; //返回state
	}
}
unsigned char main_menu(void) //定义一个函数main_menu，用来显示主菜单，并返回用户的选择
{
	unsigned char temp; //定义一个变量temp，用来存储用户的选择
	display_main_menu(); //调用display_main_menu函数，显示主菜单
	while(1) //无限循环
	{
		temp=kscan(); //调用kscan函数，扫描键盘输入，并赋值给temp
		if(temp==0|temp==1|temp==14) //如果temp等于0或1或14，表示有效的选择
		{
			break; //跳出循环
		}
	}
	return temp; //返回temp
}
unsigned char mode_select(void) //定义一个函数mode_select，用来显示模式选择，并返回用户的选择
{
	unsigned char temp; //定义一个变量temp，用来存储用户的选择
	display_mode_select(); //调用display_mode_select函数，显示模式选择
	while(1) //无限循环
	{
		temp=kscan(); //调用kscan函数，扫描键盘输入，并赋值给temp
		if(temp==0|temp==1|temp==2|temp==14) //如果temp等于0或1或2或14，表示有效的选择
		{
			break; //跳出循环
		}
	}
	return temp; //返回temp
}
bit begin_select(void) //定义一个函数begin_select，用来显示开始选择，并返回用户的选择
{
	display_begin_select(); //调用display_begin_select函数，显示开始选择
	return f_or_e(); //调用f_or_e函数，返回用户的选择，F表示开始游戏，E表示返回
}
void mode1(void) //定义一个函数mode1，用来进行闯关模式的游戏
{
	unsigned char i=0; //定义一个变量i，用来作为关卡的索引，初始化为0
	unsigned char state; //定义一个变量state，用来存储游戏状态
	while(1) //无限循环
	{
	for(i=0;i<10;i++) //循环10次，表示10个关卡
	{
		bits=level_bits[i]; //将数组level_bits的第i个元素赋值给bits，表示当前关卡的位数
		display_time=level_display_time[i]; //将数组level_display_time的第i个元素赋值给display_time，表示当前关卡的显示时间
		if(begin_select()) //调用begin_select函数，显示开始选择，并判断用户的选择
		{
			return; //如果用户选择返回，结束函数
		}
		state=guess_one_level(i==9); //调用guess_one_level函数，传入i是否等于9，表示是否是最后一关，并赋值给state
		if(state==1) //如果state等于1，表示用户选择返回
		{		
			return; //结束函数
		}
		if(state==0) //如果state等于0，表示用户选择再次挑战
		{		
			break; //跳出循环，重新开始游戏
		}
	}
	}
}
void mode2(void) //定义一个函数mode2，用来进行练习模式的游戏
{
	while(1) //无限循环
	{
	display_bits_select(); //调用display_bits_select函数，显示位数选择
	if(input_bits()==1) //调用input_bits函数，输入位数，并判断返回值
	{
		return; //如果返回1，表示用户选择返回，结束函数
	}
	display_time_select(); //调用display_time_select函数，显示时间选择
	if(input_display_time()==1) //调用input_display_time函数，输入时间，并判断返回值
	{
		return; //如果返回1，表示用户选择返回，结束函数
	}
	display_begin_select(); //调用display_begin_select函数，显示开始选择
	while(1) //无限循环
	{
	if(begin_select()) //调用begin_select函数，显示开始选择，并判断用户的选择
	{
		return; //如果用户选择返回，结束函数
	}
	if(guess_once()==1) //调用guess_once函数，进行一次猜数游戏，并判断返回值
	{		
		return; //如果返回1，表示用户选择返回，结束函数
	}
	}
	}
}
void mode3(void) //定义一个函数mode3，用来进行随机模式的游戏
{
	while(1) //无限循环
	{
	bits=1+rand()%8; //将1加上0到7的随机数赋值给bits，表示随机的位数
	display_time=bits*200+rand()%101; //将bits乘以200加上0到100的随机数赋值给display_time，表示随机的显示时间
	if(begin_select()) //调用begin_select函数，显示开始选择，并判断用户的选择
	{
		return; //如果用户选择返回，结束函数
	}
	if(guess_once()==1) //调用guess_once函数，进行一次猜数游戏，并判断返回值
	{		
		return; //如果返回1，表示用户选择返回，结束函数
	}
	}
}
void acknowledgement(void) //定义一个函数acknowledgement，用来显示致谢的画面
{
	display_acknowledgement(); //调用display_acknowledgement函数，显示致谢的画面
}
void gussing_game(void) //定义一个函数gussing_game，用来进行猜数游戏
{
	unsigned char mode; //定义一个变量mode，用来存储游戏模式
	while(1) //无限循环
	{
		mode=mode_select(); //调用mode_select函数，显示模式选择，并赋值给mode
		if(mode==14) //如果mode等于14，表示用户选择返回
		{
			break; //跳出循环
		}	
		switch(mode) //根据mode的值选择不同的分支
		{
			case 0: 
				mode1(); //如果mode等于0，调用mode1函数，进行闯关模式的游戏
				break;
			case 1: 
				mode2(); //如果mode等于1，调用mode2函数，进行练习模式的游戏
				break;
			case 2: 
				mode3(); //如果mode等于2，调用mode3函数，进行随机模式的游戏
				break;
			default:
				break;
		}
	}
}
void games(void) //定义一个函数games，用来进行游戏
{
	unsigned char menu; //定义一个变量menu，用来存储主菜单的选择
	display_gussing_game(); //调用display_gussing_game函数，显示猜数游戏的LOGO
	while(1) //无限循环
	{
		menu=main_menu(); //调用main_menu函数，显示主菜单，并赋值给menu
		if(menu==14) //如果menu等于14，表示用户选择退出
		{
			break; //跳出循环
		}	
	switch(menu) //根据menu的值选择不同的分支
	{
		case 0: 
			gussing_game(); //如果menu等于0，调用gussing_game函数，进行猜数游戏
			break;
		case 1: 
			acknowledgement(); //如果menu等于1，调用acknowledgement函数，显示致谢的画面
			break;
		default:
			break;
	}
	}
}

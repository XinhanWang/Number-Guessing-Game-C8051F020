/*
 * @Author: �����
 * @Date: 2023-12-20 11:15:50
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 22:51:48
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\guessing_game.c
 * @Description: ������Ϸ�ļ�������������Ϸ��غ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
#include "guessing_game.h" //����������Ϸ��ص�ͷ�ļ�
unsigned char code digits[]="0123456789ABCDEF"; //����һ����������digits�������洢16���Ƶ����ֵ�ASCII��
unsigned char xdata random_digits[64]={0}; //����һ����չ��������random_digits�������洢��������֣���ʼ��Ϊȫ0
unsigned char bits=0; //����һ������bits�������洢�����λ������ʼ��Ϊ0
unsigned int display_time=0; //����һ������display_time�������洢��ʾ��ʱ�䣬��ʼ��Ϊ0
unsigned char xdata level_bits[10]={1,2,3,4,5,6,7,8,9,10}; //����һ����չ��������level_bits�������洢��ͬ�ؿ���λ��
unsigned int xdata level_display_time[10]={200,400,600,800,1000,1200,1400,1600,1800,2000}; //����һ����չ��������level_display_time�������洢��ͬ�ؿ���������ʾʱ��
bit check_digits(void) //����һ������check_digits����������û�����������Ƿ�������������ͬ
{
	unsigned char i=0; //����һ������i��������Ϊ�������������ʼ��Ϊ0
	for(i=0;i<64;i++) //ѭ��64��
	{
		if(random_digits[i]!=inputs[i]) //�������random_digits�ĵ�i��Ԫ�غ�����inputs�ĵ�i��Ԫ�ز����
		{
			break; //����ѭ��
		}
	}
	if(i==64) //���i����64����ʾ���е�Ԫ�ض����
	{
		return 1; //����1����ʾ��ȷ
	}
	else //����
	{
		return 0; //����0����ʾ����
	}
}
bit correct(void) //����һ������correct��������ʾ��ȷ�Ļ��棬���ȴ��û���ѡ��
{
	display_correct(); //����display_correct��������ʾ��ȷ�Ļ���
	return f_or_e(); //����f_or_e�����������û���ѡ��F��ʾ������E��ʾ����
}
bit error(void) //����һ������error��������ʾ����Ļ��棬���ȴ��û���ѡ��
{
	display_error(); //����display_error��������ʾ����Ļ���
	return f_or_e(); //����f_or_e�����������û���ѡ��F��ʾ���¿�ʼ��E��ʾ����
}
bit win(void) //����һ������win��������ʾ���سɹ��Ļ��棬���ȴ��û���ѡ��
{
	display_win(); //����display_win��������ʾ���سɹ��Ļ���
	return f_or_e(); //����f_or_e�����������û���ѡ��F��ʾ�ٴ���ս��E��ʾ����
}
bit lose(void) //����һ������lose��������ʾ����ʧ�ܵĻ��棬���ȴ��û���ѡ��
{
	display_lose(); //����display_lose��������ʾ����ʧ�ܵĻ���
	return f_or_e(); //����f_or_e�����������û���ѡ��F��ʾ�ٴ���ս��E��ʾ����
}
unsigned char guess_once(void) //����һ������guess_once����������һ�β�����Ϸ
{
	bit a,temp; //��������λ����a��temp�������洢��������û�ѡ��
	unsigned char state=0; //����һ������state�������洢��Ϸ״̬����ʼ��Ϊ0
	display_random_digits(); //����display_random_digits��������ʾ���������
	display_input(); //����display_input��������ʾ����Ļ���
	state=input_digits(); //����input_digits�������������֣�����ֵ��state
	if(state==1) //���state����1����ʾ�û�ѡ�񷵻�
	{
		return state; //����state
	}
	a=check_digits(); //����check_digits��������������Ƿ���ȷ������ֵ��a
	if(a==1) //���a����1����ʾ��ȷ
	{
		temp=correct(); //����correct��������ʾ��ȷ�Ļ��棬����ֵ��temp
		if(temp) //���tempΪ�棬��ʾ�û�ѡ�񷵻�
		{
			state=1; //��state��ֵΪ1
			return state; //����state
		}
		return 0; //���򷵻�0����ʾ������Ϸ
	}
	else //���a����0����ʾ����
	{
		temp=error(); //����error��������ʾ����Ļ��棬����ֵ��temp
		if(temp) //���tempΪ�棬��ʾ�û�ѡ�񷵻�
		{
			state=1; //��state��ֵΪ1
			return state; //����state
		}
		return 2; //���򷵻�2����ʾ���¿�ʼ
	}
}
unsigned char guess_one_level(bit b) //����һ������guess_one_level������һ��λ����b����������һ�δ�����Ϸ
{
	bit a; //����һ��λ����a�������洢�����
	unsigned char state=0; //����һ������state�������洢��Ϸ״̬����ʼ��Ϊ0
	display_random_digits(); //����display_random_digits��������ʾ���������
	display_input(); //����display_input��������ʾ����Ļ���
	state=input_digits(); //����input_digits�������������֣�����ֵ��state
	if(state==1) //���state����1����ʾ�û�ѡ�񷵻�
	{
		return state; //����state
	}
	a=check_digits(); //����check_digits��������������Ƿ���ȷ������ֵ��a
	if(a==1) //���a����1����ʾ��ȷ
	{
		if(b==0) //���b����0����ʾ�������һ��
		{
			state=correct(); //����correct��������ʾ��ȷ�Ļ��棬����ֵ��state
			if(state==1) //���state����1����ʾ�û�ѡ�񷵻�
			{
				return state; //����state
			}
			else //����
			{
				return 2; //����2����ʾ������Ϸ
			}
		}
		else //���b����1����ʾ�����һ��
		{
			state=win(); //����win��������ʾ���سɹ��Ļ��棬����ֵ��state
			if(state==1) //���state����1����ʾ�û�ѡ�񷵻�
			{
				return state; //����state
			}
			else //����
			{
				return 0; //����0����ʾ�ٴ���ս
			}
		}
	}
	else //���a����0����ʾ����
	{
		state=lose(); //����lose��������ʾ����ʧ�ܵĻ��棬����ֵ��state
		return state; //����state
	}
}
unsigned char main_menu(void) //����һ������main_menu��������ʾ���˵����������û���ѡ��
{
	unsigned char temp; //����һ������temp�������洢�û���ѡ��
	display_main_menu(); //����display_main_menu��������ʾ���˵�
	while(1) //����ѭ��
	{
		temp=kscan(); //����kscan������ɨ��������룬����ֵ��temp
		if(temp==0|temp==1|temp==14) //���temp����0��1��14����ʾ��Ч��ѡ��
		{
			break; //����ѭ��
		}
	}
	return temp; //����temp
}
unsigned char mode_select(void) //����һ������mode_select��������ʾģʽѡ�񣬲������û���ѡ��
{
	unsigned char temp; //����һ������temp�������洢�û���ѡ��
	display_mode_select(); //����display_mode_select��������ʾģʽѡ��
	while(1) //����ѭ��
	{
		temp=kscan(); //����kscan������ɨ��������룬����ֵ��temp
		if(temp==0|temp==1|temp==2|temp==14) //���temp����0��1��2��14����ʾ��Ч��ѡ��
		{
			break; //����ѭ��
		}
	}
	return temp; //����temp
}
bit begin_select(void) //����һ������begin_select��������ʾ��ʼѡ�񣬲������û���ѡ��
{
	display_begin_select(); //����display_begin_select��������ʾ��ʼѡ��
	return f_or_e(); //����f_or_e�����������û���ѡ��F��ʾ��ʼ��Ϸ��E��ʾ����
}
void mode1(void) //����һ������mode1���������д���ģʽ����Ϸ
{
	unsigned char i=0; //����һ������i��������Ϊ�ؿ�����������ʼ��Ϊ0
	unsigned char state; //����һ������state�������洢��Ϸ״̬
	while(1) //����ѭ��
	{
	for(i=0;i<10;i++) //ѭ��10�Σ���ʾ10���ؿ�
	{
		bits=level_bits[i]; //������level_bits�ĵ�i��Ԫ�ظ�ֵ��bits����ʾ��ǰ�ؿ���λ��
		display_time=level_display_time[i]; //������level_display_time�ĵ�i��Ԫ�ظ�ֵ��display_time����ʾ��ǰ�ؿ�����ʾʱ��
		if(begin_select()) //����begin_select��������ʾ��ʼѡ�񣬲��ж��û���ѡ��
		{
			return; //����û�ѡ�񷵻أ���������
		}
		state=guess_one_level(i==9); //����guess_one_level����������i�Ƿ����9����ʾ�Ƿ������һ�أ�����ֵ��state
		if(state==1) //���state����1����ʾ�û�ѡ�񷵻�
		{		
			return; //��������
		}
		if(state==0) //���state����0����ʾ�û�ѡ���ٴ���ս
		{		
			break; //����ѭ�������¿�ʼ��Ϸ
		}
	}
	}
}
void mode2(void) //����һ������mode2������������ϰģʽ����Ϸ
{
	while(1) //����ѭ��
	{
	display_bits_select(); //����display_bits_select��������ʾλ��ѡ��
	if(input_bits()==1) //����input_bits����������λ�������жϷ���ֵ
	{
		return; //�������1����ʾ�û�ѡ�񷵻أ���������
	}
	display_time_select(); //����display_time_select��������ʾʱ��ѡ��
	if(input_display_time()==1) //����input_display_time����������ʱ�䣬���жϷ���ֵ
	{
		return; //�������1����ʾ�û�ѡ�񷵻أ���������
	}
	display_begin_select(); //����display_begin_select��������ʾ��ʼѡ��
	while(1) //����ѭ��
	{
	if(begin_select()) //����begin_select��������ʾ��ʼѡ�񣬲��ж��û���ѡ��
	{
		return; //����û�ѡ�񷵻أ���������
	}
	if(guess_once()==1) //����guess_once����������һ�β�����Ϸ�����жϷ���ֵ
	{		
		return; //�������1����ʾ�û�ѡ�񷵻أ���������
	}
	}
	}
}
void mode3(void) //����һ������mode3�������������ģʽ����Ϸ
{
	while(1) //����ѭ��
	{
	bits=1+rand()%8; //��1����0��7���������ֵ��bits����ʾ�����λ��
	display_time=bits*200+rand()%101; //��bits����200����0��100���������ֵ��display_time����ʾ�������ʾʱ��
	if(begin_select()) //����begin_select��������ʾ��ʼѡ�񣬲��ж��û���ѡ��
	{
		return; //����û�ѡ�񷵻أ���������
	}
	if(guess_once()==1) //����guess_once����������һ�β�����Ϸ�����жϷ���ֵ
	{		
		return; //�������1����ʾ�û�ѡ�񷵻أ���������
	}
	}
}
void acknowledgement(void) //����һ������acknowledgement��������ʾ��л�Ļ���
{
	display_acknowledgement(); //����display_acknowledgement��������ʾ��л�Ļ���
}
void gussing_game(void) //����һ������gussing_game���������в�����Ϸ
{
	unsigned char mode; //����һ������mode�������洢��Ϸģʽ
	while(1) //����ѭ��
	{
		mode=mode_select(); //����mode_select��������ʾģʽѡ�񣬲���ֵ��mode
		if(mode==14) //���mode����14����ʾ�û�ѡ�񷵻�
		{
			break; //����ѭ��
		}	
		switch(mode) //����mode��ֵѡ��ͬ�ķ�֧
		{
			case 0: 
				mode1(); //���mode����0������mode1���������д���ģʽ����Ϸ
				break;
			case 1: 
				mode2(); //���mode����1������mode2������������ϰģʽ����Ϸ
				break;
			case 2: 
				mode3(); //���mode����2������mode3�������������ģʽ����Ϸ
				break;
			default:
				break;
		}
	}
}
void games(void) //����һ������games������������Ϸ
{
	unsigned char menu; //����һ������menu�������洢���˵���ѡ��
	display_gussing_game(); //����display_gussing_game��������ʾ������Ϸ��LOGO
	while(1) //����ѭ��
	{
		menu=main_menu(); //����main_menu��������ʾ���˵�������ֵ��menu
		if(menu==14) //���menu����14����ʾ�û�ѡ���˳�
		{
			break; //����ѭ��
		}	
	switch(menu) //����menu��ֵѡ��ͬ�ķ�֧
	{
		case 0: 
			gussing_game(); //���menu����0������gussing_game���������в�����Ϸ
			break;
		case 1: 
			acknowledgement(); //���menu����1������acknowledgement��������ʾ��л�Ļ���
			break;
		default:
			break;
	}
	}
}

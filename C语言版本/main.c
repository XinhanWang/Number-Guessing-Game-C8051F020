/*
 * @Author: �����
 * @Date: 2023-11-23 19:30:43
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 22:49:45
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\main.c
 * @Description: �������ļ��������������Ͷ�ʱ��0���жϷ����������ó�ʼ���豸�����Ͳ�������Ϸ�ĺ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
// ����C8051F020оƬ��ͷ�ļ�
#include "C8051F020.h"
// ����LCD12864Һ����ʾ����ͷ�ļ�
#include "LCD12864.h"
// �������������ͷ�ļ�
#include "keyboard.h"
// ������ʾ��ͷ�ļ�
#include "display.h"
// ������������Ϸ��ͷ�ļ�
#include "guessing_game.h"
// ������ʼ���豸�ĺ���
void Init_Device(void);

// ����һ���޷��ų����ͱ��������ڴ洢ʱ�䣨���룩
unsigned long data time_ms;
// ������
void main(void)
{
	//��ǰʱ���ʼ��Ϊ0
	time_ms=0;
	// �رտ��Ź���ʱ��
	WDTCN     = 0xDE;
  	WDTCN     = 0xAD;
	// ���ó�ʼ���豸�ĺ���
	Init_Device();
/*WDTCN=0xA5;
WDTCN=0xA5;
	*/
	// ����ѭ��
	while(1)
   {
		 /*
      #WDTCN=0xA5;
		 */
		// ���ò�������Ϸ�ĺ���
		games();
   }
}

// ��ʱ��0���жϷ�����
void T0I(void) interrupt 1
{	
	// ���ö�ʱ��0�ĵ�8λΪ0x30
	TL0       = 0x30;
	// ���ö�ʱ��0�ĸ�8λΪ0xF8
  	TH0       = 0xF8;
	// ʱ�������1
	time_ms++;
}



/*
 * @Author: �����
 * @Date: 2023-12-19 11:10:32
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 22:56:51
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\time.c
 * @Description: ʱ���ļ�������ʱ����صĺ���(��ʱms����)
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
#include "time.h" //����ʱ����ص�ͷ�ļ�
void delay_ms(unsigned long a) //����һ������delay_ms��������ʱa����
{
	unsigned long data time_ms_start=time_ms; //����һ������time_ms_start�������洢��ʼ��ʱ��
	while(1) //����ѭ��
	{
		if(time_ms-time_ms_start==a) //�����ǰʱ���ȥ��ʼʱ�����a
			break; //����ѭ��
	}
}




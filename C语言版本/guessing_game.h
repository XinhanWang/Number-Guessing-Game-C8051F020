/*
 * @Author: �����
 * @Date: 2023-12-20 11:16:05
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 22:52:20
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\guessing_game.h
 * @Description: ������Ϸͷ�ļ�
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
//���ֶ��巽ʽ�Ƿ�ֹͷ�ļ����ݵ��ظ�����
#ifndef GUESSING //���û�ж���GUESSING��
#define GUESSING //����GUESSING��
#include "C8051F020.h" //����C8051F020��Ƭ����ͷ�ļ�
#include "time.h" //����ʱ����ص�ͷ�ļ�
#include "LCD12864.h" //����LCD12864Һ����ʾ����ͷ�ļ�
#include "keyboard.h" //����������ص�ͷ�ļ�
#include "display.h" //������ʾ��ص�ͷ�ļ�
#include <stdlib.h> //������׼���ͷ�ļ�
extern unsigned char xdata inputs[64]; //����һ��XRAM�е���������inputs�������洢�û����������
unsigned char guess_once(void); //����һ������guess_once����������һ�β�����Ϸ
void gussing_game(void); //����һ������gussing_game���������в�����Ϸ
void mode3(void); //����һ������mode3�������������ģʽ����Ϸ
unsigned char mode_select(void); //����һ������mode_select������ѡ����Ϸģʽ
unsigned char main_menu(void); //����һ������main_menu��������ʾ���˵�
void games(void); //����һ������games������������Ϸ
#endif //������������

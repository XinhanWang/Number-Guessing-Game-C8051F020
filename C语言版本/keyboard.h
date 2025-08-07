/*
 * @Author: �����
 * @Date: 2023-11-23 22:02:50
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 22:54:13
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\keyboard.h
 * @Description: ��������ͷ�ļ�
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
//���ֶ��巽ʽ�Ƿ�ֹͷ�ļ����ݵ��ظ�����
#ifndef KEYBOARD //���û�ж���KEYBOARD��
#define KEYBOARD //����KEYBOARD��
#include "C8051F020.h" //����C8051F020��Ƭ����ͷ�ļ�
#include "time.h" //����ʱ����ص�ͷ�ļ�
#include "LCD12864.h" //����LCD12864Һ����ʾ����ͷ�ļ�
#include "display.h" //������ʾ��ص�ͷ�ļ�
extern unsigned char bits; //����һ���ⲿ����bits�������洢�����λ��
extern unsigned int display_time; //����һ���ⲿ����display_time�������洢��ʾ��ʱ��
extern unsigned char code digits[]; //����һ���ⲿ��������digits�������洢����0-F����ʾ��
unsigned char kscan(void); //����һ������kscan������ɨ���������
bit input_digits(void); //����һ������input_digits����������λ��
bit input_bits(void); //����һ������input_bits������������ʾ����λ��
bit input_display_time(void); //����һ������input_display_time������������ʾʱ��
bit wait_input(void); //����һ������wait_input�������ȴ��û�����
bit f_or_e(void); //����һ������f_or_e�������ж��û��������F����E
bit wrong_input_bits(void); //����һ������wrong_input_bits��������ʾ����λ���������Ϣ
bit wrong_display_time(void); //����һ������wrong_display_time��������ʾ������ʾʱ��������Ϣ
#endif //������������

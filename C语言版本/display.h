/*
 * @Author: �����
 * @Date: 2023-12-20 09:55:35
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 22:51:14
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\display.h
 * @Description: ��ʾͷ�ļ�
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
//���ֶ��巽ʽ�Ƿ�ֹͷ�ļ����ݵ��ظ�����
#ifndef DISPLAY //���û�ж���DISPLAY��
#define DISPLAY //����DISPLAY��
#include "C8051F020.h" //����C8051F020��Ƭ����ͷ�ļ�
#include "LCD12864.h" //����LCD12864Һ����ʾ����ͷ�ļ�
#include <stdlib.h> //������׼���ͷ�ļ�
extern unsigned char bits; //����һ���ⲿ����bits�������洢�������ʾ����λ��
extern unsigned int display_time; //����һ���ⲿ����display_time�������洢��ʾ��ʱ��
extern unsigned char code digits[]; //����һ���ⲿ��������digits�������洢0-F����ʾ��
extern unsigned char xdata random_digits[64]; //����һ���ⲿ��չ��������random_digits�������洢���������
extern unsigned char code zhu[]; //����һ���ⲿ��������zhu�������洢�ɰ�С���ͼƬ
extern unsigned char code sft[]; //����һ���ⲿ��������sft�������洢δ������ѧԺ��Ժ��
extern unsigned char code hust[]; //����һ���ⲿ��������hust�������洢���пƼ���ѧ��LOGO(HUST)
extern unsigned char code csyx[]; //����һ���ⲿ��������csyx�������洢������Ϸ��LOGO
extern unsigned char code xxdj[]; //����һ���ⲿ��������xxdj�������洢лл��ҵ�ͼƬ
void display_mode_select(void); //����һ������display_mode_select��������ʾģʽѡ��
void display_bits_select(void); //����һ������display_bits_select��������ʾλ��ѡ��
void display_time_select(void); //����һ������display_time_select��������ʾʱ��ѡ��
void display_begin_select(void); //����һ������display_begin_select��������ʾ��ʼѡ��
void display_correct(void); //����һ������display_correct��������ʾ��ȷ
void display_error(void); //����һ������display_error��������ʾ����
void display_win(void); //����һ������display_win��������ʾ���سɹ�
void display_main_menu(void); //����һ������display_main_menu��������ʾ���˵�
void display_startup_logo(void); //����һ������display_startup_logo��������ʾ������LOGO
void display_input(void); //����һ������display_input��������ʾ����
void display_lose(void); //����һ������display_lose��������ʾ����ʧ��
void display_random_digits(void); //����һ������display_random_digits��������ʾ���������
void display_wrong_input_bits(void); //����һ������display_wrong_input_bits��������ʾ����λ���Ƿ�
void display_wrong_input_display_time(void); //����һ������display_wrong_input_display_time��������ʾ������ʾʱ��Ƿ�
void display_picture(const unsigned  char *ptr); //����һ������display_picture������һ�������ַ�ָ��ptr��������ʾͼƬ
void display_gussing_game(void); //����һ������display_gussing_game��������ʾ������Ϸ��LOGO
void print_acknowledgement(void); //����һ������print_acknowledgement��������ӡ��л������
void display_acknowledgement(void); //����һ������display_acknowledgement��������ʾ��л�Ļ���
#endif //������������

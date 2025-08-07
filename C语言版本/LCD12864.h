/*
 * @Author: �����
 * @Date: 2023-11-23 21:06:54
 * @LastEditors: �����
 * @LastEditTime: 2023-12-25 07:59:57
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\LCD12864.h
 * @Description: LCD12864ͷ�ļ�
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
//���ֶ��巽ʽ�Ƿ�ֹͷ�ļ����ݵ��ظ�����
#ifndef LCD12864 //���û�ж���LCD12864�����
#define LCD12864 //����LCD12864�����

#include "C8051F020.h" //����C8051F020��Ƭ����ͷ�ļ�
#include "time.h" //����ʱ����ص�ͷ�ļ�
#define LCD_data P0  //����LCD_dataΪP0�˿ڣ����ڴ�������
#define LCD_read_write P0MDOUT //����LCD_read_writeΪP0�˿ڵ����ģʽ
#define uchar unsigned char //����ucharΪ�޷����ַ�����
#define uint  unsigned int //����uintΪ�޷�����������

sbit LCD_RS=P2^5; //����LCD_RSΪP2�˿ڵĵ�5λ������ѡ��ָ�������
sbit LCD_RW=P2^6; //����LCD_RWΪP2�˿ڵĵ�6λ������ѡ�����д
sbit LCD_EN=P2^7; //����LCD_ENΪP2�˿ڵĵ�7λ������ʹ��LCD
sbit D0=LCD_data^0; //����D0ΪLCD_data�ĵ�0λ�����ڴ����0λ����
sbit D1=LCD_data^1; //����D1ΪLCD_data�ĵ�1λ�����ڴ����1λ����
sbit D2=LCD_data^2; //����D2ΪLCD_data�ĵ�2λ�����ڴ����2λ����
sbit D3=LCD_data^3; //����D3ΪLCD_data�ĵ�3λ�����ڴ����3λ����
sbit D4=LCD_data^4; //����D4ΪLCD_data�ĵ�4λ�����ڴ����4λ����
sbit D5=LCD_data^5; //����D5ΪLCD_data�ĵ�5λ�����ڴ����5λ����
sbit D6=LCD_data^6; //����D6ΪLCD_data�ĵ�6λ�����ڴ����6λ����
sbit D7=LCD_data^7; //����D7ΪLCD_data�ĵ�7λ�����ڴ����7λ����

void lcd_init(void); //����lcd_init���������ڳ�ʼ��LCD
void Draw_PM(const unsigned  char *); //����Draw_PM���������ڻ��Ƶ���ͼ
void print(unsigned char x,unsigned char y,const unsigned char* str); //����print������������ָ��λ����ʾ�ַ���
void clear(void); //����clear��������������
void print_char(unsigned char x,unsigned char y,unsigned char a); //����print_char������������ָ��λ����ʾ�ַ�
void cursor_shift_contorl(void);//����cursor_shift_contorl�����������α�����
#endif //������������

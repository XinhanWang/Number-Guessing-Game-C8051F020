/*
 * @Author: �����
 * @Date: 2023-11-23 21:04:30
 * @LastEditors: �����
 * @LastEditTime: 2023-12-25 07:58:57
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\C���԰汾\LCD12864.c
 * @Description: LCD12864�ļ�������LCD12864��ʾ��غ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
// ����LCD12864Һ����ʾ����ͷ�ļ�
#include "LCD12864.h"

// ��������LCD��дģʽ�ĺ���
void set_LCD_read_write(void)
{
	// ���LCD_RWΪ0����ʾдģʽ����LCD_read_write��Ϊ0xFF���������
	if(LCD_RW==0)
	{
		LCD_read_write= 0xFF;
	}
	// ���򣬱�ʾ��ģʽ����LCD_read_write��Ϊ0x00����LCD_data��Ϊ0xFF��©��д1��Ϊ����
	else
	{
		LCD_read_write= 0x00;
		LCD_data=0xFF;
	}
}

/*
* ��  �ܣ��ȴ�LCD12864����
* ��  ������
* ����ֵ����
*/
void wait_lcd_not_busy()
{                          
	// ��LCD_RS��Ϊ0����ʾѡ��ָ��Ĵ���
	LCD_RS = 0;
	// ��LCD_RW��Ϊ1����ʾ��ȡ״̬
	LCD_RW = 1;
	// ��������LCD��дģʽ�ĺ���
	set_LCD_read_write();
	// ��LCD_EN��Ϊ1
	LCD_EN = 1;
	// �ȴ�D7Ϊ0����ʾLCD����
	while(D7);
	// ��LCD_EN��Ϊ0
	LCD_EN = 0;
}

/*
* ��  �ܣ�дָ�LCD
* ��  ����Ҫд���ָ��
* ����ֵ����
*/
void lcd_wcmd(uchar cmd)
{                          
	// ���õȴ�LCD���еĺ���
	wait_lcd_not_busy();
	// ��LCD_RS��Ϊ0����ʾѡ��ָ��Ĵ���
	LCD_RS = 0;
	// ��LCD_RW��Ϊ0����ʾд������
	LCD_RW = 0;
	// ��������LCD��дģʽ�ĺ���
	set_LCD_read_write();
	// ��Ҫд���ָ�ֵ��LCD_data
	LCD_data = cmd;
	// ��ʱ1����
	delay_ms(1);
	// ��LCD_EN��Ϊ1
	LCD_EN = 1;
	// ��ʱ1����
	delay_ms(1);
	// ��LCD_EN��Ϊ0
	LCD_EN = 0;  
}

/*
* ��  �ܣ�LCDд����
* ��  ����Ҫд�������
* ����ֵ����
*/
void lcd_wdat(uchar dat)
{                          
	// ���õȴ�LCD���еĺ���
	wait_lcd_not_busy();
	// ��LCD_RS��Ϊ1����ʾѡ�����ݼĴ���
	LCD_RS = 1;
	// ��LCD_RW��Ϊ0����ʾд������
	LCD_RW = 0;
	// ��������LCD��дģʽ�ĺ���
	set_LCD_read_write();
	// ��Ҫд������ݸ�ֵ��LCD_data
	LCD_data = dat;
	// ��ʱ1����
	delay_ms(1);
	// ��LCD_EN��Ϊ1
	LCD_EN = 1;
	// ��ʱ1����
	delay_ms(1);
	// ��LCD_EN��Ϊ0
	LCD_EN = 0;
}

// �������LCD��ʾ���ݵĺ���
void clear(void)
{
	// д��0x01ָ���ʾ���LCD����ʾ����
	lcd_wcmd(0x01);      
}

/*
* ��  �ܣ�LCD��ʼ��
* ��  ������
* ����ֵ����
*/
void lcd_init(void)
{ 
	// д��0x34ָ���ʾ������ָ�����
	lcd_wcmd(0x34);      
	// ��ʱ5����
	delay_ms(5);
	// д��0x30ָ���ʾ�򿪻���ָ�����
	lcd_wcmd(0x30);      
	// ��ʱ5����
	delay_ms(5);
	// д��0x0Cָ���ʾ��ʾ�����ع��
	lcd_wcmd(0x0C);     
	//lcd_wcmd(0x0E);	
	// ��ʱ5����
	delay_ms(5);
	// д��0x01ָ���ʾ���LCD����ʾ����
	lcd_wcmd(0x01);      
	// ��ʱ5����
	delay_ms(5);
}
/*������ʾλ��  xpos(0~7),ypos(1~4)*/
void set_xy(unsigned char xpos,unsigned char ypos)
{
	// ����ypos��ֵ��ѡ��ͬ���е�ַ
	switch(ypos)
	{
		case 1:
			// д��0x80|xposָ���ʾ���õ�һ�е���ʾλ��
			lcd_wcmd(0X80|xpos);break;
		case 2:
			// д��0x90|xposָ���ʾ���õڶ��е���ʾλ��
			lcd_wcmd(0X90|xpos);break;
		case 3:
			// д��0x88|xposָ���ʾ���õ����е���ʾλ��
			lcd_wcmd(0X88|xpos);break;
		case 4:
			// д��0x98|xposָ���ʾ���õ����е���ʾλ��
			lcd_wcmd(0X98|xpos);break;
		default:
			// ��������������κβ���
			break;
	}
}
//����LCD���α�����һλ�ĺ���
void cursor_shift_contorl(void)
{
	//����LCD���α�����һλ
	lcd_wcmd(0X10);
}
/*��ָ��λ����ʾ�ַ���*/
void print(unsigned char x,unsigned char y,const unsigned char* str)
{ 
	// ����һ���޷����ַ����������ڴ洢�ַ����е��ַ�
	unsigned char lcd_temp; 
	// ����������ʾλ�õĺ���
	set_xy(x,y);
	// ȡ���ַ����еĵ�һ���ַ�
	lcd_temp=*str;
		// ���ַ���Ϊ0x00ʱ����ʾ�ַ���δ����
		while(lcd_temp != 0x00) 
		{ 
		// ��LCD��д����ַ�
		lcd_wdat(lcd_temp);
		// ȡ���ַ����е���һ���ַ�
		lcd_temp=*(++str);
		} 
}
/*��ָ��λ����ʾ�ַ�*/
void print_char(unsigned char x,unsigned char y,unsigned char a)
{ 
	// ����������ʾλ�õĺ���
	set_xy(x,y);
	// ��LCD��д����ַ�
	lcd_wdat(a);
}
/*
* ��  �ܣ�������Һ����Ļ�ϻ�ͼ
* ��  ����ͼƬ�ĵ�������
* ����ֵ����
*/
void Draw_PM(const unsigned  char *ptr)
{
	// ���������޷����ַ�������������Ϊѭ��������
	uchar i, j, k;
	// д��0x34ָ���ʾ����չָ�
	lcd_wcmd(0x34);        
	// ��i��Ϊ0x80����ʾ�ӵ�һ�п�ʼ
	i = 0x80;
	            
	// ��д�ϰ���
	// ����ÿһ�У���32��
	for(j=0; j<32; j++)
	{
		// д��iָ���ʾ�����е�ַ
		lcd_wcmd(i++);
		// д��0x80ָ���ʾ�����е�ַΪ0
		lcd_wcmd(0x80);
		// ����ÿһ�У���8*2=16��
		for(k=0; k<16; k++)
		{
			// ��LCD��д��ͼƬ�ĵ�������
			lcd_wdat(*ptr++);
		}
	}
	// ��i��Ϊ0x80����ʾ�ӵ�һ�п�ʼ
	i = 0x80;
	// ��д�°���
	// ����ÿһ�У���32��
	for(j=0; j<32; j++)
	{
		// д��iָ���ʾ�����е�ַ
		lcd_wcmd(i++);
		// д��0x88ָ���ʾ�����е�ַΪ8
		lcd_wcmd(0x88);	   
		// ����ÿһ�У���8*2=16��
		for(k=0; k<16; k++)
		{
			// ��LCD��д��ͼƬ�ĵ�������
			lcd_wdat(*ptr++);
		} 
	}  
	// д��0x36ָ���ʾ�򿪻�ͼ��ʾ
	lcd_wcmd(0x36);        
	// д��0x30ָ���ʾ�ص�����ָ�
	lcd_wcmd(0x30);        
}

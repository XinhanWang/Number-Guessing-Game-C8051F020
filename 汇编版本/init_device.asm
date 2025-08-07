/*
 * @Author: �����
 * @Date: 2023-12-22 10:59:11
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 23:08:09
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\���汾\init_device.asm
 * @Description: ��ʼ���豸�ļ���������ʼ���豸��غ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
$NOMOD51  ; ����51��SFR

NAME	INIT_DEVICE ; ���������Ϊ INIT_DEVICE
$include(init_device.inc) ; ����main.inc�ļ�

	RSEG  Timer_Init_INIT_DEVICE  ; �������Ϊ Timer_Init
Timer_Init: ; ���� Timer_Init �ӳ���
	MOV  	CKCON,#08H ; ����ʱ�ӿ��ƼĴ�����ʹ T0 ʱ��ԴΪϵͳʱ��
	MOV  	TCON,#010H ; ���ö�ʱ�����ƼĴ�����ʹ T0ʹ��ϵͳʱ��
	MOV  	TMOD,#01H ; ���ö�ʱ��ģʽ�Ĵ�����ʹ T0 ������ 16 λ��ʱ��ģʽ
	MOV  	TL0,#030H ; ���� T0 �ĵ� 8 λ��ֵΪ 30H
	MOV  	TH0,#0F8H ; ���� T0 �ĸ� 8 λ��ֵΪ F8H
	RET  	; ����������


	RSEG  Port_IO_Init_INIT_DEVICE  ; �������Ϊ Port_IO_Init
Port_IO_Init: ; ���� Port_IO_Init �ӳ���
	MOV  	P0MDOUT,#0FFH ; ���� P0 ��Ϊ�������
	MOV  	P2MDOUT,#0E0H ; ���� P2.7-P2.5 Ϊ���������P2.4-P2.0 Ϊ©��
	MOV  	XBR2,#040H ; ʹ�ܽ��濪��
	RET  	; ����������

	RSEG  Interrupts_Init_INIT_DEVICE  ; �������Ϊ Interrupts_Init
Interrupts_Init: ; ���� Interrupts_Init �ӳ���
	MOV  	IE,#082H ; �����жϿ��ƼĴ�����ʹ�� T0 �жϺ�ȫ���ж�
	MOV  	IP,#02H ; �����ж����ȼ��Ĵ�����ʹ T0 �ж�Ϊ�����ȼ�
	RET  	; ����������

	RSEG  InInit_Device_INIT_DEVICE ; �������Ϊ Init_Device
Init_Device: ; ���� Init_Device �ӳ���
	USING	0 ; ʹ�üĴ����� 0
	LCALL	Timer_Init ; ���� Timer_Init �ӳ���
	LCALL	Port_IO_Init ; ���� Port_IO_Init �ӳ���
	LCALL	Interrupts_Init ; ���� Interrupts_Init �ӳ���
	MOV  	R7,#0AH ; ��0AH��ֵ��R7����Ϊ��������ӵĵ��ֽ�
	MOV  	R6,#00H ; ��00H��ֵ��R6����Ϊ��������ӵĸ��ֽ�
	LCALL	_srand ; ����_srand�������������������
	LCALL	lcd_init ; ���� lcd_init �ӳ��򣬳�ʼ��Һ����ʾ��
	LCALL	display_startup_logo ; ���� display_startup_logo �ӳ�����ʾ��������
	MOV  	R7,#0E8H ; ���� R7 Ϊ E8H����Ϊ��ʱ��������ʱ1000����
	MOV  	R6,#03H ; ���� R6 Ϊ 03H����Ϊ��ʱ��������ʱ1000����
	MOV  	R5,#00H ; ���� R5 Ϊ 00H����Ϊ��ʱ��������ʱ1000����
	MOV  	R4,#00H ; ���� R4 Ϊ 00H����Ϊ��ʱ��������ʱ1000����
	LJMP 	_delay_ms ; ��ת�� _delay_ms �ӳ���ִ����ʱ����ʱ1000����
	RET  	; ����������

	END ; ��������

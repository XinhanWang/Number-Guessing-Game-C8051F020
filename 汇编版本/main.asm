/*
 * @Author: �����
 * @Date: 2023-12-22 08:59:52
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 23:15:07
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\���汾\main.asm
 * @Description:  �������ļ��������������Ͷ�ʱ��0���жϷ����������ó�ʼ���豸�����Ͳ�������Ϸ�ĺ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
$NOMOD51 ; ����51��SFR
NAME	MAIN ; ������ΪMAIN
$include(main.inc) ; ����main.inc�ļ�
	RSEG  DT_MIAN; ѡ�����ݶ�
        time_ms:   DS   4 ; ����4�ֽڵı���time_ms�����ڴ洢������

	RSEG  main_MAIN; ѡ������������
main: ; ��������
	USING	0 ; ʹ�üĴ�����0
	CLR  	A ; ����A
	MOV  	time_ms+03H,A ; ����time_ms
	MOV  	time_ms+02H,A ; ����time_ms
	MOV  	time_ms+01H,A ; ����time_ms
	MOV  	time_ms,A ; ����time_ms
	MOV  	WDTCN,#0DEH ; ���Ź����ƼĴ���д��0DEH����ֹ���Ź�
	MOV  	WDTCN,#0ADH ; ���Ź����ƼĴ���д��0ADH����ֹ���Ź�
	LCALL	Init_Device ; ����Init_Device��������ʼ���豸

MIAN0001: ; ѭ�����
	LCALL	games ; ����games������ִ�в�����Ϸ
	SJMP 	MIAN0001 ; ��������ת��MIAN0001���γ���ѭ��

CSEG	AT	0000BH ; ��0000BH���������Σ���ʱ��T0�ж���ڵ�ַ
	LJMP	T0I ; ����ת��T0I����Ϊ��ʱ��0�ж�����

	RSEG  T0I_MIAN; ѡ��ʱ��0�жϷ����������
	USING	0 ; ʹ�üĴ�����0
T0I: ; ��ʱ��0�жϷ���������
	PUSH 	ACC ; ���ۼ���ѹջ�������ֳ�
	PUSH 	PSW ; ������״̬��ѹջ�������ֳ�
	MOV  	TL0,#030H ; ��030H��ֵ��TL0�����ö�ʱ��0�ĵ��ֽ�
	MOV  	TH0,#0F8H ; ��0F8H��ֵ��TH0�����ö�ʱ��0�ĸ��ֽ�
	MOV  	A,time_ms+03H ; ��time_ms�ĵ�4�ֽڸ�ֵ��A
	ADD  	A,#01H ; ��A��01H��ӣ�ʵ�ֺ�������1
	MOV  	time_ms+03H,A ; ��A��ֵ��time_ms�ĵ�4�ֽ�
	CLR  	A ; ����A
	ADDC 	A,time_ms+02H ; ��A��time_ms�ĵ�3�ֽ���ӣ����ǽ�λ
	MOV  	time_ms+02H,A ; ��A��ֵ��time_ms�ĵ�3�ֽ�
	CLR  	A ; ����A
	ADDC 	A,time_ms+01H ; ��A��time_ms�ĵ�2�ֽ���ӣ����ǽ�λ
	MOV  	time_ms+01H,A ; ��A��ֵ��time_ms�ĵ�2�ֽ�
	CLR  	A ; ����A
	ADDC 	A,time_ms ; ��A��time_ms�ĵ�1�ֽ���ӣ����ǽ�λ
	MOV  	time_ms,A ; ��A��ֵ��time_ms�ĵ�1�ֽ�
	POP  	PSW ; ������״̬�ֳ�ջ���ָ��ֳ�
	POP  	ACC ; ���ۼ�����ջ���ָ��ֳ�
	RETI 	;�жϷ��أ������жϷ������
	
	END ; �������

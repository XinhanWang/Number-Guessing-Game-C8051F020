/*
 * @Author: �����
 * @Date: 2023-12-22 12:21:50
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 23:12:00
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\���汾\KEYBOARD.asm
 * @Description: ���̴����ļ����������̼�⡢����������غ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
$NOMOD51 ; ����51��SFR
NAME	KEYBOARD ; ָ�����������ΪKEYBOARD
$include(KEYBOARD.inc) ; ����KEYBOARD.inc�ļ���������һЩ�����ͺ�
	RSEG  DT_kscan_KEYBOARD ; ����һ�����ݶΣ����ڴ洢��ʱ����
kscan_BYTE: ; �����ֽڿռ�ı��
       keyl:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢��ʱ����
       temp:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢��ʱ����
	RSEG  DT_input_digits_KEYBOARD ; ����һ�����ݶΣ����ڴ洢��ʱ����
input_digits_BYTE:  ; �����ֽڿռ�ı��
          i:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢ѭ��������
      digit:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢���������
	RSEG  BI_input_digits_KEYBOARD  ; ����һ��λ�Σ����ڴ洢��ʱ����
input_digits_BIT: ; ����λ�ռ�ı��
      state:   DBIT   1 ; ����һ��λ�Ŀռ䣬���ڴ洢�������ֵ�״̬
	RSEG  DT_input_display_time_KEYBOARD ; ����һ�����ݶΣ����ڴ洢��ʱ����
input_display_time_BYTE: ; �����ֽڿռ�ı��
          i1:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢ѭ��������
          j1:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢ѭ��������
      digit1:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢���������
          a1:   DS   5 ; ��������ֽڵĿռ䣬���ڴ洢�������ʾʱ�������
       temp1:   DS   4 ; �����ĸ��ֽڵĿռ䣬���ڴ洢��ʱ����
	RSEG  BI_input_display_time_KEYBOARD  ; ����һ��λ�Σ����ڴ洢��ʱ����
input_display_time_BIT: ; ����λ�ռ�ı��
      state1:   DBIT   1 ; ����һ��λ�Ŀռ䣬���ڴ洢������ʾʱ���״̬
	RSEG  DT_input_bits_KEYBOARD ; ����һ�����ݶΣ���������λ������
input_bits_BYTE: ; �����ֽڿռ�ı��
          i2:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢ѭ��������
      digit2:   DS   1 ; ����һ���ֽڵĿռ䣬���ڴ洢���������
          a2:   DS   2 ; ���������ֽڵĿռ䣬���ڴ洢�������ʾλ��������
	RSEG  BI_input_bits_KEYBOARD  ; ����һ��λ�Σ����ڴ洢��ʱ����
input_bits_BIT: ; ����λ�ռ�ı��
      state2:   DBIT   1 ; ����һ��λ�Ŀռ䣬���ڴ洢������ʾλ��������״̬
	RSEG  BI_wait_input_KEYBOARD  ; ����һ��λ�Σ����ڴ洢�ȴ����������״̬����
wait_input_BIT: ; ����λ�ռ�ı��
      state3:   DBIT   1 ; ����һ��λ�Ŀռ䣬���ڴ洢�ȴ����������״̬
	RSEG  XD_KEYBOARD ; ����һ����չ���ݶΣ����ڼ��̵�����
         inputs:   DS   64 ; ����64���ֽڵĿռ䣬���ڴ洢�������������
	RSEG  CO_KEYBOARD ; ����һ�������
_?ix1000: ; ����һ����ţ����ڴ洢һ������
	DB	000H ; �洢һ���ֽڵ����ݣ�ֵΪ0
	DB  000H ; �洢һ���ֽڵ����ݣ�ֵΪ0
_?ix1001: ; ����һ����ţ����ڴ洢һ������
	DB	000H ; �洢һ���ֽڵ����ݣ�ֵΪ0
	DB  000H,000H,000H,000H ; �洢�ĸ��ֽڵ����ݣ�ֵ��Ϊ0
	RSEG  kscan_KEYBOARD ; ����һ������Σ����ڼ���ɨ��ĳ���
kscan: ; ����һ��ɨ����̵��ӳ���
	USING	0 ; ʹ�üĴ����� 0
	MOV  	P1MDOUT,#0F0H ; ���� P1 �ڵĸ���λΪ���������λΪ����
	MOV  	P1,#0FH ; ��� 0000 1111 �� P1 ��
KEYBOARD0001: ; ����һ��ѭ����ǩ
	MOV  	A,P1 ; �� P1 �ڵ�ֵ�����ۼ��� A
	XRL  	A,#0FH ; �� A �� 0000 1111 ��򣬵õ��������к�
	JZ   	KEYBOARD0001 ; ��� A Ϊ 0��˵��û�а������£���ת�� KEYBOARD0001 ����ѭ��
	MOV  	R7,#0AH ; �� 10 ���� R7��������ʱ
	MOV  	R6,#00H ; �� 0 ���� R6��������ʱ
	MOV  	R5,#00H ; �� 0 ���� R5��������ʱ
	MOV  	R4,#00H ; �� 0 ���� R4��������ʱ
	LCALL	_delay_ms ; ����һ����ʱ�ӳ�����������
	MOV  	A,P1 ; �� P1 �ڵ�ֵ�����ۼ��� A
	XRL  	A,#0FH ; �� A �� 0000 1111 ��򣬵õ��������к�
	JZ   	KEYBOARD0001 ; ��� A Ϊ 0��˵������������ת�� KEYBOARD0001 ����ѭ��
	MOV  	keyl,P1 ; �� P1 �ڵ�ֵ���� keyl�����ڱ��水�����к�
	MOV  	P1MDOUT,#0FH ; ���� P1 �ڵĵ���λΪ���������λΪ����
	MOV  	P1,#0F0H ; ��� 1111 0000 �� P1 ��
	MOV  	R7,#0AH ; �� 10 ���� R7��������ʱ
	MOV  	R6,#00H ; �� 0 ���� R6��������ʱ
	MOV  	R5,#00H ; �� 0 ���� R5��������ʱ
	MOV  	R4,#00H ; �� 0 ���� R4��������ʱ
	LCALL	_delay_ms ; ����һ����ʱ�ӳ�����������
	MOV  	R7,P1 ; �� P1 �ڵ�ֵ���� R7�����ڱ��水�����к�
	MOV  	A,keyl ; �� keyl ��ֵ�����ۼ��� A
	ORL  	A,R7 ; �� A �� R7 �����㣬�õ������ı���
	LCALL	?C?CCASE ; ����һ����֧���ӳ��򣬸��ݰ����ı�����ת����Ӧ�ı�ǩ
	DW   	KEYBOARD0009 ; ����һ����֧��������������Ϊ 0111 0111����ת�� KEYBOARD0009
	DB   	077H ; ���尴������Ϊ 0111 0111
	DW   	KEYBOARD0013 ; ����һ����֧��������������Ϊ 0111 1011����ת�� KEYBOARD0013
	DB   	07BH ; ���尴������Ϊ 0111 1011
	DW   	KEYBOARD0017 ; ����һ����֧��������������Ϊ 0111 1101����ת�� KEYBOARD0017
	DB   	07DH ; ���尴������Ϊ 0111 1101
	DW   	KEYBOARD0021 ; ����һ����֧��������������Ϊ 0111 1110����ת�� KEYBOARD0021
	DB   	07EH ; ���尴������Ϊ 0111 1110
	DW   	KEYBOARD0008 ; ����һ����֧��������������Ϊ 1011 0111����ת�� KEYBOARD0008
	DB   	0B7H ; ���尴������Ϊ 1011 0111
	DW   	KEYBOARD0012 ; ����һ����֧��������������Ϊ 1011 1011����ת�� KEYBOARD0012
	DB   	0BBH ; ���尴������Ϊ 1011 1011
	DW   	KEYBOARD0016 ; ����һ����֧��������������Ϊ 1011 1101����ת�� KEYBOARD0016
	DB   	0BDH ; ���尴������Ϊ 1011 1101
	DW   	KEYBOARD0020 ; ����һ����֧��������������Ϊ 1011 1110����ת�� KEYBOARD0020
	DB   	0BEH ; ���尴������Ϊ 1011 1110
	DW   	KEYBOARD0007 ; ����һ����֧��������������Ϊ 1101 0111����ת�� KEYBOARD0007
	DB   	0D7H ; ���尴������Ϊ 1101 0111
	DW   	KEYBOARD0011 ; ����һ����֧��������������Ϊ 1101 1011����ת�� KEYBOARD0011
	DB   	0DBH ; ���尴������Ϊ 1101 1011
	DW   	KEYBOARD0015 ; ����һ����֧��������������Ϊ 1101 1101����ת�� KEYBOARD0015
	DB   	0DDH ; ���尴������Ϊ 1101 1101
	DW   	KEYBOARD0019 ; ����һ����֧��������������Ϊ 1101 1110����ת�� KEYBOARD0019
	DB   	0DEH ; ���尴������Ϊ 1101 1110
	DW   	KEYBOARD0006 ; ����һ����֧��������������Ϊ 1110 0111����ת�� KEYBOARD0006
	DB   	0E7H ; ���尴������Ϊ 1110 0111
	DW   	KEYBOARD0010 ; ����һ����֧��������������Ϊ 1110 1011����ת�� KEYBOARD0010
	DB   	0EBH ; ���尴������Ϊ 1110 1011
	DW   	KEYBOARD0014 ; ����һ����֧��������������Ϊ 1110 1101����ת�� KEYBOARD0014
	DB   	0EDH ; ���尴������Ϊ 1110 1101
	DW   	KEYBOARD0018 ; ����һ����֧��������������Ϊ 1110 1110����ת�� KEYBOARD0018
	DB   	0EEH ; ���尴������Ϊ 1110 1110
	DW   	00H ; ����һ����֧��������������Ϊ 0000 0000����ת�� 00H
	DW   	KEYBOARD0005 ; ����һ����֧��������������Ϊ����ֵ����ת�� KEYBOARD0005
KEYBOARD0006: ; ����һ����ǩ�����ڴ���������Ϊ 1110 0111 �����
	CLR  	A ; ����ۼ��� A
	MOV  	temp,A ; �� A ��ֵ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0007: ; ����һ����ǩ�����ڴ���������Ϊ 1101 0111 �����
	MOV  	temp,#01H ; �� 01 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0008: ; ����һ����ǩ�����ڴ���������Ϊ 10110111�����
	MOV  	temp,#02H ; �� 02 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0009: ; ����һ����ǩ�����ڴ���������Ϊ 0111 0111 �����
	MOV  	temp,#03H ; �� 03 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0010: ; ����һ����ǩ�����ڴ���������Ϊ 1110 1011 �����
	MOV  	temp,#04H ; �� 04 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0011: ; ����һ����ǩ�����ڴ���������Ϊ 1101 1011 �����
	MOV  	temp,#05H ; �� 05 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0012: ; ����һ����ǩ�����ڴ���������Ϊ 1011 1011 �����
	MOV  	temp,#06H ; �� 06 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0013: ; ����һ����ǩ�����ڴ���������Ϊ 0111 1011 �����
	MOV  	temp,#07H ; �� 07 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0014: ; ����һ����ǩ�����ڴ���������Ϊ 1110 1101 �����
	MOV  	temp,#08H ; �� 08 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0015: ; ����һ����ǩ�����ڴ���������Ϊ 1101 1101 �����
	MOV  	temp,#09H ; �� 09 ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0016: ; ����һ����ǩ�����ڴ���������Ϊ 1011 1101 �����
	MOV  	temp,#0AH ; �� 0A ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0017: ; ����һ����ǩ�����ڴ���������Ϊ 0111 1101 �����
	MOV  	temp,#0BH ; �� 0B ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0018: ; ����һ����ǩ�����ڴ���������Ϊ 1110 1110 �����
	MOV  	temp,#0CH ; �� 0C ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0019: ; ����һ����ǩ�����ڴ���������Ϊ 1101 1110 �����
	MOV  	temp,#0DH ; �� 0D ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0020: ; ����һ����ǩ�����ڴ���������Ϊ 1011 1110 �����
	MOV  	temp,#0EH ; �� 0E ���� temp�����ڱ��水����ֵ
	SJMP 	KEYBOARD0005 ; ��������ת�� KEYBOARD0005
KEYBOARD0021: ; ����һ����ǩ�����ڴ���������Ϊ 0111 1110 �����
	MOV  	temp,#0FH ; �� 0F ���� temp�����ڱ��水����ֵ
KEYBOARD0005: ; ����һ����ǩ�����ڴ�������ֵ
	MOV  	P1MDOUT,#0F0H ; ���� P1 �ڵĸ���λΪ���������λΪ����
	MOV  	P1,#0FH ; ��� 0000 1111 �� P1 ��
KEYBOARD0023: ; ����һ��ѭ����ǩ
	MOV  	A,P1 ; �� P1 �ڵ�ֵ�����ۼ��� A
	CJNE 	A,#0FH,KEYBOARD0023 ; ��� A ������ 0F��˵��������û���ɿ�����ת�� KEYBOARD0023 ����ѭ��
	MOV  	R7,#0AH ; �� 10 ���� R7��������ʱ
	MOV  	R6,#00H ; �� 0 ���� R6��������ʱ
	MOV  	R5,#00H ; �� 0 ���� R5��������ʱ
	MOV  	R4,#00H ; �� 0 ���� R4��������ʱ
	LCALL	_delay_ms ; ����һ����ʱ�ӳ�����������
	MOV  	A,P1 ; �� P1 �ڵ�ֵ�����ۼ��� A
	CJNE 	A,#0FH,KEYBOARD0023 ; ��� A ������ 0F��˵��������û���ɿ�����ת�� KEYBOARD0023 ����ѭ��
KEYBOARD0024: ; ����һ����ǩ�����ڷ��ذ�����ֵ
	MOV  	R7,temp ; �� temp ��ֵ���� R7����Ϊ����ֵ
	RET  	; ����������
	RSEG  f_or_e_KEYBOARD ; ����һ���Σ����ڴ�ż��̵�ֵ
f_or_e: ; ����һ���жϰ����Ƿ�Ϊ F �� E ���ӳ���
	USING	0 ; ʹ�üĴ����� 0
KEYBOARD0028: ; ����һ��ѭ����ǩ
	LCALL	kscan ; ���� kscan �ӳ���ɨ����̣����ذ�����ֵ�� R7
	MOV  	R6,#00H ; �� 0 ���� R6�����ڱȽ�
	MOV  	A,R7 ; �� R7 ��ֵ�����ۼ��� A
	XRL  	A,#0FH ; �� A �� 0F ��򣬵õ�������ֵ
	JNZ  	KEYBOARD0030 ; ��� A ��Ϊ 0��˵���������� F����ת�� KEYBOARD0030
	CLR  	C ; �����λ��־λ C
	RET  	; ����������C Ϊ 0 ��ʾ������ F
KEYBOARD0030: ; ����һ����ǩ�����ڴ��������� F �����
	MOV  	A,R7 ; �� R7 ��ֵ�����ۼ��� A
	XRL  	A,#0EH ; �� A �� 0E ��򣬵õ�������ֵ
	ORL  	A,R6 ; �� A �� R6 �����㣬�õ�������ֵ
	JNZ  	KEYBOARD0028 ; ��� A ��Ϊ 0��˵���������� E����ת�� KEYBOARD0028 ����ѭ��
	SETB 	C ; ��λ��λ��־λ C
KEYBOARD0031: ; ����һ����ǩ�����ڷ��ذ�����ֵ
	RET  	; ����������C Ϊ 1 ��ʾ������ E
	RSEG  input_digits_KEYBOARD ; ����һ���Σ����ڴ�Ű�����ֵ
input_digits: ; ����һ���������ֵ��ӳ���
	USING	0 ; ʹ�üĴ����� 0
	CLR  	A ; ����ۼ��� A
	MOV  	digit,A ; �� A ��ֵ���� digit�����ڱ������������
	CLR  	state ; ��� state�����ڱ��������״̬
	LCALL	wait_input ; ���� wait_input �ӳ��򣬵ȴ����룬���������״̬�� C
	MOV  	state,C ; �� C ��ֵ���� state�������ж������״̬
	JNB  	state,KEYBOARD0036 ; ��� state Ϊ 0��˵�����벻��E����ת�� KEYBOARD0036
	SETB 	C ; ��λ��λ��־λ C
	RET  	; �������������״̬Ϊ1����ʾ�˳�(������E)
KEYBOARD0036: ; ����һ����ǩ�����ڴ������벻��E�����
	LCALL	clear ; ���� clear �ӳ��������ʾ��
	CLR  	A ; ����ۼ��� A
	MOV  	i,A ; �� A ��ֵ���� i�����ڱ�������ĸ���
KEYBOARD0038: ; ����һ��ѭ����ǩ�����ڳ�ʼ�� inputs ����
	MOV  	A,#LOW (inputs) ; �� inputs �ĵ��ֽڵ�ַ���� A
	ADD  	A,i ; �� A �� i ��ӣ��õ� inputs[i] �ĵ��ֽڵ�ַ
	MOV  	DPL,A ; �� A ��ֵ���� DPL�����ڱ�������ָ��ĵ��ֽ�
	CLR  	A ; ����ۼ��� A
	ADDC 	A,#HIGH (inputs) ; �� A �� inputs �ĸ��ֽڵ�ַ��ӣ��õ� inputs[i] �ĸ��ֽڵ�ַ
	MOV  	DPH,A ; �� A ��ֵ���� DPH�����ڱ�������ָ��ĸ��ֽ�
	CLR  	A ; ����ۼ��� A
	MOVX 	@DPTR,A ; �� A ��ֵ���� inputs[i]������ inputs[i] ����
	INC  	i ; �� i �� 1�����ڱ��� inputs ����
	MOV  	A,i ; �� i ��ֵ���� A
	CJNE 	A,#040H,KEYBOARD0038 ; ��� A ������ 40H��˵�� inputs ���黹û�б����꣬��ת�� KEYBOARD0038 ����ѭ��
KEYBOARD0039: ; ����һ����ǩ�����ڿ�ʼ��������
	CLR  	A ; ����ۼ��� A
	MOV  	i,A ; �� A ��ֵ���� i�����ڱ�������ĸ���
KEYBOARD0041: ; ����һ��ѭ����ǩ��������������
	MOV  	A,i ; �� i ��ֵ���� A
	CLR  	C ; �����λ��־λ C
	SUBB 	A,#041H ; �� A �� 41H ������õ�����ĸ����� 41H �Ĳ�
	JNC  	KEYBOARD0036 ; ��� C Ϊ 0��˵������ĸ������� 41H����ת�� KEYBOARD0036 ��������
	LCALL	kscan ; ���� kscan �ӳ���ɨ����̣����ذ�����ֵ�� R7
	MOV  	digit,R7 ; �� R7 ��ֵ���� digit�����ڱ��水����ֵ
	MOV  	A,digit ; �� digit ��ֵ�����ۼ��� A
	CLR  	C ; �����λ��־λ C
	SUBB 	A,#00H ; �� A �� 00H ������õ�������ֵ�� 00H �Ĳ�
	JC   	KEYBOARD0045 ; ��� C Ϊ 1��˵��������ֵС�� 00H����ת�� KEYBOARD0045
	MOV  	R7,#01H ; �� 01H ���� R7�������жϰ�����ֵ�Ƿ�Ϸ�
	SJMP 	KEYBOARD0046 ; ��������ת�� KEYBOARD0046
KEYBOARD0045: ; ����һ����ǩ�����ڴ�������ֵС�� 00H �����
	MOV  	R7,#00H ; �� 00H ���� R7�������жϰ�����ֵ�Ƿ�Ϸ�
KEYBOARD0046: ; ����һ����ǩ�������жϰ�����ֵ�Ƿ�Ϸ�
	MOV  	A,i ; �� i ��ֵ�����ۼ��� A
	CLR  	C ; �����λ��־λ C
	SUBB 	A,#040H ; �� A �� 40H ������õ�����ĸ����� 40H �Ĳ�
	JNC  	KEYBOARD0047 ; ��� C Ϊ 0��˵������ĸ������� 40H����ת�� KEYBOARD0047
	MOV  	R6,#01H ; �� 01H ���� R6�������ж�����ĸ����Ƿ�Ϸ�
	SJMP 	KEYBOARD0048 ; ��������ת�� KEYBOARD0048
KEYBOARD0047: ; ����һ����ǩ�����ڴ�������ĸ������� 40H �����
	MOV  	R6,#00H ; �� 00H ���� R6�������ж�����ĸ����Ƿ�Ϸ�
KEYBOARD0048: ; ����һ����ǩ�������ж�����ĸ����Ƿ�Ϸ�
	MOV  	A,R6 ; �� R6 ��ֵ�����ۼ��� A
	ANL  	A,R7 ; �� A �� R7 �����㣬�õ�����ĸ����Ͱ�����ֵ�Ƿ񶼺Ϸ�
	MOV  	R7,A ; �� A ��ֵ���� R7�������ж��Ƿ��������
	MOV  	A,digit ; �� digit ��ֵ�����ۼ��� A
	SETB 	C ; ��λ��λ��־λ C
	SUBB 	A,#09H ; �� A �� 09H ������õ�������ֵ�� 09H �Ĳ�
	JNC  	KEYBOARD0049 ; ��� C Ϊ 0��˵��������ֵ���ڵ��� 09H����ת�� KEYBOARD0049
	MOV  	R6,#01H ; �� 01H ���� R6�������жϰ�����ֵ�Ƿ�Ϸ�
	SJMP 	KEYBOARD0050 ; ��������ת�� KEYBOARD0050
KEYBOARD0049: ; ����һ����ǩ�����ڴ�������ֵ���ڵ��� 09H �����
	MOV  	R6,#00H ; �� 00H ���� R6�������жϰ�����ֵ�Ƿ�Ϸ�
KEYBOARD0050:
	MOV  	A,R6
	ANL  	A,R7
	JZ   	KEYBOARD0044
	MOV  	A,digit
	MOV  	DPTR,#digits
	MOVC 	A,@A+DPTR
	MOV  	R7,A
	MOV  	A,#LOW (inputs)
	ADD  	A,i
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (inputs)
	MOV  	DPH,A
	MOV  	A,R7
	MOVX 	@DPTR,A
	MOV  	digit,A
	MOV  	A,i
	CJNE 	A,#010H,KEYBOARD0051
	MOV  	R3,digit
	MOV  	R5,#02H
	SJMP 	KEYBOARD0169
KEYBOARD0051:
	MOV  	A,i
	CJNE 	A,#020H,KEYBOARD0053
	MOV  	R3,digit
	MOV  	R5,#03H
KEYBOARD0169:
	CLR  	A
	SJMP 	KEYBOARD0170
KEYBOARD0053:
	MOV  	A,i
	MOV  	R3,digit
	CJNE 	A,#030H,KEYBOARD0055
	MOV  	R5,#04H
	CLR  	A
	SJMP 	KEYBOARD0168
KEYBOARD0055:
	CLR  	A
	MOV  	R5,A
KEYBOARD0168:
KEYBOARD0170:
	MOV  	R7,A
	LCALL	_print_char
	SJMP 	KEYBOARD0043
KEYBOARD0044:
	MOV  	A,digit
	CJNE 	A,#0FH,KEYBOARD0059
	MOV  	R7,#01H
	SJMP 	KEYBOARD0060
KEYBOARD0059:
	MOV  	R7,#00H
KEYBOARD0060:
	MOV  	A,i
	SETB 	C
	SUBB 	A,#00H
	JC   	KEYBOARD0061
	MOV  	R6,#01H
	SJMP 	KEYBOARD0062
KEYBOARD0061:
	MOV  	R6,#00H
KEYBOARD0062:
	MOV  	A,R6
	ANL  	A,R7
	JZ   	KEYBOARD0058
	CLR  	C
	RET  	
KEYBOARD0058:
	MOV  	A,digit
	CJNE 	A,#0EH,KEYBOARD0064
	SETB 	C
	RET  	
KEYBOARD0064:
	MOV  	A,digit
	CJNE 	A,#0DH,KEYBOARD0067
	MOV  	R7,#01H
	SJMP 	KEYBOARD0068
KEYBOARD0067:
	MOV  	R7,#00H
KEYBOARD0068:
	MOV  	A,i
	SETB 	C
	SUBB 	A,#00H
	JC   	KEYBOARD0069
	MOV  	R6,#01H
	SJMP 	KEYBOARD0070
KEYBOARD0069:
	MOV  	R6,#00H
KEYBOARD0070:
	MOV  	A,R6
	ANL  	A,R7
	JZ   	$ + 5H
	LJMP 	KEYBOARD0036
	DEC  	i
KEYBOARD0043:
	INC  	i
	LJMP 	KEYBOARD0041
	RSEG  input_bits_KEYBOARD  ;����һ���Σ���ʾ������ʾλ���ļ��̴���
input_bits: ;����һ����ǩ����ʾ������ʾλ��
	USING	0 ;ʹ�üĴ����� 0
	CLR  	A ;����ۼ��� A ������
	MOV  	digit2,A ;�� A �������ƶ��� digit2 �У��� digit2 = 0
	MOV  	R0,#LOW (a2) ;�� a2 �ĵ� 8 λ��ַ�ƶ��� R0 ��
	MOV  	R4,#HIGH (a2) ;�� a2 �ĸ� 8 λ��ַ�ƶ��� R4 ��
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R3,#0FFH ;�� 0FFH �ƶ��� R3 �У��� R3 = 255
	MOV  	R2,#HIGH (_?ix1000) ;�� _?ix1000 �ĸ� 8 λ��ַ�ƶ��� R2 ��
	MOV  	R1,#LOW (_?ix1000) ;�� _?ix1000 �ĵ� 8 λ��ַ�ƶ��� R1 ��
	MOV  	R6,A ;�� A �������ƶ��� R6 �У��� R6 = 0
	MOV  	R7,#02H ;�� 02H �ƶ��� R7 �У��� R7 = 2
	LCALL	?C?COPY ;���� ?C?COPY �ӳ��򣬽� R1-R7 �е����ݸ��Ƶ� a2 �� _?ix1000 ��
	CLR  	state2 ;��� state2 �����ݣ��� state2 = 0
	LCALL	wait_input ;���� wait_input �ӳ��򣬵ȴ�����
	MOV  	state2,C ;����λ��־ C �������ƶ��� state2 ��
	JNB  	state2,KEYBOARD0074 ;��� state2 Ϊ 0����û�����룬����ת�� KEYBOARD0074 ������ִ��
	SETB 	C ;��� state2 ��Ϊ 0���������룬����λ C
	RET ;����
KEYBOARD0074: ;����һ����ǩ����ʾ��������Ĵ���
	LCALL	clear ;���� clear �ӳ��������Ļ
	CLR  	A ;����ۼ��� A ������
	MOV  	i2,A ;�� A �������ƶ��� i2 �У��� i2 = 0
KEYBOARD0076: ;����һ��ѭ���Ŀ�ʼ
	MOV  	A,#LOW (a2) ;�� a2 �ĵ� 8 λ�ƶ��� A ��
	ADD  	A,i2 ;�� A �� i2 ��ӣ��� A = A + i2
	MOV  	R0,A ;�� A �������ƶ��� R0 ��
	CLR  	A ;��� A ������
	MOV  	@R0,A ;�� A �������ƶ��� R0 ָ����ڴ浥Ԫ�У������ a2[i2] ������
	INC  	i2 ;�� i2 �� 1���� i2 = i2 + 1
	MOV  	A,i2 ;�� i2 �������ƶ��� A ��
	CJNE 	A,#02H,KEYBOARD0076 ;�Ƚ� A �� 02H���������ȣ�����ת�� KEYBOARD0076 ������ѭ�����������ִ��
KEYBOARD0077: ;����һ���µı�ǩ
	CLR  	A ;��� A ������
	MOV  	i2,A ;�� A �������ƶ��� i2 �У��� i2 = 0
KEYBOARD0079: ;����һ���µ�ѭ���Ŀ�ʼ
	MOV  	A,i2 ;�� i2 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#03H ;�� A �� 03H ������� A = A - 03H
	JNC  	KEYBOARD0074 ;���û�н�λ���� A >= 03H������ת�� KEYBOARD0074 ������ִ��
	LCALL	kscan ;����н�λ���� A < 03H������� kscan �ӳ���ɨ���������
	MOV  	digit2,R7 ;�� R7 �������ƶ��� digit2 �У��� digit2 = R7
	MOV  	A,digit2 ;�� digit2 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0083 ;����н�λ���� A < 00H������ת�� KEYBOARD0083 ������ִ��
	MOV  	R7,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R7 �У��� R7 = 01H
	SJMP 	KEYBOARD0084 ;��������ת�� KEYBOARD0084 ������ִ��
KEYBOARD0083: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0084: ;����һ���µı�ǩ
	MOV  	A,i2 ;�� i2 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#02H ;�� A �� 02H ������� A = A - 02H
	JNC  	KEYBOARD0085 ;���û�н�λ���� A >= 02H������ת�� KEYBOARD0085 ������ִ��
	MOV  	R6,#01H ;����н�λ���� A < 02H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0086 ;��������ת�� KEYBOARD0086 ������ִ��
KEYBOARD0085: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0086: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	MOV  	R7,A ;�� A �������ƶ��� R7 ��
	MOV  	A,digit2 ;�� digit2 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#09H ;�� A �� 09H ������� A = A - 09H
	JNC  	KEYBOARD0087 ;���û�н�λ���� A >= 09H������ת�� KEYBOARD0087 ������ִ��
	MOV  	R6,#01H ;����н�λ���� A < 09H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0088 ;��������ת�� KEYBOARD0088 ������ִ��
KEYBOARD0087: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0088: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JZ   	KEYBOARD0082 ;��� A Ϊ 0������ת�� KEYBOARD0082 ������ִ��
	MOV  	A,#LOW (a2) ;�� a2 �ĵ� 8 λ�ƶ��� A ��
	ADD  	A,i2 ;�� A �� i2 ��ӣ��� A = A + i2
	MOV  	R0,A ;�� A �������ƶ��� R0 ��
	MOV  	@R0,digit2 ;�� digit2 �������ƶ��� R0 ָ����ڴ浥Ԫ�У��� a2[i2] = digit2
	MOV  	A,digit2 ;�� digit2 �������ƶ��� A ��
	ADD  	A,#030H ;�� A �� 030H ��ӣ��� A = A + 030H
	MOV  	R3,A ;�� A �������ƶ��� R3 ��
	CLR  	A ;��� A ������
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R7,A ;�� A �������ƶ��� R7 �У��� R7 = 0
	LCALL	_print_char ;���� _print_char �ӳ��򣬴�ӡ�ַ�
	LJMP 	KEYBOARD0081 ;��������ת�� KEYBOARD0081 ������ִ��
KEYBOARD0082: ;����һ���µı�ǩ
	MOV  	A,digit2 ;�� digit2 �������ƶ��� A ��
	CJNE 	A,#0FH,KEYBOARD0091 ;�Ƚ� A �� 0FH���������ȣ�����ת�� KEYBOARD0091 ������ִ��
	MOV  	R7,#01H ;�����ȣ��� 01H �ƶ��� R7 �У��� R7 = 1
	SJMP 	KEYBOARD0092 ;��������ת�� KEYBOARD0092 ������ִ��
KEYBOARD0091: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0092: ;����һ���µı�ǩ
	MOV  	A,i2 ;�� i2 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0093 ;����н�λ���� A < 00H������ת�� KEYBOARD0093 ������ִ��
	MOV  	R6,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0094 ;��������ת�� KEYBOARD0094 ������ִ��
KEYBOARD0093: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0094: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JZ   	KEYBOARD0090 ;��� A Ϊ 0������ת�� KEYBOARD0090 ������ִ��
	MOV  	A,i2 ;�� i2 �������ƶ��� A ��
	CJNE 	A,#01H,KEYBOARD0095 ;�Ƚ� A �� 01H���������ȣ�����ת�� KEYBOARD0095 ������ִ��
	MOV  	bits,a2 ;�����ȣ��� a2 �������ƶ��� bits �У��� bits = a2
	SJMP 	KEYBOARD0096 ;��������ת�� KEYBOARD0096 ������ִ��
KEYBOARD0095: ;����һ���µı�ǩ
	MOV  	A,a2 ;�� a2 �������ƶ��� A ��
	MOV  	B,#0AH ;�� 0AH �ƶ��� B �У��� B = 10
	MUL  	AB ;�� A �� B ��ˣ��� A = A * B
	ADD  	A,a2+01H ;�� A �� a2+01H ��ӣ��� A = A + a2+01H
	MOV  	bits,A ;�� A �������ƶ��� bits �У��� bits = A
KEYBOARD0096: ;����һ���µı�ǩ
	MOV  	A,bits ;�� bits �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#040H ;�� A �� 040H ������� A = A - 040H
	JNC  	KEYBOARD0098 ;���û�н�λ���� A >= 040H������ת�� KEYBOARD0098 ������ִ��
	MOV  	R7,#01H ;����н�λ���� A < 040H���� 01H �ƶ��� R7 �У��� R7 = 1
	SJMP 	KEYBOARD0099 ;��������ת�� KEYBOARD0099 ������ִ��
KEYBOARD0098: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0099: ;����һ���µı�ǩ
	MOV  	A,bits ;�� bits �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#01H ;�� A �� 01H ������� A = A - 01H
	JC   	KEYBOARD0100 ;����н�λ���� A < 01H������ת�� KEYBOARD0100 ������ִ��
	MOV  	R6,#01H ;���û�н�λ���� A >= 01H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0101 ;��������ת�� KEYBOARD0101 ������ִ��
KEYBOARD0100: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0101: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JZ   	KEYBOARD0097 ;��� A Ϊ 0������ת�� KEYBOARD0097 ������ִ��
	CLR  	C ;�����λ��־ C
	RET ;����
KEYBOARD0097: ;����һ���µı�ǩ
	LCALL	wrong_input_bits ;���� wrong_input_bits �ӳ��򣬴�����������λ
	JC   	$ + 5H ;����н�λ��������λ��������ת������� RET ָ��
	LJMP 	KEYBOARD0074 ;���û�н�λ��������λ��ȷ������������ת�� KEYBOARD0074 ������ִ��
	RET  	;����
KEYBOARD0090: ;����һ���µı�ǩ
	MOV  	A,digit2 ;�� digit2 �������ƶ��� A ��
	CJNE 	A,#0EH,KEYBOARD0106 ;�Ƚ� A �� 0EH���������ȣ�����ת�� KEYBOARD0106 ������ִ��
	SETB 	C ;�����ȣ�����λ��λ��־ C
	RET  	;����
KEYBOARD0106: ;����һ���µı�ǩ
	MOV  	A,digit2 ;�� digit2 �������ƶ��� A ��
	CJNE 	A,#0DH,KEYBOARD0109 ;�Ƚ� A �� 0DH���������ȣ�����ת�� KEYBOARD0109 ������ִ��
	MOV  	R7,#01H ;�����ȣ��� 01H �ƶ��� R7 �У��� R7 = 1
	SJMP 	KEYBOARD0110 ;��������ת�� KEYBOARD0110 ������ִ��
KEYBOARD0109: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0110: ;����һ���µı�ǩ
	MOV  	A,i2 ;�� i2 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0111 ;����н�λ���� A < 00H������ת�� KEYBOARD0111 ������ִ��
	MOV  	R6,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0112 ;��������ת�� KEYBOARD0112 ������ִ��
KEYBOARD0111: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0112: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JZ   	$ + 5H ;��� A Ϊ 0������ת������� DEC ָ��
	LJMP 	KEYBOARD0074 ;��� A ��Ϊ 0������������ת�� KEYBOARD0074 ������ִ��
	DEC  	i2 ;�� i2 �� 1���� i2 = i2 - 1
KEYBOARD0081: ;����һ���µı�ǩ
	INC  	i2 ;�� i2 �� 1���� i2 = i2 + 1
	LJMP 	KEYBOARD0079 ;��������ת�� KEYBOARD0079 ������ִ��
	RSEG  input_display_time_KEYBOARD ;����һ���Σ���ʾ������ʾʱ��ļ��̴���
input_display_time: ;����һ����ǩ����ʾ������ʾʱ��Ĵ���
	USING	0 ;ʹ�üĴ����� 0
	CLR  	A ;����ۼ��� A ������
	MOV  	digit1,A ;�� A �������ƶ��� digit1 �У��� digit1 = 0
	MOV  	R0,#LOW (a1) ;�� a1 �ĵ� 8 λ�ƶ��� R0 ��
	MOV  	R4,#HIGH (a1) ;�� a1 �ĸ� 8 λ�ƶ��� R4 ��
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R3,#0FFH ;�� 0FFH �ƶ��� R3 �У��� R3 = 255
	MOV  	R2,#HIGH (_?ix1001) ;�� _?ix1001 �ĸ� 8 λ�ƶ��� R2 ��
	MOV  	R1,#LOW (_?ix1001) ;�� _?ix1001 �ĵ� 8 λ�ƶ��� R1 ��
	MOV  	R6,A ;�� A �������ƶ��� R6 �У��� R6 = 0
	MOV  	R7,#05H ;�� 05H �ƶ��� R7 �У��� R7 = 5
	LCALL	?C?COPY ;���� ?C?COPY �ӳ��򣬽� R1-R7 �е����ݸ��Ƶ� a1 �� _?ix1001 ��
	CLR  	state1 ;��� state1 �����ݣ��� state1 = 0
	LCALL	wait_input ;���� wait_input �ӳ��򣬵ȴ�����
	MOV  	state1,C ;����λ��־ C �������ƶ��� state1 ��
	JNB  	state1,KEYBOARD0116 ;��� state1 Ϊ 0����û�����룬����ת�� KEYBOARD0116 ������ִ��
	SETB 	C ;��� state1 ��Ϊ 0���������룬����λ C
	RET  	;����
KEYBOARD0116: ;����һ����ǩ����ʾ��������Ĵ���
	LCALL	clear ;���� clear �ӳ��������Ļ
	CLR  	A ;����ۼ��� A ������
	MOV  	i1,A ;�� A �������ƶ��� i1 �У��� i1 = 0
KEYBOARD0118: ;����һ��ѭ���Ŀ�ʼ
	MOV  	A,#LOW (a1) ;�� a1 �ĵ� 8 λ�ƶ��� A ��
	ADD  	A,i1 ;�� A �� i1 ��ӣ��� A = A + i1
	MOV  	R0,A ;�� A �������ƶ��� R0 ��
	CLR  	A ;��� A ������
	MOV  	@R0,A ;�� A �������ƶ��� R0 ָ����ڴ浥Ԫ�У������ a1[i1] ������
	INC  	i1 ;�� i1 �� 1���� i1 = i1 + 1
	MOV  	A,i1 ;�� i1 �������ƶ��� A ��
	CJNE 	A,#05H,KEYBOARD0118 ;�Ƚ� A �� 05H���������ȣ�����ת�� KEYBOARD0118 ������ѭ�����������ִ��
KEYBOARD0119: ;����һ���µı�ǩ
	CLR  	A ;��� A ������
	MOV  	i1,A ;�� A �������ƶ��� i1 �У��� i1 = 0
KEYBOARD0121: ;����һ���µ�ѭ���Ŀ�ʼ
	MOV  	A,i1 ;�� i1 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#06H ;�� A �� 06H ������� A = A - 06H
	JNC  	KEYBOARD0116 ;���û�н�λ���� A >= 06H������ת�� KEYBOARD0116 ������ִ��
	LCALL	kscan ;����н�λ���� A < 06H������� kscan �ӳ���ɨ���������
	MOV  	digit1,R7 ;�� R7 �������ƶ��� digit1 �У��� digit1 = R7
	MOV  	A,digit1 ;�� digit1 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0125 ;����н�λ���� A < 00H������ת�� KEYBOARD0125 ������ִ��
	MOV  	R7,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R7 �У��� R7 = 1
	SJMP 	KEYBOARD0126 ;��������ת�� KEYBOARD0126 ������ִ��
KEYBOARD0125: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0126: ;����һ���µı�ǩ
	MOV  	A,i1 ;�� i1 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#05H ;�� A �� 05H ������� A = A - 05H
	JNC  	KEYBOARD0127 ;���û�н�λ���� A >= 05H������ת�� KEYBOARD0127 ������ִ��
	MOV  	R6,#01H ;����н�λ���� A < 05H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0128 ;��������ת�� KEYBOARD0128 ������ִ��
KEYBOARD0127: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0128: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	MOV  	R7,A ;�� A �������ƶ��� R7 ��
	MOV  	A,digit1 ;�� digit1 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#09H ;�� A �� 09H ������� A = A - 09H
	JNC  	KEYBOARD0129 ;���û�н�λ���� A >= 09H������ת�� KEYBOARD0129 ������ִ��
	MOV  	R6,#01H ;����н�λ���� A < 09H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0130 ;��������ת�� KEYBOARD0130 ������ִ��
KEYBOARD0129: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0130: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JZ   	KEYBOARD0124 ;��� A Ϊ 0������ת�� KEYBOARD0124 ������ִ��
	MOV  	A,#LOW (a1) ;�� a1 �ĵ� 8 λ�ƶ��� A ��
	ADD  	A,i1 ;�� A �� i1 ��ӣ��� A = A + i1
	MOV  	R0,A ;�� A �������ƶ��� R0 ��
	MOV  	@R0,digit1 ;�� digit1 �������ƶ��� R0 ָ����ڴ浥Ԫ�У��� a1[i1] = digit1
	MOV  	A,digit1 ;�� digit1 �������ƶ��� A ��
	ADD  	A,#030H ;�� A �� 030H ��ӣ��� A = A + 030H
	MOV  	R3,A ;�� A �������ƶ��� R3 ��
	CLR  	A ;��� A ������
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R7,A ;�� A �������ƶ��� R7 �У��� R7 = 0
	LCALL	_print_char ;���� _print_char �ӳ��򣬴�ӡ�ַ�
	LJMP 	KEYBOARD0123 ;��������ת�� KEYBOARD0123 ������ִ��
KEYBOARD0124: ;����һ���µı�ǩ
	MOV  	A,digit1 ;�� digit1 �������ƶ��� A ��
	CJNE 	A,#0FH,KEYBOARD0133 ;�Ƚ� A �� 0FH���������ȣ�����ת�� KEYBOARD0133 ������ִ��
	MOV  	R7,#01H ;�����ȣ��� 01H �ƶ��� R7 �У��� R7 = 1
	SJMP 	KEYBOARD0134 ;��������ת�� KEYBOARD0134 ������ִ��
KEYBOARD0133: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0134: ;����һ���µı�ǩ
	MOV  	A,i1 ;�� i1 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0135 ;����н�λ���� A < 00H������ת�� KEYBOARD0135 ������ִ��
	MOV  	R6,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0136 ;��������ת�� KEYBOARD0136 ������ִ��
KEYBOARD0135: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0136: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JNZ  	$ + 5H ;��� A ��Ϊ 0������ת������� LJMP ָ��
	LJMP 	KEYBOARD0132 ;��� A Ϊ 0������������ת�� KEYBOARD0132 ������ִ��
	CLR  	A ;��� A ������
	MOV  	temp1+03H,A ;�� A �������ƶ��� temp1+03H �У��� temp1+03H = 0
	MOV  	temp1+02H,A ;�� A �������ƶ��� temp1+02H �У��� temp1+02H = 0
	MOV  	temp1+01H,A ;�� A �������ƶ��� temp1+01H �У��� temp1+01H = 0
	MOV  	temp1,A ;�� A �������ƶ��� temp1 �У��� temp1 = 0
	MOV  	j1,A ;�� A �������ƶ��� j1 �У��� j1 = 0
KEYBOARD0137: ;����һ���µı�ǩ
	MOV  	A,j1 ;�� j1 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,i1 ;�� A �� i1 ������� A = A - i1
	JNC  	KEYBOARD0138 ;���û�н�λ���� A >= i1������ת�� KEYBOARD0138 ������ִ��
	CLR  	A ;��� A ������
	MOV  	R7,#0AH ;�� 0AH �ƶ��� R7 �У��� R7 = 10
	MOV  	R6,A ;�� A �������ƶ��� R6 �У��� R6 = 0
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R4,A ;�� A �������ƶ��� R4 �У��� R4 = 0
	MOV  	R3,temp1+03H ;�� temp1+03H �������ƶ��� R3 ��
	MOV  	R2,temp1+02H ;�� temp1+02H �������ƶ��� R2 ��
	MOV  	R1,temp1+01H ;�� temp1+01H �������ƶ��� R1 ��
	MOV  	R0,temp1 ;�� temp1 �������ƶ��� R0 ��
	LCALL	?C?LMUL ;���� ?C?LMUL �ӳ��򣬽� R0-R7 �е�������ˣ��� R0-R7 = R0-R3 * R4-R7
	PUSH 	AR4 ;�� R4 ������ѹ���ջ
	MOV  	R1,AR5 ;�� R5 �������ƶ��� R1 ��
	MOV  	R2,AR6 ;�� R6 �������ƶ��� R2 ��
	MOV  	R3,AR7 ;�� R7 �������ƶ��� R3 ��
	MOV  	A,#LOW (a1) ;�� a1 �ĵ� 8 λ�ƶ��� A ��
	ADD  	A,j1 ;�� A �� j1 ��ӣ��� A = A + j1
	MOV  	R0,A ;�� A �������ƶ��� R0 ��
	MOV  	A,@R0 ;�� R0 ָ����ڴ浥Ԫ�������ƶ��� A �У��� A = a1[j1]
	MOV  	R7,A ;�� A �������ƶ��� R7 ��
	CLR  	A ;��� A ������
	MOV  	R4,A ;�� A �������ƶ��� R4 �У��� R4 = 0
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R6,A ;�� A �������ƶ��� R6 �У��� R6 = 0
	POP  	AR0 ;����ջ���������ݵ����� R0 �У��� R0 = R4
	MOV  	A,R3 ;�� R3 �������ƶ��� A ��
	ADD  	A,R7 ;�� A �� R7 ��ӣ��� A = A + R7
	MOV  	temp1+03H,A ;�� A �������ƶ��� temp1+03H ��
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ADDC 	A,R2 ;�� A �� R2 ��ӣ�����λ���� A = A + R2 + C
	MOV  	temp1+02H,A ;�� A �������ƶ��� temp1+02H ��
	MOV  	A,R5 ;�� R5 �������ƶ��� A ��
	ADDC 	A,R1 ;�� A �� R1 ��ӣ�����λ���� A = A + R1 + C
	MOV  	temp1+01H,A ;�� A �������ƶ��� temp1+01H ��
	MOV  	A,R4 ;�� R4 �������ƶ��� A ��
	ADDC 	A,R0 ;�� A �� R0 ��ӣ�����λ���� A = A + R0 + C
	MOV  	temp1,A ;�� A �������ƶ��� temp1 ��
	INC  	j1 ;�� j1 �� 1���� j1 = j1 + 1
	SJMP 	KEYBOARD0137 ;��������ת�� KEYBOARD0137 ������ѭ��
KEYBOARD0138: ;����һ���µı�ǩ
	CLR  	A ;��� A ������
	MOV  	R7,#0FFH ;�� 0FFH �ƶ��� R7 �У��� R7 = 255
	MOV  	R6,#0FFH ;�� 0FFH �ƶ��� R6 �У��� R6 = 255
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R4,A ;�� A �������ƶ��� R4 �У��� R4 = 0
	MOV  	R3,temp1+03H ;�� temp1+03H �������ƶ��� R3 ��
	MOV  	R2,temp1+02H ;�� temp1+02H �������ƶ��� R2 ��
	MOV  	R1,temp1+01H ;�� temp1+01H �������ƶ��� R1 ��
	MOV  	R0,temp1 ;�� temp1 �������ƶ��� R0 ��
	SETB 	C ;��λ��λ��־ C
	LCALL	?C?ULCMP ;���� ?C?ULCMP �ӳ��򣬽� R0-R7 �е�������Ƚϣ��� R0-R3 �� R4-R7
	JNC  	KEYBOARD0141 ;���û�н�λ���� R0-R3 >= R4-R7������ת�� KEYBOARD0141 ������ִ��
	MOV  	R7,#01H ;����н�λ���� R0-R3 < R4-R7���� 01H �ƶ��� R7 �У��� R7 = 1
	PUSH 	AR7 ;�� R7 ������ѹ���ջ
	SJMP 	KEYBOARD0142 ;��������ת�� KEYBOARD0142 ������ִ��
KEYBOARD0141: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
	PUSH 	AR7 ;�� R7 ������ѹ���ջ
KEYBOARD0142: ;����һ���µı�ǩ
	CLR  	A ;��� A ������
	MOV  	R7,#032H ;�� 032H �ƶ��� R7 �У��� R7 = 50
	MOV  	R6,A ;�� A �������ƶ��� R6 �У��� R6 = 0
	MOV  	R5,A ;�� A �������ƶ��� R5 �У��� R5 = 0
	MOV  	R4,A ;�� A �������ƶ��� R4 �У��� R4 = 0
	MOV  	R3,temp1+03H ;�� temp1+03H �������ƶ��� R3 ��
	MOV  	R2,temp1+02H ;�� temp1+02H �������ƶ��� R2 ��
	MOV  	R1,temp1+01H ;�� temp1+01H �������ƶ��� R1 ��
	MOV  	R0,temp1 ;�� temp1 �������ƶ��� R0 ��
	CLR  	C ;�����λ��־ C
	LCALL	?C?ULCMP ;���� ?C?ULCMP �ӳ��򣬽� R0-R7 �е�������Ƚϣ��� R0-R3 �� R4-R7
	JC   	KEYBOARD0143 ;����н�λ���� R0-R3 < R4-R7������ת�� KEYBOARD0143 ������ִ��
	MOV  	R6,#01H ;���û�н�λ���� R0-R3 >= R4-R7���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0144 ;��������ת�� KEYBOARD0144 ������ִ��
KEYBOARD0143: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0144: ;����һ���µı�ǩ
	POP  	ACC ;����ջ���������ݵ����� ACC �У��� ACC = R7
	ANL  	A,R6 ;�� A �� R6 �����߼������㣬�� A = A & R6
	JZ   	KEYBOARD0140 ;��� A Ϊ 0������ת�� KEYBOARD0140 ������ִ��
	MOV  	display_time,temp1+02H ;�� temp1+02H �������ƶ��� display_time ��
	MOV  	display_time+01H,temp1+03H ;�� temp1+03H �������ƶ��� display_time+01H ��
	CLR  	C ;�����λ��־ C
	RET  	;����
KEYBOARD0140: ;����һ���µı�ǩ
	LCALL	wrong_display_time ;���� wrong_display_time �ӳ�����ʾ���������ʱ��
	JC   	$ + 5H ;����н�λ��������ʱ���������ת������� LJMP ָ��
	LJMP 	KEYBOARD0116 ;���û�н�λ��������ʱ����ȷ������������ת�� KEYBOARD0116 ������ִ��
	RET  	;����
KEYBOARD0132: ;����һ���µı�ǩ
	MOV  	A,digit1 ;�� digit1 �������ƶ��� A ��
	CJNE 	A,#0EH,KEYBOARD0149 ;�Ƚ� A �� 0EH���������ȣ�����ת�� KEYBOARD0149 ������ִ��
	SETB 	C ;�����ȣ�����λ C
	RET  	;����
KEYBOARD0149: ;����һ���µı�ǩ
	MOV  	A,digit1 ;�� digit1 �������ƶ��� A ��
	CJNE 	A,#0DH,KEYBOARD0152 ;�Ƚ� A �� 0DH���������ȣ�����ת�� KEYBOARD0152 ������ִ��
	MOV  	R7,#01H ;�����ȣ��� 01H �ƶ��� R7 �У��� R7 = 1
	SJMP 	KEYBOARD0153 ;��������ת�� KEYBOARD0153 ������ִ��
KEYBOARD0152: ;����һ���µı�ǩ
	MOV  	R7,#00H ;�� 00H �ƶ��� R7 �У��� R7 = 0
KEYBOARD0153: ;����һ���µı�ǩ
	MOV  	A,i1 ;�� i1 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0154 ;����н�λ���� A < 00H������ת�� KEYBOARD0154 ������ִ��
	MOV  	R6,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0155 ;��������ת�� KEYBOARD0155 ������ִ��
KEYBOARD0154: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0155: ;����һ���µı�ǩ
	MOV  	A,R6 ;�� R6 �������ƶ��� A ��
	ANL  	A,R7 ;�� A �� R7 �����߼������㣬�� A = A & R7
	JZ   	$ + 5H ;��� A Ϊ 0������ת������� DEC ָ��
	LJMP 	KEYBOARD0116 ;��� A ��Ϊ 0������������ת�� KEYBOARD0116 ������ִ��
	DEC  	i1 ;�� i1 �� 1���� i1 = i1 - 1
KEYBOARD0123: ;����һ���µı�ǩ
	INC  	i1 ;�� i1 �� 1���� i1 = i1 + 1
	LJMP 	KEYBOARD0121 ;��������ת�� KEYBOARD0121 ������ִ��
	RSEG  wait_input_KEYBOARD ;����һ���Σ���ʾ�ȴ�����ļ��̴���
wait_input: ;����һ����ǩ����ʾ�ȴ�����Ĵ���
	USING	0 ;ʹ�üĴ����� 0
	CLR  	state3 ;��� state3 �����ݣ��� state3 = 0
KEYBOARD0157: ;����һ��ѭ���Ŀ�ʼ
	LCALL	kscan ;���� kscan �ӳ���ɨ���������
	MOV  	A,R7 ;�� R7 �������ƶ��� A ��
	SETB 	C ;��λ��λ��־ C
	SUBB 	A,#0FH ;�� A �� 0FH ������� A = A - 0FH
	JNC  	KEYBOARD0160 ;���û�н�λ���� A >= 0FH������ת�� KEYBOARD0160 ������ִ��
	MOV  	R6,#01H ;����н�λ���� A < 0FH���� 01H �ƶ��� R6 �У��� R6 = 1
	SJMP 	KEYBOARD0161 ;��������ת�� KEYBOARD0161 ������ִ��
KEYBOARD0160: ;����һ���µı�ǩ
	MOV  	R6,#00H ;�� 00H �ƶ��� R6 �У��� R6 = 0
KEYBOARD0161: ;����һ���µı�ǩ
	MOV  	A,R7 ;�� R7 �������ƶ��� A ��
	CLR  	C ;�����λ��־ C
	SUBB 	A,#00H ;�� A �� 00H ������� A = A - 00H
	JC   	KEYBOARD0162 ;����н�λ���� A < 00H������ת�� KEYBOARD0162 ������ִ��
	MOV  	R5,#01H ;���û�н�λ���� A >= 00H���� 01H �ƶ��� R5 �У��� R5 = 1
	SJMP 	KEYBOARD0163 ;��������ת�� KEYBOARD0163 ������ִ��
KEYBOARD0162: ; ����R5Ϊ0
	MOV  	R5,#00H
KEYBOARD0163: ; ��R5��ֵ�ƶ���A�У�����R6�����߼�������
	MOV  	A,R5
	ANL  	A,R6
	JZ   	KEYBOARD0157 ; ���AΪ0����ת��KEYBOARD0157
	CJNE 	R7,#0EH,KEYBOARD0164 ; ���R7������0EH����ת��KEYBOARD0164
	SETB 	state3 ; ��������state3Ϊ1
KEYBOARD0164: ; ��state3��ֵ�ƶ���C�У�������
	MOV  	C,state3
	RET  	
RSEG  wrong_input_bits_KEYBOARD ; ����һ����������ʾ���������λ
wrong_input_bits: ; ����һ����ǩ����ʾ���������λ�Ĵ������
	USING	0 ; ʹ�üĴ�����0
	LCALL	display_wrong_input_bits ; ������ʾ��������λ���ӳ���
	LJMP 	f_or_e ; ����ת��f_or_e
RSEG  wrong_display_time_KEYBOARD ; ����һ����������ʾ�������ʾʱ��
wrong_display_time: ; ����һ����ǩ����ʾ�������ʾʱ��Ĵ������
	USING	0 ; ʹ�üĴ�����0
	LCALL	display_wrong_input_display_time ; ������ʾ����������ʾʱ����ӳ���
	LJMP 	f_or_e ; ����ת��f_or_e
END ; ����

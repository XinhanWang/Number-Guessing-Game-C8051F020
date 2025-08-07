/*
 * @Author: �����
 * @Date: 2023-12-22 12:43:17
 * @LastEditors: �����
 * @LastEditTime: 2023-12-25 11:53:21
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\���汾\GUESSING_GAME.asm
 * @Description:  ������Ϸ�ļ�������������Ϸ��غ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
; ����51��SFR��������������
$NOMOD51
NAME	GUESSING_GAME
; ����һ�������궨����ļ�������GUESSING_GAME.inc
$include(GUESSING_GAME.inc) ;
; ����һ����ΪDT_guess_once_GUESSING_GAME�ĶΣ����ڴ洢���������
RSEG  DT_guess_once_GUESSING_GAME

; guess_once_BYTE: ����һ����Ϊguess_once_BYTE�ĶΣ����ڴ洢���������
guess_once_BYTE:
     state:   DS   1  ; ����һ����Ϊstate�ļĴ��������ڴ洢�²�״̬
	RSEG  BI_guess_once_GUESSING_GAME  ; ����һ����ΪBI_guess_once_GUESSING_GAME�ĶΣ����ڴ洢���������
guess_once_BIT:
         a1:   DBIT   1  ; ����һ����Ϊa1�ļĴ��������ڴ洢һ��λ
      temp:   DBIT   1  ; ����һ����Ϊtemp�ļĴ��������ڴ洢һ��λ
	RSEG  BI_guess_one_level_GUESSING_GAME  ; ����һ����ΪBI_guess_one_level_GUESSING_GAME�ĶΣ����ڴ洢���������
guess_one_level_BIT:
         b2:   DBIT   1  ; ����һ����Ϊb2�ļĴ��������ڴ洢һ��λ
         a2:   DBIT   1  ; ����һ����Ϊa2�ļĴ��������ڴ洢һ��λ
	RSEG  DT_mode1_GAME  ; ����һ����ΪDT_mode1_GAME�ĶΣ����ڴ洢���������
mode1_BYTE:
        i:   DS   1  ; ����һ����Ϊi�ļĴ��������ڴ洢һ���ֽ�
    state1:   DS   1  ; ����һ����Ϊstate1�ļĴ��������ڴ洢�²�״̬
	RSEG  XD_GUESSING_GAME  ; ����һ����ΪXD_GUESSING_GAME�ĶΣ����ڴ洢���������
level_display_time:   DS   20  ; ����һ����Ϊlevel_display_time�ļĴ��������ڴ洢��ʾʱ��
    level_bits:   DS   10  ; ����һ����Ϊlevel_bits�ļĴ��������ڴ洢��ʾ��λ
 random_digits:   DS   64  ; ����һ����Ϊrandom_digits�ļĴ��������ڴ洢�����
	RSEG  DT_GUESSING_GAME  ; ����һ����ΪDT_GUESSING_GAME�ĶΣ����ڴ洢���������
  display_time:   DS   2  ; ����һ����Ϊdisplay_time�ļĴ��������ڴ洢��ʾʱ��
          bits:   DS   1  ; ����һ����Ϊbits�ļĴ��������ڴ洢һ��λ

    RSEG CO_GUESSING_GAME ; ����һ����ΪCO_GUESSING_GAME�ĶΣ����ڴ洢���������
CODE_GUESSING_GAME:
   ; digits: ����һ����Ϊdigits�����飬���ڴ洢����0-9����ĸA-F
   digits:   DB  '0' ,'1' ,'2' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9' 
         DB  'A' ,'B' ,'C' ,'D' ,'E' ,'F' ,000H
	; RSEG  ?C_INITSEG: ����һ����Ϊ?C_INITSEG�ĶΣ����ڴ洢���������
	RSEG  ?C_INITSEG
	DB	060H
	DB	040H
	DW	random_digits
	DB	000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
	DB  000H,000H,000H
	DB	001H
	DB	bits
	DB	000H
	DB	002H
	DB	display_time
	DW	00000H
	DB	04AH
	DW	level_bits
	DB	001H
	DB	002H
	DB	003H
	DB	004H
	DB	005H
	DB	006H
	DB	007H
	DB	008H
	DB	009H
	DB	00AH
	DB	054H
	DW	level_display_time
	DW	000C8H
	DW	00190H
	DW	00258H
	DW	00320H
	DW	003E8H
	DW	004B0H
	DW	00578H
	DW	00640H
	DW	00708H
	DW	007D0H
	RSEG  check_digits_GUESSING_GAME
; ����һ����Ϊcheck_digits_GUESSING_GAME�ĶΣ����ڴ洢���������
check_digits_GUESSING:
	; ����һ����Ϊcheck_digits�ı�ǩ��������ת���ñ�ǩ��λ��
check_digits:
	; ʹ�üĴ���0��Ϊ�����Ĵ���
	USING	0
	;���Ĵ���A�е�ֵ����
	CLR  	A
	;���Ĵ���A�е�ֵ�洢���Ĵ���R7��
	MOV  	R7,A
; GUSSING_GAME0001: ����һ��ѭ�������ڼ���û�����������Ƿ��������������
GUSSING_GAME0001:
	;������ĵ�8λ�洢���Ĵ���A��
	MOV  	A,#LOW (inputs)
	ADD  	A,R7
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (inputs); ������ĸ�8λ������ĵ�8λ��ӣ�����洢���Ĵ���A��
	MOV  	DPH,A
	MOVX 	A,@DPTR; ������������е����ִ洢���Ĵ���A��
	MOV  	R6,A; ���Ĵ���A�е�ֵ�洢���Ĵ���R6�У����ں����Ƚ�
	MOV  	A,#LOW (random_digits); ������������еĵ�8λ�洢���Ĵ���A��
	ADD  	A,R7; ������������е�ƫ�����������ƫ������ӣ�����洢���Ĵ���A��
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (random_digits); ������������еĸ�8λ������ĸ�8λ��ӣ�����洢���Ĵ���A��
	MOV  	DPH,A
	MOVX 	A,@DPTR; ������������е����ִ洢���Ĵ���A��
	CJNE 	A,AR6,GUSSING_GAME0002; ������������������������е����ֲ���ȣ�����ת��GUSSING_GAME0002��ǩ
	INC  	R7; ������������������������е�������ȣ�������������ƫ������1
	CJNE 	R7,#040H,GUSSING_GAME0001; �������������ƫ�������ڵ���40������ת��GUSSING_GAME0001��ǩ

; GUSSING_GAME0002: ������������������������е����ֲ���ȣ�����ת��GUSSING_GAME0005��ǩ
GUSSING_GAME0002:
	; CJNE 	R7,#040H,GUSSING_GAME0005: �������������ƫ�������ڵ���40������ת��GUSSING_GAME0005��ǩ
	CJNE 	R7,#040H,GUSSING_GAME0005
	; SETB 	C: ����CλΪ1����ʾ�²���ȷ
	SETB 	C
	; RET  	: ���ص��ô��ĵ�ַ
	RET  
GUSSING_GAME0005:
	; CLR  	C: ��Cλ���㣬��ʾ�²����
	CLR  	C
GUSSING_GAME0006:
	; RET  	: ���ص��ô��ĵ�ַ
	RET  
	; RSEG  correct_GAME: ����һ��������ȷ��ʾ�����Ķ�
	RSEG  correct_GAME
correct:
	; USING 0: ʹ�üĴ���0��Ϊ�����Ĵ���
	USING	0
	; LCALL	display_correct: ������ʾ��ȷ��ʾ�ĺ���
	LCALL	display_correct
	; LJMP 	f_or_e: ��ת��f_or_e��ǩ
	LJMP 	f_or_e
	; RSEG  error_GAME: ����һ������������ʾ�����Ķ�
	RSEG  error_GAME
error:
	; USING 0: ʹ�üĴ���0��Ϊ�����Ĵ���
	USING	0
	; LCALL	display_error: ������ʾ������ʾ�ĺ���
	LCALL	display_error
	; LJMP 	f_or_e: ��ת��f_or_e��ǩ
	LJMP 	f_or_e
	; RSEG  win_GAME: ����һ������ʤ����ʾ�����Ķ�
	RSEG  win_GAME
; win: ����һ������ʤ����ʾ�����Ķ�
win:
	; USING 0: ʹ�üĴ���0��Ϊ�����Ĵ���
	USING	0
	; LCALL	display_win: ������ʾʤ����ʾ�ĺ���
	LCALL	display_win
	; LJMP 	f_or_e: ��ת��f_or_e��ǩ
	LJMP 	f_or_e
	RSEG  lose_GAME  ; ������һ����Ϊ lose_GAME �����ݶ�
lose:  ; ����ǩ����ʾһ����ຯ���Ŀ�ʼ
	USING 0  ; ��ʾʹ�üĴ���0 
	LCALL display_lose  ; ���� display_lose ������������ʾ��������Ϸ��ʧ����Ϣ
	LJMP f_or_e  ; ��ת�� f_or_e ��ǩ

RSEG  guess_once_GAME
guess_once:
	; ʹ�üĴ���0��Ϊ�����Ĵ���
	USING	0
	; ��״̬�Ĵ�������
	CLR  	A
	; ��״̬�Ĵ�����ֵ�洢��state������
	MOV  	state,A
	; ������ʾ���������ĺ���
	LCALL	display_random_digits
	; ������ʾ������ʾ�ĺ���
	LCALL	display_input
	; �����������ֵĺ���
	LCALL	input_digits
	; ��״̬�Ĵ�������
	CLR  	A
	; ��״̬�Ĵ�����ֵ����1λ
	RLC  	A
	; ��״̬�Ĵ�����ֵ�洢��state������
	MOV  	state,A
	; �����������ֲ���1������ת��GUSSING_GAME0012��ǩ
	CJNE 	A,#01H,GUSSING_GAME0012
	; ����������ִ洢��R7�Ĵ�����
	MOV  	R7,A
	; ���ص��ô��ĵ�ַ
	RET  	
GUSSING_GAME0012:
	; ���ü�����ֵĺ���
	LCALL	check_digits
	; ������洢���Ĵ���A��
	MOV  	a1,C
	; ��������������ȷ������ת��GUSSING_GAME0014��ǩ
	JNB  	a1,GUSSING_GAME0014
	; ������ʾ��ȷ��ʾ�ĺ���
	LCALL	correct
	; ����������ִ洢���Ĵ���R7��
	MOV  	temp,C
	; ��������������ȷ������ת��GUSSING_GAME0015��ǩ
	JNB  	temp,GUSSING_GAME0015
	; ��ת��GUSSING_GAME0094��ǩ
	SJMP 	GUSSING_GAME0094
GUSSING_GAME0015:
	; ��R7�Ĵ�����ֵ����Ϊ0
	MOV  	R7,#00H
	; ���ص��ô��ĵ�ַ
	RET  	
GUSSING_GAME0014:
	; ������ʾ������ʾ�ĺ���
	LCALL	error
	; ����������ִ洢���Ĵ���R7��
	MOV  	temp,C
	; ��������������ȷ������ת��GUSSING_GAME0017��ǩ
	JNB  	temp,GUSSING_GAME0017
GUSSING_GAME0094:
	; ��״̬�Ĵ�����ֵ����Ϊ1
	MOV  	state,#01H
	; ��״̬�Ĵ�����ֵ�洢��R7�Ĵ�����
	MOV  	R7,state
	; ���ص��ô��ĵ�ַ
	RET  	
GUSSING_GAME0017:
	; ��R7�Ĵ�����ֵ����Ϊ2
	MOV  	R7,#02H
GUSSING_GAME0013:
	; ���ص��ô��ĵ�ַ
	RET  	
	RSEG  guess_one_level_GAME

guess_one_level:
	USING	0
	CLR  	A
	MOV  	R5,A
	LCALL	display_random_digits
	LCALL	display_input
	LCALL	input_digits
	CLR  	A
	RLC  	A
	MOV  	R5,A
	CJNE 	R5,#01H,GUSSING_GAME0018
	MOV  	R7,A
	RET  	
GUSSING_GAME0018:
	LCALL	check_digits
	MOV  	a2,C
	JNB  	a2,GUSSING_GAME0020
	JB   	b2,GUSSING_GAME0021
	LCALL	correct
	CLR  	A
	RLC  	A
	MOV  	R5,A
	CJNE 	R5,#01H,GUSSING_GAME0022
	MOV  	R7,A
	RET  	
GUSSING_GAME0022:
	MOV  	R7,#02H
	RET  	
GUSSING_GAME0021:
	LCALL	win
	CLR  	A
	RLC  	A
	MOV  	R5,A
	CJNE 	R5,#01H,GUSSING_GAME0025
	MOV  	R7,A
	RET  	
GUSSING_GAME0025:
	MOV  	R7,#00H
	RET  	
GUSSING_GAME0020:
	LCALL	lose
	CLR  	A
	RLC  	A
	MOV  	R7,A
GUSSING_GAME0019:
	RET  	
	RSEG  main_menu_GAME
main_menu:
	USING	0
	LCALL	display_main_menu
GUSSING_GAME0028:
	LCALL	kscan
	CJNE 	R7,#01H,GUSSING_GAME0031
	MOV  	R6,#01H
	SJMP 	GUSSING_GAME0032
GUSSING_GAME0031:
	MOV  	R6,#00H
GUSSING_GAME0032:
	MOV  	A,R7
	JNZ  	GUSSING_GAME0033
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0034
GUSSING_GAME0033:
	MOV  	R5,#00H
GUSSING_GAME0034:
	MOV  	A,R5
	ORL  	A,R6
	MOV  	R6,A
	CJNE 	R7,#0EH,GUSSING_GAME0035
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0036
GUSSING_GAME0035:
	MOV  	R5,#00H
GUSSING_GAME0036:
	MOV  	A,R5
	ORL  	A,R6
	JZ   	GUSSING_GAME0028
GUSSING_GAME0029:
	RET  	
	RSEG  mode_select_GAME
mode_select:
	USING	0
	LCALL	display_mode_select
GUSSING_GAME0038:
	LCALL	kscan
	CJNE 	R7,#01H,GUSSING_GAME0041
	MOV  	R6,#01H
	SJMP 	GUSSING_GAME0042
GUSSING_GAME0041:
	MOV  	R6,#00H
GUSSING_GAME0042:
	MOV  	A,R7
	JNZ  	GUSSING_GAME0043
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0044
GUSSING_GAME0043:
	MOV  	R5,#00H
GUSSING_GAME0044:
	MOV  	A,R5
	ORL  	A,R6
	MOV  	R6,A
	CJNE 	R7,#02H,GUSSING_GAME0045
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0046
GUSSING_GAME0045:
	MOV  	R5,#00H
GUSSING_GAME0046:
	MOV  	A,R5
	ORL  	A,R6
	MOV  	R6,A
	CJNE 	R7,#0EH,GUSSING_GAME0047
	MOV  	R5,#01H
	SJMP 	GUSSING_GAME0048
GUSSING_GAME0047:
	MOV  	R5,#00H
GUSSING_GAME0048:
	MOV  	A,R5
	ORL  	A,R6
	JZ   	GUSSING_GAME0038
GUSSING_GAME0039:
	RET  	
	RSEG  begin_select_GAME
begin_select:
	USING	0
	LCALL	display_begin_select
	LJMP 	f_or_e
	RSEG  mode1_GAME
mode1:
	USING	0
	CLR  	A
	MOV  	i,A
GUSSING_GAME0051:
	CLR  	A
	MOV  	i,A
GUSSING_GAME0053:
	MOV  	A,#LOW (level_bits)
	ADD  	A,i
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (level_bits)
	MOV  	DPH,A
	MOVX 	A,@DPTR
	MOV  	bits,A
	MOV  	A,i
	ADD  	A,ACC
	ADD  	A,#LOW (level_display_time)
	MOV  	DPL,A
	CLR  	A
	ADDC 	A,#HIGH (level_display_time)
	MOV  	DPH,A
	MOVX 	A,@DPTR
	MOV  	display_time,A
	INC  	DPTR
	MOVX 	A,@DPTR
	MOV  	display_time+01H,A
	LCALL	begin_select
	JC   	GUSSING_GAME0057
	MOV  	A,i
	CJNE 	A,#09H,GUSSING_GAME0058
	SETB 	C
	SJMP 	GUSSING_GAME0059
GUSSING_GAME0058:
	CLR  	C
GUSSING_GAME0059:
	MOV  	guess_one_level_BIT,C
	LCALL	guess_one_level
	MOV  	state1,R7
	MOV  	A,state1
	XRL  	A,#01H
	JZ   	GUSSING_GAME0057
	MOV  	A,state1
	JZ   	GUSSING_GAME0051
	INC  	i
	MOV  	A,i
	CLR  	C
	SUBB 	A,#0AH
	JC   	GUSSING_GAME0053
	SJMP 	GUSSING_GAME0051
GUSSING_GAME0057:
	RET  	
	RSEG  mode2_GAME
mode2:
	USING	0
	LCALL	display_bits_select
	LCALL	input_bits
	JC   	GUSSING_GAME0065
	LCALL	display_time_select
	LCALL	input_display_time
	JC   	GUSSING_GAME0065
	LCALL	display_begin_select
GUSSING_GAME0067:
	LCALL	begin_select
	JC   	GUSSING_GAME0065
	LCALL	guess_once
	CJNE 	R7,#01H,GUSSING_GAME0067
GUSSING_GAME0065:
	RET  	
	RSEG  mode3_GAME
mode3:
	USING	0
GUSSING_GAME0071:
	LCALL	rand
	MOV  	R4,#00H
	MOV  	R5,#08H
	LCALL	?C?SIDIV
	MOV  	A,R5
	INC  	A
	MOV  	bits,A
	LCALL	rand
	MOV  	R4,#00H
	MOV  	R5,#065H
	LCALL	?C?SIDIV
	MOV  	A,bits
	MOV  	B,#0C8H
	MUL  	AB
	MOV  	R6,B
	ADD  	A,R5
	MOV  	display_time+01H,A
	MOV  	A,R6
	ADDC 	A,R4
	MOV  	display_time,A
	LCALL	begin_select
	JC   	GUSSING_GAME0074
	LCALL	guess_once
	CJNE 	R7,#01H,GUSSING_GAME0071
GUSSING_GAME0074:
	RET  	
	RSEG  acknowledgement_GAME
acknowledgement:
	USING	0
	LJMP 	display_acknowledgement
	RSEG  gussing_game_GAME
gussing_game:
	USING	0
GUSSING_GAME0077:
	LCALL	mode_select
	MOV  	A,R7
	XRL  	A,#0EH
	JZ   	GUSSING_GAME0085
	MOV  	A,R7
	DEC  	A
	JZ   	GUSSING_GAME0082
	DEC  	A
	JZ   	GUSSING_GAME0083
	ADD  	A,#02H
	JNZ  	GUSSING_GAME0077
GUSSING_GAME0081:
	LCALL	mode1
	SJMP 	GUSSING_GAME0077
GUSSING_GAME0082:
	LCALL	mode2
	SJMP 	GUSSING_GAME0077
GUSSING_GAME0083:
	LCALL	mode3
	SJMP 	GUSSING_GAME0077
GUSSING_GAME0085:
	RET  	
	RSEG  games_GUESSING_GAME
games:
	USING	0
	LCALL	display_gussing_game
GUSSING_GAME0086:
	LCALL	main_menu
	MOV  	A,R7
	XRL  	A,#0EH
	JZ   	GUSSING_GAME0093
	MOV  	A,R7
	DEC  	A
	JZ   	GUSSING_GAME0091
	INC  	A
	JNZ  	GUSSING_GAME0086
GUSSING_GAME0090:
	LCALL	gussing_game
	SJMP 	GUSSING_GAME0086
GUSSING_GAME0091:
	LCALL	acknowledgement
	SJMP 	GUSSING_GAME0086
GUSSING_GAME0093:
	RET  	
	END

/*
 * @Author: �����
 * @Date: 2023-12-22 11:33:36
 * @LastEditors: �����
 * @LastEditTime: 2023-12-22 23:14:08
 * @FilePath: \undefinedc:\Users\u2021\Desktop\����\����\��Ƭ��\ʵ��\���ʵ��\���汾\LCD12864.asm
 * @Description: LCD12864�ļ�������LCD12864��ʾ��غ���
 * 
 * Copyright (c) 2023 by ${�����}, All Rights Reserved. 
 */
$NOMOD51 ; ����51��SFR
NAME	LCD12864 ; ָ��ģ�������
$include(LCD12864.inc) ; ����LCD12864��ͷ�ļ�
	RSEG  DT_Draw_PM_LCD12864 ; ����һ������Σ����ڻ��Ƶ���ͼ
Draw_PM_BYTE: ; ����һ�����������ڻ��Ƶ���ͼ
        ptr:   DS   3 ; ����һ��3�ֽڵ����ݶΣ����ڴ洢����ͼ�ĵ�ַ
          i:   DS   1 ; ����һ��1�ֽڵ����ݶΣ����ڴ洢ѭ������i
          j:   DS   1 ; ����һ��1�ֽڵ����ݶΣ����ڴ洢ѭ������j
          k:   DS   1 ; ����һ��1�ֽڵ����ݶΣ����ڴ洢ѭ������k
	RSEG  DT_set_xy_LCD12864 ; ����һ������Σ���������LCD������
_set_xy_BYTE: ; ����һ����������������LCD������
       xpos:   DS   1 ; ����һ��1�ֽڵ����ݶΣ����ڴ洢x����
	RSEG  DT_print_LCD12864 ; ����һ������Σ����ڴ�ӡ�ַ���
_print_BYTE: ; ����һ�����������ڴ�ӡ�ַ���
        str:   DS   3 ; ����һ��3�ֽڵ����ݶΣ����ڴ洢�ַ����ĵ�ַ
	RSEG  DT_print_char_LCD12864 ; ����һ������Σ����ڴ�ӡ�ַ�
_print_char_BYTE: ; ����һ�����������ڴ�ӡ�ַ�
          a1:   DS   1 ; ����һ��1�ֽڵ����ݶΣ����ڴ洢�ַ���ASCII��
	RSEG  set_LCD_read_write_LCD12864 ; ����һ������Σ���������LCD�Ķ�дģʽ
set_LCD_read_write: ; ����һ����������������LCD�Ķ�дģʽ
	JB   	LCD_RW,LCD128640001 ; ���LCD_RWλΪ1����ת��LCD128640001
	MOV  	P0MDOUT,#0FFH ; ��P0�˿�����Ϊ�������ģʽ
	RET  	; ����
LCD128640001: ; ��ǩ
	CLR  	A ; ����ۼ���
	MOV  	P0MDOUT,A ; ��P0�˿�����Ϊ��©����ģʽ
	MOV  	P0,#0FFH ; ��P0�˿ڵ�ֵ����Ϊ0xFF
LCD128640003: ; ��ǩ
	RET  	; ����
	RSEG  wait_lcd_not_busy_LCD12864 ; ����һ������Σ����ڵȴ�LCD��æ
wait_lcd_not_busy: ; ����һ�����������ڵȴ�LCD��æ
	CLR  	LCD_RS ; ���LCD_RSλ����ʾ��ȡ״̬
	SETB 	LCD_RW ; ��λLCD_RWλ����ʾ��ȡģʽ
	LCALL	set_LCD_read_write ; ����set_LCD_read_write����������LCD�Ķ�дģʽ
	SETB 	LCD_EN ; ��λLCD_ENλ��ʹ��LCD
LCD128640004: ; ��ǩ
	JB   	D7,LCD128640004 ; ���D7λΪ1����ʾLCDæ����ת��LCD128640004
	CLR  	LCD_EN ; ���LCD_ENλ������LCD
	RET  	; ����
	RSEG  _lcd_wcmd_LCD12864 ; ����һ������Σ�����д��LCD������
_lcd_wcmd: ; ����һ������������д��LCD������
	USING	0 ; ʹ�üĴ�����0
	LCALL	wait_lcd_not_busy ; ����wait_lcd_not_busy�������ȴ�LCD��æ
	CLR  	LCD_RS ; ���LCD_RSλ����ʾд������
	CLR  	LCD_RW ; ���LCD_RWλ����ʾд��ģʽ
	LCALL	set_LCD_read_write ; ����set_LCD_read_write����������LCD�Ķ�дģʽ
	MOV  	P0,R7 ; ��R7��ֵ�ƶ���P0�˿ڣ�R7�洢��Ҫд�������
	MOV  	R7,#01H ; ��01H��ֵ�ƶ���R7��������ʱ
	MOV  	R6,#00H ; ��00H��ֵ�ƶ���R6��������ʱ
	MOV  	R5,#00H ; ��00H��ֵ�ƶ���R5��������ʱ
	MOV  	R4,#00H ; ��00H��ֵ�ƶ���R4��������ʱ
	LCALL	_delay_ms ; ����_delay_ms��������ʱ1����
	SETB 	LCD_EN ; ��λLCD_ENλ��ʹ��LCD
	MOV  	R7,#01H ; ��01H��ֵ�ƶ���R7��������ʱ
	MOV  	R6,#00H ; ��00H��ֵ�ƶ���R6��������ʱ
	MOV  	R5,#00H ; ��00H��ֵ�ƶ���R5��������ʱ
	MOV  	R4,#00H ; ��00H��ֵ�ƶ���R4��������ʱ
	LCALL	_delay_ms ; ����_delay_ms��������ʱ1����
	CLR  	LCD_EN ; ���LCD_ENλ������LCD
	RET  	; ����
	RSEG  _lcd_wdat_LCD12864 ; ����һ������Σ�����д��LCD������
L?0042: ; ��ǩ
	USING	0 ; ʹ�üĴ�����0
	DEC  	A ; ���ۼ�����ֵ��1
	MOV  	R1,A ; ���ۼ�����ֵ�ƶ���R1��R1�洢��Ҫд������ݵĵ�ַ
	LCALL	?C?CLDPTR ; ����?C?CLDPTR��������R1��ֵת��Ϊָ�룬��ȡ���ݷ���A��
	MOV  	R7,A ; ���ۼ�����ֵ�ƶ���R7��R7�洢��Ҫд�������
_lcd_wdat: ; ����һ������������д��LCD������
	USING	0 ; ʹ�üĴ�����0
	LCALL	wait_lcd_not_busy ; ����wait_lcd_not_busy�������ȴ�LCD��æ
	SETB 	LCD_RS ; ��λLCD_RSλ����ʾд������
	CLR  	LCD_RW ; ���LCD_RWλ����ʾд��ģʽ
	LCALL	set_LCD_read_write ; ����set_LCD_read_write����������LCD�Ķ�дģʽ
	MOV  	P0,R7 ; ��R7��ֵ�ƶ���P0�˿ڣ�R7�洢��Ҫд�������
	MOV  	R7,#01H ; ��01H��ֵ�ƶ���R7��������ʱ
	MOV  	R6,#00H ; ��00H��ֵ�ƶ���R6��������ʱ
	MOV  	R5,#00H ; ��00H��ֵ�ƶ���R5��������ʱ
	MOV  	R4,#00H ; ��00H��ֵ�ƶ���R4��������ʱ
	LCALL	_delay_ms ; ����_delay_ms��������ʱ1����
	SETB 	LCD_EN ; ��λLCD_ENλ��ʹ��LCD
	MOV  	R7,#01H ; ��01H��ֵ�ƶ���R7��������ʱ
	MOV  	R6,#00H ; ��00H��ֵ�ƶ���R6��������ʱ
	MOV  	R5,#00H ; ��00H��ֵ�ƶ���R5��������ʱ
	MOV  	R4,#00H ; ��00H��ֵ�ƶ���R4��������ʱ
	LCALL	_delay_ms ; ����_delay_ms��������ʱ1����
	CLR  	LCD_EN ; ���LCD_ENλ������LCD
	RET  	; ����
	RSEG  clear_LCD12864 ; ����һ������Σ��������LCD����ʾ
clear: ; ����һ���������������LCD����ʾ
	USING	0 ; ʹ�üĴ�����0
	MOV  	R7,#01H ; ��01H��ֵ�ƶ���R7��R7�洢�����LCD������
	LJMP 	_lcd_wcmd ; ����ת��_lcd_wcmd������д��LCD������
	RSEG  lcd_init_LCD12864 ; ����һ������Σ����ڳ�ʼ��LCD
lcd_init: ; ��ʼ��LCD��ʾ��
	USING	0 ; ʹ�üĴ�����0
	MOV  	R7,#034H ; ��034H��ֵ��R7����ʾ������ָ�����
	LCALL	_lcd_wcmd ; ����_lcd_wcmd�ӳ�����LCD��������
	MOV  	R7,#05H ; ��05H��ֵ��R7
	MOV  	R6,#00H ; ��00H��ֵ��R6
	MOV  	R5,#00H ; ��00H��ֵ��R5
	MOV  	R4,#00H ; ��00H��ֵ��R4
	LCALL	_delay_ms ; ����_delay_ms�ӳ�����ʱ5����
	MOV  	R7,#030H ; ��030H��ֵ��R7����ʾ�򿪻���ָ�����
	LCALL	_lcd_wcmd ; ����_lcd_wcmd�ӳ�����LCD��������
	MOV  	R7,#05H ; ��05H��ֵ��R7
	MOV  	R6,#00H ; ��00H��ֵ��R6
	MOV  	R5,#00H ; ��00H��ֵ��R5
	MOV  	R4,#00H ; ��00H��ֵ��R4
	LCALL	_delay_ms ; ����_delay_ms�ӳ�����ʱ5����
	MOV  	R7,#0CH ; ��0CH��ֵ��R7����ʾ��ʾ�����ع��
	LCALL	_lcd_wcmd ; ����_lcd_wcmd�ӳ�����LCD��������
	MOV  	R7,#05H ; ��05H��ֵ��R7
	MOV  	R6,#00H ; ��00H��ֵ��R6
	MOV  	R5,#00H ; ��00H��ֵ��R5
	MOV  	R4,#00H ; ��00H��ֵ��R4
	LCALL	_delay_ms ; ����_delay_ms�ӳ�����ʱ5����
	MOV  	R7,#01H ; ��01H��ֵ��R7����ʾ���LCD����ʾ����
	LCALL	_lcd_wcmd ; ����_lcd_wcmd�ӳ�����LCD��������
	MOV  	R7,#05H ; ��05H��ֵ��R7
	MOV  	R6,#00H ; ��00H��ֵ��R6
	MOV  	R5,#00H ; ��00H��ֵ��R5
	MOV  	R4,#00H ; ��00H��ֵ��R4
	LJMP 	_delay_ms ; ��������ת��_delay_ms�ӳ�����ʱ5����
	RSEG  _set_xy_LCD12864 ; ���ö���Ϊ_set_xy_LCD12864
_set_xy: ; ����LCD����ʾλ��
	USING	0 ; ʹ�üĴ�����0
	MOV  	xpos,R7 ; ��R7��ֵ����xpos
	MOV  	A,R5 ; ��R5��ֵ�����ۼ���A
	ADD  	A,#0FEH ; ��A��0FEH���
	JZ   	LCD128640013 ; ������Ϊ0����ת��LCD128640013
	DEC  	A ; ��A��1
	JZ   	LCD128640014 ; ������Ϊ0����ת��LCD128640014
	DEC  	A ; ��A��1
	JZ   	LCD128640015 ; ������Ϊ0����ת��LCD128640015
	ADD  	A,#03H ; ��A��03H���
	JNZ  	LCD128640017 ; ��������Ϊ0����ת��LCD128640017
LCD128640012: ; ��ǩLCD128640012
	MOV  	A,xpos ; ��xpos��ֵ����A
	ORL  	A,#080H ; ��A��080H���л�����
	SJMP 	LCD128640040 ; ����ת��LCD128640040
LCD128640013: ; ��ǩLCD128640013
	MOV  	A,xpos ; ��xpos��ֵ����A
	ORL  	A,#090H ; ��A��090H���л�����
LCD128640038: ; ��ǩLCD128640038
	SJMP 	LCD128640040 ; ����ת��LCD128640040
LCD128640014: ; ��ǩLCD128640014
	MOV  	A,xpos ; ��xpos��ֵ����A
	ORL  	A,#088H ; ��A��088H���л�����
LCD128640039: ; ��ǩLCD128640039
	SJMP 	LCD128640040 ; ����ת��LCD128640040
LCD128640015: ; ��ǩLCD128640015
	MOV  	A,xpos ; ��xpos��ֵ����A
	ORL  	A,#098H ; ��A��098H���л�����
LCD128640040: ; ��ǩLCD128640040
	MOV  	R7,A ; ��A��ֵ����R7
	LCALL	_lcd_wcmd ; ����_lcd_wcmd�ӳ�����LCD��������
LCD128640017: ; ��ǩLCD128640017
	RET  	; ����
	RSEG  _print_LCD12864 ; ���ö���Ϊ_print_LCD12864
_print: ; ��ӡ�ַ�����LCD
	USING	0 ; ʹ�üĴ�����0
	MOV  	str,R3 ; ��R3��ֵ����str
	MOV  	str+01H,R2 ; ��R2��ֵ����str+01H
	MOV  	str+02H,R1 ; ��R1��ֵ����str+02H
	LCALL	_set_xy ; ����_set_xy�ӳ�������LCD����ʾλ��
	MOV  	R3,str ; ��str��ֵ����R3
	MOV  	R2,str+01H ; ��str+01H��ֵ����R2
	MOV  	R1,str+02H ; ��str+02H��ֵ����R1
	SJMP 	LCD128640041 ; ����ת��LCD128640041
LCD128640018: ; ��ǩLCD128640018
	MOV  	A,R7 ; ��R7��ֵ����A
	JZ   	LCD128640020 ; ������Ϊ0����ת��LCD128640020
	LCALL	_lcd_wdat ; ����_lcd_wdat�ӳ�����LCD��������
	MOV  	R3,str ; ��str��ֵ����R3
	INC  	str+02H ; ��str+02H��1
	MOV  	A,str+02H ; ��str+02H��ֵ����A
	JNZ  	LCD128640035 ; ��������Ϊ0����ת��LCD128640035
	INC  	str+01H ; ��str+01H��1
LCD128640035: ; ��ǩLCD128640035
	MOV  	R1,A ; ��A��ֵ����R1
	MOV  	R2,str+01H ; ��str+01H��ֵ����R2
LCD128640041: ; ��ǩLCD128640041
	LCALL	?C?CLDPTR ; ����?C?CLDPTR�ӳ��򣬼���ָ������
	MOV  	R7,A ; ��A��ֵ����R7
	SJMP 	LCD128640018 ; ����ת��LCD128640018
LCD128640020: ; ��ǩLCD128640020
	RET  	; ����
	RSEG  _print_char_LCD12864 ; ���ö���Ϊ_print_char_LCD12864
_print_char: ;����һ���ӳ���������LCD�ϴ�ӡһ���ַ�
	USING	0 ;ʹ�üĴ�����0
	MOV  	a1,R3 ;��R3��ֵ����a1��a1��һ���ڴ浥Ԫ�����ڴ洢�ַ���ASCII��
	LCALL	_set_xy ;����_set_xy�ӳ�����������LCD�Ĺ��λ��
	MOV  	R7,a1 ;��a1��ֵ����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD������
	LJMP 	_lcd_wdat ;��������ת��_lcd_wdat�ӳ���������LCDд������
	RSEG  _Draw_PM_LCD12864 ;����һ�����������ڻ���LCD12864��ͼ��
_Draw_PM: ;����һ���ӳ������ڻ���LCD12864��ͼ��
	USING	0 ;ʹ�üĴ�����0
	MOV  	ptr,R3 ;��R3��ֵ����ptr��ptr��һ���ڴ浥Ԫ�����ڴ洢ͼ�����ݵĵ�ַ
	MOV  	ptr+01H,R2 ;��R2��ֵ����ptr+01H��ptr+01H��ptr�ĸ�8λ
	MOV  	ptr+02H,R1 ;��R1��ֵ����ptr+02H��ptr+02H��ptr�ĵ�8λ
	MOV  	R7,#034H ;��16������34����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	LCALL	_lcd_wcmd ;����_lcd_wcmd�ӳ���������LCDд������
	MOV  	i,#080H ;��16������80����i��i��һ���ڴ浥Ԫ�����ڴ洢LCD���е�ַ
	CLR  	A ;�����ۼ���A
	MOV  	j,A ;��A��ֵ����j��j��һ���ڴ浥Ԫ�����ڴ洢�к�
LCD128640022: ;����һ����ţ�����ѭ������LCD���ϰ벿��
	MOV  	R7,i ;��i��ֵ����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	INC  	i ;��i��ֵ��1
	LCALL	_lcd_wcmd ;����_lcd_wcmd�ӳ���������LCDд������
	MOV  	R7,#080H ;��16������80����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	LCALL	_lcd_wcmd ;����_lcd_wcmd�ӳ���������LCDд������
	CLR  	A ;�����ۼ���A
	MOV  	k,A ;��A��ֵ����k��k��һ���ڴ浥Ԫ�����ڴ洢LCD���е�ַ
LCD128640025: ;����һ����ţ�����ѭ������LCD��ÿһ��
	MOV  	R3,ptr ;��ptr��ֵ����R3��R3��һ���Ĵ��������ڴ洢ͼ�����ݵĵ�ַ
	INC  	ptr+02H ;��ptr+02H��ֵ��1��ptr+02H��ptr�ĵ�8λ
	MOV  	A,ptr+02H ;��ptr+02H��ֵ����A��A��һ���ۼ��������ڴ洢ͼ�����ݵĵ�ַ
	MOV  	R2,ptr+01H ;��ptr+01H��ֵ����R2��R2��һ���Ĵ��������ڴ洢ͼ�����ݵĵ�ַ
	JNZ  	LCD128640036 ;���A��Ϊ�㣬��ת��LCD128640036
	INC  	ptr+01H ;��ptr+01H��ֵ��1��ptr+01H��ptr�ĸ�8λ
LCD128640036: ;����һ����ţ����ڶ�ȡͼ������
	LCALL	L?0042 ;����L?0042�ӳ������ڴ�ptrָ��ĵ�ַ��ȡһ���ֽڵ�ͼ�����ݣ������丳��R7
	INC  	k ;��k��ֵ��1
	MOV  	A,k ;��k��ֵ����A��A��һ���ۼ��������ڴ洢LCD���е�ַ
	CLR  	C ;�����λ��־C
	SUBB 	A,#010H ;��A��ֵ��ȥ16������10���������A��ͬʱ����C
	JC   	LCD128640025 ;���CΪ1����ת��LCD128640025
LCD128640024: ;����һ����ţ����ڻ���LCD����һ��
	INC  	j ;��j��ֵ��1
	MOV  	A,j ;��j��ֵ����A��A��һ���ۼ��������ڴ洢LCD��ҳ��ַ
	CLR  	C ;�����λ��־C
	SUBB 	A,#020H ;��A��ֵ��ȥ16������20���������A��ͬʱ����C
	JC   	LCD128640022 ;���CΪ1����ת��LCD128640022
LCD128640023: ;����һ����ţ����ڻ���LCD���°벿��
	MOV  	i,#080H ;��16������80����i��i��һ���ڴ浥Ԫ�����ڴ洢LCD���е�ַ
	CLR  	A ;�����ۼ���A
	MOV  	j,A ;��A��ֵ����j��j��һ���ڴ浥Ԫ�����ڴ洢LCD��ҳ��ַ
LCD128640028: ;����һ����ţ�����ѭ������LCD���°벿��
	MOV  	R7,i ;��i��ֵ����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	INC  	i ;��i��ֵ��1
	LCALL	_lcd_wcmd ;����_lcd_wcmd�ӳ���������LCDд������
	MOV  	R7,#088H ;��16������88����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	LCALL	_lcd_wcmd ;����_lcd_wcmd�ӳ���������LCDд������
	CLR  	A ;�����ۼ���A
	MOV  	k,A ;��A��ֵ����k��k��һ���ڴ浥Ԫ�����ڴ洢LCD���е�ַ
LCD128640031: ;����һ����ţ�����ѭ������LCD��ÿһ��
	MOV  	R3,ptr ;��ptr��ֵ����R3��R3��һ���Ĵ��������ڴ洢ͼ�����ݵĵ�ַ
	INC  	ptr+02H ;��ptr+02H��ֵ��1��ptr+02H��ptr�ĵ�8λ
	MOV  	A,ptr+02H ;��ptr+02H��ֵ����A��A��һ���ۼ��������ڴ洢ͼ�����ݵĵ�ַ
	MOV  	R2,ptr+01H ;��ptr+01H��ֵ����R2��R2��һ���Ĵ��������ڴ洢ͼ�����ݵĵ�ַ
	JNZ  	LCD128640037 ;���A��Ϊ�㣬��ת��LCD128640037
	INC  	ptr+01H ;��ptr+01H��ֵ��1��ptr+01H��ptr�ĸ�8λ
LCD128640037: ;����һ�����
	LCALL	L?0042 ;����L?0042�ӳ������ڴ�ptrָ��ĵ�ַ��ȡһ���ֽڵ�ͼ�����ݣ������丳��R7
	INC  	k ;��k��ֵ��1
	MOV  	A,k ;��k��ֵ����A
	CLR  	C ;�����λ��־C
	SUBB 	A,#010H ;��A��ֵ��ȥ16������10���������A
	JC   	LCD128640031 ;���CΪ1����ת��LCD128640031
LCD128640030: ;����һ�����
	INC  	j ;��j��ֵ��1
	MOV  	A,j ;��j��ֵ����A
	CLR  	C ;�����λ��־C
	SUBB 	A,#020H ;��A��ֵ��ȥ16������20���������A��ͬʱ����C
	JC   	LCD128640028 ;���CΪ1����ת��LCD128640028
LCD128640029: ;����һ����ţ����ڽ�������
	MOV  	R7,#036H ;��16������36����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	LCALL	_lcd_wcmd ;����_lcd_wcmd�ӳ���������LCDд�������ʾ�򿪻�ͼ��ʾ
	MOV  	R7,#030H ;��16������30����R7��R7��һ�����⹦�ܼĴ��������ڴ洢LCD�����ݻ�����
	LJMP 	_lcd_wcmd ;��������ת��_lcd_wcmd�ӳ���������LCDд�������ʾ�ص�����ָ�
	END ;��������

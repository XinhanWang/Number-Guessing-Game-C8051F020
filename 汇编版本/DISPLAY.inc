/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:38:40
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:05:37
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\DISPLAY.inc
 * @Description: 显示头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ;
display_startup_logo_DISPLAY         SEGMENT CODE 
display_gussing_game_DISPLAY         SEGMENT CODE 
print_acknowledgement_DISPLAY        SEGMENT CODE 
DT_print_acknowledgement_DISPLAY        SEGMENT DATA OVERLAYABLE 
display_acknowledgement_DISPLAY      SEGMENT CODE 
_display_picture_DISPLAY             SEGMENT CODE 
DT_display_picture_DISPLAY             SEGMENT DATA OVERLAYABLE 
display_main_menu_DISPLAY            SEGMENT CODE 
display_mode_select_DISPLAY          SEGMENT CODE 
display_bits_select_DISPLAY          SEGMENT CODE 
display_time_select_DISPLAY          SEGMENT CODE 
display_begin_select_DISPLAY         SEGMENT CODE 
display_input_DISPLAY                SEGMENT CODE 
display_correct_DISPLAY              SEGMENT CODE 
display_error_DISPLAY                SEGMENT CODE 
display_win_DISPLAY                  SEGMENT CODE 
display_lose_DISPLAY                 SEGMENT CODE 
display_random_digits_DISPLAY        SEGMENT CODE 
DT_display_random_digits_DISPLAY        SEGMENT DATA OVERLAYABLE 
display_wrong_input_bits_DISPLAY     SEGMENT CODE 
display_wrong_input_display_time_DISPLAY SEGMENT CODE 
CO_DISPLAY          SEGMENT CODE 
	EXTRN	CODE (digits)
	EXTRN	CODE (clear)
	EXTRN	DATA (display_time)
	EXTRN	CODE (_Draw_PM)
	EXTRN	CODE (rand)
	EXTRN	CODE (_print)
	EXTRN	CODE (_print_char)
	EXTRN	DATA (bits)
	EXTRN	CODE (xxdj)
	EXTRN	CODE (hust)
	EXTRN	CODE (csyx)
	EXTRN	CODE (sft)
	EXTRN	CODE (_delay_ms)
	EXTRN	CODE (zhu)
	EXTRN	XDATA (random_digits)
	EXTRN	CODE (?C?SIDIV)
	PUBLIC	acknowledgements
	PUBLIC	display_wrong_input_display_time
	PUBLIC	display_wrong_input_bits
	PUBLIC	display_random_digits
	PUBLIC	display_lose
	PUBLIC	display_win
	PUBLIC	display_error
	PUBLIC	display_correct
	PUBLIC	display_input
	PUBLIC	display_begin_select
	PUBLIC	display_time_select
	PUBLIC	display_bits_select
	PUBLIC	display_mode_select
	PUBLIC	display_main_menu
	PUBLIC	_display_picture
	PUBLIC	display_acknowledgement
	PUBLIC	print_acknowledgement
	PUBLIC	display_gussing_game
	PUBLIC	display_startup_logo
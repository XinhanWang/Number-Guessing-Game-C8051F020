/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:43:23
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-25 11:41:58
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\GUESSING_GAME.inc
 * @Description:  猜数游戏头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ; 包含头文件C8051F020.inc
check_digits_GUESSING_GAME           SEGMENT CODE   ; 定义check_digits_GUESSING_GAME段为代码段
correct_GAME                SEGMENT CODE   ; 定义correct_GAME段为代码段
error_GAME                  SEGMENT CODE   ; 定义error_GAME段为代码段
win_GAME                    SEGMENT CODE   ; 定义win_GAME段为代码段
lose_GAME                   SEGMENT CODE   ; 定义lose_GAME段为代码段
guess_once_GAME             SEGMENT CODE   ; 定义guess_once_GAME段为代码段
DT_guess_once_GUESSING_GAME             SEGMENT DATA OVERLAYABLE ; 定义DT_guess_once_GUESSING_GAME段为数据段，且是堆栈段
BI_guess_once_GUESSING_GAME             SEGMENT BIT OVERLAYABLE ; 定义BI_guess_once_GUESSING_GAME段为位域段
guess_one_level_GAME        SEGMENT CODE   ; 定义guess_one_level_GUESSING_GAME段为代码段
BI_guess_one_level_GUESSING_GAME        SEGMENT BIT OVERLAYABLE ; 定义BI_guess_one_level_GUESSING_GAME段为位域段
main_menu_GAME              SEGMENT CODE   ; 定义main_menu_GAME段为代码段
mode_select_GAME            SEGMENT CODE   ; 定义mode_select_GAME段为代码段
begin_select_GAME           SEGMENT CODE   ; 定义begin_select_GAME段为代码段
mode1_GAME                  SEGMENT CODE   ; 定义mode1_GAME段为代码段
DT_mode1_GAME                  SEGMENT DATA OVERLAYABLE ; 定义DT_mode1_GUESSING_GAME段为数据段，且是堆栈段
mode2_GAME                  SEGMENT CODE   ; 定义mode2_GAME段为代码段
mode3_GAME                  SEGMENT CODE   ; 定义mode3_GAME段为代码段
acknowledgement_GAME        SEGMENT CODE   ; 定义acknowledgement_GAME段为代码段
gussing_game_GAME           SEGMENT CODE   ; 定义gussing_game_GAME段为代码段
games_GUESSING_GAME                  SEGMENT CODE   ; 定义games_GUESSING_GAME段为代码段
?C_INITSEG           SEGMENT CODE   ; 定义?C_INITSEG段为代码段
CO_GUESSING_GAME    SEGMENT CODE   ; 定义CO_GUESSING_GAME段为代码段
XD_GUESSING_GAME    SEGMENT XDATA   ; 定义XD_GUESSING_GAME段为扩展数据段
DT_GUESSING_GAME    SEGMENT DATA   ; 定义DT_GUESSING_GAME段为数据段
; 定义外部函数
EXTRN	CODE (display_error)		; 定义display_error函数
EXTRN	CODE (display_input)		; 定义display_input函数
EXTRN	CODE (display_lose)		; 定义display_lose函数
EXTRN	CODE (kscan)			; 定义kscan函数
EXTRN	CODE (display_main_menu)	; 定义display_main_menu函数
EXTRN	CODE (input_digits)		; 定义input_digits函数
EXTRN	CODE (display_acknowledgement)	; 定义display_acknowledgement函数
EXTRN	CODE (input_display_time)	; 定义input_display_time函数
EXTRN	XDATA (inputs)		; 定义inputs扩展数据段
EXTRN	CODE (rand)			; 定义rand函数
EXTRN	CODE (display_win)		; 定义display_win函数
EXTRN	CODE (input_bits)		; 定义input_bits函数
EXTRN	CODE (display_begin_select)	; 定义display_begin_select函数
EXTRN	CODE (display_random_digits)	; 定义display_random_digits函数
EXTRN	CODE (display_correct)	; 定义display_correct函数
EXTRN	CODE (display_gussing_game)	; 定义display_gussing_game函数
EXTRN	CODE (display_mode_select)	; 定义display_mode_select函数
EXTRN	CODE (f_or_e)			; 定义f_or_e函数
EXTRN	CODE (display_time_select)	; 定义display_time_select函数
EXTRN	CODE (display_bits_select)	; 定义display_bits_select函数
EXTRN	CODE (?C?SIDIV)		; 定义?C?SIDIV函数

; 定义公共变量
PUBLIC random_digits		; 定义random_digits公共变量
PUBLIC bits			; 定义bits公共变量
PUBLIC level_bits		; 定义level_bits公共变量
PUBLIC display_time		; 定义display_time公共变量
PUBLIC level_display_time	; 定义level_display_time公共变量
PUBLIC digits			; 定义digits公共变量
PUBLIC games			; 定义games公共变量
PUBLIC gussing_game		; 定义gussing_game公共变量
PUBLIC acknowledgement		; 定义acknowledgement公共变量
PUBLIC mode3			; 定义mode3公共变量
PUBLIC mode2			; 定义mode2公共变量
PUBLIC mode1			; 定义mode1公共变量
PUBLIC begin_select		; 定义begin_select公共变量
PUBLIC mode_select		; 定义mode_select公共变量
PUBLIC main_menu		; 定义main_menu公共变量
PUBLIC guess_one_level_BIT	; 定义guess_one_level_BIT公共变量
PUBLIC guess_one_level		; 定义guess_one_level公共变量
PUBLIC guess_once		; 定义guess_once公共变量
PUBLIC lose			; 定义lose公共变量
PUBLIC win			; 定义win公共变量
PUBLIC error			; 定义error公共变量
PUBLIC correct			; 定义correct公共变量
PUBLIC check_digits     ; 定义check_digits公共变量

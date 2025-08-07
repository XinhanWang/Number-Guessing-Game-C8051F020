/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 12:31:26
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:17:19
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\TIME.inc
 * @Description:  时间头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ;
_delay_ms_TIME   SEGMENT CODE 
DT_delay_ms_TIME   SEGMENT DATA OVERLAYABLE 
	EXTRN	DATA (time_ms)
	EXTRN	CODE (?C?ULCMP)
	PUBLIC	_delay_ms
/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 11:16:21
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:14:12
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\LCD12864.inc
 * @Description: LCD12864头文件
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$include(C8051F020.inc) ; 包含C8051F020单片机的头文件，定义了一些寄存器和位变量
LCD_EN	BIT	0A0H.7 ; 定义LCD_EN为P2端口的第7位，用于使能LCD
LCD_RW	BIT	0A0H.6 ; 定义LCD_RW为P2端口的第6位，用于选择读或写
LCD_RS	BIT	0A0H.5 ; 定义LCD_RS为P2端口的第5位，用于选择指令或数据
D7	BIT	080H.7 ; 定义D7为LCD_data的第7位，用于传输第7位数据
set_LCD_read_write_LCD12864          SEGMENT CODE ; 定义一个代码段，用于设置LCD的读写模式
wait_lcd_not_busy_LCD12864           SEGMENT CODE ; 定义一个代码段，用于等待LCD不忙
_lcd_wcmd_LCD12864                   SEGMENT CODE ; 定义一个代码段，用于向LCD写入命令
_lcd_wdat_LCD12864                   SEGMENT CODE ; 定义一个代码段，用于向LCD写入数据
clear_LCD12864   SEGMENT CODE ; 定义一个代码段，用于清屏
lcd_init_LCD12864                    SEGMENT CODE ; 定义一个代码段，用于初始化LCD
_set_xy_LCD12864 SEGMENT CODE ; 定义一个代码段，用于设置LCD的光标位置
DT_set_xy_LCD12864 SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量
_print_LCD12864  SEGMENT CODE ; 定义一个代码段，用于打印字符串
DT_print_LCD12864  SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量
_print_char_LCD12864                 SEGMENT CODE ; 定义一个代码段，用于打印单个字符
DT_print_char_LCD12864                 SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量
_Draw_PM_LCD12864                    SEGMENT CODE ; 定义一个代码段，用于绘制点阵图
DT_Draw_PM_LCD12864                    SEGMENT DATA OVERLAYABLE ; 定义一个数据段，用于存储临时变量
	EXTRN	CODE (_delay_ms) ; 引用外部代码段，用于延时毫秒
	EXTRN	CODE (?C?CLDPTR) ; 引用外部代码段，用于加载数据指针
	PUBLIC	_Draw_PM ; 将_Draw_PM代码段声明为公共的，可以被其他模块调用
	PUBLIC	_print_char ; 将_print_char代码段声明为公共的，可以被其他模块调用
	PUBLIC	_print ; 将_print代码段声明为公共的，可以被其他模块调用
	PUBLIC	_set_xy ; 将_set_xy代码段声明为公共的，可以被其他模块调用
	PUBLIC	lcd_init ; 将lcd_init代码段声明为公共的，可以被其他模块调用
	PUBLIC	clear ; 将clear代码段声明为公共的，可以被其他模块调用
	PUBLIC	_lcd_wdat ; 将_lcd_wdat代码段声明为公共的，可以被其他模块调用
	PUBLIC	_lcd_wcmd ; 将_lcd_wcmd代码段声明为公共的，可以被其他模块调用
	PUBLIC	wait_lcd_not_busy ; 将wait_lcd_not_busy代码段声明为公共的，可以被其他模块调用
	PUBLIC	set_LCD_read_write ; 将set_LCD_read_write代码段声明为公共的，可以被其他模块调用

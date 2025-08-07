/*
 * @Author: 王心瀚
 * @Date: 2023-12-22 11:33:36
 * @LastEditors: 王心瀚
 * @LastEditTime: 2023-12-22 23:14:08
 * @FilePath: \undefinedc:\Users\u2021\Desktop\资料\大三\单片机\实验\提高实验\汇编版本\LCD12864.asm
 * @Description: LCD12864文件，包含LCD12864显示相关函数
 * 
 * Copyright (c) 2023 by ${王心瀚}, All Rights Reserved. 
 */
$NOMOD51 ; 禁用51的SFR
NAME	LCD12864 ; 指定模块的名称
$include(LCD12864.inc) ; 包含LCD12864的头文件
	RSEG  DT_Draw_PM_LCD12864 ; 定义一个代码段，用于绘制点阵图
Draw_PM_BYTE: ; 定义一个函数，用于绘制点阵图
        ptr:   DS   3 ; 定义一个3字节的数据段，用于存储点阵图的地址
          i:   DS   1 ; 定义一个1字节的数据段，用于存储循环变量i
          j:   DS   1 ; 定义一个1字节的数据段，用于存储循环变量j
          k:   DS   1 ; 定义一个1字节的数据段，用于存储循环变量k
	RSEG  DT_set_xy_LCD12864 ; 定义一个代码段，用于设置LCD的坐标
_set_xy_BYTE: ; 定义一个函数，用于设置LCD的坐标
       xpos:   DS   1 ; 定义一个1字节的数据段，用于存储x坐标
	RSEG  DT_print_LCD12864 ; 定义一个代码段，用于打印字符串
_print_BYTE: ; 定义一个函数，用于打印字符串
        str:   DS   3 ; 定义一个3字节的数据段，用于存储字符串的地址
	RSEG  DT_print_char_LCD12864 ; 定义一个代码段，用于打印字符
_print_char_BYTE: ; 定义一个函数，用于打印字符
          a1:   DS   1 ; 定义一个1字节的数据段，用于存储字符的ASCII码
	RSEG  set_LCD_read_write_LCD12864 ; 定义一个代码段，用于设置LCD的读写模式
set_LCD_read_write: ; 定义一个函数，用于设置LCD的读写模式
	JB   	LCD_RW,LCD128640001 ; 如果LCD_RW位为1，跳转到LCD128640001
	MOV  	P0MDOUT,#0FFH ; 将P0端口设置为推挽输出模式
	RET  	; 返回
LCD128640001: ; 标签
	CLR  	A ; 清除累加器
	MOV  	P0MDOUT,A ; 将P0端口设置为开漏输入模式
	MOV  	P0,#0FFH ; 将P0端口的值设置为0xFF
LCD128640003: ; 标签
	RET  	; 返回
	RSEG  wait_lcd_not_busy_LCD12864 ; 定义一个代码段，用于等待LCD不忙
wait_lcd_not_busy: ; 定义一个函数，用于等待LCD不忙
	CLR  	LCD_RS ; 清除LCD_RS位，表示读取状态
	SETB 	LCD_RW ; 置位LCD_RW位，表示读取模式
	LCALL	set_LCD_read_write ; 调用set_LCD_read_write函数，设置LCD的读写模式
	SETB 	LCD_EN ; 置位LCD_EN位，使能LCD
LCD128640004: ; 标签
	JB   	D7,LCD128640004 ; 如果D7位为1，表示LCD忙，跳转到LCD128640004
	CLR  	LCD_EN ; 清除LCD_EN位，禁能LCD
	RET  	; 返回
	RSEG  _lcd_wcmd_LCD12864 ; 定义一个代码段，用于写入LCD的命令
_lcd_wcmd: ; 定义一个函数，用于写入LCD的命令
	USING	0 ; 使用寄存器组0
	LCALL	wait_lcd_not_busy ; 调用wait_lcd_not_busy函数，等待LCD不忙
	CLR  	LCD_RS ; 清除LCD_RS位，表示写入命令
	CLR  	LCD_RW ; 清除LCD_RW位，表示写入模式
	LCALL	set_LCD_read_write ; 调用set_LCD_read_write函数，设置LCD的读写模式
	MOV  	P0,R7 ; 将R7的值移动到P0端口，R7存储了要写入的命令
	MOV  	R7,#01H ; 将01H的值移动到R7，用于延时
	MOV  	R6,#00H ; 将00H的值移动到R6，用于延时
	MOV  	R5,#00H ; 将00H的值移动到R5，用于延时
	MOV  	R4,#00H ; 将00H的值移动到R4，用于延时
	LCALL	_delay_ms ; 调用_delay_ms函数，延时1毫秒
	SETB 	LCD_EN ; 置位LCD_EN位，使能LCD
	MOV  	R7,#01H ; 将01H的值移动到R7，用于延时
	MOV  	R6,#00H ; 将00H的值移动到R6，用于延时
	MOV  	R5,#00H ; 将00H的值移动到R5，用于延时
	MOV  	R4,#00H ; 将00H的值移动到R4，用于延时
	LCALL	_delay_ms ; 调用_delay_ms函数，延时1毫秒
	CLR  	LCD_EN ; 清除LCD_EN位，禁能LCD
	RET  	; 返回
	RSEG  _lcd_wdat_LCD12864 ; 定义一个代码段，用于写入LCD的数据
L?0042: ; 标签
	USING	0 ; 使用寄存器组0
	DEC  	A ; 将累加器的值减1
	MOV  	R1,A ; 将累加器的值移动到R1，R1存储了要写入的数据的地址
	LCALL	?C?CLDPTR ; 调用?C?CLDPTR函数，将R1的值转换为指针，读取数据放入A中
	MOV  	R7,A ; 将累加器的值移动到R7，R7存储了要写入的数据
_lcd_wdat: ; 定义一个函数，用于写入LCD的数据
	USING	0 ; 使用寄存器组0
	LCALL	wait_lcd_not_busy ; 调用wait_lcd_not_busy函数，等待LCD不忙
	SETB 	LCD_RS ; 置位LCD_RS位，表示写入数据
	CLR  	LCD_RW ; 清除LCD_RW位，表示写入模式
	LCALL	set_LCD_read_write ; 调用set_LCD_read_write函数，设置LCD的读写模式
	MOV  	P0,R7 ; 将R7的值移动到P0端口，R7存储了要写入的数据
	MOV  	R7,#01H ; 将01H的值移动到R7，用于延时
	MOV  	R6,#00H ; 将00H的值移动到R6，用于延时
	MOV  	R5,#00H ; 将00H的值移动到R5，用于延时
	MOV  	R4,#00H ; 将00H的值移动到R4，用于延时
	LCALL	_delay_ms ; 调用_delay_ms函数，延时1毫秒
	SETB 	LCD_EN ; 置位LCD_EN位，使能LCD
	MOV  	R7,#01H ; 将01H的值移动到R7，用于延时
	MOV  	R6,#00H ; 将00H的值移动到R6，用于延时
	MOV  	R5,#00H ; 将00H的值移动到R5，用于延时
	MOV  	R4,#00H ; 将00H的值移动到R4，用于延时
	LCALL	_delay_ms ; 调用_delay_ms函数，延时1毫秒
	CLR  	LCD_EN ; 清除LCD_EN位，禁能LCD
	RET  	; 返回
	RSEG  clear_LCD12864 ; 定义一个代码段，用于清除LCD的显示
clear: ; 定义一个函数，用于清除LCD的显示
	USING	0 ; 使用寄存器组0
	MOV  	R7,#01H ; 将01H的值移动到R7，R7存储了清除LCD的命令
	LJMP 	_lcd_wcmd ; 长跳转到_lcd_wcmd函数，写入LCD的命令
	RSEG  lcd_init_LCD12864 ; 定义一个代码段，用于初始化LCD
lcd_init: ; 初始化LCD显示屏
	USING	0 ; 使用寄存器组0
	MOV  	R7,#034H ; 将034H赋值给R7，表示打开扩充指令操作
	LCALL	_lcd_wcmd ; 调用_lcd_wcmd子程序，向LCD发送命令
	MOV  	R7,#05H ; 将05H赋值给R7
	MOV  	R6,#00H ; 将00H赋值给R6
	MOV  	R5,#00H ; 将00H赋值给R5
	MOV  	R4,#00H ; 将00H赋值给R4
	LCALL	_delay_ms ; 调用_delay_ms子程序，延时5毫秒
	MOV  	R7,#030H ; 将030H赋值给R7，表示打开基本指令操作
	LCALL	_lcd_wcmd ; 调用_lcd_wcmd子程序，向LCD发送命令
	MOV  	R7,#05H ; 将05H赋值给R7
	MOV  	R6,#00H ; 将00H赋值给R6
	MOV  	R5,#00H ; 将00H赋值给R5
	MOV  	R4,#00H ; 将00H赋值给R4
	LCALL	_delay_ms ; 调用_delay_ms子程序，延时5毫秒
	MOV  	R7,#0CH ; 将0CH赋值给R7，表示显示开，关光标
	LCALL	_lcd_wcmd ; 调用_lcd_wcmd子程序，向LCD发送命令
	MOV  	R7,#05H ; 将05H赋值给R7
	MOV  	R6,#00H ; 将00H赋值给R6
	MOV  	R5,#00H ; 将00H赋值给R5
	MOV  	R4,#00H ; 将00H赋值给R4
	LCALL	_delay_ms ; 调用_delay_ms子程序，延时5毫秒
	MOV  	R7,#01H ; 将01H赋值给R7，表示清除LCD的显示内容
	LCALL	_lcd_wcmd ; 调用_lcd_wcmd子程序，向LCD发送命令
	MOV  	R7,#05H ; 将05H赋值给R7
	MOV  	R6,#00H ; 将00H赋值给R6
	MOV  	R5,#00H ; 将00H赋值给R5
	MOV  	R4,#00H ; 将00H赋值给R4
	LJMP 	_delay_ms ; 无条件跳转到_delay_ms子程序，延时5毫秒
	RSEG  _set_xy_LCD12864 ; 设置段名为_set_xy_LCD12864
_set_xy: ; 设置LCD的显示位置
	USING	0 ; 使用寄存器组0
	MOV  	xpos,R7 ; 将R7的值赋给xpos
	MOV  	A,R5 ; 将R5的值赋给累加器A
	ADD  	A,#0FEH ; 将A与0FEH相加
	JZ   	LCD128640013 ; 如果结果为0，跳转到LCD128640013
	DEC  	A ; 将A减1
	JZ   	LCD128640014 ; 如果结果为0，跳转到LCD128640014
	DEC  	A ; 将A减1
	JZ   	LCD128640015 ; 如果结果为0，跳转到LCD128640015
	ADD  	A,#03H ; 将A与03H相加
	JNZ  	LCD128640017 ; 如果结果不为0，跳转到LCD128640017
LCD128640012: ; 标签LCD128640012
	MOV  	A,xpos ; 将xpos的值赋给A
	ORL  	A,#080H ; 将A与080H进行或运算
	SJMP 	LCD128640040 ; 短跳转到LCD128640040
LCD128640013: ; 标签LCD128640013
	MOV  	A,xpos ; 将xpos的值赋给A
	ORL  	A,#090H ; 将A与090H进行或运算
LCD128640038: ; 标签LCD128640038
	SJMP 	LCD128640040 ; 短跳转到LCD128640040
LCD128640014: ; 标签LCD128640014
	MOV  	A,xpos ; 将xpos的值赋给A
	ORL  	A,#088H ; 将A与088H进行或运算
LCD128640039: ; 标签LCD128640039
	SJMP 	LCD128640040 ; 短跳转到LCD128640040
LCD128640015: ; 标签LCD128640015
	MOV  	A,xpos ; 将xpos的值赋给A
	ORL  	A,#098H ; 将A与098H进行或运算
LCD128640040: ; 标签LCD128640040
	MOV  	R7,A ; 将A的值赋给R7
	LCALL	_lcd_wcmd ; 调用_lcd_wcmd子程序，向LCD发送命令
LCD128640017: ; 标签LCD128640017
	RET  	; 返回
	RSEG  _print_LCD12864 ; 设置段名为_print_LCD12864
_print: ; 打印字符串到LCD
	USING	0 ; 使用寄存器组0
	MOV  	str,R3 ; 将R3的值赋给str
	MOV  	str+01H,R2 ; 将R2的值赋给str+01H
	MOV  	str+02H,R1 ; 将R1的值赋给str+02H
	LCALL	_set_xy ; 调用_set_xy子程序，设置LCD的显示位置
	MOV  	R3,str ; 将str的值赋给R3
	MOV  	R2,str+01H ; 将str+01H的值赋给R2
	MOV  	R1,str+02H ; 将str+02H的值赋给R1
	SJMP 	LCD128640041 ; 短跳转到LCD128640041
LCD128640018: ; 标签LCD128640018
	MOV  	A,R7 ; 将R7的值赋给A
	JZ   	LCD128640020 ; 如果结果为0，跳转到LCD128640020
	LCALL	_lcd_wdat ; 调用_lcd_wdat子程序，向LCD发送数据
	MOV  	R3,str ; 将str的值赋给R3
	INC  	str+02H ; 将str+02H加1
	MOV  	A,str+02H ; 将str+02H的值赋给A
	JNZ  	LCD128640035 ; 如果结果不为0，跳转到LCD128640035
	INC  	str+01H ; 将str+01H加1
LCD128640035: ; 标签LCD128640035
	MOV  	R1,A ; 将A的值赋给R1
	MOV  	R2,str+01H ; 将str+01H的值赋给R2
LCD128640041: ; 标签LCD128640041
	LCALL	?C?CLDPTR ; 调用?C?CLDPTR子程序，加载指针数据
	MOV  	R7,A ; 将A的值赋给R7
	SJMP 	LCD128640018 ; 短跳转到LCD128640018
LCD128640020: ; 标签LCD128640020
	RET  	; 返回
	RSEG  _print_char_LCD12864 ; 设置段名为_print_char_LCD12864
_print_char: ;定义一个子程序，用于在LCD上打印一个字符
	USING	0 ;使用寄存器组0
	MOV  	a1,R3 ;将R3的值赋给a1，a1是一个内存单元，用于存储字符的ASCII码
	LCALL	_set_xy ;调用_set_xy子程序，用于设置LCD的光标位置
	MOV  	R7,a1 ;将a1的值赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据
	LJMP 	_lcd_wdat ;无条件跳转到_lcd_wdat子程序，用于向LCD写入数据
	RSEG  _Draw_PM_LCD12864 ;定义一个段名，用于绘制LCD12864的图形
_Draw_PM: ;定义一个子程序，用于绘制LCD12864的图形
	USING	0 ;使用寄存器组0
	MOV  	ptr,R3 ;将R3的值赋给ptr，ptr是一个内存单元，用于存储图形数据的地址
	MOV  	ptr+01H,R2 ;将R2的值赋给ptr+01H，ptr+01H是ptr的高8位
	MOV  	ptr+02H,R1 ;将R1的值赋给ptr+02H，ptr+02H是ptr的低8位
	MOV  	R7,#034H ;将16进制数34赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	LCALL	_lcd_wcmd ;调用_lcd_wcmd子程序，用于向LCD写入命令
	MOV  	i,#080H ;将16进制数80赋给i，i是一个内存单元，用于存储LCD的行地址
	CLR  	A ;清零累加器A
	MOV  	j,A ;将A的值赋给j，j是一个内存单元，用于存储行号
LCD128640022: ;定义一个标号，用于循环绘制LCD的上半部分
	MOV  	R7,i ;将i的值赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	INC  	i ;将i的值加1
	LCALL	_lcd_wcmd ;调用_lcd_wcmd子程序，用于向LCD写入命令
	MOV  	R7,#080H ;将16进制数80赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	LCALL	_lcd_wcmd ;调用_lcd_wcmd子程序，用于向LCD写入命令
	CLR  	A ;清零累加器A
	MOV  	k,A ;将A的值赋给k，k是一个内存单元，用于存储LCD的列地址
LCD128640025: ;定义一个标号，用于循环绘制LCD的每一行
	MOV  	R3,ptr ;将ptr的值赋给R3，R3是一个寄存器，用于存储图形数据的地址
	INC  	ptr+02H ;将ptr+02H的值加1，ptr+02H是ptr的低8位
	MOV  	A,ptr+02H ;将ptr+02H的值赋给A，A是一个累加器，用于存储图形数据的地址
	MOV  	R2,ptr+01H ;将ptr+01H的值赋给R2，R2是一个寄存器，用于存储图形数据的地址
	JNZ  	LCD128640036 ;如果A不为零，跳转到LCD128640036
	INC  	ptr+01H ;将ptr+01H的值加1，ptr+01H是ptr的高8位
LCD128640036: ;定义一个标号，用于读取图形数据
	LCALL	L?0042 ;调用L?0042子程序，用于从ptr指向的地址读取一个字节的图形数据，并将其赋给R7
	INC  	k ;将k的值加1
	MOV  	A,k ;将k的值赋给A，A是一个累加器，用于存储LCD的列地址
	CLR  	C ;清零进位标志C
	SUBB 	A,#010H ;将A的值减去16进制数10，结果存入A，同时更新C
	JC   	LCD128640025 ;如果C为1，跳转到LCD128640025
LCD128640024: ;定义一个标号，用于绘制LCD的下一行
	INC  	j ;将j的值加1
	MOV  	A,j ;将j的值赋给A，A是一个累加器，用于存储LCD的页地址
	CLR  	C ;清零进位标志C
	SUBB 	A,#020H ;将A的值减去16进制数20，结果存入A，同时更新C
	JC   	LCD128640022 ;如果C为1，跳转到LCD128640022
LCD128640023: ;定义一个标号，用于绘制LCD的下半部分
	MOV  	i,#080H ;将16进制数80赋给i，i是一个内存单元，用于存储LCD的行地址
	CLR  	A ;清零累加器A
	MOV  	j,A ;将A的值赋给j，j是一个内存单元，用于存储LCD的页地址
LCD128640028: ;定义一个标号，用于循环绘制LCD的下半部分
	MOV  	R7,i ;将i的值赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	INC  	i ;将i的值加1
	LCALL	_lcd_wcmd ;调用_lcd_wcmd子程序，用于向LCD写入命令
	MOV  	R7,#088H ;将16进制数88赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	LCALL	_lcd_wcmd ;调用_lcd_wcmd子程序，用于向LCD写入命令
	CLR  	A ;清零累加器A
	MOV  	k,A ;将A的值赋给k，k是一个内存单元，用于存储LCD的列地址
LCD128640031: ;定义一个标号，用于循环绘制LCD的每一行
	MOV  	R3,ptr ;将ptr的值赋给R3，R3是一个寄存器，用于存储图形数据的地址
	INC  	ptr+02H ;将ptr+02H的值加1，ptr+02H是ptr的低8位
	MOV  	A,ptr+02H ;将ptr+02H的值赋给A，A是一个累加器，用于存储图形数据的地址
	MOV  	R2,ptr+01H ;将ptr+01H的值赋给R2，R2是一个寄存器，用于存储图形数据的地址
	JNZ  	LCD128640037 ;如果A不为零，跳转到LCD128640037
	INC  	ptr+01H ;将ptr+01H的值加1，ptr+01H是ptr的高8位
LCD128640037: ;定义一个标号
	LCALL	L?0042 ;调用L?0042子程序，用于从ptr指向的地址读取一个字节的图形数据，并将其赋给R7
	INC  	k ;将k的值加1
	MOV  	A,k ;将k的值赋给A
	CLR  	C ;清零进位标志C
	SUBB 	A,#010H ;将A的值减去16进制数10，结果存入A
	JC   	LCD128640031 ;如果C为1，跳转到LCD128640031
LCD128640030: ;定义一个标号
	INC  	j ;将j的值加1
	MOV  	A,j ;将j的值赋给A
	CLR  	C ;清零进位标志C
	SUBB 	A,#020H ;将A的值减去16进制数20，结果存入A，同时更新C
	JC   	LCD128640028 ;如果C为1，跳转到LCD128640028
LCD128640029: ;定义一个标号，用于结束绘制
	MOV  	R7,#036H ;将16进制数36赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	LCALL	_lcd_wcmd ;调用_lcd_wcmd子程序，用于向LCD写入命令，表示打开绘图显示
	MOV  	R7,#030H ;将16进制数30赋给R7，R7是一个特殊功能寄存器，用于存储LCD的数据或命令
	LJMP 	_lcd_wcmd ;无条件跳转到_lcd_wcmd子程序，用于向LCD写入命令，表示回到基本指令集
	END ;结束程序

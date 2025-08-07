#include "LCD12864RSPI.h"
#define AR_SIZE( a ) sizeof( a ) / sizeof( a[0] )
 
unsigned char show0[]= { 0xBC,0xC5,0xC4,0xAF,0xC4,0xD0,0xBA,0xA2,0xB5,0xC8, 0xC4, 0xE3,0xC0,0xB4, 0xA3, 0xA1};  //智位机器人
unsigned char show1[]="I LOVE YOU ! ^_^13_14_520 ♂♀ ";
unsigned char show2[]={ 0xB4, 0xA8,
  0xB8, 0xE7,
  0xD2, 0xBB,
  0xD6, 0xB1,
  0xD4, 0xDA,
  0xC9, 0xA7,
  0xB6, 0xAF,
  0xA3, 0xA1};
 
void setup()
{
LCDA.Initialise(); // 屏幕初始化
delay(100);
LCDA.CLEAR();//清屏
}
 
void loop()
{
LCDA.DisplayString(0,0,show0,AR_SIZE(show0));//第一行第三格开始，显示文智位机器人
delay(100);
LCDA.DisplayString(2,0,show1,AR_SIZE(show1));;//第三行第二格开始，显示网址dfrobot.com/
delay(500);
LCDA.DisplayString(3,0,show2,AR_SIZE(show2));
delay(100);
}

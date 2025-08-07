#include "LCD12864RSPI.h"
#define AR_SIZE( a ) sizeof( a ) / sizeof( a[0] )
 
unsigned char show0[]= {   0xD3, 0xC5,
  0xD0, 0xC5,
  0xB5, 0xE7,
  0xD7, 0xD3,
  0xBF, 0xC6,
  0xBC, 0xBC  };  //优信电子科技
unsigned char show1[]="Welcome!";

 
void setup()
{
LCDA.Initialise(); // 屏幕初始化
delay(100);
}
 
void loop()
{
LCDA.CLEAR();//清屏
delay(100);
LCDA.DisplayString(0,0,show0,AR_SIZE(show0));//第一行第三格开始，显示优信电子科技
delay(100);
LCDA.DisplayString(2,1,show1,AR_SIZE(show1));;//第三行第二格开始，显示Welcome!
delay(5000);
}

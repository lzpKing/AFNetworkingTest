//
//  INTERFACE.h
//  FirstDemo
//
//  Created by chenjiahe on 15/7/21.
//  Copyright (c) 2015年 🍉. All rights reserved.
//

#ifndef FirstDemo_INTERFACE_h
#define FirstDemo_INTERFACE_h


#pragma mark - 主屏幕宽高
#define kAl_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kAL_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - 故事板
#define StoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
 
//带有RGBA的颜色设置
#define mainColor [UIColor colorWithRed:0.99f green:0.47f blue:0.19f alpha:1.00f]//橙色
#define blueColor [UIColor colorWithRed:0.11f green:0.61f blue:0.84f alpha:1.00f]//蓝色
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define grayColor [UIColor colorWithRed:0.81f green:0.82f blue:0.82f alpha:1.00f]//button背景灰色
#define bgColor [UIColor colorWithRed:0.95f green:0.94f blue:0.95f alpha:1.00f]//背景色
#define ziColor [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f];//灰色字
//////////接口

//二期
#define kSERVER_URL @"https://www.quanziben.com/service/"


//新手体验标列表
#define newInvestUrl (kSERVER_URL@"appBulkLoan/ProductListByType")//更改

//投资列表
#define investUrl (kSERVER_URL@"appBulkLoan/ProductList")//更改

//json解析 null的数据处理
#define VerifyValue(value)({id tmp;if ([value isKindOfClass:[NSNull class]])tmp = nil;else tmp =value;tmp;})

#define VALUE(obj) [obj isKindOfClass:[NSNull class]]? @"":obj


//控制打印

#ifndef __OPTIMIZE__

#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<所在文件：%s : %d行> 方法：%s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "------------------------------- 我是华丽丽的分割线 --------------------------\n");                                               \
} while (0)

#else
#define NSLog(...){}
#endif

#endif

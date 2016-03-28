//
//  HttpRequestManager.m
//  CjhPengyeApp
//
//  Created by admin on 15/1/13.
//  Copyright (c) 2015年 chenjiahe. All rights reserved.
//

//单例模式：设计
//(1)永远只分配一块内存来创建对象 --> 重写 +(id)allocWithZone:(struct _NSZone *)zone
//(2)提供一个类方法，返回内部唯一的一个变量 --> 类方法 +(instancetype)shareManager
//(3)最好保证init方法也只初始化一次,保证所有的资源都只加载一次，可以不重写 --> 重写init方法
//(4) 重写+(id)copyWithZone:(struct _NSZone *)zone
//这样就保证了，无论是shareManager, init, copy, 实例化的对象都是同一个

#import "PMNetworkManager.h"
#import <sys/utsname.h>

@implementation PMNetworkManager
//全局唯一实例
static PMNetworkManager *_instance;

#pragma mark -
#pragma mark ==================== 标准单例的实现 ======================
//这里重写init方法的原因是：为了保证_manager只有一个实例存在


- (id)init
{
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [[AFHTTPSessionManager alloc] init];
            _manager.requestSerializer = [AFHTTPRequestSerializer serializer];

            _manager.responseSerializer = [AFJSONResponseSerializer serializer];
            _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

//            [self addHTTPHeader];
            
        });
    }
    return self;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+(id)copyWithZone:(struct _NSZone *)zone
{
    return _instance;
}

- (void)addHTTPHeader
{
    //手机型号
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //设备唯一标识
    NSString * strUUID =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //客户端版本号
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //UA
    //手机系统版本
    NSString* phoneVersion = [NSString stringWithFormat:@"%@;iOS %@",platform,[[UIDevice currentDevice] systemVersion]];
    
    //屏幕尺寸
    NSString * iphoneSize = [NSString stringWithFormat:@"%.f*%.f",[ UIScreen mainScreen ].bounds.size.width*[ UIScreen mainScreen ].scale,[ UIScreen mainScreen ].bounds.size.height*[ UIScreen mainScreen ].scale];
    
    [_manager.requestSerializer setValue:@"part210000" forHTTPHeaderField:@"c"];//渠道号
    [_manager.requestSerializer setValue:platform forHTTPHeaderField:@"n"];//手机型号
    [_manager.requestSerializer setValue:strUUID forHTTPHeaderField:@"i"];//设备唯一标识
    [_manager.requestSerializer setValue:version forHTTPHeaderField:@"v"];//客户端版本号
    [_manager.requestSerializer setValue:phoneVersion forHTTPHeaderField:@"s"];//UA
    [_manager.requestSerializer setValue:iphoneSize forHTTPHeaderField:@"p"];//屏幕尺寸
}





@end

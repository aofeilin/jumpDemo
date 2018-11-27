//
//  PayApi.m
//  PayApi
//
//  Created by aofeilin on 2018/11/26.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import "PayApi.h"
#import <UIKit/UIKit.h>

@implementation  BaseReq

@end

@implementation  BaseResp

@end

@interface PayApi()

@end
id<OlePayApiDelegate> payDelegate;
NSString *scheme;
@implementation PayApi


//回调方法。
+(BOOL) handleOpenURL:(NSURL *) url delegate:(id<OlePayApiDelegate>) delegate{
    payDelegate = delegate;
    BaseResp *resp = [PayApi getResp:url];
    [delegate onResp:resp];
    
    //1.------url data -》调用方法。delegate onResp:(BaseResp *)resp
    return  YES;
}
+ (NSDictionary *)getParamsWithURL:(NSURL *)url {
    
    //query是？后面的参数，在这个demo中，指的是title=hello&content=helloworld&urlschemes=shixueqian
    NSString *query = url.query;
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [query componentsSeparatedByString:@"&"];
    //把subArray转换为字典
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    for (int i = 0 ; i < subArray.count ; i++) {
        //通过“=”拆分键和值
        NSArray *dicArray = [subArray[i] componentsSeparatedByString:@"="]
        ;
        //给字典加入元素,=前面为key，后面为value
        [tempDic setObject:dicArray[1] forKey:dicArray[0]];
    }
    //返回转换后的字典
    return tempDic ;
}
+ (BaseResp *) getResp:(NSURL *)url {
     NSDictionary *dics =   [PayApi getParamsWithURL:url];
     BaseResp * baseResp = [[BaseResp alloc] init];
     NSString *strDics =  [dics objectForKey:@"code"];
     baseResp.errCode = strDics.integerValue;
     scheme = [dics objectForKey:@"scheme"];
     return  baseResp;
}

//判断是否安装。
+(BOOL) isOlePayAppInstalled{
    BOOL open = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twoApp://"]];
    if (open == YES){
        return YES;
    }
    return NO;
}

//请求
+(BOOL) sendReq:(BaseReq*)req{
    //1.网络请求
    //2.跳转app 3.*修改schemes
     NSURL *url = [NSURL URLWithString:@"twoApp://payContent?orderId=888888&scheme=oneApp"];
    //先判断是否能打开该url
    if ([PayApi isOlePayAppInstalled] == YES) {
        //打开url
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSLog(@"打不开应用");
    }
    return  YES;
}

@end

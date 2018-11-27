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
     baseResp.errCode = (NSString *)[dics objectForKey:@"code"];
     scheme = [dics objectForKey:@"scheme"];
     return  baseResp;
}

//订单请求---支付接口
+(BOOL)request{
    return YES;
}
+ (BOOL)successPay{
    NSLog(@"支付成功");
    [PayApi backPay:PaySuccess];
    return  YES;
}

+ (BOOL)cancelPay{
    NSLog(@"取消成功");
    [PayApi backPay:PayErrCodeUserCancel];
    return  YES;
}

//返回
+(BOOL)backPay:(NSInteger) code{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://payContent?code=%@",scheme,[NSString stringWithFormat:@"%ld",code]]];
    //先判断是否能打开该url
    [[UIApplication sharedApplication] openURL:url];
    return YES;
}

@end

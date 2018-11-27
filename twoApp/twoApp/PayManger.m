//
//  PayManger.m
//  oneApp
//
//  Created by aofeilin on 2018/11/27.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import "PayManger.h"
@implementation PayManger
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static PayManger *instance;
    dispatch_once(&onceToken, ^{
        instance = [[PayManger alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate

-(void) onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[BaseResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case PaySuccess:
                NSLog(@"支付成功");
                
                break;
            case PayErrCodeUserCancel:
                NSLog(@"取消");
                break;
            default:
                //PayErrCode
                NSLog(@"错误，retcode = %d", resp.errCode);
                break;
        }
    }
}

@end

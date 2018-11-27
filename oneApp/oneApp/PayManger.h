//
//  PayManger.h
//  oneApp
//
//  Created by aofeilin on 2018/11/27.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayApi.h"


@interface PayManger : NSObject<OlePayApiDelegate>
+ (instancetype)sharedManager;
@end


//
//  PayApi.h
//  PayApi
//
//  Created by aofeilin on 2018/11/26.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, PayCode) {
    PaySuccess = 0,
    PayErrCode           = -1,   /**< 普通错误类型    */
    PayErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
};


@interface BaseReq : NSObject
/** 请求参数 */
@property (nonatomic, assign) int type;
@end

@interface BaseResp : NSObject
/** 错误码 */
@property (nonatomic, assign) PayCode errCode;
@end

@protocol OlePayApiDelegate <NSObject>
@optional

/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req;



/*! @brief 发送一个sendReq后
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp;

@end

@interface PayApi : NSObject
//回调方法。
+(BOOL) handleOpenURL:(NSURL *) url delegate:(id<OlePayApiDelegate>) delegate;

//判断是否安装。
+(BOOL) isOlePayAppInstalled;
//请求
+(BOOL) sendReq:(BaseReq*)req;
@end

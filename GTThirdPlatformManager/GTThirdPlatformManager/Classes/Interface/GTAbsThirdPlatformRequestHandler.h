//
//  GTAbsThirdPlatformRequestHandler.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTThirdPlatformDefine.h"

@class OrderModel, ThirdPlatformShareModel;

@protocol GTAbsThirdPlatformRequestHandler <NSObject>

@optional

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController;

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order;

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel*)model;

@end

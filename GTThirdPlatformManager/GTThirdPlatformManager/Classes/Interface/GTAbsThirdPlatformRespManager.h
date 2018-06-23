//
//  GTAbsThirdPlatformRespManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTThirdPlatformDefine.h"

@class ThirdPlatformUserInfo;

// RespManagerDelegate
@protocol GTAbsThirdPlatformRespManagerDelegate <NSObject>

@optional

- (void)respManagerDidRecvPayResponse:(GTPayResult)result platform:(GTThirdPlatformType)platform;
- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(GTThirdPlatformType)platform;
- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(GTShareType)platform;

@end

@protocol GTAbsThirdPlatformRespManager <NSObject>

@optional

// 代理，子类需要设置getter/setter
@property (nonatomic, weak) id<GTAbsThirdPlatformRespManagerDelegate> delegate;

@end

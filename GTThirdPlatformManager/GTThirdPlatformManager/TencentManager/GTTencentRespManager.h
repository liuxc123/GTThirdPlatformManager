//
//  GTTencentRespManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "GTBaseThirdPlatformRespManager.h"

@interface GTTencentRespManager : GTBaseThirdPlatformRespManager<TencentSessionDelegate, QQApiInterfaceDelegate>

AS_SINGLETON

@property (nonatomic, strong) TencentOAuth* tencentOAuth;

- (void)setPayResult:(GTPayResult)payResult;

@end

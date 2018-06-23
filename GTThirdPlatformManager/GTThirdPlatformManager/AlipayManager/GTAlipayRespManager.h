//
//  GTAlipayRespManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTBaseThirdPlatformRespManager.h"

@interface GTAlipayRespManager : GTBaseThirdPlatformRespManager

AS_SINGLETON

// 设置响应结果
- (void)setResponse:(NSDictionary*)response;

@end

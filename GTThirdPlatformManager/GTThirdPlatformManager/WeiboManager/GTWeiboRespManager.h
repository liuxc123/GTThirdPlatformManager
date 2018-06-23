//
//  GTWeiboRespManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTBaseThirdPlatformRespManager.h"
#import <WeiboSDK/WeiboSDK.h>

@interface GTWeiboRespManager : GTBaseThirdPlatformRespManager<WeiboSDKDelegate>

AS_SINGLETON

@end

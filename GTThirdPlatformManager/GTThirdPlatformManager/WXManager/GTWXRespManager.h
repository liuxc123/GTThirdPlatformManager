//
//  GTWXRespManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTBaseThirdPlatformRespManager.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface GTWXRespManager : GTBaseThirdPlatformRespManager <WXApiDelegate>

AS_SINGLETON

@end

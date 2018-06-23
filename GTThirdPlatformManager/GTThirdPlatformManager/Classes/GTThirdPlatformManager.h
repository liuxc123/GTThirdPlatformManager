//
//  GTThirdPlatformManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTAbsThirdPlatformManager.h"
#import "GTThirdPlatformConfigurable.h"

@interface GTThirdPlatformManager : NSObject<GTThirdPlatformConfigurable, GTAbsThirdPlatformManager>

AS_SINGLETON

@end

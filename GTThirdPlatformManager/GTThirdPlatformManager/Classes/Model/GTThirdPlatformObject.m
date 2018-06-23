//
//  GTThirdPlatformObject.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTThirdPlatformObject.h"

@implementation ThirdPlatformUserInfo

@end


@implementation GTSharedObject

@end


@implementation GTSharedVideoObject

@end


@implementation GTSharedWebPageObject

@end


@implementation ThirdPlatformShareModel

@end


@implementation ThirdPlatformLoginModel

@end

@implementation OrderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderID" : @"oId",
             @"sign": @[@"sign", @"body"],
             };
}
@end

@implementation GTThirdPlatformConfig

@end


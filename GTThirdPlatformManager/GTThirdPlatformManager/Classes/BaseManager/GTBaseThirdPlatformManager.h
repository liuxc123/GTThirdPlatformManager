//
//  GTBaseThirdPlatformManager.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTAbsThirdPlatformManager.h"

@interface GTBaseThirdPlatformManager : NSObject<GTAbsThirdPlatformManager>

@property (nonatomic, copy) void (^paymentBlock)(GTPayResult result);
@property (nonatomic, copy) void (^callback)(ThirdPlatformUserInfo* userInfo, NSError* err);
@property (nonatomic, copy) void (^shareResultBlock)(GTShareType, GTShareResult, NSError *);


// 第三方分享，子类重写该方法
- (void)doShareWithModel:(ThirdPlatformShareModel*)model;

@end

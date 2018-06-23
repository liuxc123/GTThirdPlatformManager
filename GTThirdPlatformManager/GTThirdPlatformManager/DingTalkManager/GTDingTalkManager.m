//
//  GTDingTalkManager.m
//  GTThirdPlatformKit_Example
//
//  Created by liuxc on 2018/6/2.
//  Copyright © 2018年 liuxc123. All rights reserved.
//

#import "GTDingTalkManager.h"
#import <DTShareKit/DTOpenKit.h>
#import "GTDingTalkRespManager.h"
#import "GTDingTalkRequestHandler.h"
#import "GTThirdPlatformManager.h"
#import "GTThirdPlatformObject.h"

@interface GTDingTalkManager () <GTAbsThirdPlatformRespManagerDelegate>
@end

@implementation GTDingTalkManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化钉钉模块
    NSString* appID = [[GTThirdPlatformManager sharedInstance] appIDWithPlaform:GTThirdPlatformTypeDingTalk];
    [DTOpenAPI registerApp:appID];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 钉钉URL处理
    if ([DTOpenAPI handleOpenURL:url delegate:[GTDingTalkRespManager sharedInstance]]) {
        return YES;
    }

    return NO;
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [GTDingTalkRespManager sharedInstance].delegate = self;
    BOOL shareResult = [GTDingTalkRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(GTShareTypeDingTalk, GTShareResultFailed, nil);
    }
}

- (BOOL)isThirdPlatformInstalled:(GTShareType)thirdPlatform {
    return [DTOpenAPI isDingTalkInstalled];
}


@end

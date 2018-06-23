//
//  GTWeiboRespManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTWeiboRespManager.h"
#import "GTThirdPlatformObject.h"
#import <WeiboSDK/WeiboUser.h>

@implementation GTWeiboRespManager

DEF_SINGLETON

#pragma mark - ......::::::: WeiboSDKDelegate :::::::......

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    // Nothing TODO
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]) {
            [self.delegate respManagerDidRecvMessageResponse:(response.statusCode == WeiboSDKResponseStatusCodeSuccess) platform:GTShareTypeWeibo];
        }
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        // 获取用户信息
        [self userWithAccessToken:[(WBAuthorizeResponse *)response accessToken] userId:[(WBAuthorizeResponse *)response userID]];
    }
}

- (void)userWithAccessToken:(NSString *)accessToken userId:(NSString *)userId {
    [WBHttpRequest requestForUserProfile:userId withAccessToken:accessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        if (error) {
            if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
                [self.delegate respManagerDidRecvAuthResponse:nil platform:GTThirdPlatformTypeWeibo];
            }
        }else{
            ThirdPlatformUserInfo *user = [self.class userbyTranslateSinaResult:result];
            user.userId = userId;
            user.tokenString = accessToken;
            
            if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
                [self.delegate respManagerDidRecvAuthResponse:user platform:GTThirdPlatformTypeWeibo];
            }
        }
    }];
}

+ (ThirdPlatformUserInfo *)userbyTranslateSinaResult:(id)result {
    ThirdPlatformUserInfo *user = [[ThirdPlatformUserInfo alloc] init];
    user.thirdPlatformType = GTThirdPlatformTypeWeibo;
    
    if ([result isKindOfClass:[WeiboUser class]]) {
        WeiboUser *wbUser = (WeiboUser *)result;
        user.username = wbUser.screenName;
        user.gender = wbUser.gender;
        user.head = wbUser.avatarLargeUrl;
    }
    return user;
}

@end

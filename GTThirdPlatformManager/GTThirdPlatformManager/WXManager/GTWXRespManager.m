//
//  GTWXRespManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTWXRespManager.h"
#import <WXApi.h>
#import "NSData+GTJsonConvert.h"
#import "GTThirdPlatformManager.h"
#import "NetworkRequestUtil.h"
#import "GTThirdPlatformObject.h"

@implementation GTWXRespManager

DEF_SINGLETON

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]) {
            if (resp.errCode == WXSuccess) {
                [self.delegate respManagerDidRecvMessageResponse:YES platform:GTShareTypeWechat];
            } else {
                [self.delegate respManagerDidRecvMessageResponse:NO platform:GTShareTypeWechat];
            }
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == WXSuccess) {
            // wx请求accessToken & openId
            NSString* appID = [[GTThirdPlatformManager sharedInstance] appIDWithPlaform:GTThirdPlatformTypeWechat];
            NSString* appSecret = [[GTThirdPlatformManager sharedInstance] appSecretWithPlaform:GTThirdPlatformTypeWechat];
            NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", appID, appSecret, ((SendAuthResp*)resp).code];
            [NetworkRequestUtil requestWithURLString:urlString completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *resultDict = [data nsjsonObject];
                [self getUserInfoWithAccessToken:[resultDict objectForKey:@"access_token"] andOpenId:[resultDict objectForKey:@"openid"]];
            }];
        } else {
            if (self.delegate
                && [self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
                [self.delegate respManagerDidRecvAuthResponse:nil platform:GTThirdPlatformTypeWechat];
            }
        }
        
    } else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]) {
            GTPayResult payResult = resp.errCode == WXSuccess ? GTPayResultSuccess : resp.errCode == WXErrCodeUserCancel ? GTPayResultCancel : GTPayResultFailed ;
            [self.delegate respManagerDidRecvPayResponse:payResult platform:GTThirdPlatformTypeWechat];
        }
    }
}

//wx获取用户信息
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", accessToken, openId];
    [NetworkRequestUtil requestWithURLString:urlString completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *resultDict = [data nsjsonObject];
        ThirdPlatformUserInfo* userInfo = [ThirdPlatformUserInfo new];
        userInfo.userId = [resultDict objectForKey:@"unionid"];
        userInfo.openid = [resultDict objectForKey:@"openid"];
        userInfo.username = [resultDict objectForKey:@"nickname"];
        userInfo.head = [resultDict objectForKey:@"headimgurl"];
        userInfo.tokenString = accessToken;
        GTThirdPlatformOnMainThreadAsync(^{
            if (self.delegate
                && [self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
                [self.delegate respManagerDidRecvAuthResponse:userInfo platform:GTThirdPlatformTypeWechat];
            }
        });
    }];
}

@end

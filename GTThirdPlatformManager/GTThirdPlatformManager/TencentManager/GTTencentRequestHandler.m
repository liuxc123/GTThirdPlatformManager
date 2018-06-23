//
//  GTTencentRequestHandler.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTTencentRequestHandler.h"
#import "GTTencentRespManager.h"
#import "GTThirdPlatformObject.h"
#import "QQWalletSDK.h"
#import "GTThirdPlatformManager.h"

@implementation GTTencentRequestHandler

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {
    NSArray* permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    BOOL result = [[GTTencentRespManager sharedInstance].tencentOAuth authorize:permissions inSafari:NO];
    return result;
}

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel *)model {
    QQApiObject* obj;
    if (GTShareContentTypeVideo == model.mediaObject.contentType) {
        // PTSharedVideoObject* mediaObj = (PTSharedVideoObject*)model.mediaObject;
        obj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)] title:model.title description:model.text previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
    } else {
        obj = [QQApiNewsObject
               objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)]
               title:model.title
               description:model.text
               previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
    }
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    QQApiSendResultCode sent = 0;
    if (GTShareTypeQQ == model.platform) {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    } else {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    return EQQAPISENDSUCESS == sent;
}

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order {
    // 发起支付
    NSString* appID = [[GTThirdPlatformManager sharedInstance] appIDWithPlaform:GTThirdPlatformTypeTencentQQ subType:GTThirdPlatformSubTypePay];
    NSString* scheme = [[GTThirdPlatformManager sharedInstance] URLSchemesWithPlaform:GTThirdPlatformTypeTencentQQ subType:GTThirdPlatformSubTypePay];
    [[QQWalletSDK sharedInstance] startPayWithAppId:appID
                                        bargainorId:order.prepayid
                                            tokenId:order.package
                                          signature:order.sign
                                              nonce:order.noncestr
                                             scheme:scheme
                                         completion:^(QQWalletErrCode errCode, NSString *errStr){
                                             // 支付完成的回调处理
                                             if (errCode == QQWalletErrCodeSuccess) {
                                                 // 对支付成功的处理
                                                 [[GTTencentRespManager sharedInstance] setPayResult:GTPayResultSuccess];
                                             } else if (errCode == QQWalletErrCodeUserCancel) {
                                                 // 对支付取消的处理
                                                 [[GTTencentRespManager sharedInstance] setPayResult:GTPayResultCancel];
                                             } else {
                                                 // 对支付失败的处理
                                                 [[GTTencentRespManager sharedInstance] setPayResult:GTPayResultFailed];
                                             }
                                         }];
    return YES;
}


@end

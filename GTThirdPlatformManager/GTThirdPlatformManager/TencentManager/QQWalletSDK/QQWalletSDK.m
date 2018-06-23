//
//  QQWalletSDK.m
//  QQWalletSDK
//
//  Created by Eric on 17/9/1.
//  Copyright (c) 2017年 Teccent. All rights reserved.
//

#import "QQWalletSDK.h"

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface QQWalletSDK()<UIAlertViewDelegate>
@property(nonatomic, strong) NSString *urlScheme;
@end

void (^_completion)(QQWalletErrCode errCode, NSString *errStr);
static dispatch_once_t once;
static QQWalletSDK *defaultInstance;

@implementation QQWalletSDK

+ (instancetype)sharedInstance{
    dispatch_once(&once, ^{
        defaultInstance = [QQWalletSDK new];
    });
    return defaultInstance;
}

- (void)startPayWithAppId:(NSString *)appId
              bargainorId:(NSString *)bargainorId
                  tokenId:(NSString *)tokenId
                signature:(NSString *)sig
                    nonce:(NSString *)nonce
                   scheme:(NSString *)scheme
               completion:(void (^)(QQWalletErrCode errCode, NSString *errStr))completion{
    self.urlScheme = scheme;
    NSString *appVersion = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleVersion"];
    NSDictionary *params = @{QQWalletTokenId : tokenId?:@"",
                             QQWalletSignature : sig?:@"",
                             QQWalletBargainorId : bargainorId?:@"",
                             QQWalletNonce : nonce?:@"",
                             QQWalletAppVersion : appVersion?:@""};
    NSDictionary *application = @{QQWalletAppID : appId?:@"",
                                  QQWalletSchemeKey : self.urlScheme};
    NSDictionary *infos = @{QQWalletApplication : application?:@"",
                            QQWalletParams : params?:@""};
    
    NSMutableString* urlString = [NSMutableString stringWithFormat:@"%@://",QQWalletURLScheme];
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infos options:1 error:&jsonError];
#if DEBUG
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"QQWallet pay param: %@", jsonStr);
#endif
    if (!jsonError) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        [urlString appendString:[jsonData base64EncodedStringWithOptions:0]];
#else
        [urlString appendString:[jsonData base64Encoding]];
#endif
    }
    NSURL* url = [NSURL URLWithString:urlString];
    _completion = completion;
    [[UIApplication sharedApplication] openURL:url];
}

- (BOOL)hanldeOpenURL:(NSURL *)url{
    if (![url.scheme isEqualToString: self.urlScheme]) {
        return NO;
    }
    NSString *base64String = url.host;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    NSData *originData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
#else
    NSData *originData = [[NSData alloc] initWithBase64Encoding:base64String];
#endif
    NSError* parserError = nil;
    NSDictionary* infos = [NSJSONSerialization JSONObjectWithData:originData options:0 error:&parserError];
    if (parserError) {
        return NO;
    }
    NSDictionary* params =  infos[QQWalletParams];
    QQWalletErrCode code = (QQWalletErrCode)[params[@"code"] integerValue];
    if (code != QQWalletErrCodeUserCancel && code!= QQWalletErrCodeSuccess) {
        code = QQWalletErrCodeCommon;
    }
    _completion((QQWalletErrCode)code,params[@"message"]);
    _completion = nil;
    return YES;
}

+ (BOOL)isSupportQQWallet{
    NSURL* url = [NSURL URLWithString:[QQWalletURLScheme stringByAppendingString:@"://"]];
    return [[UIApplication sharedApplication] canOpenURL:url];
}

@end

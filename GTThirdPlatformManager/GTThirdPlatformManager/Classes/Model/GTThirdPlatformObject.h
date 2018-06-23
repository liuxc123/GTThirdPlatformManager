//
//  GTThirdPlatformObject.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTThirdPlatformDefine.h"


#pragma mark - ......::::::: ThirdPlatformUserInfo :::::::......

@interface ThirdPlatformUserInfo : NSObject
@property (nonatomic, assign) GTThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* openid;///<微信openid
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* head;
@property (nonatomic, copy) NSString* age;
@property (nonatomic, copy) NSString* gender;
@property (nonatomic, strong) NSDate* expirationDate;
@property (nonatomic, strong) NSString* tokenString;

@end


@interface GTSharedObject : NSObject
@property (nonatomic, assign) GTShareContentType contentType;
@end


@interface GTSharedVideoObject : GTSharedObject
/**
 视频网页的url
 @warning 不能为空且长度不能超过255
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 视频lowband网页的url
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoLowBandUrl;
@end


@interface GTSharedWebPageObject : GTSharedObject
/**
 网页的url地址
 
 @warning 不能为空且长度不能超过255
 */
@property (nonatomic, strong) NSString *webpageUrl;
@end


@interface ThirdPlatformShareModel : NSObject
@property (nonatomic, assign) GTShareType platform;
@property (nonatomic, strong) GTSharedObject* mediaObject;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSString* imageUrlString;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* weiboText;
@property (nonatomic, strong) NSString* urlString;
@property (nonatomic, strong) UIViewController* fromViewController;
@property (nonatomic, copy) void (^shareResultBlock)(GTShareType pplatform, GTShareResult result, NSError *);
@end


@interface ThirdPlatformLoginModel : NSObject
@property (nonatomic, assign) GTThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* icon;
@property (nonatomic, copy) NSString* name;
@end


@interface OrderModel : NSObject
/** 商家向财付通申请的商家id */
@property (nonatomic, retain) NSString *partnerid;
/** 预支付订单 */
@property (nonatomic, retain) NSString *prepayid;
/** 随机串，防重发 */
@property (nonatomic, retain) NSString *noncestr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, retain) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, retain) NSString *sign;
/** 订单号 */
@property (nonatomic, strong) NSString* orderID;
@end

// 第三方平台的配置信息
@interface GTThirdPlatformConfig : NSObject
@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *redirectURL;
@property (nonatomic, copy) NSString *URLSchemes;
@end

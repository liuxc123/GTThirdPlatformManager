//
//  NetworkRequestUtil.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestUtil : NSObject

+ (void)requestWithURLString:(NSString*_Nullable)urlString  completionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end

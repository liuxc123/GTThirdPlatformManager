//
//  NetworkRequestUtil.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "NetworkRequestUtil.h"

@implementation NetworkRequestUtil

+ (void)requestWithURLString:(NSString*)urlString  completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    // 创建请求
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
}


@end

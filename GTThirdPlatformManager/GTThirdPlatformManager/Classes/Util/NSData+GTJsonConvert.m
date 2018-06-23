//
//  NSData+GTJsonConvert.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "NSData+GTJsonConvert.h"

@implementation NSData (GTJsonConvert)

- (id)nsjsonObject {
    NSError *JSONSerializationError;
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&JSONSerializationError];
    
    if (JSONSerializationError) {
        NSLog(@"-NSJSONObject JSON Serialization Error is: %@", JSONSerializationError);
    }
    return obj;
}

@end

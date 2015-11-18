//
//  XSOAuthResult.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSOAuthResult.h"

@implementation XSOAuthResult
MJCodingImplementation

-(void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    _overDate = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

+ (NSString *)getAccess_token
{
    return [[NSKeyedUnarchiver unarchiveObjectWithFile:OAuthResultFileName] valueForKey:@"access_token"];
}

@end

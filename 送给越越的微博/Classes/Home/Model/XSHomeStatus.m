//
//  XSHomeStatus.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSHomeStatus.h"
#import "XSHomePic.h"

@implementation XSHomeStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[XSHomePic class]};
}

- (void)setCreated_at:(NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat       = @"EEE MMM d HH:mm:ss Z yyyy";
    formatter.locale           = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *date               = [formatter dateFromString:created_at];
    _created_at                 = [date timeAgo];
}

@end

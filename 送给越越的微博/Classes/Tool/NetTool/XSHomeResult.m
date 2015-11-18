//
//  XSHomeResult.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSHomeResult.h"
#import "XSHomeStatus.h"

@implementation XSHomeResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[XSHomeStatus class]};
}


@end

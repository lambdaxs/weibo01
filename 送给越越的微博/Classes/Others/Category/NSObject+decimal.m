//
//  NSObject+decimal.m
//  进制转换
//
//  Created by xiaos on 15/10/6.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "NSObject+decimal.h"

@implementation NSObject (decimal)

#pragma mark - 将任意字符串 转换成指定进制的十进制数
+(NSString *)getDecimalWithOtherstr:(NSString *)Otherstr system:(systemType)system
{
    NSInteger sum = 0;
    for (NSInteger i = 0; i<Otherstr.length; i++) {
        NSString *ch = [NSString stringWithFormat:@"%c",[Otherstr characterAtIndex:i]];
        sum = (sum * system) + ch.intValue;
    }
    
    return [NSString stringWithFormat:@"%ld",(long)sum];
}

#pragma mark - 将十进制字符串转成任意进制
+ (NSString *)getResultWithDecimalstr:(NSString *)decimalstr system:(systemType)system
{
    NSInteger num = [decimalstr integerValue];
    NSInteger result = 0;
    //分解字符串 拆分成对应进制
    NSMutableString *tempStr = [NSMutableString string];
    
    //16进制
    if (system == hexadecimal) {
        while (num != 0) {
            result = num%system;
            switch (result) {
                case 10:
                    [tempStr appendString:@"A"];
                    break;
                case 11:
                    [tempStr appendString:@"B"];
                    break;
                case 12:
                    [tempStr appendString:@"C"];
                    break;
                case 13:
                    [tempStr appendString:@"D"];
                    break;
                case 14:
                    [tempStr appendString:@"E"];
                    break;
                case 15:
                    [tempStr appendString:@"F"];
                    break;
                default:
                    [tempStr appendFormat:@"%ld",(long)result];
                    break;
            }
            num = num/system;
        }
    }else{
        while (num != 0) {
            result = num%system;
            [tempStr appendFormat:@"%ld",(long)result];
            num = num/system;
        }
    }
    
    
    //翻转字符串
    NSMutableString *resultStr = [NSMutableString string];
    for (NSInteger i = tempStr.length-1; i >= 0 ; i--) {
        [resultStr appendFormat:@"%c",[tempStr characterAtIndex:i]];
    }
    return resultStr;
}

@end

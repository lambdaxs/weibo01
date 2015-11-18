//
//  NSObject+decimal.h
//  进制转换
//
//  Created by xiaos on 15/10/6.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    binary = 2,
    octal = 8,
    decimal = 10,
    hexadecimal = 16
}systemType;

@interface NSObject (decimal)

//将任意字符串 转换成指定进制的十进制数
+ (NSString *)getDecimalWithOtherstr:(NSString *)Otherstr system:(systemType)system;

//将十进制字符串转成任意进制
+ (NSString *)getResultWithDecimalstr:(NSString *)decimalstr system:(systemType)system;

@end

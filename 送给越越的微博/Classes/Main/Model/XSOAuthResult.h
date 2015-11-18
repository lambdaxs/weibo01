//
//  XSOAuthResult.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OAuthResultFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@interface XSOAuthResult : NSObject

@property (nonatomic,copy) NSString *access_token;      ///< 获取的token
@property (nonatomic,copy) NSString *expires_in;        ///< token有效时间
@property (nonatomic,copy) NSString *remind_in;         ///< token有效时间
@property (nonatomic,copy) NSString *uid;               ///< 用户uid

@property (nonatomic,strong) NSDate *overDate;          ///< 到期时间 5年才过期，慌毛线--

+ (NSString *)getAccess_token;                          ///< 快速得到token
@end

//
//  XSNetTool.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSNetTool : NSObject

/** OAuth验证请求 POST */
+ (void)netOAuthWithCode:(NSString *)code
        success:(void(^)())success
        failure:(void(^)(NSError *error))failure;

/** 首页请求新微博 GET */
+ (void)netHomeGetNewStatusWithSinceId:(NSString *)sinceId
        success:(void(^)(NSArray *statuses))success
        failure:(void(^)(NSError *error))failure;

/** 首页请求旧微博 GET */
+ (void)netHomeGetOldStatusWithMaxId:(NSString *)maxId
                    success:(void(^)(NSArray *statuses))success
                    failure:(void(^)(NSError *error))failure;


@end

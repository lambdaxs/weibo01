//
//  XSNetTool.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSNetTool.h"
#import "XSHttpTool.h"

#import "XSOAuthParam.h"
#import "XSOAuthResult.h"

#import "XSHomeParam.h"
#import "XSHomeResult.h"

@implementation XSNetTool



+ (void)netOAuthWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *))failure
{
    XSOAuthParam *param = [[XSOAuthParam alloc] init];
    param.client_id     = @"529280005";
    param.client_secret = @"409d20047a0ab16d345046c89dd23cb6";
    param.grant_type    = @"authorization_code";
    param.code          = code;
    param.redirect_uri  = @"http://www.xsdota.com";
    
    [XSHttpTool POST:@"https://api.weibo.com/oauth2/access_token"
                param:param.keyValues
                success:^(id responseObject) {
        //保存用户token到归档
        XSOAuthResult *result = [XSOAuthResult objectWithKeyValues:responseObject];
        [NSKeyedArchiver archiveRootObject:result toFile:OAuthResultFileName];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)netHomeGetNewStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    XSHomeParam *param = [XSHomeParam new];
    param.access_token = [XSOAuthResult getAccess_token];
    if (sinceId) {
        param.since_id = sinceId;
    }
    
    [XSHttpTool GET:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param.keyValues success:^(id responseObject) {
        XSHomeResult *result = [XSHomeResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {failure(error);}
    }];
}

+ (void)netHomeGetOldStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    XSHomeParam *param = [XSHomeParam new];
    param.access_token = [XSOAuthResult getAccess_token];
    if (maxId) {
        param.max_id = maxId;
    }
    
    [XSHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" param:param.keyValues success:^(id responseObject) {
        XSHomeResult *result = [XSHomeResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {failure(error);}
    }];

}


@end

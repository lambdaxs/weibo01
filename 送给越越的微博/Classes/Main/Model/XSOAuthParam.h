//
//  XSOAuthParam.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSOAuthParam : NSObject

@property (nonatomic,copy) NSString *client_id;         ///< 客户端id
@property (nonatomic,copy) NSString *client_secret;     ///< 客户端密钥
@property (nonatomic,copy) NSString *grant_type;        ///< 授权类型
@property (nonatomic,copy) NSString *code;              ///< 授权code
@property (nonatomic,copy) NSString *redirect_uri;      ///< 回调地址

@end

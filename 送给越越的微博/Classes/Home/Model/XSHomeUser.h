//
//  XSHomeUser.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSHomeUser : NSObject

/**
 "avatar_hd" = "http://ww4.sinaimg.cn/crop.0.1.750.750.1024/c02dc63cjw8exwei5kf42j20ku0kw3zj.jpg";
 "avatar_large" = "http://tp1.sinaimg.cn/3224225340/180/5742144464/0"
 */
@property (nonatomic,copy) NSString *idStr;             ///< 用户id
@property (nonatomic,copy) NSString *location;          ///< 所在地
@property (nonatomic,copy) NSString *name;              ///< 名字
@property (nonatomic,copy) NSString *profile_image_url; ///< 头像url
@property (nonatomic,copy) NSString *avatar_hd;         ///< 高清头像url
@property (nonatomic,copy) NSString *avatar_large;      ///< 中清头像url
@property (nonatomic,copy) NSString *cover_image_phone; ///< 个人背景图片url
@property (nonatomic,copy) NSString *profile_url;       ///< 用户url(需要拼接)
@property (nonatomic,copy) NSString *created_at;        ///< 创建时间
@property (nonatomic,copy) NSString *statuses_count;    ///< 微博数
@property (nonatomic,copy) NSString *followers_count;   ///< 粉丝数
@property (nonatomic,copy) NSString *friends_count;     ///< 关注数

//@property (nonatomic,copy) NSString *description;


@end

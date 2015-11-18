//
//  XSHomeStatus.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XSHomeUser.h"

@interface XSHomeStatus : NSObject<MJKeyValue>

/**
 created_at                 string	微博创建时间
 mid                        int64	微博MID
 idstr                      string	字符串型的微博ID
 text                       string	微博信息内容
 source                     string	微博来源
 favorited                  boolean	是否已收藏，true：是，false：否
 truncated                  boolean	是否被截断，true：是，false：否
 in_reply_to_status_id      string	（暂未支持）回复ID
 in_reply_to_user_id        string	（暂未支持）回复人UID
 in_reply_to_screen_name	string	（暂未支持）回复人昵称
 thumbnail_pic              string	缩略图片地址，没有时不返回此字段
 bmiddle_pic                string	中等尺寸图片地址，没有时不返回此字段
 original_pic               string	原始图片地址，没有时不返回此字段
 geo                        object	地理信息字段 详细
 user                       object	微博作者的用户信息字段 详细
 retweeted_status           object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count              int     转发数
 comments_count             int     评论数
 attitudes_count            int     表态数
 mlevel                     int     暂未支持
 visible                    object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 pic_ids                    object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 */
@property (nonatomic,copy) NSString *idstr;                 ///< 微博id
@property (nonatomic,copy) NSString *created_at;            ///< 生成时间
@property (nonatomic,copy) NSString *mid;                   ///< mid
@property (nonatomic,copy) NSString *text;                  ///< 正文内容
@property (nonatomic,copy) NSString *source;                ///< 来源
@property (nonatomic,copy) NSString *thumbnail_pic;         ///< 缩略图
@property (nonatomic,copy) NSString *bmiddle_pic;           ///< 中等质量图
@property (nonatomic,copy) NSString *original_pic;          ///< 原图
@property (nonatomic,copy) NSString *reposts_count;         ///< 转发数
@property (nonatomic,copy) NSString *comments_count;        ///< 评论数
@property (nonatomic,copy) NSString *attitudes_count;       ///< 点赞数
@property (nonatomic,assign) BOOL    favorited;             ///< 是否收藏
@property (nonatomic,strong) NSArray *pic_urls;             ///< 配图数组(XSHomePic)

@property (nonatomic,strong) XSHomeUser *user;                  ///< 用户对象
@property (nonatomic,strong) XSHomeStatus *retweeted_status;      ///< 转发微博对象
//@property (nonatomic,copy) NSString *geo;                   ///< 地理对象


@end

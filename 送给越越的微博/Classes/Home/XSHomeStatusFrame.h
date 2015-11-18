//
//  XSHomeStatusFrame.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NAME_FONT       [UIFont fontWithName:@"Helvetica" size:16.0f]       ///< 昵称字体大小
#define TEXT_FONT       [UIFont systemFontOfSize:16.0f]                     ///< 正文字体大小
#define RETEXT_FONT     [UIFont systemFontOfSize:15.0f]                     ///< 转发字体大小
#define TIME_FONT       [UIFont systemFontOfSize:12.0f]                     ///< 时间字体大小

#define ICON_SIZE       40.0f
#define REICON_SIZE     18.0f
extern const CGFloat cellMargin;


@class XSHomeStatus;
@interface XSHomeStatusFrame : NSObject

@property (nonatomic,strong) XSHomeStatus *status;      ///< 数据模型

@property (nonatomic,assign) CGRect originalFrame;      ///< 原创微博尺寸
@property (nonatomic,assign) CGRect nameFrame;          ///< 昵称尺寸
@property (nonatomic,assign) CGRect iconFrame;          ///< 头像尺寸
@property (nonatomic,assign) CGRect sourceFrame;        ///< 来源尺寸
@property (nonatomic,assign) CGRect timeFrame;          ///< 时间尺寸
@property (nonatomic,assign) CGRect textFrame;          ///< 正文尺寸
@property (nonatomic,assign) CGRect picFrame;           ///< 配图尺寸

@property (nonatomic,assign) CGRect retweetedFrame;     ///< 转发微博尺寸
@property (nonatomic,assign) CGRect reIconFrame;        ///< 转发头像尺寸
@property (nonatomic,assign) CGRect reNameFrame;        ///< 转发昵称尺寸
@property (nonatomic,assign) CGRect reTextFrame;        ///< 转发正文尺寸
@property (nonatomic,assign) CGRect rePicFrame;         ///< 转发配图尺寸

@property (nonatomic,assign) CGRect toolFrame;          ///< 工具条尺寸
@property (nonatomic,assign) CGFloat cellHeight;        ///< cell高度

@end

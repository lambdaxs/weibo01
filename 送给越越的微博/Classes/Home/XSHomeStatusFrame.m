//
//  XSHomeStatusFrame.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSHomeStatusFrame.h"

#import "XSHomeStatus.h"
#import "XSHomeUser.h"

const CGFloat cellMargin = 10.0f;

@implementation XSHomeStatusFrame


- (void)setStatus:(XSHomeStatus *)status
{
    _status = status;
    /** 计算原创微博尺寸 */
    [self setUpOriginalFrame];
    
    CGFloat toolbarY = CGRectGetMaxY(self.originalFrame);
    if (status.retweeted_status)
    {   /** 计算转发微博尺寸 */
        [self setUpRetweetedFrame];
        toolbarY = CGRectGetMaxY(self.retweetedFrame);
    }

    /** 计算工具条尺寸 */
    CGFloat toolbarX = self.nameFrame.origin.x;
    CGFloat toolbarW = SCREEN_W - toolbarX - cellMargin;
    CGFloat toolbarH = 35;
    self.toolFrame   = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /* cell的高度 */
    self.cellHeight  = CGRectGetMaxY(self.toolFrame);
}

#pragma mark 计算原创微博frame
-(void)setUpOriginalFrame
{
    XSHomeUser *user = _status.user;
    
    /** 头像 */
    CGFloat iconXY  = cellMargin;
    CGFloat iconWH  = ICON_SIZE;
    self.iconFrame  = CGRectMake(iconXY, iconXY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX   = CGRectGetMaxX(self.iconFrame) + 8.0f;
    CGFloat nameY   = iconXY;
    CGSize nameSize = [user.name sizeWithFont:NAME_FONT];
    self.nameFrame  = (CGRect){{nameX, nameY}, nameSize};
    
    /** 时间 */
    CGSize timeSize = [_status.created_at sizeWithFont:TIME_FONT];
    CGFloat timeX   = SCREEN_W - timeSize.width - 2*cellMargin;
    CGFloat timeY   = iconXY;
    self.timeFrame  = (CGRect){{timeX, timeY}, timeSize};
    
    /** 正文 */
    CGFloat textX   = nameX;
    CGFloat textY   = CGRectGetMaxY(self.nameFrame) + 5.0f;
    CGFloat maxW    = SCREEN_W - nameX - cellMargin;
    CGSize textSize = [_status.text sizeWithFont:TEXT_FONT maxWidth:maxW];
    self.textFrame  = (CGRect){{textX, textY}, textSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (_status.pic_urls.count) { // 有配图
        CGFloat photosX   = textX;
        CGFloat photosY   = CGRectGetMaxY(self.textFrame) + cellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        self.picFrame     = (CGRect){{photosX, photosY}, photosSize};
        originalH         = CGRectGetMaxY(self.picFrame) + cellMargin;
    } else { // 没配图
        originalH         = CGRectGetMaxY(self.textFrame) + cellMargin;
    }
    
    /** 原创微博整体 */
    CGFloat originalX  = 0;
    CGFloat originalY  = 0;
    CGFloat originalW  = SCREEN_W;
    self.originalFrame = CGRectMake(originalX, originalY, originalW, originalH);
}

#pragma mark 计算转发微博frame
-(void)setUpRetweetedFrame
{
    XSHomeStatus *reStatus = _status.retweeted_status;
    XSHomeUser *user = reStatus.user;
    
    /** 转发头像 */
    CGFloat iconXY   = cellMargin;
    CGFloat iconWH   = REICON_SIZE;
    self.reIconFrame = (CGRect){{ iconXY, iconXY},{ iconWH, iconWH}};
    
    /** 转发昵称 */
    CGFloat nameX    = CGRectGetMaxX(self.reIconFrame) + cellMargin;
    CGFloat nameY    = iconXY;
    CGSize  nameSize = [user.name sizeWithFont:RETEXT_FONT];
    self.reNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    /** 转发正文 */
    CGFloat textX    = iconXY;
    CGFloat textY    = CGRectGetMaxY(self.reNameFrame) + cellMargin;
    CGFloat maxW     = SCREEN_W - self.nameFrame.origin.x - 2*cellMargin;
    CGSize  textSize = [reStatus.text sizeWithFont:RETEXT_FONT maxWidth:maxW];
    self.reTextFrame = (CGRect){{textX, textY}, textSize};
    
    /** 转发配图 */
    CGFloat retweetedH = 0;
    if (reStatus.pic_urls.count)
    { // 有配图
        CGFloat photosX   = textX;
        CGFloat photosY   = CGRectGetMaxY(self.reTextFrame) + cellMargin;
        CGSize photosSize = [self photosSizeWithCount:reStatus.pic_urls.count];
        self.rePicFrame   = (CGRect){{photosX, photosY}, photosSize};
        retweetedH        = CGRectGetMaxY(self.rePicFrame) + cellMargin;
    }
    else
    { // 没配图
        retweetedH        = CGRectGetMaxY(self.reTextFrame) + cellMargin;
    }
    
    /** 转发微博整体 */
    CGFloat retweetedX  = self.nameFrame.origin.x;
    CGFloat retweetedY  = CGRectGetMaxY(self.originalFrame) + 5.0f;
    CGFloat retweetedW  = SCREEN_W - retweetedX - cellMargin;
    self.retweetedFrame = CGRectMake(retweetedX, retweetedY, retweetedW, retweetedH);
}

- (CGSize)photosSizeWithCount:(NSInteger)count
{
    if (count == 1) {
        return CGSizeMake(SCREEN_W - 90, (SCREEN_W - 90) * 0.618);
    }
    
    // 获取总列数
    NSInteger cols = count == 4 || count == 2? 2 : 3;


    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    NSInteger rols = (count - 1) / cols + 1;
    CGFloat photoWH = (SCREEN_W - 90 - 2*cols)/cols;
//    CGFloat w = (SCREEN_W - 90 - 2 * cols)/cols;
    CGFloat w = cols * photoWH + (cols - 1) * cols;
    CGFloat h = rols * photoWH + (rols - 1) * cols;
    
    
    return CGSizeMake(w, h);
}

@end

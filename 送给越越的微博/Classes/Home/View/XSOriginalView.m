//
//  XSOriginalView.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSOriginalView.h"
#import "XSPicView.h"

#import "XSHomeUser.h"
#import "XSHomeStatus.h"
#import "XSHomeStatusFrame.h"

#import "UIImageView+WebCache.h"

@interface XSOriginalView ()

@property (nonatomic,strong) UILabel     *nameView;         ///< 昵称
@property (nonatomic,strong) UIImageView *iconView;         ///< 头像
@property (nonatomic,strong) UILabel     *sourceView;       ///< 来源
@property (nonatomic,strong) UILabel     *timeView;         ///< 时间
@property (nonatomic,strong) UILabel     *textView;         ///< 正文
@property (nonatomic,strong) XSPicView   *picView;          ///< 配图

@end

@implementation XSOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = RGB(249, 249, 249);
        [self setUpSubViews];
    }
    return self;
}

#pragma mark - 初始化子控件
-(void)setUpSubViews
{
    /** 头像 */
    self.iconView = [UIImageView new];
    self.iconView.layer.cornerRadius = 4.0f;
    self.iconView.layer.masksToBounds = YES;
    [self addSubview:self.iconView];
    
    /** 昵称 */
    self.nameView = [UILabel new];
    self.nameView.font = NAME_FONT;
    [self addSubview:self.nameView];
    
    /** 时间 */
    self.timeView = [UILabel new];
    self.timeView.font = TIME_FONT;
    self.timeView.textColor = RGB(177, 187, 195);
    [self addSubview:self.timeView];
    
    /** 正文 */
    self.textView = [UILabel new];
    self.textView.font = TEXT_FONT;
    self.textView.numberOfLines = 0;
    [self addSubview:self.textView];
    
    /** 来源 */
    self.sourceView = [UILabel new];
//    [self addSubview:self.sourceView];
    
    /** 配图 */
    self.picView = [XSPicView new];
    [self addSubview:self.picView];
}

#pragma mark - 设置子控件内容和尺寸
- (void)setStatusFrame:(XSHomeStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    XSHomeStatus *status = statusFrame.status;
    XSHomeUser *user = status.user;
    
    self.iconView.frame = statusFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.nameView.frame = statusFrame.nameFrame;
    self.nameView.text = user.name;
    
    self.timeView.frame = statusFrame.timeFrame;
    self.timeView.text = status.created_at;
    
    self.textView.frame = statusFrame.textFrame;
    self.textView.text = status.text;
    
    self.picView.frame = statusFrame.picFrame;
    self.picView.pic_urls = status.pic_urls;
}


@end

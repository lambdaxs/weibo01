//
//  XSRetweetedView.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSRetweetedView.h"

#import "XSPicView.h"
#import "XSHomeStatus.h"
#import "XSHomeStatusFrame.h"
#import "XSHomeUser.h"

#import "UIImageView+WebCache.h"
#import "UIImage+XSStretch.h"

@interface XSRetweetedView ()

@property (nonatomic,strong) UILabel     *reNameView;     ///< 昵称
@property (nonatomic,strong) UIImageView *reIconView;     ///< 头像
@property (nonatomic,strong) UILabel     *reTextView;     ///< 正文
@property (nonatomic,strong) XSPicView   *rePicView;      ///< 配图

@end

@implementation XSRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
        self.userInteractionEnabled = YES;
        self.image = [UIImage setStretchImg:@"cell_background"];
    }
    return self;
}

#pragma mark - 初始化子控件
-(void)setUpSubViews
{
    self.reIconView = [UIImageView new];
    self.reIconView.layer.cornerRadius = 2.0f;
    [self addSubview:self.reIconView];
    
    self.reNameView = [UILabel new];
    self.reNameView.font = RETEXT_FONT;
    [self addSubview:self.reNameView];
    
    self.reTextView = [UILabel new];
    self.reTextView.font = RETEXT_FONT;
    self.reTextView.lineBreakMode = NSLineBreakByCharWrapping;
    self.reTextView.numberOfLines = 0;
    [self addSubview:self.reTextView];
    
    self.rePicView = [XSPicView new];
    [self addSubview:self.rePicView];
    
}

#pragma mark - 设置子控件内容和frame
- (void)setRetweetedStatusFrame:(XSHomeStatusFrame *)retweetedStatusFrame
{
    _retweetedStatusFrame         = retweetedStatusFrame;
    XSHomeStatus *retweetedStatus = retweetedStatusFrame.status.retweeted_status;
    XSHomeUser *retweetedUser     = retweetedStatus.user;
    
    self.reIconView.frame = retweetedStatusFrame.reIconFrame;
    [self.reIconView sd_setImageWithURL:[NSURL URLWithString:retweetedUser.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.reNameView.frame = retweetedStatusFrame.reNameFrame;
    self.reNameView.text = retweetedUser.name;
    
    self.reTextView.frame = retweetedStatusFrame.reTextFrame;
    self.reTextView.text = retweetedStatus.text;
    
    self.rePicView.frame = retweetedStatusFrame.rePicFrame;
    self.rePicView.pic_urls = retweetedStatus.pic_urls;
}

@end

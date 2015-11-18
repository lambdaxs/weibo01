//
//  XSCellImage.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/12.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSCellImage.h"

#import "UIImageView+WebCache.h"

#import "XSHomePic.h"

@interface XSCellImage ()

@property (nonatomic,strong) UIImageView *gitView;

@end

@implementation XSCellImage

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius  = 3.0f;
        self.clipsToBounds = YES;
        
        self.gitView = [UIImageView new];
        self.gitView.image = [UIImage imageNamed:@"timeline_image_gif"];
        [self addSubview:self.gitView];
        
        
    }
    return self;
}

- (void)setPic:(XSHomePic *)pic
{
    _pic = pic;
    NSString *lagerPic = [pic.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail"
                                                                      withString:@"bmiddle"];
   
    if ([lagerPic hasSuffix:@".gif"])
    {//显示
        [self sd_setImageWithURL:[NSURL URLWithString:pic.thumbnail_pic]
                placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.gitView.hidden = NO;
    }else
    {//隐藏
        [self sd_setImageWithURL:[NSURL URLWithString:lagerPic]
                placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.gitView.hidden = YES;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = 25;
    CGFloat h = 15;
    CGFloat x = self.width - w;
    CGFloat y  = self.height - h;
    self.gitView.frame = CGRectMake(x, y, w, h);
}

@end

//
//  XSPicView.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSPicView.h"
#import "XSCellImage.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "XSHomePic.h"


@implementation XSPicView

- (instancetype)init
{
    if (self = [super init]) {
        [self setUpSubviews];
    }
    return self;
}

/** 设置9张图片控件 */
- (void)setUpSubviews
{
    for (NSInteger i = 0; i < 9; i++)
    {
        XSCellImage *imgV = [XSCellImage new];
        imgV.tag = i ;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageBroswer:)];
        [imgV addGestureRecognizer:tap];
        [self addSubview:imgV];
    }
}

/** 赋值的时候 生成对应数量的图片控件 */
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XSCellImage *imgV = (XSCellImage *)obj;
        if (idx < pic_urls.count)
        {//显示
            imgV.hidden = NO;
            imgV.pic = pic_urls[idx];
        }
        else
        {//隐藏
            imgV.hidden = YES;
        }
    }];

}

- (void)openImageBroswer:(UITapGestureRecognizer *)tap
{
    XSCellImage *tapView = (XSCellImage *)tap.view;
    // CZPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (XSHomePic *pic in self.pic_urls) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *bmiddle_pic = [pic.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = bmiddle_pic ? [NSURL URLWithString:bmiddle_pic]: [NSURL URLWithString:pic.thumbnail_pic];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    // MJPhoto
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
}

/** 计算配图视图的size */
+ (CGSize)getPhotosViewSizeWithCount:(NSUInteger)count
{
    return CGSizeZero;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.pic_urls.count == 1) {
        XSCellImage *oneImgV = [self.subviews firstObject];
        oneImgV.frame = CGRectMake(0, 0, SCREEN_W - 90, (SCREEN_W - 90) * 0.618);
        return;
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = 3;
    NSInteger col = 0;
    NSInteger rol = 0;
    NSInteger cols = self.pic_urls.count == 4 || self.pic_urls.count == 2 ? 2: 3;
    CGFloat w = (SCREEN_W - 90 - 2 * cols)/cols;
    CGFloat h = w;
    
    // 计算显示出来的imageView
    for (NSInteger i = 0; i < self.pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        XSCellImage *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
    
}


@end

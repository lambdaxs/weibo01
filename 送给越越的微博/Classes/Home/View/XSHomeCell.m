//
//  XSHomeCell.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSHomeCell.h"
#import "XSHomeStatus.h"
#import "XSHomeStatusFrame.h"

#import "XSOriginalView.h"
#import "XSRetweetedView.h"
#import "XSToolView.h"

@interface XSHomeCell ()

/** 

 */
@property (nonatomic,strong) XSOriginalView  *originalView; ///< 原创微博

@property (nonatomic,strong) XSRetweetedView *retweetedView;///< 转发微博

@property (nonatomic,strong) XSToolView      *toolView;     ///< 工具条

//@property (nonatomic,strong) UIView      *originalView;     ///< 原创

//@property (nonatomic,strong) UIView      *toolView;         ///< 工具条

@end

@implementation XSHomeCell

#pragma mark - 初始化子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /** 设置cell的背景色为空  在添加自定义视图的时候能避免cell显示时顶部有黑色横线 */
        self.backgroundColor = [UIColor clearColor];
        [self setUpSubViews];
    }
    return self;
}

-(void)setUpSubViews
{
    
    self.originalView = [XSOriginalView new];
    [self.contentView addSubview:self.originalView];
    
    self.retweetedView = [XSRetweetedView new];
    [self.contentView addSubview:self.retweetedView];
    
    self.toolView = [XSToolView new];
    [self.contentView addSubview:self.toolView];
        
}

#pragma mark - 设置子控件内容和frame
- (void)setStatusFrame:(XSHomeStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.originalView.frame       = statusFrame.originalFrame;
    self.originalView.statusFrame = statusFrame;
    
    if (statusFrame.status.retweeted_status)
    {/** 显示转发微博 */
        self.retweetedView.frame                = statusFrame.retweetedFrame;
        self.retweetedView.retweetedStatusFrame = statusFrame;
        self.retweetedView.hidden               = NO;
    }
    else
    {/** 隐藏转发微博 */
        self.retweetedView.hidden = YES;
    }
    
    self.toolView.frame = statusFrame.toolFrame;
    
    
}

///** 取消点击cell高亮状态 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {}

#pragma mark - 绘图


- (void)drawRect:(CGRect)rect
{
    //画cell下方的分割线
    [RGB(232, 237, 240) set];
    CGFloat cellLineWidth = 1.0f;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = cellLineWidth;
    [path moveToPoint:CGPointMake(0, rect.size.height - cellLineWidth)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - cellLineWidth)];
    [path stroke];

}





@end

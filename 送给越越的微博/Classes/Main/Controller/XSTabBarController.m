//
//  XSTabBarController.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSTabBarController.h"
#import "XSNaviController.h"

#import "XSHomeController.h"
#import "XSMessageController.h"
#import "XSFavoController.h"
#import "XSMeController.h"

#import "UIImage+XSStretch.h"


@interface XSTabBarController ()

@end

@implementation XSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundImage = [UIImage setStretchImg:@"background_tabbar"];
//    self.tabBar.tintColor = [UIColor blueColor];
    
    [self setUpSubviews];   ///< 设置子控制器
    
    
}

-(void)setUpSubviews
{
    XSHomeController *home = [[XSHomeController alloc] init];
    [self setUpChirldController:home withImage:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"] title:@"首页"];
    
    XSMessageController *message = [[XSMessageController alloc] init];
    [self setUpChirldController:message withImage:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] title:@"消息"];
    
    XSFavoController *favo = [[XSFavoController alloc] init];
    [self setUpChirldController:favo withImage:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] title:@"收藏"];

    XSMeController *me = [[XSMeController alloc] init];
    [self setUpChirldController:me withImage:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] title:@"我"];
}

- (void)setUpChirldController:(UIViewController *)vc withImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    XSNaviController *navi = [[XSNaviController alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
}



@end

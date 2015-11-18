//
//  UIImage+XSStretch.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "UIImage+XSStretch.h"

@implementation UIImage (XSStretch)

+ (UIImage*)setStretchImg:(NSString*)imgName
{
    UIImage *bgImg = [UIImage imageNamed:imgName];
    bgImg = [bgImg stretchableImageWithLeftCapWidth:bgImg.size.width/2 topCapHeight:bgImg.size.height/2];
    
    return bgImg;
}

@end

//
//  XSHomeResult.h
//  送给越越的微博
//
//  Created by xiaos on 15/11/11.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSHomeResult : NSObject<MJKeyValue>

/**
 "has_unread" = 0;
 hasvisible = 0;
 interval = 2000;
 "max_id" = 3907924030259063;
 "next_cursor" = 3907924030259063;
 "previous_cursor" = 0;
 "since_id" = 3907937397384025;
 statuses =     (
 */

@property (nonatomic,copy) NSString *since_id;      ///< 最新时间id
@property (nonatomic,copy) NSString *max_id;        ///< 最旧时间id

@property (nonatomic,strong) NSArray *statuses;     ///< 微博数组（XSHomeStatus）




@end

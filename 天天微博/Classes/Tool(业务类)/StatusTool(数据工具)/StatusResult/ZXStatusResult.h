//
//  ZXStatusResult.h
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface ZXStatusResult : NSObject<MJKeyValue>
/**
 *  微博数据模型
 */
@property (nonatomic, strong) NSArray  *statuses;
/**
 *  最近的微博总数
 */
@property (nonatomic, assign) int total_number;
@end

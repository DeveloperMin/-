//
//  ZXStatusCacheTool.h
//  天天微博
//
//  Created by zxopen06 on 15/11/2.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXStatusPrama;

@interface ZXStatusCacheTool : NSObject

+ (void)saveCacheWithStatus:(NSArray *)statuses;

+ (NSArray *)statusWithParam:(ZXStatusPrama *)param;

@end

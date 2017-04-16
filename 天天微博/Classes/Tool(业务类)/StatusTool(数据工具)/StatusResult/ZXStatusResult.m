//
//  ZXStatusResult.m
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatusResult.h"
#import "ZXStatus.h"

@implementation ZXStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[ZXStatus class]};
}
@end

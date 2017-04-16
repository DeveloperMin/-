//
//  ZXUser.m
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXUser.h"

@implementation ZXUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}
@end

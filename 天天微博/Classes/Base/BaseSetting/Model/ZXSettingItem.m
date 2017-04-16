//
//  ZXSettingItem.m
//  天天微博
//
//  Created by zxopen06 on 15/10/30.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXSettingItem.h"

@implementation ZXSettingItem

+ (instancetype)itemWithImage:(UIImage *)image Title:(NSString *)title subTitle:(NSString *)subTitle
{
    ZXSettingItem *item = [[self alloc] init];
    item.title = title;
    item.detailTitle = subTitle;
    item.image = image;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithImage:nil Title:title subTitle:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [self itemWithImage:nil Title:title subTitle:subTitle];
}
+ (instancetype)itemWithImage:(UIImage *)image Title:(NSString *)title
{
    return [self itemWithImage:image Title:title subTitle:nil];
}


@end

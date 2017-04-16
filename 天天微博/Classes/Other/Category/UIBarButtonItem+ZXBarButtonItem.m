//
//  UIBarButtonItem+ZXBarButtonItem.m
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "UIBarButtonItem+ZXBarButtonItem.h"

@implementation UIBarButtonItem (ZXBarButtonItem)

+ (instancetype)barButtoonWithImage:(UIImage *)image hImage:(UIImage *)himage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:himage forState:UIControlStateHighlighted];
    //设置合适的frame
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end

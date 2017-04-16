//
//  UIBarButtonItem+ZXBarButtonItem.h
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZXBarButtonItem)

+ (instancetype)barButtoonWithImage:(UIImage *)image hImage:(UIImage *)himage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end

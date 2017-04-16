//
//  ZXPopMenu.h
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXPopMenu : UIImageView
/**
 *  显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;
/**
 *  隐藏弹出菜单
 */
+ (void)hide;
/**
 *  内容视图
 */
@property (nonatomic, weak) UIView *contentView;
@end

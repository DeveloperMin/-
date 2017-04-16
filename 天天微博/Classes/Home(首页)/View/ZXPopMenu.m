//
//  ZXPopMenu.m
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXPopMenu.h"

@implementation ZXPopMenu
//显示弹出菜单
+ (instancetype)showInRect:(CGRect)rect
{
    ZXPopMenu *menu = [[ZXPopMenu alloc] initWithFrame:rect];
    
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName: @"popover_background"];
    
    [ZXKeyWindow addSubview:menu];
    return menu;
}
//隐藏弹出菜单
+ (void)hide
{
    for (UIView *popView in ZXKeyWindow.subviews) {
        if ([popView isKindOfClass:self]) {
            [popView removeFromSuperview];
        }
    }
}
//设置内容视图
- (void)setContentView:(UIView *)contentView
{
    //先移除内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    self.contentView.frame = CGRectMake(x, y, w, h);
}
@end


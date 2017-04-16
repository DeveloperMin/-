//
//  ZXTextToolBar.m
//  天天微博
//
//  Created by zxopen06 on 15/10/26.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXTextToolBar.h"

@implementation ZXTextToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChild];
    }
    return self;
}
- (void)setUpAllChild
{
    //相册
    [self setUpButtoonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] hImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    //提及
    [self setUpButtoonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] hImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    //话题
    [self setUpButtoonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] hImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    //表情
    [self setUpButtoonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] hImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    //键盘
    [self setUpButtoonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] hImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpButtoonWithImage:(UIImage *)image hImage:(UIImage *)himage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:himage forState:UIControlStateHighlighted];
   
    [btn addTarget:target action:action forControlEvents:controlEvents];
    [self addSubview:btn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat h = 35;
    CGFloat w = self.width / count;
    CGFloat y = self.height - h;
    CGFloat x = 0 ;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
    }
}
- (void)btnOnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [_delegate composeToolBar:self didClickBtn:btn.tag];
    }
}

@end

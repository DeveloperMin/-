//
//  ZXBadgeView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXBadgeView.h"

#define ZXBadgeViewFont [UIFont systemFontOfSize:11]

@implementation ZXBadgeView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        //设置字体大小
        self.titleLabel.font = ZXBadgeViewFont;
        
        [self sizeToFit];
        
    }
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    //判断badgeValue是否有值
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else
    {
        self.hidden = NO;
    }
    CGSize size = [badgeValue sizeWithFont:ZXBadgeViewFont];
    /**
     *  文字的尺寸大于控件的宽度
     */
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else
    {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
    
}

@end

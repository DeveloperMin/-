//
//  ZXTitleButton.m
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXTitleButton.h"


@implementation ZXTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.currentImage == nil) return;
    //title
    self.titleLabel.x = 0;
    //image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
 
}
//重写setTitle方法,扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //自动调节尺寸
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
     //自动调节尺寸
    [self sizeToFit];
}
@end

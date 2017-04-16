//
//  ZXComposePhotoView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/26.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXComposePhotoView.h"

@implementation ZXComposePhotoView


- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = image;
    [self addSubview:imageV];
}
//添加每个子控件的时候就会调用此方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    
    CGFloat x = 0 ;
    CGFloat y = 0;
    CGFloat wh = (self.width - (cols - 1) * 10)/cols;
    
    NSInteger col = 0;
    NSInteger rol = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageV= self.subviews[i];
        col = i % cols;
        rol = i / cols;
        x = (margin + wh) * col;
        y = (margin + wh) * rol;
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
}

@end

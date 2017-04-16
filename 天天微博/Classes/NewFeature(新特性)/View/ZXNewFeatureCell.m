//
//  ZXNewFeatureCell.m
//  天天微博
//
//  Created by zxopen06 on 15/10/20.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXNewFeatureCell.h"
#import "ZXTabBarController.h"

@interface ZXNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) UIButton *starButton;

@end
@implementation ZXNewFeatureCell
- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
    }
    return _shareButton;
}
- (UIButton *)starButton
{
    if (_starButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        
        _starButton = btn;
    }
    return _starButton;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    //分享按钮
    self.shareButton.center = CGPointMake(self.width *0.5, self.height*0.8);
    
    //开始按钮
    self.starButton.center = CGPointMake(self.width*0.5, self.height*0.9);
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}
- (void)start
{
    //进入tabBar
    ZXTabBarController *tabBarController = [[ZXTabBarController alloc] init];
    //切换根控制器
    ZXKeyWindow.rootViewController = tabBarController;
    
}
// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) {
        self.shareButton.hidden = NO;
        self.starButton.hidden = NO;
    }else
    {
        self.shareButton.hidden = YES;
        self.starButton.hidden = YES;
    }
}

@end

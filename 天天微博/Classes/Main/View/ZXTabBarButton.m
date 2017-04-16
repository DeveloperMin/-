//
//  ZXTabBarButton.m
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXTabBarButton.h"
#import "ZXBadgeView.h"


#define ZXImageRidio 0.7
@interface ZXTabBarButton ()

@property (nonatomic, strong) ZXBadgeView *badgeView;

@end

@implementation ZXTabBarButton
//重新Highlighted方法,取消高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

- (ZXBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [ZXBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:_badgeView];
    }
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil
                          change:nil context:nil];
    
    // KVO：时刻监听一个对象的属性有没有改变,Observer:按钮
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}
//只要监听的属性一有值,就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    self.badgeView.badgeValue = self.item.badgeValue;
}
//修改按钮内部的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    //imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * ZXImageRidio;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    //title
    CGFloat titleX = 0;
    CGFloat titleY = imageH + 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    //badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

@end

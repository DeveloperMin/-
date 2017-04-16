//
//  ZXTabBar.m
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXTabBar.h"
#import "ZXTabBarButton.h"


@interface ZXTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation ZXTabBar

- (NSMutableArray *)buttons
{
    if(!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (void)setItems:(NSArray *)items
{
    _items = items;
    //遍历所有的items,创建自定义的tabBarButton
    for (UITabBarItem *item in self.items) {
        ZXTabBarButton *btn = [ZXTabBarButton buttonWithType:UIButtonTypeCustom];
        //给按钮赋值模型,按钮的内容由模型决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (btn.tag == 0) { //选中第0个
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        //把按钮添加到按钮数组
        [self.buttons addObject:btn];
        
    }
 
}
- (void)btnClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    //通知tabBarVc切换控制器
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [self.delegate tabBar:self didClickButton:button.tag];
    }
}

- (UIButton *)plusButton
{
    if (!_plusButton) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_add_highlighted"] forState:UIControlStateHighlighted];
        _plusButton = btn;
        [self addSubview:_plusButton];
        //添加点击事件
        [btn addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_plusButton sizeToFit];
    }
    return _plusButton;
}
- (void)plusButtonClick
{
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w/(self.items.count+1);
    CGFloat btnH = h;
    
    int i = 0;
    //调整系统自带的tabBar上的位置
    for (UIView *tabBarButton in self.subviews) {
       //判断是否是UITabBarButton
        if([tabBarButton isKindOfClass:NSClassFromString(@"ZXTabBarButton")])
        {
            if (i == 2) {
                i = 3;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
        self.plusButton.center = CGPointMake(w*0.5, h*0.5);
    
    }
}

@end

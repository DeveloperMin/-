//
//  ZXTabBar.h
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXTabBar;
@protocol ZXTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ZXTabBar *)tabBar didClickButton:(NSInteger)index;
/**
 *  点击加号按钮的时候调用
 */
- (void)tabBarDidClickPlusButton:(ZXTabBar *)tabBar;

@end
@interface ZXTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak)id<ZXTabBarDelegate> delegate;
@end

//
//  ZXNavigationController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXNavigationController.h"
#import "UIBarButtonItem+ZXBarButtonItem.h"

@interface ZXNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation ZXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    如果让自定义的导航栏按钮具备返回功能,就要取消代理方法
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    //清空手势滑动返回的代理,就能实现其功能
    self.interactivePopGestureRecognizer.delegate = nil;
    
    self.delegate = self;
}
//设置导航栏的颜色和字体颜色
+ (void)initialize
{
    /**
     *  获取当前类下面的UIBarButtonItem
     */
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    /**
     *  设置导航条上的文字颜色
     */
    NSMutableDictionary *titleAtt = [NSMutableDictionary dictionary];
    titleAtt[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:titleAtt forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {
        //设置导航栏左边的按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtoonWithImage:[UIImage imageNamed:@"navigationbar_back"] hImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        //设置导航栏右边的按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtoonWithImage:[UIImage imageNamed:@"navigationbar_more"] hImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
        //隐藏底部tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
 
    [super pushViewController:viewController animated:animated];
}
//导航控制器即将显示的时候会调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBar = (UITabBarController *)ZXKeyWindow.rootViewController;
    
    //移除系统对应的tabBarButton
    for (UIView *tabBarButton in tabBar.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}
//导航栏跳转完成的时候会调用此方法
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {//显示根控制器
        //还原滑动返回的手势处理
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else
    {   //不是显示跟控制器,实现滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}


@end

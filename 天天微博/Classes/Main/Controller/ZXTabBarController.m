//
//  ZXTabBarController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXTabBar.h"
#import "ZXHomeViewController.h"
#import "ZXMessageTableViewController.h"
#import "ZXDiscoverTableViewController.h"
#import "ZXProfileTableViewController.h"

#import "ZXUserTool.h"
#import "ZXUserResult.h"

#import "ZXComposeViewController.h"

#import "ZXNavigationController.h"

@interface ZXTabBarController ()<ZXTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) ZXHomeViewController *home;
@property (nonatomic, weak) ZXMessageTableViewController *message;
@property (nonatomic, weak) ZXProfileTableViewController *profile;

@end

@implementation ZXTabBarController

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

+ (void)initialize
{
    //获取当前类下面的所有tabBarItem,
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加所有子控制器
    [self setUpAllChildViewController];
    
    //创建自定义tabBar控制器
    [self setUpTabBar];
    
    //每隔一段时间,请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];

}
//设置微博的未读数
//更新未读数据
- (void)requestUnread
{
    //请求微博未读数
    [ZXUserTool unReadWithSuccess:^(ZXUserResult *result) {
        //设置首页未读数
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        //设置未读消息数
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        //设置粉丝数
        self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        //设置应用的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.unReadCount;
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //移除系统对应的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}

#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    //首页
    ZXHomeViewController *home = [[ZXHomeViewController alloc] init];
    [self setUpOneController:home image:[UIImage imageWithOriginalName: @"tabbar_home"] selectedImage:[UIImage imageWithOriginalName: @"tabbar_home_selected"] title:@"首页"];
    self.home = home;
    
    //消息
    ZXMessageTableViewController *message = [[ZXMessageTableViewController alloc] init];
    [self setUpOneController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage: [UIImage imageWithOriginalName: @"tabbar_message_center_selected"] title:@"消息"];
    self.message = message;
    
    //发现
    ZXDiscoverTableViewController *discover = [[ZXDiscoverTableViewController alloc] init];
    [self setUpOneController:discover image:[UIImage imageNamed: @"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];

    
    //我
    ZXProfileTableViewController *profile = [[ZXProfileTableViewController alloc] init];
    [self setUpOneController:profile image:[UIImage imageWithOriginalName: @"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    self.profile = profile;
}
/**
 *  创建自定义TabBar
 */
- (void)setUpTabBar
{
    ZXTabBar *tabBar = [[ZXTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
   
    //设置代理
    tabBar.delegate  = self;
    
    //给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    //设置只读属性的值是,可以用KVC来设置
//    //self.tabBar = tabBar;
//    [self setValue:tabBar forKeyPath:@"tabBar"];
    //添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    //移除系统的tabBar
//    [self.tabBar removeFromSuperview];
    
}
/**
 *  切换对应的控制器
 */
- (void)tabBar:(ZXTabBar *)tabBar didClickButton:(NSInteger)index
{
    if(index == 0 && self.selectedIndex == index)
    {
        //刷新数据
        [self.home refresh];
    }
    self.selectedIndex = index;
}
- (void)tabBarDidClickPlusButton:(ZXTabBar *)tabBar
{
    ZXComposeViewController *composeVc = [[ZXComposeViewController alloc] init];
    ZXNavigationController *nav = [[ZXNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - 添加一个控制器
- (void)setUpOneController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
//    vc.tabBarItem.title = title;
//    vc.navigationItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
//    vc.tabBarItem.badgeValue = @"10";
    
    //把item模型保存在数组中
    [self.items addObject:vc.tabBarItem];
    
    ZXNavigationController *navigationVc = [[ZXNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navigationVc];
}


@end

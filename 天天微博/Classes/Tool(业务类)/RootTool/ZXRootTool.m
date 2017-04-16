//
//  ZXRootTool.m
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXRootTool.h"
#import "ZXTabBarController.h"
#import "ZXNewFeatureController.h"

#define ZXVersion @"version"
@implementation ZXRootTool
/**
 *  选择根控制器
 */
+ (void)chooseRootViewController:(UIWindow *)window
{
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //获取上一个版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:ZXVersion];
    if ([currentVersion isEqualToString:lastVersion]) {//没有新版本
        ZXTabBarController *tabBarVc = [[ZXTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    }else
    {
        //判断时候有新版本
        //创建根控制器
        ZXNewFeatureController *newFeatureVc = [[ZXNewFeatureController alloc] init];
        
        window.rootViewController = newFeatureVc;
        //保存当前的版本号,保存在偏好设置中
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:currentVersion forKey:ZXVersion];
        
        //操作完数据必须进行同步，来保存数据
        [defaults synchronize];
    }
}

@end

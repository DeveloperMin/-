//
//  AppDelegate.m
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "AppDelegate.h"

#import "ZXOAuthViewController.h"
#import "ZXRootTool.h"
#import "ZXAccountTool.h"

#import <AVFoundation/AVFoundation.h>

#import "UIImageView+WebCache.h"



@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //真机上后台播放,要设置session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    //设置会话类型(后台播放)
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //激活会话
    [session setActive:YES error:nil];
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     //判断有没有授权
    //选择根控制器
    if ([ZXAccountTool accout]) {//有账号
        
        [ZXRootTool chooseRootViewController:self.window];
    }else
    {//进行授权
        ZXOAuthViewController *oAuthVc = [[ZXOAuthViewController alloc] init];
        
        self.window.rootViewController = oAuthVc;
    }

    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

#warning 使用SDwebImage很容易让内存增大,造成内存警告
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //无限循环
    self.player.numberOfLoops = -1;
    
    [self.player prepareToPlay];
    [self.player play];
    
}
//程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //开启后台任务,按时此法开启的后台任务的优先级很低,
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        //程序结束的时候会调用
        [application endBackgroundTask:ID];
    }];
    //为了增加优先级,可以在失去焦点的时候播放一段音乐
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

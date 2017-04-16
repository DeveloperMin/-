//
//  ZXAccountTool.m
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXAccountTool.h"
#import "ZXAccount.h"
#import "AFNetworking.h"
#import "ZXAccountParam.h"

#import "ZXHttpTool.h"

#import "MJExtension.h"

#define ZXClient_id     @"1896394484"
#define ZXRedirect_uri  @"http://www.baidu.com"
#define ZXClient_secret @"97263b3b64afafa6e748e343ac554d02"

#define ZXAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject ] stringByAppendingPathComponent:@"Account.data"]
@implementation ZXAccountTool
//类方法用静态变量代替成员变量
static ZXAccount *_account;

+ (void)saveAccount:(ZXAccount *)account
{
    //保存账号信息
    [NSKeyedArchiver archiveRootObject:account toFile:ZXAccountPath];
}

+ (ZXAccount *)accout
{
    if (_account == nil) {
        
         _account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZXAccountPath];
        //判断账号是否过期
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending ) {//过期
            return nil;
        }
    }
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)())failure
{
    //创建参数模型
    ZXAccountParam *param = [[ZXAccountParam alloc] init];
    param.client_id = ZXClient_id;
    param.client_secret = ZXClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = ZXRedirect_uri;
    
    //使用AFN框架
    //创建管理者
    [ZXHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        //字典转模型
        ZXAccount *accout = [ZXAccount accoutWithDictionary:responseObject];
        
        //保存账号信息
        [ZXAccountTool saveAccount:accout];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"%@", error);
            failure();
        }
    }];
}
@end

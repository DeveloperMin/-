//
//  ZXUserTool.m
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXUserTool.h"

#import "ZXUserResult.h"
#import "ZXUserPrama.h"
#import "ZXUser.h"

#import "ZXAccount.h"
#import "ZXAccountTool.h"

#import "ZXHttpTool.h"

#import "MJExtension.h"

@implementation ZXUserTool

+ (void)unReadWithSuccess:(void(^)(ZXUserResult *result))success failure:(void(^)(NSError *error))failure
{
    //创建参数模型
    ZXUserPrama *prama = [[ZXUserPrama alloc] init];
    prama.access_token = [ZXAccountTool accout].access_token;
    prama.uid = [ZXAccountTool accout].uid;
    
    //请求未读数据
    [ZXHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:prama.keyValues success:^(id responseObject) {
        //字典转模型
        ZXUserResult *result = [ZXUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)userInfoWithSuccess:(void (^)(ZXUser *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    ZXUserPrama *prama = [[ZXUserPrama alloc] init];
    prama.access_token = [ZXAccountTool accout].access_token;
    prama.uid = [ZXAccountTool accout].uid;
    
    [ZXHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:prama.keyValues success:^(id responseObject) {
        //字典转模型
        ZXUser *user = [ZXUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end

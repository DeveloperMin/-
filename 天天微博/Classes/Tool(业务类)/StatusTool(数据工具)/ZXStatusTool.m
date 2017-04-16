//
//  ZXStatusTool.m
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatusTool.h"

#import "ZXStatus.h"
#import "ZXHttpTool.h"
#import "ZXAccountTool.h"
#import "ZXAccount.h"

#import "ZXStatusResult.h"
#import "ZXStatusPrama.h"
#import "ZXStatusCacheTool.h"

#import "MJExtension.h"

@implementation ZXStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    ZXStatusPrama *param = [[ZXStatusPrama alloc] init];
    param.access_token = [ZXAccountTool accout].access_token;
    if(sinceId)
    {
        param.since_id = sinceId;
    }
    
    //先从数据库中取数据
    NSArray *status = [ZXStatusCacheTool statusWithParam:param];
    if (status.count) {
        if (success) {
            
            success(status);
            return;
        }
    }
    
    
    
    //获取网络数据
    [ZXHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        //json转模型
//        NSArray *dictArray = responseObject[@"statuses"];
//        
//        NSArray *status= [ZXStatus  objectArrayWithKeyValuesArray:dictArray];
        //转化成ZXStatusResult模型
        ZXStatusResult *result = [ZXStatusResult objectWithKeyValues:responseObject];
        //如果有值,把值传出去
        if (success) {
            success(result.statuses);
        }
        
        //有新的数据就保存到数据库
        //一定要保存最原始的数据
        [ZXStatusCacheTool saveCacheWithStatus: responseObject[@"statuses"]];
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

+ (void)moreStatusWithSinceId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    ZXStatusPrama *params = [[ZXStatusPrama alloc] init];
    params.access_token = [ZXAccountTool accout].access_token;
    
    if(maxId)
    {
        params.max_id = maxId;
    }
    
    //先从数据库中取数据
    NSArray *status = [ZXStatusCacheTool statusWithParam:params];
    if (status.count) {
        if (success) {
            success(status);
            return;
        }
    }

    //获取网络数据
    [ZXHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        
        //json转模型
//        NSArray *dictArray = responseObject[@"statuses"];
//        
//        NSArray *status= [ZXStatus objectArrayWithKeyValuesArray:dictArray];
        //转化成ZXStatusResult模型
        ZXStatusResult *result = [ZXStatusResult objectWithKeyValues:responseObject];
        //如果有值,把值传出去
        if (success) {
            success(result.statuses);
        }
        
        [ZXStatusCacheTool saveCacheWithStatus: responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
@end

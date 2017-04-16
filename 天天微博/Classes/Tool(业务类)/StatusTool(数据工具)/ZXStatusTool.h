//
//  ZXStatusTool.h
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface ZXStatusTool : NSObject
/**
 *  请求更新的数据
 *
 *  @param singceId 返回比这个更大的微博数据
 *  @param success  请求成功后调用这个方法
 *  @param failure  请求失败调用该方法
 */
+ (void)newStatusWithSinceId:(NSString *)singceId success:(void (^)(NSArray *status))success failure:(void (^)(NSError * error))failure;
/**
 *  请求更多的数据
 *
 *  @param maxId   返回比这个更小的数据
 *  @param success 请求成功后调用这个方法
 *  @param failure 请求失败调用该方法
 */
+ (void)moreStatusWithSinceId:(NSString *)maxId success:(void (^)(NSArray *status))success failure:(void (^)(NSError * error))failure;

@end

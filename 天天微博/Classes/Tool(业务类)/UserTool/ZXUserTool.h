//
//  ZXUserTool.h
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//  

#import <Foundation/Foundation.h>
@class ZXUserResult, ZXUser;

@interface ZXUserTool : NSObject
/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unReadWithSuccess:(void(^)(ZXUserResult *result))success failure:(void(^)(NSError *error))failure;
/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(ZXUser *user))success failure:(void(^)(NSError *error))failure;
@end

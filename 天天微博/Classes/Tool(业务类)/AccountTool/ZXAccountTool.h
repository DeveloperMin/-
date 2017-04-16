//
//  ZXAccountTool.h
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXAccount;

@interface ZXAccountTool : NSObject
//存储账户
+ (void)saveAccount:(ZXAccount *)account;
//获取账户
+ (ZXAccount *)accout;
//获取accesstoken
+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)())failure;
@end

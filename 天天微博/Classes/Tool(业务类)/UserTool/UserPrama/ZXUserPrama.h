//
//  ZXUserPrama.h
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//  基本参数模型

#import <Foundation/Foundation.h>


@interface ZXUserPrama : NSObject

/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  需要获取消息未读数的用户UID，必须是当前登录用户。
 */
@property (nonatomic, copy) NSString *uid;

@end

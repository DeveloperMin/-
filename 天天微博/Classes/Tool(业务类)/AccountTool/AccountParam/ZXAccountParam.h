//
//  ZXAccountParam.h
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 */
@interface ZXAccountParam : NSObject
/**
 *  申请应用时分配的AppKey。
 */
@property (nonatomic, copy) NSString *client_id;
/**
 *  申请应用时分配的AppSecret。
 */
@property (nonatomic, copy) NSString *client_secret;
/**
 *  填写authorization_code
 */
@property (nonatomic, copy) NSString *grant_type;
/**
 *  调用authorize获得的code值
 */
@property (nonatomic, copy) NSString *code;
/**
 *  回调地址，需需与注册应用里的回调地址一致。
 */
@property (nonatomic, copy) NSString *redirect_uri;
@end

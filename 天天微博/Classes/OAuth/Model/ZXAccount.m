//
//  ZXAccount.m
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXAccount.h"

#import "MJExtension.h"

#define ZXAccess_tokenKey  @"access_token"
#define ZXExpires_inKey    @"expires_in"
#define ZXRemind_inKey     @"remind_in"
#define ZXUid_inKey        @"uid"
#define ZXExpires_dateKey  @"expires_date"
#define ZXName_inKey       @"name"

@implementation ZXAccount
//可以用MJExtension
#pragma mark - MJCodingImplementation代理后面的归档和解档

+ (instancetype)accoutWithDictionary:(NSDictionary *)dict;
{
    ZXAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dict];
    
 
    return account;
}
//归档的时候会调用
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:ZXAccess_tokenKey];
    [enCoder encodeObject:self.expires_in forKey:ZXExpires_inKey];
    [enCoder encodeObject:self.remind_in forKey:ZXRemind_inKey];
    [enCoder encodeObject:self.uid forKey:ZXUid_inKey];
    [enCoder encodeObject:self.expires_date forKey:ZXExpires_dateKey];
    [enCoder encodeObject:self.name forKey:ZXName_inKey];
}
//解档的时候会调用
- (instancetype)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        self.access_token = [Decoder decodeObjectForKey:ZXAccess_tokenKey];
        self.remind_in = [Decoder decodeObjectForKey:ZXRemind_inKey];
        self.uid = [Decoder decodeObjectForKey:ZXUid_inKey];
        self.expires_in = [Decoder decodeObjectForKey:ZXExpires_inKey];
        self.expires_date = [Decoder decodeObjectForKey:ZXExpires_dateKey];
    }
    return self;
}


- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    //计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[_expires_in longLongValue]];
}
@end

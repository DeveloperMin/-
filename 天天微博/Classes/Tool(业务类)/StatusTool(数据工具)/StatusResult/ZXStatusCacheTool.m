//
//  ZXStatusCacheTool.m
//  天天微博
//
//  Created by zxopen06 on 15/11/2.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatusCacheTool.h"
#import "FMDB.h"
#import "ZXAccountTool.h"
#import "ZXAccount.h"
#import "ZXStatusPrama.h"
#import "ZXStatus.h"

@implementation ZXStatusCacheTool

static FMDatabase *_db;

+ (void)initialize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"status.sqlite"];
    //创建一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    //打开数据库
    if([_db open])
    {
        NSLog(@"打开成功");
    }else
    {
        NSLog(@"打开失败");
    }
    //创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, idstr next, access_token text, dict blob);"];
    if (flag) {
        NSLog(@"创建成功");
    }else
    {
        NSLog(@"创建失败");
    }
}

+ (void)saveCacheWithStatus:(NSArray *)statuses
{
    for (NSDictionary *dict in statuses) {
        
        NSString *idstr = dict[@"idstr"];
        NSString *access_token = [ZXAccountTool accout].access_token;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        BOOL flag = [_db executeUpdate:@"insert into t_status (idstr,access_token, dict) values (?,?,?);", idstr, access_token, data];
        if (flag) {
            NSLog(@"插入成功");
        }else
        {
            NSLog( @"插入失败");
        }
    }
}

+ (NSArray *)statusWithParam:(ZXStatusPrama *)param
{
    //第一次进入程序的时候
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;", param.access_token];
    if (param.since_id) { //获取最新数据
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;",param.access_token, param.since_id];
    }else if(param.max_id)
    {//获取更多的数据
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;",param.access_token, param.max_id];
    }
    NSMutableArray *arrM = [NSMutableArray array];
    
    FMResultSet *set = [_db executeQuery:sql];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        ZXStatus *status = [ZXStatus objectWithKeyValues:dict];
        
        [arrM addObject:status];
    }
    return arrM;
}

@end

//
//  ZXUserResult.m
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXUserResult.h"



@implementation ZXUserResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}
- (int)unReadCount
{
   return  self.messageCount + _status + _follower;
}
@end

//
//  ZXStatus.m
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatus.h"
#import "ZXPhoto.h"

#import "NSDate+MJ.h"

@implementation ZXStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[ZXPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [format dateFromString:_created_at];
    
    //时间本地化
    format.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    if ([created_at isThisYear]) { //今年
        
        if([created_at isToday])
        {
            NSDateComponents *cmp = [created_at deltaWithNow];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前", cmp.hour];
            }else if(cmp.minute >1)
            {
                return [NSString stringWithFormat:@"%ld分钟之前", cmp.minute];
            }else
            {
                return @"刚刚";
            }
        }else if ([created_at isYesterday])//昨天
        {
            format.dateFormat = @"昨天 HH:mm";
            return [format stringFromDate:created_at];
        }else //前天
        {
            format.dateFormat = @"MM-dd HH:mm";
            return  [format stringFromDate:created_at];
        }
    }else  //不是今年
    {
        format.dateFormat = @"yyyy-MM-dd HH:mm";
        return [format stringFromDate:created_at];
    }
    
    return _created_at;
}
- (void)setSource:(NSString *)source
{
    //<a href="http://app.weibo.com/t/feed/cm2BN" rel="nofollow">王子部落APP</a>
    source = @">王子部落APP</a>";
    //截取字符串
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.length + range.location];
    
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    
    source = [NSString stringWithFormat:@"来自%@", source];

    _source = source;
}
- (void)setRetweeted_status:(ZXStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweetName = [NSString stringWithFormat:@"@%@", retweeted_status.user.name];
}
@end

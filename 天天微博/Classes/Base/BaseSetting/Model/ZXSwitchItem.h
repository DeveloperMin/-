//
//  ZXSwitchItem.h
//  天天微博
//
//  Created by zxopen06 on 15/10/31.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXSettingItem.h"

@interface ZXSwitchItem : ZXSettingItem
/**
 * 描述开关状态
 */
@property (nonatomic, assign, getter=isSwitchOn) BOOL switchOn;

@end

//
//  ZXTextToolBar.h
//  天天微博
//
//  Created by zxopen06 on 15/10/26.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXTextToolBar;

@protocol  ZXTextToolBarDelegate<NSObject>

@optional

- (void)composeToolBar:(ZXTextToolBar *)toolBar didClickBtn:(NSUInteger)index;

@end
@interface ZXTextToolBar : UIView

@property (nonatomic, weak) id<ZXTextToolBarDelegate> delegate;
@end

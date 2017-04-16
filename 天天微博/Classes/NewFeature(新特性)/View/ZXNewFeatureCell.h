//
//  ZXNewFeatureCell.h
//  天天微博
//
//  Created by zxopen06 on 15/10/20.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end

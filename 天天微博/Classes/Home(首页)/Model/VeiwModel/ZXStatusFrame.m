//
//  ZXStatusFrame.m
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatusFrame.h"
#import "ZXStatus.h"
#import "ZXUser.h"



@implementation ZXStatusFrame

- (void)setStatus:(ZXStatus *)status
{
    _status = status;
   
   
    //计算原创微博的frame
    [self setUpOriginalFrame];
    
    CGFloat toolBarY = toolBarY = CGRectGetMaxY(self.originalViewFrame);
    //计算转发微博的frame
    if (status.retweeted_status) {
        
        [self setUpRetWeetFrame];
        
        toolBarY = CGRectGetMaxY(self.retWeetViewFrame);
    }
 
    //计算工具条的frame
    CGFloat toolBarX = 0;
    CGFloat toolBarW = ZXScreenW;
    CGFloat toolBarH = 35;
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //计算cell的高度
    self.cellHight = CGRectGetMaxY(self.toolBarFrame);
}
#pragma mark - 计算原创微博的frame
- (void)setUpOriginalFrame
{
    //头像frame
    CGFloat iconX = ZXStatusCellMargin;
    CGFloat iconY = iconX;
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    self.originalIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称frame
    CGFloat nameX = CGRectGetMaxX(self.originalIconFrame)+ZXStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [_status.user.name sizeWithFont:ZXStatusNameFront];
    self.originalNameFrame =(CGRect){{nameX, nameY}, nameSize};
    
    //VIPframe
    if (self.status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(self.originalNameFrame) + ZXStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        self.originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    //时间的frame
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.originalNameFrame) + 5;
//    CGSize timeSize = [self.status.created_at sizeWithFont:ZXStatusTimeFront];
//    self.originalTimeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    //来源的frame
//    CGFloat sourceX = CGRectGetMaxX(self.originalTimeFrame) + ZXStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [self.status.source sizeWithFont:ZXSourceFront];
//    self.originalSourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //正文的frame
    CGFloat textX = ZXStatusCellMargin;
    CGFloat textY = CGRectGetMaxY(self.originalIconFrame) + ZXStatusCellMargin;
    CGFloat textW = ZXScreenW - 2 * ZXStatusCellMargin;
    CGSize textSize = [self.status.text sizeWithFont:ZXStatusTextFront constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    self.originalTextFrame =  (CGRect){{textX, textY}, textSize};
    
    CGFloat originalViewH = CGRectGetMaxY(self.originalTextFrame) + ZXStatusCellMargin;
    //计算配图的frame
    int count = _status.pic_urls.count;
    if (count) {
        CGFloat photosX = ZXStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(self.originalTextFrame) + ZXStatusCellMargin;
        CGSize photoSize = [self photoSizeWithCount:count];
        self.originalPhotoFrame = (CGRect){{photosX, photosY}, photoSize};
        originalViewH = CGRectGetMaxY(self.originalPhotoFrame) + ZXStatusCellMargin;
    }
    
    //计算原创微博的frame
    CGFloat originalViewX = 0;
    CGFloat originalViewY = 10;
    CGFloat originalViewW = ZXScreenW;
    self.originalViewFrame = CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
    
}
#pragma mark - 计算转发微博的frame
- (void)setUpRetWeetFrame
{
    //计算昵称的frame
    CGFloat nameX = ZXStatusCellMargin;
    CGFloat nameY = nameX;
    CGSize nameSize = [self.status.retweetName sizeWithFont:ZXStatusTextFront];
    self.retWeetNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //计算正文的frame
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.retWeetNameFrame) + ZXStatusCellMargin;
    CGFloat textW = ZXScreenW - 2*ZXStatusCellMargin;
    CGSize textSize = [self.status.retweeted_status.text sizeWithFont:ZXStatusTextFront constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    self.retWeetTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat reweetH = CGRectGetMaxY(self.retWeetTextFrame) +ZXStatusCellMargin;
    //计算配图的frame
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = ZXStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(self.retWeetTextFrame) + ZXStatusCellMargin;
        CGSize photoSize = [self photoSizeWithCount:count];
        self.retWeetPhotoFrame = (CGRect){{photosX, photosY}, photoSize};
        reweetH = CGRectGetMaxY(self.retWeetPhotoFrame);
    }

    //计算转发微博的frame
    CGFloat reweetX = 0;
    CGFloat reweetY = CGRectGetMaxY(self.originalViewFrame);
    CGFloat reweetW = ZXScreenW;
    self.retWeetViewFrame = CGRectMake(reweetX, reweetY, reweetW, reweetH);

}


- (CGSize)photoSizeWithCount:(int)count
{
    //总列数
    int cols = count == 4 ? 2:3;
    //总行数
    int rols = (count-1)/cols + 1;
    
    CGFloat photoWH = 70;
    
    CGFloat photoW = cols * photoWH + (cols - 1) *ZXStatusCellMargin;
    CGFloat photoH=  rols * photoWH + (rols - 1) *ZXStatusCellMargin;
    
    return CGSizeMake(photoW, photoH);
}

@end

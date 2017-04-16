//
//  ZXPhotosView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/25.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXPhotosView.h"

#import "ZXPhoto.h"
#import "UIImageView+WebCache.h"

#import "ZXPhotoView.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation ZXPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpAllChild];
    }
    return self;
}
- (void)setUpAllChild
{
    for (int i = 0 ; i < 9; i++) {
        ZXPhotoView *imageV = [[ZXPhotoView alloc] init];
        
        imageV.tag = i;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        //添加九个子控件
        [self addSubview:imageV];
    }
}
- (void)tap:(UIGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    //ZXPhoto->MJPhoto
    int i= 0;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (ZXPhoto *photo in self.pic_urls) {
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:urlStr];
        mjphoto.index = i;
        mjphoto.srcImageView = tapView;
        [tempArray addObject:mjphoto];
        i++;
    }
    //创建图片浏览器对象
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    //MJPhoto
    browser.photos = tempArray;
    browser.currentPhotoIndex = tapView.tag;
    
    [browser show];
    
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int count = self.subviews.count;
    
    for (int i = 0; i < count; i++) {
        
        ZXPhotoView *imageV = self.subviews[i];
        
        if (i < pic_urls.count) { //显示
            imageV.hidden = NO;
            
            //获取photo模型
            ZXPhoto *photo = _pic_urls[i];
            
            imageV.photo = photo;
            
        }else
        {
            imageV.hidden = YES;
        }
    }
}
//计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    
    //列数
    int col = 0;
    //行数
    int rol = 0;
    int cols = _pic_urls.count == 4? 2:3;

    for (int i  = 0; i < self.pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *image = self.subviews[i];
        x = (w + margin) * col;
        y = (h + margin) * rol;
        image.frame = CGRectMake(x, y, w, h);
    }
}

@end

//
//  ZXStatusCell.m
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatusCell.h"
#import "ZXOriginalView.h"
#import "ZXRetWeetView.h"
#import "ZXStatusToolBar.h"

#import "ZXStatus.h"
#import "ZXStatusFrame.h"

@interface ZXStatusCell ()

@property (nonatomic, weak) ZXOriginalView *originalView;
@property (nonatomic, weak) ZXRetWeetView *retWeetView;
@property (nonatomic, weak) ZXStatusToolBar *toolBarView;

@end
@implementation ZXStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加所有子控件
        [self setUpAllChild];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setUpAllChild
{
    //添加原创微博控件
    ZXOriginalView *originalView = [[ZXOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
    
    //添加转发微博控件
    ZXRetWeetView *retWeetView = [[ZXRetWeetView alloc] init];
    [self addSubview:retWeetView];
    self.retWeetView = retWeetView;
    
    //添加工具条
    ZXStatusToolBar *toolBarView = [[ZXStatusToolBar alloc] init];
    [self addSubview:toolBarView];
    self.toolBarView = toolBarView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    ZXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (void)setStatusFrame:(ZXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //设置原创微博的frame
    self.originalView.frame = statusFrame.originalViewFrame;
    self.originalView.statusFrame = statusFrame;
    
    //设置转发微博的frame
    if (statusFrame.status.retweeted_status) {
        
        // 设置转发微博frame
        self.retWeetView.frame = statusFrame.retWeetViewFrame;
        self.retWeetView.statusFrame = statusFrame;
        self.retWeetView.hidden = NO;
    }else{
        self.retWeetView.hidden = YES;
    }
  
    
    //设置工具条的frame
    self.toolBarView.frame = statusFrame.toolBarFrame;
    self.toolBarView.status = statusFrame.status;
}

@end

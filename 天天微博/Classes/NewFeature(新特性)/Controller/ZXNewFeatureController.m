//
//  ZXNewFeatureController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/20.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXNewFeatureController.h"
#import "ZXNewFeatureCell.h"

@interface ZXNewFeatureController ()

@property (nonatomic, strong) UIPageControl *control;

@end
static NSString *ID = @"cell";

@implementation ZXNewFeatureController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 在tableview和collectionView中self.view != self.collectionView
    self.collectionView.backgroundColor = [UIColor redColor];
    
    //设置分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    //取消滑动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //注册cell
    [self.collectionView registerClass:[ZXNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    //设置pageController
    [self setUpPageController];
    
}
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    //设置cell间的间距
    layout.minimumLineSpacing = 0;
    //设置cell滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}
//设置pageController
- (void)setUpPageController
{
    UIPageControl *control = [[UIPageControl alloc] init];
    
    //设置页数
    control.numberOfPages = 4;
    //颜色
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    //设置center
    control.center = CGPointMake(self.view.width *0.5, self.view.height - 20);
    self.control = control;
    
    [self.view addSubview:control];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}

#pragma mark- collectionController的代理方法和数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    ZXNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];

    
    UIImage *image = [UIImage imageNamed:imageName];
    //设置cell
    cell.image = image;
   
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

@end

//
//  ZXHomeViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//  code=04089eccb9b65875c2f3b2f809a3e95a


#import "ZXHomeViewController.h"

#import "UIBarButtonItem+ZXBarButtonItem.h"
#import "ZXTitleButton.h"
#import "ZXCover.h"
#import "ZXPopMenu.h"
#import "ZXTitleTableViewController.h"
#import "ZXOneViewController.h"
#import "ZXAccountTool.h"
#import "ZXAccount.h"

#import "ZXStatusFrame.h"
#import "ZXStatus.h"
#import "ZXStatusTool.h"
#import "ZXUserTool.h"

#import "ZXStatusCell.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface ZXHomeViewController ()<ZXCoverDelegate>

@property (nonatomic, weak) ZXTitleButton *titleButton;
@property (nonatomic, strong) ZXTitleTableViewController *titleVc;
/**
 *  存放数据
 */
@property (nonatomic, strong) NSMutableArray *statuesFrames;
@end

@implementation ZXHomeViewController


- (NSMutableArray *)statuesFrames
{
    if (_statuesFrames == nil) {
        _statuesFrames = [NSMutableArray array];
    }
    return _statuesFrames;
}


- (ZXTitleTableViewController *)titleVc
{
    if (_titleVc == nil) {
        _titleVc = [[ZXTitleTableViewController alloc] init];
    }
    return _titleVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    /**
     *  取消分割线
     */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /**
     *  设置导航条内容
     */
    [self setUpNavagationBar];
    
//    [self loadNewStatus];
    
    //添加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    //添加上拉加载
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    //请求当前用户的昵称
    [ZXUserTool userInfoWithSuccess:^(ZXUser *user) {
        //显示数据
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //获取当前用户
        ZXAccount *account = [ZXAccountTool accout];
        account.name = user.name;
        
        //保存账号
        [ZXAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)loadMoreStatus
{
    NSString *maxId = nil;
    if (self.statuesFrames.count) { //有微博数据,才需要上拉加载
        ZXStatus *status = [[self.statuesFrames lastObject] status];
        long long index = [status.idstr longLongValue] - 1;
        
        maxId= [NSString stringWithFormat:@"%lld",index];
    }
    /**
     *  请求更多的数据
     */
    [ZXStatusTool moreStatusWithSinceId:maxId success:^(NSArray *status) {
        
        //结束上拉加载
        [self.tableView footerEndRefreshing];
        
        //在顶部插入新的数据
        //一个一个遍历加进原来的数组中
        //把模型从ZXStatus->ZXStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (ZXStatus *aStatus in status) {
            ZXStatusFrame *statusFrame = [[ZXStatusFrame alloc] init];
            statusFrame.status = aStatus;
            
            [statusFrames addObject:statusFrame];
        }
        [self.statuesFrames addObjectsFromArray:statusFrames];
        
        
        //刷新表格
        [self.tableView reloadData];
      
    } failure:^(NSError *error) {
          NSLog(@"%@", error);
    }];
    
}
#pragma mark更新数据
- (void)refresh
{
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
}

- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statuesFrames.count) { //有微博数据,才需要下拉刷新
        ZXStatus *status = [self.statuesFrames[0] status];
        sinceId = status.idstr;
    }
    //请求最新的数据
    [ZXStatusTool newStatusWithSinceId:sinceId success:^(NSArray *status) {
        
        //把模型从ZXStatus->ZXStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (ZXStatus *aStatus in status) {
            ZXStatusFrame *statusFrame = [[ZXStatusFrame alloc] init];
            statusFrame.status = aStatus;
            
            [statusFrames addObject:statusFrame];
        }
        
        //展示微博数
        [self showNewStatusCount:statusFrames.count];
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        //在顶部插入新的数据
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusFrames.count)];
        [self.statuesFrames insertObjects:statusFrames atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
         NSLog(@"%@", error);
    }];
    
//    //创建管理者
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    //获取数据
//    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //结束下拉刷新
//        [self.tableView headerEndRefreshing];
//        
//        //json转模型
//        NSArray *dictArray = responseObject[@"statuses"];
//        
//        NSArray *dataArray = [ZXStatus objectArrayWithKeyValuesArray:dictArray];
//        
//        //在顶部插入新的数据
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, dataArray.count)];
//        [self.statues insertObjects:dataArray atIndexes:indexSet];
//        
//        //刷新表格
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}
#pragma mark显示微博数
- (void)showNewStatusCount:(NSInteger)count
{
    if(count == 0) return;
    
    CGFloat labelH = 35;
    CGFloat labelY = CGRectGetMaxY(self.navigationController.navigationBar.frame) - labelH;
    CGFloat labelX = 0;
    CGFloat labelW = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    label.text = [NSString stringWithFormat:@"最新微博数%ld条", count];
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    //插入导航控制器的导航栏下
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //向下平移动画
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, labelH);
    } completion:^(BOOL finished) {
        //向上平移动画
        [UIView animateWithDuration:0.25 delay:1.0 options:UIViewAnimationOptionCurveLinear  animations:^{
            //还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
#pragma mark设置导航条内容
- (void)setUpNavagationBar
{
    /**
     *  设置导航栏左边按钮
     */
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtoonWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] hImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    /**
     *  设置导航栏右边按钮
     */
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtoonWithImage:[UIImage imageNamed:@"navigationbar_pop"] hImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    /**
     *  设置titleView
     */
    ZXTitleButton *titleButton = [ZXTitleButton buttonWithType:UIButtonTypeCustom];
//    titleButton.frame = self.navigationItem.titleView.bounds;
    
    self.titleButton = titleButton;
    
    //设置首页标题
    NSString *title = [ZXAccountTool accout].name?:@"首页";
    
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    //高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

- (void)titleClick:(UIButton *)button {
    button.selected = !button.selected;
    
    //弹出蒙板
    ZXCover *cover = [ZXCover show];
    cover.delegate = self;
    
    //弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200)*0.5;
    CGFloat popY = 55;
    CGFloat popH = popW;
    ZXPopMenu *menu = [ZXPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.titleVc.view;
    
}
- (void)friendSearch
{
    
}
- (void)pop
{
    ZXOneViewController *one = [[ZXOneViewController alloc] init];
    
    [self.navigationController pushViewController:one animated:YES];
}
- (void)coverDidClickCover:(ZXCover *)cover
{
  //隐藏pop菜单
    [ZXPopMenu hide];
    
    self.titleButton.selected = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statuesFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //cell模型
    ZXStatusCell *cell = [ZXStatusCell cellWithTableView:tableView];
    
    //获取模型
    ZXStatusFrame *statusFrame = self.statuesFrames[indexPath.row];
    
    //赋值
    cell.statusFrame = statusFrame;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXStatusFrame *statusFrame = self.statuesFrames[indexPath.row];
    return statusFrame.cellHight;
}



@end

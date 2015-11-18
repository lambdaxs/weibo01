//
//  XSHomeController.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSHomeController.h"
#import "XSContentController.h"

#import "XSHomeCell.h"
#import "XSHomeStatus.h"
#import "XSHomeStatusFrame.h"

#import "SDImageCache.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "MBProgressHUD+Extend.h"

#import "XSNetTool.h"

typedef NS_ENUM(NSInteger,updateType) {
    updateTypeNew,
    updateTypeOld
};

@interface XSHomeController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation XSHomeController{
    NSInteger _cleanCacheTime;   ///< 清除图片缓存周期
}

#pragma mark - 生命周期
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
//    XSLog(@"warning");
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpNavi];
    [self setUpTableView];
    [self setUpAutoLayout];
}

#pragma mark - 事件响应和监听
#pragma mark 加载最新微博
- (void)loadNewStatus
{
    NSString *sinceId = @"0";
    if (self.statusFrames.count) {
        sinceId = [[[self.statusFrames firstObject] status] idstr];
    }
    WS;
    [XSNetTool netHomeGetNewStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        [weakSelf.tableView headerEndRefreshing];
        if (statuses)
        {
            [weakSelf updateDataArray:statuses withType:updateTypeNew];
        /** 显示更新动画 */
            [weakSelf showNotificationViewWithCount:statuses.count];
        }
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
        [weakSelf.tableView headerEndRefreshing];
        [MBProgressHUD showError:@"加载失败"];
    }];
}
#pragma mark 加载更多微博
- (void)loadMoreStatus
{
    WS;
    NSString *maxId = @"0";
    if (self.statusFrames.count)
    {
        maxId = [[[self.statusFrames lastObject] status] idstr];
        NSInteger maxIdNum = [maxId integerValue] - 1;
        maxId = [NSString stringWithFormat:@"%ld",(long)maxIdNum];
    }
    [XSNetTool netHomeGetOldStatusWithMaxId:maxId success:^(NSArray *statuses) {
        [weakSelf.tableView footerEndRefreshing];
        if (statuses)
        {
            [weakSelf updateDataArray:statuses withType:updateTypeOld];
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView footerEndRefreshing];
        [MBProgressHUD showError:@"加载失败"];
    }];
}

#pragma mark - 私有方法
#pragma mark 显示更新微博数量动画
- (void)showNotificationViewWithCount:(NSUInteger)count
{
    XSLog(@"更新动画");
}

- (void)updateDataArray:(NSArray *)statuses withType:(updateType)type
{
    WS;
    NSMutableArray *tempArray = [NSMutableArray array];
    [statuses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XSHomeStatusFrame *statusFrame = [XSHomeStatusFrame new];
        statusFrame.status = obj;
        [tempArray addObject:statusFrame];
    }];
    if (type == updateTypeNew)
    {
        [weakSelf.statusFrames prependObjects:tempArray];
    }
    else if (type == updateTypeOld)
    {
        [weakSelf.statusFrames addObjectsFromArray:tempArray];
    }
    [weakSelf.tableView reloadData];
}

#pragma mark - 实现代理
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count ? self.statusFrames.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrames[indexPath.row] cellHeight];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSLog(@"%ld",(long)indexPath.row);
    XSContentController *vc = [XSContentController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{/** 每循环20个cell就对图片内存清理 */
    _cleanCacheTime++;
    if (_cleanCacheTime % 20 == 0)
    {
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    }
}

#pragma mark - 设置子控件、通知
- (void)setUpNavi
{
    WS;
    UIBarButtonItem *left  = [[UIBarButtonItem alloc] init];
    [left setTitle:@"刷新"];
    left.actionBlock = ^(id sender){
        [weakSelf.tableView headerBeginRefreshing];
    };
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    [right setTitle:@"发微博"];
    right.actionBlock = ^(id sender){
        XSLog(@"right");
    };
    
    UIButton *titleButton = [[UIButton alloc] init];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [titleButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf.tableView headerBeginRefreshing];
    }];
    
    self.navigationItem.leftBarButtonItem  = left;
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.titleView = titleButton;
}

-(void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[XSHomeCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    WS;
    [self.tableView addHeaderWithCallback:^{/** 添加下拉刷新 */
        [weakSelf loadNewStatus];
    }];
    [self.tableView addFooterWithCallback:^{/** 添加上拉加载更多 */
        [weakSelf loadMoreStatus];
    }];
}

#pragma mark - 自动布局
- (void)setUpAutoLayout
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
}

#pragma mark - Getter & Setter
- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {_statusFrames = [NSMutableArray array];}
    return _statusFrames;
}

@end

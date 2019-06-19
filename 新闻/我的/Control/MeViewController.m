//
//  MeViewController.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "MeViewController.h"
#import "SDImageCache.h"
#import "SettingHeaderView.h"

#import "SettingGroup.h"
#import "SettingCell.h"
#import "SettingArrowItem.h"

#import "PhotoAlbumListVC.h"
#import "ScanViewController.h"
#import "BNRItemsViewController.h"


@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic , strong) NSString *clearCacheName;

@property (nonatomic , strong) NSMutableArray *arrays;

@property (nonatomic , weak) UIView *headerview;
@property (nonatomic , weak) UITableView *tableview;

@end

@implementation MeViewController

- (NSMutableArray *)arrays
{
    if (!_arrays) {
        _arrays = [NSMutableArray array];
    }
    return _arrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    SettingHeaderView *headerview = [[SettingHeaderView alloc]init];
    self.headerview = headerview;

    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    tableview.tableHeaderView = headerview;
    self.tableview = tableview;
    
    [self setupGroup0];
}

- (void)setupGroup0
{
    SettingItem *info = [SettingArrowItem itemWithItem:@"selfInfo" title:@"个人信息" VcClass:[BNRItemsViewController class]];
    SettingItem *QRCode = [SettingArrowItem itemWithItem:@"QRCode" title:@"二维码扫描" VcClass:[ScanViewController class]];
    SettingItem *album = [SettingArrowItem itemWithItem:@"album" title:@"我的相册"
        VcClass:[PhotoAlbumListVC class]];

    SettingGroup *group0 = [[SettingGroup alloc]init];
    group0.items = @[info,QRCode,album];
    [self.arrays addObject:group0];
}

#pragma mark - tableview代理数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.arrays[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    SettingGroup *group = self.arrays[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SettingGroup *group = self.arrays[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.optionHandler) {
        item.optionHandler();
    }else if ([item isKindOfClass:[SettingArrowItem class]]) {
        SettingArrowItem *arrowItem = (SettingArrowItem *)item;
        if (arrowItem.VcClass == nil) return;
        UIViewController *vc = [[arrowItem.VcClass alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.title = arrowItem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 计算偏移量控制状态栏的颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat hey = CGRectGetMaxY(self.headerview.frame);
    if (y <= -30 || y >= hey-40) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableview.delegate = self;
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    self.arrays = nil;
    [self setupGroup0];
    [self.tableview reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableview.delegate = nil;
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

@end

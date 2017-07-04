//
//  MingRenTangWebViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MingRenTangWebViewController.h"
#import "TABaseTableView.h"

@interface MingRenTangWebViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TABaseTableView *tableView;
@end

@implementation MingRenTangWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (TABaseTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, -20, KTA_Screen_Width, KTA_Screen_Height) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
//        [self.view addSubview:self.tableView];
//        UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 300)];
//        _tableView.tableHeaderView = bigView;
        
//        TAWeakSelf(weakSelf)
        
        
//        [_tableView refreshHeaderRefresh:^{
//            [weakSelf loadData];
//        } withFooterRefreshingBlock:^{
//            [weakSelf loadData];
//        }];
        
    }
    return _tableView;
}
#pragma mark - UItableViewDelegateDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  TAHomePageViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAHomePageViewController.h"
#import "TABaseTableView.h"
#import "TARequestManager.h"

static NSString *identifier = @"CellID";

@interface TAHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)TABaseTableView *tableView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@end


@implementation TAHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"ddfdsfsdfdfdff");
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [self.view addSubview:self.tableView];
}

// 123
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"token":@"DYSkOX@YN10!"};
    
    [TARequestManager TARequestCompletedWithParameters:dic sucee:^(NSDictionary *dic) {
        // 解析数据
        
        
    } fail:^(NSError *error) {
        
    }];
    
 
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];

}




- (TABaseTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height-49) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        TAWeakSelf(weakSelf)
        
        
        [_tableView refreshHeaderRefresh:^{
            [weakSelf loadData];
        } withFooterRefreshingBlock:^{
            [weakSelf loadData];
        }];
        
    }
    
    return _tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
    
}

- (void)loadData {
    
    [self.dataSource removeAllObjects];
    
    for (int i = 0 ; i <self.tableView.page*5; i ++) {
        NSString *str  = [NSString stringWithFormat:@"%d",i+1];
        [self.dataSource addObject:str];
    }
    
    [self.tableView endReload];
    
}




@end

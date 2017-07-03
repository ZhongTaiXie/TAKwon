//
//  TANotsViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TANotsViewController.h"
#import "TABaseTableView.h"
#import "TANotsTableViewCell.h"

static NSString  *Identifier = @"CellID";

@interface TANotsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)TABaseTableView *notTableView;

@property (nonatomic , strong)NSMutableArray *dataSource;

@end

@implementation TANotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"消息";
    
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.notTableView];
}


- (TABaseTableView *)notTableView {
    
    if (_notTableView == nil) {
        _notTableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height-49)];
        _notTableView.dataSource = self;
        _notTableView.delegate = self;
        [_notTableView registerNib:[UINib nibWithNibName:@"TANotsTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    }
    return _notTableView;
}


#pragma mark TableViewDelegate  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TANotsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    return cell;
}



@end

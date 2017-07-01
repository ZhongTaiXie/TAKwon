//
//  TAMyCollectionViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/30.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMyCollectionViewController.h"
#import "TAOnePicCollcetionCell.h"
#import "TANoPicCollectionCell.h"
#import "TAThreePicCollectionCell.h"
#import "TAGongGaoCollectionCell.h"

@interface TAMyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation TAMyCollectionViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    
}

-(void)loadView{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height - 15)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAOnePicCollcetionCell" bundle:nil] forCellReuseIdentifier:@"onePicCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TANoPicCollectionCell" bundle:nil] forCellReuseIdentifier:@"noPicCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAThreePicCollectionCell" bundle:nil] forCellReuseIdentifier:@"threePicCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAGongGaoCollectionCell" bundle:nil] forCellReuseIdentifier:@"gonggaoCell"];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"我的收藏";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;//self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TAOnePicCollcetionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onePicCell" forIndexPath:indexPath];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        TANoPicCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noPicCell" forIndexPath:indexPath];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if (indexPath.row == 2){
        TAThreePicCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threePicCell" forIndexPath:indexPath];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        TAGongGaoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gonggaoCell" forIndexPath:indexPath];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 88;
    }else{
        tableView.rowHeight = UITableViewAutomaticDimension;
        //给一个预估高度
        tableView.estimatedRowHeight = 80;
        
        return UITableViewAutomaticDimension;
    }
    
}

@end

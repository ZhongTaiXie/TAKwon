//
//  PersonalMemberCenterViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/26.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAPersonalMemberCenterViewController.h"
#import "TAPersonalHeaderView.h"
#import "TAMemberInfoView.h"
#import "TAPersonalCell.h"
#import "TASeetingViewController.h"


@interface TAPersonalMemberCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TAPersonalHeaderView *headerView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) TAMemberInfoView *memberInfoView;
@end

@implementation TAPersonalMemberCenterViewController

-(TAPersonalHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[TAPersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 200)];
    }
    return _headerView;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@[],@[@"会员信息",@"活动记录"],@[@"会员荣誉",@"简历"],@[@"个人风采",@"比赛经历"],@[@"我的消息",@"我的收藏",],@[@"我的关注"],@[@"设置"]];
    }
    return _titleArray;
}

-(TAMemberInfoView *)memberInfoView{
    if (!_memberInfoView) {
        _memberInfoView = [[TAMemberInfoView alloc] initWithFrame:CGRectMake(0, 10, KTA_Screen_Width, 80)];
        _memberInfoView.memberGradeViewDidClick = ^(NSString *str){
            NSLog(@"memberGradeViewDidClick");
        };
        _memberInfoView.integrationViewDidClick = ^(NSString *str){
            NSLog(@"integrationViewDidClick");
        };
        
        _memberInfoView.QRCodeViewDidClick = ^(NSString *str){
            NSLog(@"QRCodeViewDidClick");
        };
    }
    return _memberInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAPersonalCell" bundle:nil] forCellReuseIdentifier:@"personCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 5 || section == 6) {
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.memberInfoView];
        
        return cell;
    }else{
        TAPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TAPersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personCell"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 10)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = self.titleArray[indexPath.section];
        NSString *tit = array[indexPath.row];
        cell.title = tit;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
    
    }else if (indexPath.section == 4){
        
    }else if (indexPath.section == 5){
        
    }else{
        TASeetingViewController *settingVC = [TASeetingViewController new];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 180;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        self.headerView.headerImageViewClick = ^(NSString *str){
            NSLog(@"=====%@",str);
        };
        self.headerView.bgImageViewDidClick = ^(NSString *str){
            NSLog(@"-----%@",str);
        };
        return self.headerView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 45;
}

@end

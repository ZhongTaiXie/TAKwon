//
//  TaekwondoMemberCenterViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/26.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekwondoMemberCenterViewController.h"
#import "TAPersonalHeaderView.h"
#import "TAMemberInfoView.h"
#import "TAPersonalCell.h"
#import "TASeetingViewController.h"
#import "TATaekwondoAuthViewController.h"
#import "TATaekwondoInfoViewController.h"
#import "TAMyCollectionViewController.h"
#import "TATaekHonorViewController.h"
#import "TAMyReleaseViewController.h"
#import "TAActivityRecordViewController.h"
#import "TAPersonalModel.h"

@interface TATaekwondoMemberCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TAPersonalHeaderView *headerView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) TAMemberInfoView *memberInfoView;
@property (nonatomic,strong) TAPersonalModel *personalModel;


@end

@implementation TATaekwondoMemberCenterViewController
//
//-(TAPersonalHeaderView *)headerView{
//    if (!_headerView) {
//        _headerView = [[TAPersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 200)];
//    }
//    return _headerView;
//}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@[],@[@"道馆信息",@"道馆认证"],@[@"我的发布",@"活动记录"],@[@"道馆荣誉"],@[@"我的消息",@"我的收藏",],@[@"我的关注"],@[@"设置"]];
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
    
    
    [self getUserInfoFromServer];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setupTableView{
    
    self.headerView = [[TAPersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 200) model:self.personalModel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAPersonalCell" bundle:nil] forCellReuseIdentifier:@"personCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}


#pragma mark - 网络交互
-(void)getUserInfoFromServer{
    
    NSDictionary *params = @{
                             @"userID":UserID
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/MemberCenter"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        
        if (dic[@"Data"][@"Success"]) {
            self.personalModel = [WQManageData getPersonalModel:dic[@"Data"][@"Data"]];
            self.headerView = [[TAPersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 200) model:self.personalModel];
            [self.tableView reloadData];
            
        }else{
            [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];

}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 3 || section == 5 || section == 6) {
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
        if (indexPath.row == 0) { //道馆信息
            TATaekwondoInfoViewController *infoVC = [TATaekwondoInfoViewController new];
            [self.navigationController pushViewController:infoVC animated:YES];
        }else{//道馆认证
            TATaekwondoAuthViewController *authVC = [TATaekwondoAuthViewController new];
            [self.navigationController pushViewController:authVC animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {  //我的发布
            TAMyReleaseViewController *releaseVC = [TAMyReleaseViewController new];
            [self.navigationController pushViewController:releaseVC animated:YES];

        }else{ //活动记录
            TAActivityRecordViewController *recordVC = [TAActivityRecordViewController new];
            [self.navigationController pushViewController:recordVC animated:YES];
        }
    }else if (indexPath.section == 3){   //道馆荣誉
        TATaekHonorViewController *honorVC = [TATaekHonorViewController new];
        [self.navigationController pushViewController:honorVC animated:YES];
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {   //我的消息
            
        }else{ //我的收藏
            TAMyCollectionViewController *collectionVC = [TAMyCollectionViewController new];
            [self.navigationController pushViewController:collectionVC animated:YES];
        }
    }else if (indexPath.section == 5){  //我的关注
        
    }else{//设置
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
    return 40;
}



@end

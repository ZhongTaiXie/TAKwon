//
//  TAMemberInfoViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMemberInfoViewController.h"
#import "TAMemberIconCell.h"
#import "TAMemberInfoCell.h"
#import "TAEditMemberInfoViewController.h"
#import "TAZhiYeRenZhengViewController.h"
#import "TAUploadMemHonorViewController.h"

@interface TAMemberInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation TAMemberInfoViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@[@"",@"昵称"],@[@"身份证号码",@"手机号",@"邮箱",@"职业认证"]]; //,@[@"会员荣誉"]
    }
    return _titleArray;
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMemberIconCell" bundle:nil] forCellReuseIdentifier:@"iconCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMemberInfoCell" bundle:nil] forCellReuseIdentifier:@"infoCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"会员信息";
    
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
    return 2;//3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{  // if (section == 1)
        return 4;
    }
//    } else{
//        return 1;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *sectionArray = self.titleArray[indexPath.section];
    NSString *title = sectionArray[indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        TAMemberIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iconCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TAMemberIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iconCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        return cell;
    }
//    else if(indexPath.section == 2){ //会员荣誉
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.text = @"会员荣誉";
//        cell.textLabel.font = [UIFont systemFontOfSize:15];
//        cell.textLabel.textColor = [WQTools colorWithHexString:@"333333"];
//
//        return cell;
//    }
    else{
        TAMemberInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TAMemberInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"infoCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = title;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            //上传头像
        }else if (indexPath.row == 1){  //修改昵称
            TAEditMemberInfoViewController *editVC = [[TAEditMemberInfoViewController alloc] initWithNavTitle:@"昵称" text:@"" index:0];
            [self.navigationController pushViewController:editVC animated:YES];
        }
    }else{  // if (indexPath.section == 1)
        if (indexPath.row == 0) {//修改身份证号码
            TAEditMemberInfoViewController *editVC = [[TAEditMemberInfoViewController alloc] initWithNavTitle:@"身份证号码" text:@"" index:1];
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (indexPath.row == 1){ //修改手机号
            TAEditMemberInfoViewController *editVC = [[TAEditMemberInfoViewController alloc] initWithNavTitle:@"手机号" text:@"" index:2];
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (indexPath.row == 2){  //修改邮箱
            TAEditMemberInfoViewController *editVC = [[TAEditMemberInfoViewController alloc] initWithNavTitle:@"邮箱" text:@"" index:3];
            [self.navigationController pushViewController:editVC animated:YES];
        }else{  //职业认证
            TAZhiYeRenZhengViewController *renzhengVC = [TAZhiYeRenZhengViewController new];
            [self.navigationController pushViewController:renzhengVC animated:YES];
        }
    }
//    else{//会员荣誉
//        TAUploadMemHonorViewController *uploadVC = [TAUploadMemHonorViewController new];
//        [self.navigationController pushViewController:uploadVC animated:YES];
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    return 45;
}

@end

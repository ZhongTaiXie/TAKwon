//
//  TAMyReleaseViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAMyReleaseViewController.h"
#import "TAMyReleaseTitleCell.h"
#import "TAReleaseActivityViewController.h"
#import "TAReleaseLessonViewController.h"
#import "TAMyReleaseCell.h"

@interface TAMyReleaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation TAMyReleaseViewController


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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TAMyReleaseTitleCell class] forCellReuseIdentifier:@"titleCell"];
//    TAMyReleaseCell
    [self.tableView registerNib:[UINib nibWithNibName:@"TAMyReleaseCell" bundle:nil] forCellReuseIdentifier:@"releaseCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"我的发布";
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            TAMyReleaseTitleCell *cell = [[TAMyReleaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell" title:@"道馆课程"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
            
            cell.addBtnClick = ^(NSString *str){  //发布道馆课程
                TAReleaseLessonViewController *lessonVC = [TAReleaseLessonViewController new];
                [self.navigationController pushViewController:lessonVC animated:YES];
            };
            
            return cell;
        }
        else{
            
            TAMyReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"releaseCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
            return cell;
        }
    }else{
        if (indexPath.row == 0){
            TAMyReleaseTitleCell *cell = [[TAMyReleaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell" title:@"道馆活动"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
            cell.addBtnClick = ^(NSString *str){  //发布道馆活动
                TAReleaseActivityViewController *releaseVC = [TAReleaseActivityViewController new];
                [self.navigationController pushViewController:releaseVC animated:YES];
            };
            return cell;
        }
        else{
            TAMyReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"releaseCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, -20, 0, 0)];
            return cell;
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 45;
    }
    return 40;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return NO;
    }
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //创建UIAlertControler对象
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除" message:@"确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //删除的操作
            
        }];
        //添加两个action
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        //显示出来(present)
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

@end

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
@property (nonatomic,strong) NSArray *dataArray; //数据数组，包括课程和活动
@end

@implementation TAMyReleaseViewController

-(NSArray *)dataArray{
    if (!_dataArray) {
//        _dataArray = [NSArray array];
        _dataArray = @[@[],@[]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromServer];
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

#pragma mark - 与服务器交互
//获取课程和活动的数据
-(void)getDataFromServer{
    NSDictionary *params = @{
                             @"userID":UserID
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/MyPublish"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        
        if (dic[@"Data"][@"Success"]) {
            self.dataArray = [WQManageData getMyReleaseData:dic];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];

}

//删除某个课程
-(void)deleteLesson:(TALessonModel *)model{
    NSDictionary *params = @{
                             @"CourseId":model.Id
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/CourseDel"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        
        if (dic[@"Data"][@"Success"]) {
            [self getDataFromServer];
        }else{
            [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count + 1;
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
            
            NSArray *lessonArray = self.dataArray[0];
            cell.lessonModel = lessonArray[indexPath.row - 1];
            
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
            NSArray *activityArray = self.dataArray[1];
            cell.lessonModel = activityArray[indexPath.row - 1];
            return cell;
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row != 0){
        NSArray *lessonArray = self.dataArray[0];
        TALessonModel *lessonModel = lessonArray[indexPath.row - 1];
        TAReleaseLessonViewController *lessonVC = [[TAReleaseLessonViewController alloc] init];
        lessonVC.model = lessonModel;
        [self.navigationController pushViewController:lessonVC animated:YES];
    }
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
            if(indexPath.section == 0){  //删除课程
                NSArray *lessonArray = self.dataArray[0];
                TALessonModel *lessonModel = lessonArray[indexPath.row - 1];
                [self deleteLesson:lessonModel];
            }
           
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

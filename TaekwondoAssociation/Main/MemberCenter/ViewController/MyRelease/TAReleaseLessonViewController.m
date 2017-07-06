//
//  TAReleaseLessonViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAReleaseLessonViewController.h"
#import "TAReleaseLessonCell.h"
#import "UICustomDatePicker.h"
#import "TALessonTimeCell.h"

@interface TAReleaseLessonViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UITextField *lessonNameTextField;
@property (nonatomic,strong) UITextField *expensesTextField;
@property (nonatomic,strong) NSString *timeStr;


@end

@implementation TAReleaseLessonViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"课程名称",@"费用",@"时间"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    
}

- (void)loadView{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"发布课程";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
    self.navigationItem.rightBarButtonItem = okItem;
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[TAReleaseLessonCell class] forCellReuseIdentifier:@"lessonCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TALessonTimeCell" bundle:nil] forCellReuseIdentifier:@"timeCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 与服务器交互
-(void)ok{
    if (self.lessonNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入课程名称"];
        return;
    }
    if (self.expensesTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入课程费用"];
        return;
    }
    if (self.timeStr.length == 0) {
        [MBProgressHUD showError:@"请选择课程时间"];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在发布...";
    
    NSDictionary *params = @{
                             @"userID":UserID,
                             @"CourseName":self.lessonNameTextField.text,
                             @"Cost":self.expensesTextField.text,
                             @"Time":self.timeStr
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/CoursePublish"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        [hud hideAnimated:YES];
        
        if (dic[@"Data"][@"Success"]) {
            [MBProgressHUD showSuccess:@"发布成功"];
            [self back];
            
        }else{
            [MBProgressHUD showError:dic[@"Data"][@"Msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row != 2) {
        TAReleaseLessonCell *cell = [[TAReleaseLessonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lessonCell" title:self.titleArray[indexPath.row] placeHolder:[NSString stringWithFormat:@"请输入%@",self.titleArray[indexPath.row]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            self.lessonNameTextField = cell.textField;
            self.lessonNameTextField.delegate = self;
        }else if (indexPath.row == 1){
            self.expensesTextField = cell.textField;
            self.expensesTextField.keyboardType = UIKeyboardTypeDecimalPad;
            self.expensesTextField.delegate = self;
        }
        return cell;
    }else{
        TALessonTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.timeStr = self.timeStr;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDateStr = [dateFormatter stringFromDate:date];
            self.timeStr = strDateStr;
            
            NSIndexPath *indexRow = [NSIndexPath indexPathForRow:2 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexRow] withRowAnimation:UITableViewRowAnimationNone];
        } cancelBlock:^{
            
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }
    return 10.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    if (textField.tag == 1000) {
//        [self.view endEditing:YES];
//        
//    }
//    
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [self.view endEditing:YES];
//}

@end

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
#import "SYDatePicker.h"

@interface TAReleaseLessonViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SYDatePickerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UITextField *lessonNameTextField;
@property (nonatomic,strong) UITextField *expensesTextField;
//@property (nonatomic,strong) NSString *timeStr;
@property (nonatomic,strong) UIButton *selctedDateBtn;//选择日期的按钮
@property (nonatomic,strong) UIButton *startBtn;//开始时间按钮
@property (nonatomic,strong) UIButton *endBtn; //结束时间按钮
@property (nonatomic,strong) SYDatePicker *picker;
@property (nonatomic,assign) NSInteger index;//区分点的是选择开始时间还是结束时间的按钮
@end

@implementation TAReleaseLessonViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"课程名称",@"费用",@"时间"];
    }
    return _titleArray;
}

-(SYDatePicker *)picker{
    if (!_picker) {
        _picker = [[SYDatePicker alloc] init];
        _picker.delegate = self;
    }
    return _picker;
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
    
    if(self.model){
        
    }
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:self.model ? @"修改" : @"发布" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
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

-(void)selectedDateTime{
    [self.picker dismiss];
    [self.view endEditing:YES];
    [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDateStr = [dateFormatter stringFromDate:date];
        [self.selctedDateBtn setTitle:strDateStr forState:UIControlStateNormal];
        
    } cancelBlock:^{
        
    }];
}

-(void)selectedStartTime{
    self.index = 1;
    [self.picker showInView:self.view withFrame:CGRectMake(0, KTA_Screen_Height - 300, KTA_Screen_Width, 300) andDatePickerMode:UIDatePickerModeTime withTitle:@"开始时间"];
}

-(void)selectedEndTime{
    self.index = 2;
    [self.picker showInView:self.view withFrame:CGRectMake(0, KTA_Screen_Height - 300, KTA_Screen_Width, 300) andDatePickerMode:UIDatePickerModeTime withTitle:@"结束时间"];
}

#pragma mark - 与服务器交互
-(void)ok{
    if (self.model) {   //修改课程
        [self reviseLesson];
    }else{
        [self releaseLesson];//发布课程
    }
}

-(void)releaseLesson{
    if (self.lessonNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入课程名称"];
        return;
    }
    if (self.expensesTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入课程费用"];
        return;
    }
    if (self.selctedDateBtn.titleLabel.text.length == 0) {
        [MBProgressHUD showError:@"请选择课程日期"];
        return;
    }
    if (self.startBtn.titleLabel.text.length == 0) {
        [MBProgressHUD showError:@"请选择课程开始时间"];
        return;
    }
    if (self.endBtn.titleLabel.text.length == 0) {
        [MBProgressHUD showError:@"请选择课程结束时间"];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在发布...";
    
    NSDictionary *params = @{   //发布课程
                   @"userID":UserID,
                   @"CourseName":self.lessonNameTextField.text,
                   @"Cost":self.expensesTextField.text,
                   @"StarTime":[NSString stringWithFormat:@"%@ %@",self.selctedDateBtn.titleLabel.text,self.startBtn.titleLabel.text],
                   @"EndTime":[NSString stringWithFormat:@"%@ %@",self.selctedDateBtn.titleLabel.text,self.endBtn.titleLabel.text]
                   };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/CoursePublish"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        [hud hideAnimated:YES];
        //
        BOOL b = dic[@"Data"][@"Success"];
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

//修改课程
-(void)reviseLesson{
    if (self.lessonNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入课程名称"];
        return;
    }
    if (self.expensesTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入课程费用"];
        return;
    }
    if (self.selctedDateBtn.titleLabel.text.length == 0) {
        [MBProgressHUD showError:@"请选择课程日期"];
        return;
    }
    if (self.startBtn.titleLabel.text.length == 0) {
        [MBProgressHUD showError:@"请选择课程开始时间"];
        return;
    }
    if (self.endBtn.titleLabel.text.length == 0) {
        [MBProgressHUD showError:@"请选择课程结束时间"];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在发布...";
    
    NSDictionary *params = @{   //修改课程
                             @"CourseId":self.model.Id,
                             @"CourseName":self.lessonNameTextField.text,
                             @"Cost":self.expensesTextField.text,
                             @"StarTime":[NSString stringWithFormat:@"%@ %@",self.selctedDateBtn.titleLabel.text,self.startBtn.titleLabel.text],
                             @"EndTime":[NSString stringWithFormat:@"%@ %@",self.selctedDateBtn.titleLabel.text,self.endBtn.titleLabel.text]
                             };
    
    NSString *url = [HeadUrl stringByAppendingString:@"Center/CourseEdit"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:params success:^(NSDictionary *dic) {
        [hud hideAnimated:YES];
        //
        BOOL b = dic[@"Data"][@"Success"];
        if (dic[@"Data"][@"Success"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
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
            self.lessonNameTextField.text = self.model.title;
        }else if (indexPath.row == 1){
            self.expensesTextField = cell.textField;
            self.expensesTextField.keyboardType = UIKeyboardTypeDecimalPad;
            self.expensesTextField.delegate = self;
            self.expensesTextField.text = self.model.Price;
        }
        return cell;
    }else{
//        NSArray *array = [self.model.CreatedTime componentsSeparatedByString:@" "];
        
        TALessonTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.selctedDateBtn = cell.dateBtn;
        NSArray *array = [self.model.StarTime componentsSeparatedByString:@" "];
        NSString *title = array[0];
        [self.selctedDateBtn setTitle:title.length == 0 ? @"请选择日期" : title forState:UIControlStateNormal];
        [self.selctedDateBtn addTarget:self action:@selector(selectedDateTime) forControlEvents:UIControlEventTouchUpInside];
        
        self.startBtn = cell.startBtn;
        NSString *title2 = array[1];
        [self.startBtn setTitle:title2.length == 0 ? @"开始时间" : title2 forState:UIControlStateNormal];
        [self.startBtn addTarget:self action:@selector(selectedStartTime) forControlEvents:UIControlEventTouchUpInside];
        
        self.endBtn = cell.endBtn;
        NSString *title3 = [self.model.EndTime componentsSeparatedByString:@" "][1];
        [self.endBtn setTitle:title3.length == 0 ? @"结束时间" : title3 forState:UIControlStateNormal];
        [self.endBtn addTarget:self action:@selector(selectedEndTime) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    [self.picker dismiss];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.picker dismiss];
}

#pragma mark - SYDatePickerDelegate
-(void)ok:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"HH:mm";  //yyyy-MM-dd
    NSString *str = [fm stringFromDate:date];
    NSLog(@"%@",str);
    if (self.index == 1) {
        [self.startBtn setTitle:str forState:UIControlStateNormal];
    }else{
        [self.endBtn setTitle:str forState:UIControlStateNormal];
    }
}
@end

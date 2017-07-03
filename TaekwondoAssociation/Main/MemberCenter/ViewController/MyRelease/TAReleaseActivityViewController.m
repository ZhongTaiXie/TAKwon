//
//  TAReleaseActivityViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAReleaseActivityViewController.h"
#import "TAActivityTimeCell.h"
#import "TATaekwondoAuthCell.h"
#import "TZImagePickerController.h"
#import "UICustomDatePicker.h"



#define Start_X 10.0f           // 第一个按钮的X坐标
#define Start_Y 10.0f           // 第一个按钮的Y坐标
#define Width_Space 10.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距
#define Button_Height Button_Width * 68 / 110   // 高
#define Button_Width (self.view.bounds.size.width - 40) / 3      // 宽


@interface TAReleaseActivityViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSUInteger sourceType;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UITextField *addressTextField;  //地址
@property (nonatomic,strong) UITextField *fuzerenTextField;  //负责人
@property (nonatomic,strong) UITextField *phoneNumTextField;  //电话
@property (nonatomic,strong) UITextView *introduceTextView;//简介
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIView *picsView;//放置图片的View
@property (nonatomic,strong) NSString *startTime;//开始时间
@property (nonatomic,strong) NSString *endTime;//结束时间


@property (strong,nonatomic)NSMutableArray *phonelist;      //图片数组

@end

@implementation TAReleaseActivityViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@[@"活动时间",@"活动地址",@"负责人",@"联系电话"],@[@"活动简介",@""],@[@"图片(最多9张)",@""]];
    }
    return _titleArray;
}

-(UITextView *)introduceTextView{
    if (!_introduceTextView) {
        _introduceTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, KTA_Screen_Width - 20, 190)];
        _introduceTextView.layer.borderWidth = 0.5;
        _introduceTextView.layer.borderColor = [WQTools colorWithHexString:@"cccccc"].CGColor;
    }
    return _introduceTextView;
}

-(UIView *)picsView{
    if (!_picsView) {
        _picsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 300)];
    }
    return _picsView;
}

-(NSMutableArray *)phonelist{
    if (!_phonelist) {
        _phonelist = [NSMutableArray array];
    }
    return _phonelist;
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height + 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TAActivityTimeCell" bundle:nil] forCellReuseIdentifier:@"timeCell"];
    [self.tableView registerClass:[TATaekwondoAuthCell class] forCellReuseIdentifier:@"infocell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"发布活动";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
    self.navigationItem.rightBarButtonItem = okItem;

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存发布
-(void)ok{
    
}

-(UIView *)addPicView{
    //button的x根据照片数组的个数定
    UIButton *addPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, Start_Y, Button_Width, Button_Height)];
    [addPicBtn setImage:[UIImage imageNamed:@"add-big"] forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(selectPics) forControlEvents:UIControlEventTouchUpInside];
    addPicBtn.tag = 2000;
    self.addBtn = addPicBtn;
    [self.picsView addSubview:addPicBtn];
    
    return self.picsView;
}


-(void)selectPics{
    if (self.phonelist.count == 9) {
        [self alert:@"提示" msg:@"最多提交9张照片"];    }
    else{
        [self showSheetView];
    }
}
-(void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alter show];
    
}
-(void)setupPics{
    
    for (UIView *view in self.picsView.subviews) {
        if (view.tag == 2000) {
            
        }else{
            [view removeFromSuperview];
        }
    }
    
    int row = 0;
    row = (int)self.phonelist.count / 3 + 1;
    
    for (int i = 0; i < self.phonelist.count; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space) + Start_Y, Button_Width, Button_Height)];
        imgview.userInteractionEnabled = YES;
        imgview.image = self.phonelist[i];
        
        //删除按钮的实现
        UIButton *delBtn =  [[UIButton alloc] initWithFrame:CGRectMake(imgview.frame.size.width - 21,1, 20, 20)];
        delBtn.tag = 100 + i;
        [delBtn setImage:[UIImage imageNamed:@"icon_find_phone_del"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(delPic:) forControlEvents:UIControlEventTouchUpInside];
        [imgview addSubview:delBtn];
        
        [self.picsView addSubview:imgview];
    }
    
    self.addBtn.frame = CGRectMake(10 + (10 + Button_Width) * (self.phonelist.count % 3), Start_Y + Button_Height * (row - 1) + 10 * (row - 1),Button_Width,Button_Height);
    
    if (self.phonelist.count == 9) {
        self.addBtn.hidden = YES;
    }else{
        self.addBtn.hidden = NO;
    }
    
}
//弹出视图
-(void)showSheetView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *setAlert = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 跳转到相机或相册页面
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:NULL];
    }];
    
    
    CGFloat ingt = 9 - self.phonelist.count;//剩余图片数量
    UIAlertAction *PhoneAlert = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:ingt delegate:nil];
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
            [self.phonelist addObjectsFromArray:photos];
            [self setupPics];
        }];
        // 在这里设置imagePickerVc的外观
        imagePickerVc.navigationBar.barTintColor = [UIColor blackColor];
        imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
        // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
        // 设置是否可以选择视频/原图
        // imagePickerVc.allowPickingVideo = NO;
        // imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePickerVc.minImagesCount = 3;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }];
    UIAlertAction *hidAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:PhoneAlert];
    [alert addAction:setAlert];
    [alert addAction:hidAlert];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

//删除某一张图片
-(void)delPic:(UIButton *)sender{
    [self.phonelist removeObjectAtIndex:sender.tag - 100];
    [self setupPics];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *section = self.titleArray[indexPath.section];
    NSString *title = section[indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TAActivityTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.startTimeStr = self.startTime;
            cell.endTimeStr = self.endTime;
            
            
            cell.startTimeBtnClick = ^(NSString *str){
                [self.view endEditing:YES];
                
                [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
                    NSString *strDateStr = [dateFormatter stringFromDate:date];
                    self.startTime = strDateStr;
                    NSIndexPath *indexRow = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:@[indexRow] withRowAnimation:UITableViewRowAnimationNone];
                } cancelBlock:^{
                    
                }];
            };
            cell.endTimeBtnClick = ^(NSString *str){
                [self.view endEditing:YES];
                [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
                    NSString *strDateStr = [dateFormatter stringFromDate:date];
                    self.endTime = strDateStr;NSIndexPath *indexRow = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:@[indexRow] withRowAnimation:UITableViewRowAnimationNone];
                } cancelBlock:^{
                    
                }];
            };
            
            return cell;
        }else{
            TATaekwondoAuthCell *cell = [[TATaekwondoAuthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"authCell" title:title placeholder:[NSString stringWithFormat:@"请输入%@",title]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                self.addressTextField = cell.textField;
            }else if (indexPath.row == 2){
                self.fuzerenTextField = cell.textField;
            }else{
                self.phoneNumTextField = cell.textField;
            }
            
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = title;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [WQTools colorWithHexString:@"333333"];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:self.introduceTextView];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = title;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [WQTools colorWithHexString:@"333333"];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:[self addPicView]];
            return cell;
        }
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
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 200;
    }else if (indexPath.section == 2 && indexPath.row == 1){
        return 300;
    }
    return 45;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end

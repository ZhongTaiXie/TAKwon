//
//  TATaekwondoAuthViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekwondoAuthViewController.h"
#import "TATaekwondoAuthCell.h"
#import "TAuploadPicView.h"
#import "TZImagePickerController.h"

@interface TATaekwondoAuthViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSUInteger sourceType;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITextField *memberNumTextfield;//会员编号输入框
@property (nonatomic,strong) UITextField *validateCodeTextfield;//验证码输入框
@property (nonatomic,strong) NSMutableArray *IDCardImageArray;
@property (nonatomic,strong) NSMutableArray *zhizhaoImageArray;
@property (nonatomic,assign) NSInteger index;  //标志点的是选身份证还是营业执照1.身份证2.营业执照

@end

@implementation TATaekwondoAuthViewController

-(NSMutableArray *)IDCardImageArray{
    if (!_IDCardImageArray) {
        _IDCardImageArray = [NSMutableArray array];
    }
    return _IDCardImageArray;
}

-(NSMutableArray *)zhizhaoImageArray{
    if (!_zhizhaoImageArray) {
        _zhizhaoImageArray = [NSMutableArray array];
    }
    return _zhizhaoImageArray;
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
-(void)setupNav{
    self.view.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];;
    self.navigationItem.title = @"道馆认证";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, KTA_Screen_Width, KTA_Screen_Height + 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [WQTools colorWithHexString:@"f1f1f1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TATaekwondoAuthCell class] forCellReuseIdentifier:@"authCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
}

-(void)selectIDCardPic{
    self.index = 1;
    if (self.zhizhaoImageArray.count == 2) {
        [self alert:@"提示" msg:@"最多提交2张照片"];
    }
    else{
        [self showSheetView];
    }
}


-(void)selectZhizhaoPic{
    self.index = 2;
    if (self.zhizhaoImageArray.count == 1) {
        [self alert:@"提示" msg:@"最多提交1张照片"];
    }
    else{
        [self showSheetView];
    }
}

//删除某一张图片
-(void)delPic:(NSString *)index tag:(NSInteger)tag{
    if ([index integerValue] == 1) {//身份证
        [self.IDCardImageArray removeObjectAtIndex:tag - 100];
        [self.tableView reloadData];
    }else{
        [self.zhizhaoImageArray removeObjectAtIndex:tag - 100];
        [self.tableView reloadData];
    }
    
}

-(void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alter show];
    
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
    
    
    
    CGFloat ingt;
    if (self.index == 1) {
        ingt = 2 - self.IDCardImageArray.count;//剩余图片数量
    }else{
        ingt = 1 - self.zhizhaoImageArray.count;//剩余图片数量
    }
    
    
    UIAlertAction *PhoneAlert = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:ingt delegate:nil];
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
            if (self.index == 1) {
                [self.IDCardImageArray addObjectsFromArray:photos];
                [self.tableView reloadData];
//                [self setupPics];
            }else{
                [self.zhizhaoImageArray addObjectsFromArray:photos];
                [self.tableView reloadData];
            }
            
            
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



#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 255) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:NULL];
        
    }
    else{
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 跳转到相机或相册页面
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:NULL];
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *imagepai = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"~~~~~%@~~~~~",imagepai);
    if (self.index == 1) {
        [self.IDCardImageArray addObject:imagepai];
        [self.tableView reloadData];
    }else{
        [self.zhizhaoImageArray addObject:imagepai];
        [self.tableView reloadData];
    }
    
}

-(void)callCameraOrPhotoWithType:(UIImagePickerControllerSourceType)sourceType{
    BOOL isCamera = YES;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {//判断是否有相机
        isCamera = [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
    }
    if (isCamera) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;//为NO，则不会出现系统的编辑界面
        imagePicker.sourceType = sourceType;
        [self presentViewController:imagePicker animated:YES completion:^(){
            if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            }
        }];
    } else {
        
    }
    
}
#pragma UIImagePickerControllerDelegate
//相册或则相机选择上传的实现
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo{
    
    if (self.index == 1) {
        [self.IDCardImageArray addObject:aImage];
        [self.tableView reloadData];
    }else{
        [self.zhizhaoImageArray addObject:aImage];
        [self.tableView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        //         [self uploadPhotos:photos];
    }];
    
    
}

#pragma mark - 与服务器交互
-(void)submitAuth{
    NSLog(@"提交认证");
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TATaekwondoAuthCell *cell = [[TATaekwondoAuthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"authCell" title:@"团体会员编号" placeholder:@"请输入团体会员编号"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.memberNumTextfield = cell.textField;
        return cell;
    }else if (indexPath.row == 1) {
        TATaekwondoAuthCell *cell = [[TATaekwondoAuthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"authCell" title:@"验证码" placeholder:@"请输入验证码"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.validateCodeTextfield = cell.textField;
        return cell;
    }else if (indexPath.row == 2) {
        
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        TAuploadPicView *uploadView = [[TAuploadPicView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 100) title:@"上传身份证反正面" imageArray:self.IDCardImageArray];
        
        uploadView.addPicBtnClick = ^(NSString *str){
            [self selectIDCardPic];
        };
        
        uploadView.delPicBtnClick = ^(NSString *str,NSInteger tag){
            [self delPic:str tag:tag];
        };
        
        [cell.contentView addSubview:uploadView];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        TAuploadPicView *uploadView = [[TAuploadPicView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 100) title:@"上传营业执照" imageArray:self.zhizhaoImageArray];
        [cell.contentView addSubview:uploadView];
        uploadView.addPicBtnClick = ^(NSString *str){
            [self selectZhizhaoPic];
        };
        
        uploadView.delPicBtnClick = ^(NSString *str,NSInteger tag){
            [self delPic:str tag:tag];
        };
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 || indexPath.row == 1){
        return 45;
    }
    
    CGFloat width = (KTA_Screen_Width - 40) / 3;
    CGFloat height = width * 68 / 100;
    
    return height + 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgview = [WQFactoryUI createViewWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 80) viewBackgroundColor:[WQTools colorWithHexString:@"f1f1f1"]];
    UIButton *submitAuthBtn = [WQFactoryUI createButtonWithTitleFont:18 buttonBackgroundColor:MAINCOLOR titleColor:WHITECOLOR buttonFrame:CGRectMake(15, 50, KTA_Screen_Width - 30, 40) text:@"提交认证" cornerRadius:5];
    [submitAuthBtn addTarget:self action:@selector(submitAuth) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:submitAuthBtn];
    return bgview;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end

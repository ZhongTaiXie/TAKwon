//
//  TAUploadMemHonorViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAUploadMemHonorViewController.h"
#import "TZImagePickerController.h"

#define Start_X 10.0f           // 第一个按钮的X坐标
#define Start_Y 50.0f           // 第一个按钮的Y坐标
#define Width_Space 10.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距
#define Button_Height Button_Width * 68 / 110   // 高
#define Button_Width (self.view.bounds.size.width - 40) / 3      // 宽

@interface TAUploadMemHonorViewController (){
    NSUInteger sourceType;
}
@property (strong,nonatomic)NSMutableArray *phonelist;      //图片数组
@property (nonatomic,strong) UIButton *addBtn;;
@end

@implementation TAUploadMemHonorViewController

-(NSMutableArray *)phonelist{
    if (!_phonelist) {
        _phonelist = [NSMutableArray array];
    }
    return _phonelist;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupViews];
}

-(void)setupNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"会员荣誉";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
    self.navigationItem.rightBarButtonItem = okItem;
}

//布局视图
-(void)setupViews{
    UILabel *label = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"666666"] textFrame:CGRectMake(10, 10, 300, 30) text:@"请选择您的荣誉证书(最多9张)"];
    label.tag = 3000;
    [self.view addSubview:label];
    
    UIButton *addPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, Start_Y, Button_Width, Button_Height)];
    [addPicBtn setImage:[UIImage imageNamed:@"add-big"] forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(selectPics) forControlEvents:UIControlEventTouchUpInside];
    addPicBtn.tag = 2000;
    self.addBtn = addPicBtn;
//    self.addBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:addPicBtn];
    
}

//选完图片重新布局
-(void)resetLayout{
    for (UIView *view in self.view.subviews) {
        if (view.tag == 2000 || view.tag == 3000) {
            
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
        
        [self.view addSubview:imgview];
    }
    
    self.addBtn.frame = CGRectMake(10 + (10 + Button_Width) * (self.phonelist.count % 3), Start_Y + Button_Height * (row - 1) + 10 * (row - 1),Button_Width,Button_Height);
    
    if (self.phonelist.count == 9) {
        self.addBtn.hidden = YES;
    }else{
        self.addBtn.hidden = NO;
    }
    
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
            [self resetLayout];
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

#pragma mark - 点击事件
//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//完成
-(void)ok{
    
}

//删除某一张图片
-(void)delPic:(UIButton *)sender{
    [self.phonelist removeObjectAtIndex:sender.tag - 100];
    [self resetLayout];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
//    if (coutIN ==5) {
//        
//        [picker dismissViewControllerAnimated:YES completion:^{}];
//        
//        
//        UIImage *image5 = [info objectForKey:UIImagePickerControllerEditedImage];
//        [self saveImage:image5 WithName:@"userAvatar"];
//    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *imagepai = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"~~~~~%@~~~~~",imagepai);
    
    [self.phonelist addObject:imagepai];
    [self resetLayout];
    
    
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
    
    //    NSArray *photos = [[NSArray alloc]initWithObjects:aImage, nil];
    [self.phonelist addObject:aImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        //         [self uploadPhotos:photos];
    }];
    
    
}


@end

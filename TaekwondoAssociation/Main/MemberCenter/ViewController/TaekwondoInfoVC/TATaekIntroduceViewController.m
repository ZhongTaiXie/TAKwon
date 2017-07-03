//
//  TATaekIntroduceViewController.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/1.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TATaekIntroduceViewController.h"
#import "TZImagePickerController.h"


#define Start_X 10.0f           // 第一个按钮的X坐标
#define Start_Y 10.0f           // 第一个按钮的Y坐标
#define Width_Space 10.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距
#define Button_Height Button_Width * 68 / 110   // 高
#define Button_Width (self.view.bounds.size.width - 40) / 3      // 宽

@interface TATaekIntroduceViewController (){
    NSUInteger sourceType;
}

@property (strong,nonatomic)NSMutableArray *phonelist;      //图片数组
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIView *picsView;//放置图片的View

@end

@implementation TATaekIntroduceViewController

-(NSMutableArray *)phonelist{
    if (!_phonelist) {
        _phonelist = [NSMutableArray array];
    }
    return _phonelist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    [self setupContentView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)setNav{
    self.view.backgroundColor = WHITECOLOR;
    self.navigationItem.title = @"道馆简介";
    
    //设置导航栏左侧返回按钮
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveIntroduce)];
    self.navigationItem.rightBarButtonItem = okItem;
}

-(void)setupContentView{
    UILabel *label = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(10, 5, 100, 30) text:@"简介"];
    [self.view addSubview:label];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 10, KTA_Screen_Width - 30, 200)];
    textView.layer.borderColor = [WQTools colorWithHexString:@"999999"].CGColor;
    textView.layer.borderWidth = 0.5;
    [self.view addSubview:textView];
    
    UILabel *picLabel = [WQFactoryUI createLabelWithtextFont:15 textBackgroundColor:WHITECOLOR textAliment:NSTextAlignmentLeft textColor:[WQTools colorWithHexString:@"333333"] textFrame:CGRectMake(10, CGRectGetMaxY(textView.frame) + 5, 100, 30) text:@"图片(最多9张)"];
    
    [self.view addSubview:picLabel];
    
    self.picsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(picLabel.frame), KTA_Screen_Width, 300)];
    [self.view addSubview:self.picsView];
    
    [self setupPics];
    
    //button的x根据照片数组的个数定
    UIButton *addPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, Start_Y, Button_Width, Button_Height)];
    [addPicBtn setImage:[UIImage imageNamed:@"add-big"] forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(selectPics) forControlEvents:UIControlEventTouchUpInside];
    addPicBtn.tag = 2000;
    self.addBtn = addPicBtn;
    [self.picsView addSubview:addPicBtn];
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

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveIntroduce{
    
}

-(void)selectPics{
    if (self.phonelist.count == 9) {
        [self alert:@"提示" msg:@"最多提交9张照片"];    }
    else{
        [self showSheetView];
    }
}
//删除某一张图片
-(void)delPic:(UIButton *)sender{
    [self.phonelist removeObjectAtIndex:sender.tag - 100];
    [self setupPics];
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

@end

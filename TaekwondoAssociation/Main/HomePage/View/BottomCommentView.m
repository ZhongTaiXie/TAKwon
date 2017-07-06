//
//  BottomCommentView.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "BottomCommentView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface BottomCommentView ()<UITextFieldDelegate>

@end

@implementation BottomCommentView


- (instancetype)initWithType:(BottomCommentViewType)type
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kDeviceHeight - 50-64, kDeviceWidth, 50);
        self.backgroundColor = [UIColor whiteColor];
        _type = type;
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    
    switch (_type) {
        case 0:
            _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _shareBtn.frame = CGRectMake(kDeviceWidth - 50, 10, 30, 30);
            _collectBtn.frame = CGRectMake(kDeviceWidth - 100, 10, 30, 30);
            _commentBtn.frame = CGRectMake(kDeviceWidth - 150, 10, 30, 30);
            [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
            [_collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            [_collectBtn setImage:[UIImage imageNamed:@"collect_selected"] forState:UIControlStateSelected];
            [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
            
//            _commentBtn.backgroundColor = [UIColor blueColor];
//            _collectBtn.backgroundColor = [UIColor blueColor];
//            _shareBtn.backgroundColor = [UIColor blueColor];
            
            [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            _tfView = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth - 200, 30)];
            
            
            [self addSubview:_tfView];
            [self addSubview:_commentBtn];
            [self addSubview:_collectBtn];
            [self addSubview:_shareBtn];
            
            
            // 角标
            _BadgeLb = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 25, 12)];
            _BadgeLb.layer.cornerRadius = 6;
            _BadgeLb.layer.masksToBounds = YES;
            _BadgeLb.contentMode = UIViewContentModeScaleAspectFill;
            _BadgeLb.backgroundColor = [UIColor redColor];
            _BadgeLb.textColor = [UIColor whiteColor];
            _BadgeLb.font = [UIFont systemFontOfSize:10];
            
            _BadgeLb.text = @"1.5w";
            [_commentBtn addSubview:_BadgeLb];
            break;
        case 1:
            _tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _shareBtn.frame = CGRectMake(kDeviceWidth - 50, 10, 30, 30);
            _tagsBtn.frame = CGRectMake(kDeviceWidth - 100, 10, 30, 30);
            [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
            [_tagsBtn setImage:[UIImage imageNamed:@"likes-big"] forState:UIControlStateNormal];
            [_tagsBtn setImage:[UIImage imageNamed:@"likes-big-selected"] forState:UIControlStateSelected];
            
//            _tagsBtn.backgroundColor = [UIColor redColor];
//            _shareBtn.backgroundColor = [UIColor redColor];
            
            [_tagsBtn addTarget:self action:@selector(tagsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            _tfView = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth - 160, 30)];
            
            [self addSubview:_tfView];
            [self addSubview:_tagsBtn];
            [self addSubview:_shareBtn];
            break;
        default:
            break;
    }
    
    // 设置图片圆角
    _tfView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    _tfView.layer.cornerRadius = 14;
    _tfView.layer.masksToBounds = YES;
    _tfView.contentMode = UIViewContentModeScaleAspectFill;
    
    _tfImageV = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 15, 15)];
    _tfImageV.image = [UIImage imageNamed:@"Write-reviews"];
    [_tfView addSubview:_tfImageV];
    _tfLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 40, 20)];
    _tfLabel.text = @"写评论";
    _tfLabel.font = [UIFont systemFontOfSize:13];
    _tfLabel.textColor = [UIColor darkGrayColor];
    [_tfView addSubview:_tfLabel];
    
    UILabel* leftLb = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 10, 20)];
    leftLb.backgroundColor = [UIColor clearColor];
    _tfView.leftView = leftLb;
    _tfView.leftViewMode = UITextFieldViewModeAlways;
    _tfView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _tfView.returnKeyType = UIReturnKeySend;
    _tfView.delegate = self;
    _tfView.enablesReturnKeyAutomatically = YES;
    
    // 虚线
    UIView* lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self addSubview:lineView];
    
    
}


- (void)commentBtnClick:(UIButton*)btn
{
    
}

- (void)collectBtnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
}

- (void)shareBtnClick:(UIButton*)btn
{
    NSArray* imageArray = @[[UIImage imageNamed:@"collect"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        
//        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
       SSUIShareActionSheetController* sheet = [ShareSDK showShareActionSheet:[UIApplication sharedApplication].keyWindow //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];

        [sheet.directSharePlatforms addObjectsFromArray:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeMail),@(SSDKPlatformTypeDouBan),@(SSDKPlatformTypeRenren)]];

    }
}


- (void)tagsBtnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
}

#pragma -marl UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tfLabel.hidden = YES;
    _tfImageV.hidden = YES;
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_tfView.text.length) {
        _tfLabel.hidden = YES;
        _tfImageV.hidden = YES;
    }else{
        _tfImageV.hidden = NO;
        _tfLabel.hidden= NO;
    }
    
    return YES;
}

// 发送评论
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了发送");
    return YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

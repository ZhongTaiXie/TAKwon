//
//  BottomCommentView.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "BottomCommentView.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

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
            [_collectBtn setImage:[UIImage imageNamed:@"solid-star"] forState:UIControlStateSelected];
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
            [_tagsBtn setImage:[UIImage imageNamed:@"Write-reviews"] forState:UIControlStateNormal];
            
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
    
    _tfImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    _tfImageV.image = [UIImage imageNamed:@"Write-reviews"];
    [_tfView addSubview:_tfImageV];
    
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
    
}

- (void)tagsBtnClick:(UIButton*)btn
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

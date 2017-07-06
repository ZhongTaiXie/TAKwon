//
//  PrescriptionImageEditView.m
//  lumbar
//
//  Created by Ceres on 16/10/23.
//  Copyright © 2016年 www.upupapp.com. All rights reserved.
//

#import "PrescriptionImageEditView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PrescriptionImageEditView()<UIScrollViewDelegate>
{
    CGPoint touchPoint;
}

@property (nonatomic, strong) UIImageView* imageV;
@property (nonatomic, strong) UIButton* btn ;
//@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIScrollView* scrollview;

@end



@implementation PrescriptionImageEditView



- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor blackColor];
        
        [self createUI];
    }
    
    return self;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
}

- (void)setDelegate:(id<prescriptionImageDelegate>)delegate
{
    _delegate = delegate;
}

// 将需要标记的图片放入控件中，并设置scrollview的contentsize
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
//    _image = _imageV.image;
    
    _scrollview.contentSize = _imageV.image.size;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];


}

- (void)createUI
{
    
    _scrollview = [[UIScrollView alloc] initWithFrame:self.frame];
    [self addSubview: _scrollview];
    
    _imageV=[[UIImageView alloc] init];
    
    _imageV.frame = [UIScreen mainScreen].bounds;
    
    _imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [_scrollview addSubview:_imageV];
    
    _scrollview.delegate = self;
    _scrollview.maximumZoomScale = 5;
    _scrollview.minimumZoomScale = 1;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [_scrollview addGestureRecognizer:tap];
    
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(10, 10, 50, 50);
//    _btn.backgroundColor = [UIColor redColor];
    [_btn setTitle:@"保存" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btn];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 10, 50, 50);
//    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"清空" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClear) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    UIButton* drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    drawBtn.frame = CGRectMake(200, 10, 50, 50);
//    drawBtn.backgroundColor = [UIColor redColor];
    [drawBtn setTitle:@"开始" forState:UIControlStateNormal];
    [drawBtn setTitle:@"结束" forState:UIControlStateSelected];
    [drawBtn addTarget:self action:@selector(drawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:drawBtn];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageV;
}

// 开始标记
-(void)drawBtnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        _scrollview.userInteractionEnabled = NO;
        _scrollview.delegate = nil;
    }
    else{
        _scrollview.userInteractionEnabled = YES;
        _scrollview.delegate = self;
    }
}

// 恢复原始图片
- (void)btnClear
{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];

}

// 将修改后的图片上传
- (void)btnClick
{
//    UIImageWriteToSavedPhotosAlbum(_imageV.image, nil, nil, nil);
    
    NSArray* imageArr = [NSArray arrayWithObject:_imageV.image];
    
//    [[LCAppDotNetAPIClient sharedClient] uploadPictureFirst:imageArr type:kUpLoadImageTypeMedical view:self hudString:nil animated:YES showHUD:YES then:^(bool state, NSArray *imageModelArray, NSError *error) {
//        if (state) {
//            // 上传成功 返回该图片地址，并且关闭页面
//            ImageSignModel* model = [imageModelArray lastObject];
//            
//            [self.delegate returnEditImage:model.imageUrl withIndex:_index];
//            
//            [self removeFromSuperview];
//            [[UIApplication sharedApplication] setStatusBarHidden:NO];
//            
//        }else{
//            NSLog(@"%@",error);
//        }
//    }];
    
}

// 返回
- (void)backClick
{
    
    [self removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


#pragma -mark 绘图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    touchPoint = [touch locationInView:_imageV];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_imageV];
    
    
    float imagey = _scrollview.frame.size.width * _imageV.image.size.height / _imageV.image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(_scrollview.frame.size.width, imagey));
    [_imageV.image drawInRect:CGRectMake(0.0,0.0, _scrollview.frame.size.width, imagey)];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    
    float lineWidthc = 3.0;
//    if ([touch respondsToSelector:@selector(force)]) {
//        //        NSLog(@"force:%f", touch.force);
//        lineWidthc = lineWidthc * touch.force;
//    }
//    lineWidthc = lineWidthc * _scrollview.frame.size.height / _scrollview.contentSize.height;
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidthc);
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);

    
    // 放大后图片的显示高度
    float contenty = imagey * _scrollview.contentSize.height /_scrollview.frame.size.height;
    
    // 上下边框的高度
    float blacky = (_scrollview.contentSize.height - contenty)/2;
    
    // 图片上边框的y坐标
    float blackTop = blacky ;
    // 图片下边框的y坐标
    float blackBottom = blackTop + contenty;
    
    
    if (touchPoint.y * contenty / imagey >= blackTop && touchPoint.y * contenty /imagey <=blackBottom) {
        
        //    float nx = _imageV.frame.size.width / [UIScreen mainScreen].bounds.size.width;
//        float ny = imagey / _scrollview.size.height;
        //    nx = 1;
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x , touchPoint.y - (667 - imagey)/2);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x , currentPoint.y - (667 - imagey)/2);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        _imageV.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        

    }
    
    
    touchPoint = currentPoint;
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

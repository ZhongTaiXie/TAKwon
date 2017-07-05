//
//  WXCommonViewClass.m
//  TianLvApp
//
//  Created by 霞 王 on 13-7-3.
//  Copyright (c) 2013年 霞 王. All rights reserved.
//

#import "WXCommonViewClass.h"
#import "WXCommonSingletonClass.h"

@implementation WXCommonViewClass

/**wangxia 2013-7-3
 *得到导航条上的返回按钮
 */
+ (UIButton*)getBackButton{
  
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 28, 40);
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
     UIColor *color = CustomBlueColor;
    backButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [backButton setTitleColor:color forState:UIControlStateHighlighted];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backImage.png"] forState:UIControlStateNormal];
    return backButton;
    
}

/**wangxia 2015-4-9
 *得到导航条上的返回按钮
 */
+ (void)setBackButton:(UINavigationBar *)navigationBar;{
    
    [navigationBar setBackIndicatorImage:[UIImage imageNamed:@"backImage.png"]];
    [navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"backImage.png"]];
    
}
/*WYD 2013-7-8 导航右侧按钮*/
+(UIButton*)getRightBtnOfNav:(NSString *)imageName hightlightedImageName:(NSString *)hightlightedImageName  title:(NSString *)titleStr
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    if (titleStr.length >= 3) {
        rightBtn.frame = CGRectMake(0, 0, 18.0*(titleStr.length), 44);
    }else{
        rightBtn.frame = CGRectMake(0, 0, 35.0, 44);
    }
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIColor *color = CustomBlueColor;
    
    [rightBtn setTitleColor:color forState:UIControlStateNormal];
    if (imageName != nil) {
        [rightBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:hightlightedImageName] forState:UIControlStateHighlighted];
    }
    if (titleStr != nil) {
        [rightBtn setTitle:titleStr forState:UIControlStateNormal];
    }
    return rightBtn;
}
+(UIButton*)getRightBtnOfNav:(NSString *)imageName hightlightedImageName:(NSString *)hightlightedImageName  title:(NSString *)titleStr titleColor:(UIColor *)titleColor
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (titleStr.length >= 3) {
        rightBtn.frame = CGRectMake(0, 0, 18.0*(titleStr.length), 44);
    }else{
        rightBtn.frame = CGRectMake(0, 0, 35.0, 44);
    }
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    if (titleColor == nil) {
        titleColor = CustomBlueColor;
    }
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    if (imageName != nil) {
        [rightBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:hightlightedImageName] forState:UIControlStateHighlighted];
    }
    if (titleStr != nil) {
        [rightBtn setTitle:titleStr forState:UIControlStateNormal];
    }
    return rightBtn;
}

/*获取导航左侧按钮*/
+(UIButton*)getLeftBtnOfNav:(NSString *)imageName title:(NSString *)titleStr frame:(CGRect)rect{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIColor *color = CustomBlueColor;
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];

    btn.frame = rect;
    if (imageName != nil) {
        if (titleStr == nil) {
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        }
        
    }
    if (titleStr != nil) {
        [btn setTitle:titleStr forState:UIControlStateNormal];
    }
    return btn;
}


/*zj 2013-8-6 弹出提示语*/
+ (MBProgressHUD *)showHudInView:(UIView *)view title:(NSString *)title{
    if (title == nil || title.length == 0 || view == nil) {
        return nil;
    }
    MBProgressHUD *mBProgressHUD = [[MBProgressHUD alloc]initWithView:view];
    [mBProgressHUD setDetailsLabelFont:[UIFont boldSystemFontOfSize:14]];
    [mBProgressHUD setDetailsLabelText:title];
    //设置纯文字显示效果
    mBProgressHUD.mode = MBProgressHUDModeText;
    [view addSubview:mBProgressHUD];
    
    [mBProgressHUD show:YES];
    [mBProgressHUD hide:YES afterDelay:2];
//    mBProgressHUD.userInteractionEnabled = NO;
    return mBProgressHUD;
}

/*wx 2015-1-4 弹出"添加成功"的提示语*/
+ (MBProgressHUD *)showHudOfAddSuccessInView:(UIView *)view title:(NSString *)title{
    if (title == nil || title.length == 0 || view == nil) {
        return nil;
    }
    MBProgressHUD *mBProgressHUD = [[MBProgressHUD alloc]initWithView:view];
    [mBProgressHUD setLabelFont:[UIFont boldSystemFontOfSize:14]];
    if (title != nil) {
        [mBProgressHUD setLabelText:title];
    }else{
        [mBProgressHUD setLabelText:@"已添加"];
    }
    UIImageView *myImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addSuccess.png"]];
    mBProgressHUD.customView = myImageview;

    mBProgressHUD.mode = MBProgressHUDModeCustomView;
    [view addSubview:mBProgressHUD];
    
    [mBProgressHUD show:YES];
    [mBProgressHUD hide:YES afterDelay:2];
//    mBProgressHUD.userInteractionEnabled = NO;
    return mBProgressHUD;
}

/*wangxia 2015-8-7 在view底部弹出提示语*/
+ (MBProgressHUD *)showHudInButtonOfView:(UIView *)view title:(NSString *)title closeInSecond:(NSInteger)second{
    if (title == nil || title.length == 0 || view == nil) {
        return nil;
    }
    MBProgressHUD *mBProgressHUD = [[MBProgressHUD alloc]initWithView:view];
    //设置纯文字显示效果
    mBProgressHUD.mode = MBProgressHUDModeText;
    mBProgressHUD.yOffset = view.frame.size.height/2 - 90.0f;
    [view addSubview:mBProgressHUD];
    [mBProgressHUD setDetailsLabelText:title];
    [mBProgressHUD setDetailsLabelFont:[UIFont boldSystemFontOfSize:14]];
    [mBProgressHUD show:YES];
    [mBProgressHUD hide:YES afterDelay:second];
//    mBProgressHUD.userInteractionEnabled = NO;
    return mBProgressHUD;

}
/*wangxia 2015-4-2 在指定位置弹出提示语*/
+ (MBProgressHUD *)showHudInButtonOfViewWX:(UIView *)view title:(NSString *)title closeInSecond:(NSInteger)second pointY:(CGFloat)pointY{
    if (title == nil || title.length == 0 || view == nil) {
        return nil;
    }
    MBProgressHUD *mBProgressHUD = [[MBProgressHUD alloc]initWithView:view];
    //设置纯文字显示效果
    mBProgressHUD.mode = MBProgressHUDModeText;
    mBProgressHUD.yOffset = pointY;
    [view addSubview:mBProgressHUD];
    [mBProgressHUD setDetailsLabelText:title];
    [mBProgressHUD setDetailsLabelFont:[UIFont boldSystemFontOfSize:14]];
    [mBProgressHUD show:YES];
    [mBProgressHUD hide:YES afterDelay:second];
//    mBProgressHUD.userInteractionEnabled = NO;
    return mBProgressHUD;
}

/*wangxia 2015-1-4 设置动画的状态
 1.如果导航是不可以操作，UINavigationController
 2.如果导航是可以操作 VC:VC:UIViewController
 */
+ (void)setLoadingHudInView:(BOOL)isShow content:(NSString *)content vc:(UIViewController *)vc{
    if (!isShow) {
        //小圈停止转动
        [MBProgressHUD hideHUDForView:vc.view animated:YES];
    }else {
        //小圈转动
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
        hud.labelText = content ;
        [hud setLabelFont:[UIFont boldSystemFontOfSize:14]];
    }
}
+ (void)setLoadingHudInView:(BOOL)isShow content:(NSString *)content myView:(UIView *)myView{
    if (!isShow) {
        //小圈停止转动
        [MBProgressHUD hideHUDForView:myView animated:YES];
    }else {
        //小圈转动
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:myView animated:YES];
        hud.labelText = content ;
        [hud setLabelFont:[UIFont boldSystemFontOfSize:14]];
    }
}
/*wangxia 2016-6-18 按照高度来压缩图片
 oldImage 图片
 maxSize 默认相框的大小
 */
+ (CGSize)getThumbnailsByHeight:(UIImage *)oldImage maxSize:(CGSize)maxSize{
    CGFloat maxHeight = maxSize.height;
    CGSize size = oldImage.size;
    CGSize newSize;
    CGFloat scale;
    CGFloat tempWidth;
    if (size.height < maxHeight)
    {
        //放大图片
        scale = maxHeight / size.height;
        tempWidth = size.width * scale;
        if (tempWidth > maxSize.width) {
            tempWidth = maxSize.width;
        }
        newSize = CGSizeMake(tempWidth, size.height * scale);

    }else{
        //压缩图片
        scale = size.height / maxHeight;
        tempWidth = size.width / scale;
        if (tempWidth > maxSize.width) {
            tempWidth = maxSize.width;
        }
        newSize = CGSizeMake(tempWidth, size.height/scale);

    }
    
    return newSize;
    
}
/*wangxia 2016-6-18 按照长度度来压缩图片
 oldImage 图片
 maxWidth 缩放的宽度
 */
+ (CGSize)getThumbnailsByWidth:(UIImage *)oldImage maxSize:(CGSize)maxSize{
    CGFloat maxWidth = maxSize.width;
    CGSize size = oldImage.size;
    CGSize newSize;
    CGFloat scale,tempHeight;
    if (size.width < maxWidth)
    {
        //放大图片
        scale = maxWidth / size.width;
        tempHeight = size.height * scale;
        if (tempHeight > maxSize.height) {
            tempHeight = maxSize.height;
        }
        newSize = CGSizeMake(size.width * scale, tempHeight);
        
    }else{
        //压缩图片
        scale = size.width / maxWidth;
        tempHeight = size.height / scale;
        if (tempHeight > maxSize.height) {
            tempHeight = maxSize.height;
        }
        newSize = CGSizeMake(size.width / scale, tempHeight);
    }
   
    return newSize;
    
}
/*wangxia 2013-08-08 成比例缩放图片
 oldImage 图片
 maxSize 相框的大小
 */
+ (CGSize)getSizeOfThumbnails:(UIImage *)oldImage maxSize:(CGSize)maxSize{
    
    CGSize size = oldImage.size;
    CGSize newSize;
    if (size.width < maxSize.width && size.height < maxSize.height)
    {
        //放大图片
        newSize = [self fitsizeFangDa:size maxSize:maxSize];
        
    }else{
        //压缩图片
        newSize = [self fitsize:size maxSize:maxSize];
    }
    /*
    //begin：缩略图
    UIGraphicsBeginImageContext(newSize);
    [oldImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end：缩略图
     */
    return newSize;
    
}

/*wangxia 2013-08-08 成比例缩放图片
 oldImage 图片
 maxSize 相框的大小
 */
+ (UIImage *)getThumbnails:(UIImage *)oldImage maxSize:(CGSize)maxSize{
    
    CGSize size = oldImage.size;
    CGSize newSize;
    if (size.width < maxSize.width && size.height < maxSize.height)
    {
        //放大图片
        newSize = [self fitsizeFangDa:size maxSize:maxSize];
        
    }else{
        //压缩图片
        newSize = [self fitsize:size maxSize:maxSize];
    }
    //begin：缩略图
    UIGraphicsBeginImageContext(newSize);
    [oldImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end：缩略图
    
//    NSData *newData = UIImagePNGRepresentation(newImage);
//    [newData writeToFile:@"/Users/wangxia/Desktop/7.png" atomically:NO];
    return newImage;
    
}
/*放大图片大小*/
+ (CGSize)fitsizeFangDa:(CGSize)thisSize maxSize:(CGSize)maxSize
{
    if(thisSize.width == 0 && thisSize.height == 0){
        return CGSizeMake(0, 0);
    }
    CGFloat wscale = maxSize.width / thisSize.width ;
    CGFloat hscale = maxSize.height / thisSize.height;
    CGFloat scale = ( wscale < hscale ) ? wscale : hscale;
    CGSize newSize = CGSizeMake(thisSize.width * scale, thisSize.height * scale);
    return newSize;
}
/*压缩图片大小*/
+ (CGSize)fitsize:(CGSize)thisSize maxSize:(CGSize)maxSize
{
    if(thisSize.width == 0 && thisSize.height == 0){
        return CGSizeMake(0, 0);
    }
    CGFloat wscale = thisSize.width / maxSize.width;
    CGFloat hscale = thisSize.height / maxSize.height;
    CGFloat scale = ( wscale > hscale ) ? wscale : hscale;
    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    return newSize;
}
//压图图片短边压缩到myValue
+ (UIImage *)compressImage:(UIImage *)oldImage{
    CGFloat myValue = 1080;
    CGSize oldSize = oldImage.size;
    CGSize newSize ;
    //按照短边压缩到myValue
    if (oldSize.width <= oldSize.height && oldSize.width > myValue){
        CGFloat scale = oldSize.width / myValue;
        newSize = CGSizeMake(myValue, oldSize.height/scale);
        
    }else if (oldSize.width >= oldSize.height && oldSize.height > myValue){
        CGFloat scale = oldSize.height / myValue;
        newSize = CGSizeMake(oldSize.width/scale, myValue);
        
    }else{
        //返回原图
        return oldImage;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [oldImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
/*zj 2013-8-20 加载中*/
+ (MBProgressHUD *)showLoadingView:(UIView *)view{
    MBProgressHUD *mBProgressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:mBProgressHUD];
    [view bringSubviewToFront:mBProgressHUD];
    mBProgressHUD.labelText = @"加载中...";
    [mBProgressHUD show:YES];
    return mBProgressHUD;
}
/*zj 2013-8-20 加载中*/
+ (MBProgressHUD *)showLoadingFrame:(CGRect)frame andView:(UIView *)view{
    MBProgressHUD *mBProgressHUD = [[MBProgressHUD alloc] initWithFrame:frame];
  //  [view addSubview:mBProgressHUD];
    [view bringSubviewToFront:mBProgressHUD];
    mBProgressHUD.labelText = @"加载中...";
    mBProgressHUD.alpha = 0;
    [mBProgressHUD show:YES];
    return mBProgressHUD;
}



/*添加星星页面*/
+ (UIView *)getStarView :(float)evaluateValue :(float)pointX :(float)pointY
{
    UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 68, 12)];
    UIView * fullStarView = [[UIView alloc]initWithFrame:CGRectMake(pointX, pointY, evaluateValue*11.8 + 2*(int)evaluateValue, 12)];
    [fullStarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"star_50_1@.png"]]];
    UIImageView * backgroundStarImg = [[UIImageView alloc]init];
    [backgroundStarImg setFrame:CGRectMake(pointX, pointY, 68, 12)];
    [backgroundStarImg setImage:[UIImage imageNamed:@"star_0.png"]];
    [mainView addSubview:fullStarView];
    [mainView addSubview:backgroundStarImg];
    return mainView;
}

/*wangxia 2014-1-5
 *根据label的内容和字体来计算label的高度
 */
+ (CGFloat)heightForLabelWithText:(UILabel *)wxLabel{
    wxLabel.numberOfLines = 0;
    NSDictionary *attribute = @{NSFontAttributeName:wxLabel.font};
    CGSize size = [wxLabel.text boundingRectWithSize:CGSizeMake(wxLabel.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    CGFloat wxHeight = ceilf(size.height);
    return wxHeight;
}
/*wangxia 2015-11-5
 *调用这个参数的时候改对应label Label.numberOfLines = 0
 *根据label的内容和字体来计算的高度
 */
+ (CGFloat)heightForStringWithText:(UIFont *)myFont mySize:(CGSize)mySize content:(NSString *)myContent {
    NSDictionary *attribute = @{NSFontAttributeName:myFont};
    CGSize size = [myContent boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    CGFloat wxHeight = ceilf(size.height);
    return wxHeight;
}

/*wangxia 2014-1-5
 *根据label的内容和字体来计算label的宽度
 */
+ (CGFloat)widthForLabelWithText:(UILabel *)wxLabel{
    wxLabel.numberOfLines = 1;
    NSDictionary *attribute = @{NSFontAttributeName:wxLabel.font};
    CGSize size = [wxLabel.text sizeWithAttributes:attribute];
    float wxHeight = ceilf(size.width);
    return wxHeight;
}
/*wangxia 2014-1-5
 *根据内容和字体来计算宽度
 */
+ (CGFloat)widthForStringWithText:(UIFont *)myFont content:(NSString *)myContent{
    NSDictionary *attribute = @{NSFontAttributeName:myFont};
    CGSize size = [myContent sizeWithAttributes:attribute];
    float wxHeight = ceilf(size.width);
    return wxHeight;
}

#pragma mark - 打电话 发短信

//打电话
+ (void)callPhone:(NSString *)phone showView:(UIView *)showView{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [showView addSubview:callWebview];
    
}
//发短信
+ (void)sendMessage:(NSString *)phone showView:(UIView *)showView{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [showView addSubview:callWebview];
    
}

//解决照片大于2M时照片自动旋转90度问题
+(UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
//根据orgId获取openId
+(NSString *)getMyOpenId:(NSString *)OrgId
{
    WXCommonSingletonClass *singleton = [WXCommonSingletonClass share];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"orgId == %@",OrgId];
    NSArray *array = [singleton.userDataDic[@"orgInfo"] filteredArrayUsingPredicate:pre];
    NSString *myOpenId = [[array objectAtIndex:0]objectForKey:@"openId"];
    return myOpenId;
}
@end

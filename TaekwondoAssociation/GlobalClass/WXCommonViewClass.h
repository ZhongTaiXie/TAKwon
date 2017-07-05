//
//  WXCommonViewClass.h
//  TianLvApp
//
//  Created by 霞 王 on 13-7-3.
//  Copyright (c) 2013年 霞 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface WXCommonViewClass : NSObject
/**wangxia 2013-7-3
 *得到导航条上的返回按钮
 */
+ (UIButton*)getBackButton;

/**wangxia 2015-4-9
 *得到导航条上的返回按钮
 */
+ (void)setBackButton:(UINavigationBar *)navigationBar;

/*WYD 2013-7-8 导航右侧按钮*/
+(UIButton*)getRightBtnOfNav:(NSString *)imageName hightlightedImageName:(NSString *)hightlightedImageName  title:(NSString *)titleStr;

+(UIButton*)getRightBtnOfNav:(NSString *)imageName hightlightedImageName:(NSString *)hightlightedImageName  title:(NSString *)titleStr titleColor:(UIColor *)titleColor;

/*获取导航左侧返回按钮 大小为*/
+(UIButton*)getLeftBtnOfNav:(NSString *)imageName title:(NSString *)titleStr frame:(CGRect)rect;

/*zj 2013-8-6 弹出提示语*/
+ (MBProgressHUD *)showHudInView:(UIView *)view title:(NSString *)title;

/*wx 2015-1-4 弹出"添加成功"的提示语*/
+ (MBProgressHUD *)showHudOfAddSuccessInView:(UIView *)view title:(NSString *)title;

/*wangxia 2015-8-3 在view底部弹出提示语*/
+ (MBProgressHUD *)showHudInButtonOfView:(UIView *)view title:(NSString *)title closeInSecond:(NSInteger)second;

/*wangxia 2015-4-2 在view的指定位置显示*/
+ (MBProgressHUD *)showHudInButtonOfViewWX:(UIView *)view title:(NSString *)title closeInSecond:(NSInteger)second pointY:(CGFloat)pointY;

/*wangxia 2015-1-4 设置动画的状态
 1.如果导航是不可以操作，UINavigationController
 2.如果导航是可以操作 VC:VC:UIViewController
 */
+ (void)setLoadingHudInView:(BOOL)isShow content:(NSString *)content vc:(UIViewController *)vc;
+ (void)setLoadingHudInView:(BOOL)isShow content:(NSString *)content myView:(UIView *)myView;
/*wangxia 2016-6-18 按照高度来压缩图片
 oldImage 图片
 maxSize 默认相框的大小
 */
+ (CGSize)getThumbnailsByHeight:(UIImage *)oldImage maxSize:(CGSize)maxSize;

/*wangxia 2016-6-18 按照长度度来压缩图片
 oldImage 图片
 maxWidth 缩放的宽度
 */
+ (CGSize)getThumbnailsByWidth:(UIImage *)oldImage maxSize:(CGSize)maxSize;

/*wangxia 2013-08-08 成比例缩放图片
 oldImage 图片
 maxSize 相框的大小
 */
+ (UIImage *)getThumbnails:(UIImage *)oldImage maxSize:(CGSize)maxSize;

//压图图片短边压缩到myValue
+ (UIImage *)compressImage:(UIImage *)oldImage;

/*添加星星页面*/
+ (UIView *)getStarView :(float)evaluateValue :(float)pointX :(float)pointY;

/*wangxia 2014-1-5
 *根据label的内容和字体来计算label的高度
 */
+ (CGFloat)heightForLabelWithText:(UILabel *)wxLabel;

/*wangxia 2015-11-5
 *调用这个参数的时候改对应label Label.numberOfLines = 0
 *根据label的内容和字体来计算的高度
 */
+ (CGFloat)heightForStringWithText:(UIFont *)myFont mySize:(CGSize)mySize content:(NSString *)myContent;

/*wangxia 2014-1-5
 *根据label的内容和字体来计算label的宽度
 */
+ (CGFloat)widthForLabelWithText:(UILabel *)wxLabel;

/*wangxia 2014-1-5
 *根据内容和字体来计算宽度
 */
+ (CGFloat)widthForStringWithText:(UIFont *)myFont content:(NSString *)myContent;

//打电话
+ (void)callPhone:(NSString *)phone showView:(UIView *)showView;

//发短信
+ (void)sendMessage:(NSString *)phone showView:(UIView *)showView;

//解决照片大于2M时照片自动旋转90度问题
+(UIImage *)fixOrientation:(UIImage *)aImage;
//根据orgId获取openId
+(NSString *)getMyOpenId:(NSString *)OrgId;
@end

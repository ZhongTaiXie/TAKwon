//
//  WQTools.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WQTools : NSObject


//颜色转换
+ (UIColor *) colorWithHexString: (NSString *)color;
//验证身份证号
+ (BOOL)isValidateIDNumber:(NSString *)IDNumber;

//验证邮箱是否合法
+(BOOL)isValidateEmail:(NSString *)email;

//判断手机号码格式是否正确
+ (BOOL)isValidateMobile:(NSString *)mobile;

//判断一个字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;

//图片转base64
+ (NSString *)imageToBase64:(UIImage *)image;

@end

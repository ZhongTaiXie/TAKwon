//
//  NSObject+Util.h
//  YiZhi
//
//  Created by solesson on 11/8/15.
//  Copyright (c) 2015年 LBS. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,PriceStringStyles)
{
    PriceStringStylesOneDecimal = 0,//一个小数
    PriceStringStylesTwoDecimal = 1,//两个小数
};

@interface NSString (Util)

//判断是否为手机号码
- (BOOL)isMoblePhoneNumber;

//判断是否为邮箱
- (BOOL)isEmail;

//是否为正确的身份证号
- (BOOL)isIDCarNumber;

- (NSString *)MD5String;

- (NSString *)priceString:(PriceStringStyles)style;

// 表情字符串加密
- (NSString *)stringEncode;

// 表情字符串加密
- (NSString *)stringDecode;

//是否是浮点型数字
- (BOOL )isFloatValue;/**< 第一个字符不能是'.' 的浮点数字*/

//是否包含数字和字母
- (BOOL)isContainShuziAndChar;

//判断邮编是否正确
+ (BOOL) isValidZipcode:(NSString*)value;
//银行卡号
- (BOOL)isBankCard;
// 是否是会员编号
- (BOOL)ismuber;
// 是否是道馆
- (BOOL)isdaoguan;

@end

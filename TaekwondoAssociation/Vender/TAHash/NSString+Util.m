//
//  NSObject+Util.m
//  YiZhi
//
//  Created by solesson on 11/8/15.
//  Copyright (c) 2015年 LBS. All rights reserved.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Util)

-(BOOL)hasValue
{
    BOOL result = NO;
    if (self && ![self isEqualToString:@""])
    {
        result = YES;
    }
    return result;
}

//判断是否为邮箱
- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

// 判断是否为手机号码
- (BOOL)isMoblePhoneNumber
{
    //第一个为0或者没有0，其次可以是1或者8，再然后是3到8的一个数字，再然后是9个0到9的数字
    NSString *moble = @"^0?[18][34578]\\d{9}$";
    NSPredicate *predMoble = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",moble];
    if ([predMoble evaluateWithObject:self] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


// 判断是否是会员
- (BOOL)ismuber {
    
    NSString *muberRegex = @"[TN][0-9]{10,11}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", muberRegex];
    return [emailTest evaluateWithObject:self];
}
// 道馆
- (BOOL)isdaoguan {
    
    NSString *muberRegex = @"CTA([0-9]{2}|[0-9]{5}|[0-9]{9})";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", muberRegex];
    return [emailTest evaluateWithObject:self];
}

//是否包含数字和字母
- (BOOL)isContainShuziAndChar
{
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, self.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    if (tNumMatchCount == self.length) {
        //全部符合数字，表示沒有英文
        return NO;
    } else if (tLetterMatchCount == self.length) {
        //全部符合英文，表示沒有数字
        return NO;
    } else if (tNumMatchCount + tLetterMatchCount == self.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return YES;
    } else {
        return NO;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }}

- (BOOL)isIDCarNumber
{
    //15位身份证号
  
    NSString *number1 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    //18位身份证号
    NSString *number2 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}(\\d|x|X)$";
    NSLog(@"正则： %@",number1);
    NSPredicate *predNumber1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number1];
    NSPredicate *predNumber2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number2];
    
    BOOL isType1 = [predNumber1 evaluateWithObject:self];
    BOOL isType2 = [predNumber2 evaluateWithObject:self];
    if (isType1 || isType2) {
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)MD5String
{
    //转换成utf-8
    const char *cStr = [self UTF8String];
    
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        //x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (NSString *)priceString:(PriceStringStyles)style
{
    NSString *newStr = @"";

    if (style == PriceStringStylesOneDecimal)
    {
        newStr = [NSString stringWithFormat:@"¥ %.1f",self.floatValue];
    }
    else if (style == PriceStringStylesTwoDecimal)
    {
        newStr = [NSString stringWithFormat:@"¥ %.2f",self.floatValue];
    }
    return newStr;
}


// 表情字符串编码
- (NSString *)stringEncode
{
    NSString *endcoderStr = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return endcoderStr;
}

// 表情字符串解密
- (NSString *)stringDecode
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@""];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

//是否是浮点型数字
- (BOOL)isFloatValue
{
    if ([self characterAtIndex:0] != '.')
    {
        //第一个字符不能是'.'的浮点型
        NSScanner *scan = [NSScanner scannerWithString:self];
        float val;
        return [scan scanFloat:&val] && [scan isAtEnd];
    }
    else
    {
        return NO;
    }
    
}

+ (BOOL) isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}

//是否是正确的银行卡号
-(BOOL)isBankCard{
    if (self.length == 0) {
        return NO;
    }
    
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < self.length; i++){
        c = [self characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    
    return modulus == 0;
}
@end








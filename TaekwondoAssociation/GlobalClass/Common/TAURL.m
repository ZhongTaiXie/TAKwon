//
//  TAURL.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAURL.h"

@implementation TAURL

NSString *const URL_BASE = @"http://192.168.1.7";

// 主页
//NSString *const URL_HOME =@"/interfaceapi/indexintmgt/index!index.action?";

NSString *const URL_HOME =@"/Home/Index";

NSString * const URL_LONGIN = @"/SignIn/SignIn";

NSString * const URL_REGIST = @"/Register/Register";

NSString * const URL_MROEPIC = @"/Home/LasterPicList";

NSString * const URL_THIRDLGON = @"http://www.chntkd.org.cn/webInterFace/APP_interface/json/membershipInformation.ashx";

NSString * const URL_FORGETPASS = @"/Account/ForgetPwd";
NSString * const URL_SEARCHHOTS = @"/Search/HotSearchKey_Query";


@end

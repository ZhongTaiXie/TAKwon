//
//  LCProgressHUD.m
//  DuoC
//
//  Created by Ceres on 15/6/30.
//  Copyright (c) 2015年 www.duoc.cn. All rights reserved.
//

#import "LCProgressHUD.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

#define kFontSize 13
#define kBackGroundColor [UIColor colorWithType:StandardColorTypeGray1]
#define kLCPCornerRadius 7
@interface LCProgressHUD ()


@end

@implementation LCProgressHUD


+(void)LCPshowSinpleHUDOntarget:(UIView *)view delegate:(id<MBProgressHUDDelegate>) delegate excuting:(SEL)method
{
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
   MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelFont = [UIFont systemFontOfSize:kFontSize];
    HUD.cornerRadius = kLCPCornerRadius;
//    HUD.color = kBackGroundColor;
    [view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = delegate;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
    
}


+ (void)showTextOntarget:(UIView *)view serverError_Code:(NSDictionary *)response
{
    
    NSString *messageCode = [response objectForKey:@"error_code"];
    id errorMessage = [response objectForKey:@"message"];
    
    NSArray *serverErrorCodeArray = @[@"E_FAIL",@"E_INVALID_PARAM",@"E_SESSION_TIMEOUT",@"E_KICK_OFF",@"E_NOT_LOGIN",@"E_PERMISSION_DENIED",@"E_ERROR_FROM_MARS"];
    
    
        [LCProgressHUD showTextOntarget:view string:errorMessage];
    
        
    

        
        

}




+ (void)showTextOntarget:(UIView *)view string:(NSString *)str
{
    if (view) {
           [view endEditing:YES];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
       hud.labelFont = [UIFont systemFontOfSize:13];
    hud.labelFont = [UIFont systemFontOfSize:kFontSize];
    hud.cornerRadius = kLCPCornerRadius;
//    hud.color = kBackGroundColor;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@" %@ ",str];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


+ (void)showTextOntarget:(UIView *)view stringType:(kCreateStyleErrorType )type
{
    
    /*
     kLoadImageFail,
     kCreateStyleErrorTypeContent
     kCreateStyleErrorTypeGroup,
     kCreateStyleErrorTypeTitle,
     kCreateStyleErrorTypeTitleLenth18
     kCreateStyleErrorTypeMainPic,
     kCreateStyleErrorTypeIntroText,
     kCreateStyleErrorTypeIntroImageNumberLower3
     kCreateStyleErrorTypeRemindStyle,
     kCreateStyleErrorTypeRemindTime,
     kCreateStyleErrorTypeWantToSay,
     kCreateStyleErrorTypeLimitedTime,
     kCreateStyleErrorTypePeriod,
     kCreateStyleErrorTypePeriodNumber
      kCreateStyleErrorTypePeriodLimiteTime,
     kCreateStyleErrorTypePermission,
     
     kCreateStyleErrorTypeSameRemindTime,
     
     //添加东西
     kADDObjectErrorTypeNameLenthLowOrHigh,
     kADDObjectErrorTypeThingName,
     kADDObjectErrorTypeThingImage,
     kADDObjectErrorTypeVideoName,
     kADDObjectErrorTypeVideoURL,
     kADDObjectErrorTypeTeacherName,
     kADDObjectErrorTypeTeacherURL,
     kADDObjectErrorTypeAPPURL
     
     kRegisterAndLoginErrorTypeMobile,
     kRegisterAndLoginErrorTypeCode,
     kRegisterAndLoginErrorTypePsw,
     kRegisterAndLoginErrorTypePswLenth
     kRegisterAndLoginErrorTypeNickname,
     kRegisterAndLoginErrorTypeAge,
     kRegisterAndLoginErrorTypeSex,
     
     kCreateStyleErrorTypePostDynamicText
     
     kCreateStyleErrorTypeReplyDynamicText
     
     //计划跳转缺少id
     kStyleDetailErrorTypeLostStyleID,
     
     kReportErrorTypeLostContent,
     */
    NSArray *errorArray = [NSArray arrayWithObjects:@"上传图片失败，请重新上传",
                                                    @"您还没有填写内容",
                                                    @"您选择的分类有误",
                                                    @"您还没有填写标题",
                                                    @"计划标题不能超过18个字符",
                                                    @"请选取一张图片作为计划主图",
                                                    @"请输入介绍内容",
                                                    @"介绍图片不能超过3张",
                                                    @"提醒方式有误",
                                                    @"提醒时间有误",
                                                    @"提醒标题有误",
                                                    @"提醒限定时间有误",
                                                    @"计划周期有误",
                                                    @"周期只能是数字",
                                                    @"周期只能位于1-365天之间",
                           
                                                    @"计划权限有误",
                           
                                                    @"两个任务的时间不能相同",
                           @"物品名称长度在1-18个字符之间",
                           @"添加的物品名称有误",
                           @"添加的物品图片有误",
                           @"添加的视频名称有误",
                           @"添加的视频链接有误",
                           @"添加的教程名称有误",
                           @"添加的教程链接有误",
                           @"APPStore繁忙，请稍后再试",
                           
                                                    @"您输入的手机号有误",
                                                    @"验证码有误",
                                                    @"您输入的密码不一致",
                                                    @"请输入六位以上密码",
                           @"您输入的昵称有误",
                           @"您输入的年龄有误",
                           @"您选择的性别有误",
                           @"说点什么吧~",
                           @"说点什么吧~",
                           @"缺少必要的计划ID~",
                           @"说点意见才能提交哦",
                           @"至少上传一张图片",
                           @"请输入对医生的评论内容",

                                                    nil];
    [LCProgressHUD showTextOntarget:view string:errorArray[type]];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

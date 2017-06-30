//
//  LCProgressHUD.h
//  DuoC
//
//  Created by Ceres on 15/6/30.
//  Copyright (c) 2015年 www.duoc.cn. All rights reserved.
//

#import "MBProgressHUD.h"

#define kNetWorkError @"网络好像出问题了，请检查后重试!"
#define kServerError @"网络繁忙，请稍候重试"
#define kUPaiYunError @"又拍云上传图片出错，请稍候重试"


typedef enum : NSUInteger {
    kSeverErrorCodeTypeFail,
    kSeverErrorCodeTypeInvalidParams,
    kSeverErrorCodeTypeSessionTimeOut,
    kSeverErrorCodeTypeKickOff,
    kSeverErrorCodeTypeNotLogin,
    kSeverErrorCodeTypePermissionDenied,
    kSeverErrorCodeTypeFromMars,
} kSeverErrorCodeType;


typedef enum : NSUInteger {
    kLoadImageFail,
    kCreateStyleErrorTypeContent,
    kCreateStyleErrorTypeGroup,
    kCreateStyleErrorTypeTitle,
    kCreateStyleErrorTypeTitleLenth18,
    kCreateStyleErrorTypeMainPic,
    kCreateStyleErrorTypeIntroText,
    kCreateStyleErrorTypeIntroImageNumberLower3,
     kCreateStyleErrorTypeRemindStyle,
     kCreateStyleErrorTypeRemindTime,
    kCreateStyleErrorTypeWantToSay,
    kCreateStyleErrorTypeLimitedTime,
    kCreateStyleErrorTypePeriod,
    kCreateStyleErrorTypePeriodNumber,
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
    kADDObjectErrorTypeAPPURL,
    
    kRegisterAndLoginErrorTypeMobile,
    kRegisterAndLoginErrorTypeCode,
    kRegisterAndLoginErrorTypePsw,
    kRegisterAndLoginErrorTypePswLenth,
    kRegisterAndLoginErrorTypeNickname,
    kRegisterAndLoginErrorTypeAge,
    kRegisterAndLoginErrorTypeSex,
    //发布动态提示
    kCreateStyleErrorTypePostDynamicText,
    
    //回复动态提示
    kCreateStyleErrorTypeReplyDynamicText,
    
    //计划跳转缺少id
    kStyleDetailErrorTypeLostStyleID,
    
    //意见反馈
    kReportErrorTypeLostContent,
    kPostErrorTypeNeedImages,
    kPostErrorTypeCommentContentNull,
    
} kCreateStyleErrorType;

@interface LCProgressHUD : MBProgressHUD

+(void)showSinpleHUDOntarget:(UIView *)view delegate:(id<MBProgressHUDDelegate>) delegate excuting:(SEL)method;

+ (void)showTextOntarget:(UIView *)view string:(NSString *)str;

+ (void)showTextOntarget:(UIView *)view stringType:(kCreateStyleErrorType )type;

//服务器返回错误处理。
+ (void)showTextOntarget:(UIView *)view serverError_Code:(NSDictionary *)response;

@end

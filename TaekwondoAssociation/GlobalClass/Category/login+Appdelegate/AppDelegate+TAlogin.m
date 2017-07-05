//
//  AppDelegate+TAlogin.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "AppDelegate+TAlogin.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <RennSDK/RennSDK.h>

@implementation AppDelegate (TAlogin)

- (void)thirdLogin {
    
    // 第三方登录
    [ShareSDK registerApp:@"16a0993f1718f"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeDouBan),
                            @(SSDKPlatformTypeMail)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeRenren:
                 [ShareSDKConnector connectRenren:[RennClient class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1050731872"
                                           appSecret:@"9d0253d69a51721a654a66e127687bc1"
                                         redirectUri:@"http://www.simuwang.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 //                 [appInfo SSDKSetupWeChatByAppId:@"wx767d5681a7937ece"
                 //                                     appSecret:@"491b1eef75000d61f1bcce487712e629"];
                 break;
             case SSDKPlatformTypeQQ:
                 //                 [appInfo SSDKSetupQQByAppId:@"100371282"
                 //                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                 //                                    authType:SSDKAuthTypeBoth
                 //                                      ];
                 //                 [appInfo SSDKSetupQQByAppId:@"1105584601"
                 //                                      appKey:@"WhoZ90pCM1KLsk11"
                 //                                    authType:SSDKAuthTypeBoth];
                 [appInfo SSDKSetupQQByAppId:@"1106180873" appKey:@"20OclPXEp0n7xG9e" authType:SSDKAuthTypeBoth];
                 break;
                 case SSDKPlatformTypeRenren:
                 [appInfo SSDKSetupRenRenByAppId:@"577430" appKey:@"8afd59f9dd7d432e943d70e489133bbb" secretKey:@"c9034e261c6645d1a70cfe67f8750735" authType:SSDKAuthTypeBoth];
                 break;
//                 case SSDKPlatformTypeDouBan:
//                 [appInfo SSDKSetupDouBanByApiKey:@"" secret:@"" redirectUri:SSDKAuthTypeBoth];
//                 break;
             default:
                 break;
         }
     }];
    
    
}


@end

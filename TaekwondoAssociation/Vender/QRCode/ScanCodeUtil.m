//
//  ScanCodeUtil.m
//  XMCitizenCard
//
//  Created by Liulu on 2017/6/7.
//  Copyright © 2017年 nationz. All rights reserved.
//

#import "ScanCodeUtil.h"
#import "LBXScanViewController.h"
#import "LBXScanNative.h"
@implementation ScanCodeUtil

+ (void)scanWithViewController:(UIViewController *)viewController success:(void(^)(NSString *result))block {
    LBXScanViewController *vc = [[LBXScanViewController alloc]init];
    vc.successBlock = block;
    viewController.hidesBottomBarWhenPushed = YES; //有tabbar时添加
    [viewController.navigationController pushViewController:vc animated:YES];
    viewController.hidesBottomBarWhenPushed = NO;  //有tabbar时添加
}

+ (UIImage*)createQRWithString:(NSString*)text QRSize:(CGSize)size {
    return [LBXScanNative createQRWithString:text QRSize:size];
}

@end

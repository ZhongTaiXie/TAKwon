//
//  TARequestManager.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TARequestManager.h"

@implementation TARequestManager

+ (void)TARequestCompletedWithParameters:(NSDictionary *)parameters sucee:(successBlock)success fail:(failureBlock)failure {
    
    [[TAHttpClient defaultClient]requestWithPath:URL_HOME method:HttpRequestGet paramenters:parameters prepareExecute:nil success:success failure:failure];
   

}

@end

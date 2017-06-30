//
//  TAHttpClient.h
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

//HTTP请求类别
typedef NS_ENUM(NSInteger,HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
};


/**
 *  请求前预处理block
 */
typedef void(^PrepareExecuteBlock)(void);

typedef void(^SuccessBlock)(id responseObject);

typedef void(^FailureBlock)(NSError * error);

@interface TAHttpClient : NSObject

+ (TAHttpClient *)defaultClient;

// 普通请求 
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
            paramenters:(NSDictionary *)params
         prepareExecute:(PrepareExecuteBlock)prepare
                success:(SuccessBlock)success
                failure:(FailureBlock)failure;
//  上传图片   
- (void)PostImageWithPath:(NSString *)url
                    image:(UIImage *)image
               parameters:(NSDictionary *)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

@end


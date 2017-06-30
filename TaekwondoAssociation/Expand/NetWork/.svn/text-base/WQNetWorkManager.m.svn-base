
//  WQPrefixHeader.pch
//  优款
//
//  Created by gut on 16/12/19.
//  Copyright © 2016年 com.personal. All rights reserved.
//

#import "WQNetWorkManager.h"
#import <AFNetworking.h>

@implementation WQNetWorkManager

+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)data success:(successBlock)success failure:(failureBlock)failure{
    
    //和AFNetworing相关的调用
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:urlStr parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"=========%ld",error.code);
        NSLog(@"%@     %ld",urlStr,((NSHTTPURLResponse *)task.response).statusCode);
        failure(error);
    }];
}

+ (void)sendPostRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)data success:(successBlock)success failure:(failureBlock)failure{
    
    //和AFNetworing相关的调用
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager POST:urlStr parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"=========%ld",error.code);
        failure(error);
    }];
}

@end

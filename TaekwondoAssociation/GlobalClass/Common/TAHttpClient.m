//
//  TAHttpClient.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAHttpClient.h"
#import "MBProgressHUD.h"

NSString *const upImageType = @"image/jpg/png/jpeg";


@interface TAHttpClient ()


@property (nonatomic, strong) AFHTTPSessionManager * manager;

@property (nonatomic, assign) BOOL isConnect;

@end

@implementation TAHttpClient


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.manager = [AFHTTPSessionManager manager];
        //设置请求类型
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置响应类型
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        
        //开启监听
        [self openNetMonitoring];
        
    }
    return self;
}

- (void)openNetMonitoring {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.isConnect = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.isConnect = YES;
                break;
            default:
                break;
        }
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    self.isConnect = YES;
}

static TAHttpClient * instance = nil;

+ (TAHttpClient *)defaultClient {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
            paramenters:(NSDictionary *)params
         prepareExecute:(PrepareExecuteBlock)prepare
                success:(SuccessBlock)success
                failure:(FailureBlock)failure {
    
    url = [NSString stringWithFormat:@"%@%@",URL_BASE,url];
    NSLog(@"请求网络地址为：%@",url);
    
    if ([self isConnectionAvailable]) {
     
        if (method == HttpRequestGet) {
            [self.manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"请求返回的是：%@", jsonString);
                
                
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        } else if(method == HttpRequestPost) {
            
            [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"请求返回的是：%@", jsonString);
                NSDictionary *dic = (NSDictionary *)responseObject[@"Data"];
                NSString *str = (NSString *)responseObject[@"Success"];
                if ([str isEqualToString:@"true"]) {
                    NSLog(@"数据返回正常");
                    success(dic);
                }else {
                    NSLog(@"数据非正常！");
                    success(dic);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                NSLog(@"%@",error);
            }];
        }

        
        
    } else {
        // 没有网络 
        [self showExceptionDialog];
    }
}

- (BOOL)isConnectionAvailable {
    
    return self.isConnect;
}

# warning  需要和后台商量文件名字和文件大小

- (void)PostImageWithPath:(NSString *)url image:(UIImage *)image parameters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [self.manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *Data = UIImageJPEGRepresentation(image, 0.28);
     
        [formData appendPartWithFileData:Data name:@"" fileName:@"" mimeType:upImageType];
   
    } progress:^(NSProgress * _Nonnull uploadProgress) {
      
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%f",progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}


- (void)showExceptionDialog {
    
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接异常，请检查网络连接" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
}

@end

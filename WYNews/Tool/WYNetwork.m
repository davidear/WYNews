//
//  WYNetwork.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNetwork.h"
#import "WYtool.h"
@implementation WYNetwork
{
    AFNetworkReachabilityStatus _netStatus;
}
single_implementation(WYNetwork)

- (instancetype)init
{
    self = [super init];
    if (self) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kWYNetworkBaseURLStr] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        self.sessionManager = manager;
        
        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_reachabilityManager startMonitoring];
        //        __weak typeof(WYNetwork *) blockNetwork = self;
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _netStatus = status;
            switch (status) {
                case 0:
                    [WYTool showMsg:@"当前无网络"];
                    break;
                default:
                    break;
            }
        }];
    }
    return self;
}

+ (void)startEngine
{
    [WYNetwork sharedWYNetwork];
}
- (void)HttpGet:(NSString *)URLString parameter:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [_sessionManager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (void)HttpPost:(NSString *)URLString parameter:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [_sessionManager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
#pragma mark -
- (void)HttpGetNews:(NSString *)urlString success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self HttpGet:urlString parameter:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)HttpGetTopic:(NSString *)urlString success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    
}
@end

//
//  WYNetwork.h
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Singleton.h"
@interface WYNetwork : NSObject
single_interface(WYNetwork)
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) AFNetworkReachabilityManager *reachabilityManager;

+ (void)startEngine;
//- (void)HttpPostComment:(NSDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)HttpGet:(NSString *)URLString parameter:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


- (void)HttpGetNews:(NSString *)urlString success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end

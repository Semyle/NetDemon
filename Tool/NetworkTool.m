//
//  NetworkTool.m
//  SocialNet
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "NetworkTool.h"
#import <AFNetworking/AFNetworking.h>



#ifdef DEBUG            //s
static NSString *baseUrl = @"https://www.1000phone.tk";

#else
static NSString *baseUrl = @"10.30.152.134";

#endif

@implementation NetworkTool

+ (AFHTTPSessionManager *)shareManager {
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://www.1000phone.tk"]];
        manager.requestSerializer.timeoutInterval = 30.0;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/html", @"text/xml", @"application/json", nil];
    });
    
    return manager;
}



+ (void)getDataWithParameters:(NSDictionary *)parameters completeBlock:(void (^)(BOOL, id))complete{
    
    [[self shareManager] POST:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber *serviceCode =  [responseObject objectForKey:@"ret"];
        if ([serviceCode isEqualToNumber:@200]) {
            NSDictionary *retData = [responseObject objectForKey:@"data"];
            NSNumber *dataCode = [retData objectForKey:@"code"];
            if ([dataCode isEqualToNumber:@0]) {
                NSDictionary *userInfo = [retData objectForKey:@"data"];
                if (complete) {
                    complete(YES,userInfo);
                }
            }else{
                NSString *dataMessage = [retData objectForKey:@"msg"];
                NSLog(@"%@",dataMessage);
                if (complete) {
                    complete (NO,dataMessage);
                }
            }
        }else{
            NSString *serviceMessage = [responseObject objectForKey:@"msg"];
            NSLog(@"%@",serviceMessage);
            if (complete) {
                
                complete (NO,serviceMessage);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (complete) {
            complete(NO,error.localizedDescription);
        }
        
    }];
    
    
}
















@end

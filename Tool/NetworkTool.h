//
//  NetworkTool.h
//  SocialNet
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTool : NSObject


+ (void)getDataWithParameters:(NSDictionary *)parameters completeBlock:(void(^)(BOOL success, id result))complete;

+ (void)uploadImageData:(NSData *)imageData andParameters:(NSDictionary *)parameters completeBlock:(void(^)(BOOL sussess,id result))complete;

@end

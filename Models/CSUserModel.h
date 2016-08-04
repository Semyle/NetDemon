//
//  CSUserModel.h
//  SocialNet
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUserModel : NSObject

//通常将用户当做一个模型来判断，那么用户是否登录就需要我们封装一个方法，因为在我们程序整个生命周期内，很可能只会创建一个用户对象，所以我们用类方法判断就可以了

+ (BOOL)isLogin;

@end

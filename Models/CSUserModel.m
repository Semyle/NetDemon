//
//  CSUserModel.m
//  SocialNet
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSUserModel.h"


// 存储用户信息的 key
static NSString *userInfoKey = @"UserInfoKey";
static NSString *userStatusKey = @"UserStatusKey";

@implementation CSUserModel



+(NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID": @"id"
             };
}
+(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults]boolForKey:userStatusKey];
}

// 当某个类(或者分类)一旦加载，就会调用这个方法
+ (void)load {
    // 判断用户以前是否登录，如果登录了，就将存储的用户信息取出，并设置单例
    if ([self isLogin]) {
        [self loginWithInfo:[[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey]];
    }
}

+ (CSUserModel *)sharedUser {
    static CSUserModel *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[CSUserModel alloc] init];
    });
    return sharedUser;
}

// 需要把用户的登录的状态存储起来
// 还可能需要存储登录的信息. id, token
// 如果对于数量较少的信息，可以直接存储到 NSUserDefault
// 我们在何时存储?
// 关于用户登录或者退出登录这样的事件，一般我们都会使用通知来做
// 因为这里很可能是一对多的关系

// 封装给外部两个方法
+ (void)loginWithInfo:(NSDictionary *)userInfo {
    // 1.用户登录完成，需要更新用户信息
    [[self sharedUser] yy_modelSetWithDictionary:userInfo];
    // 2.通知所有的地方，用户登录成功
    [[NSNotificationCenter defaultCenter] postNotificationName:WLogInSuccess object:nil];
    // 3.将用户的登录状态和信息存储到本地
    [self saveUserInfo:userInfo];
}

// 存储用户信息和登录状态
+ (void)saveUserInfo:(NSDictionary *)userInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    // 用 setObject: forKey: 存储用户信息
    [userDefault setObject:[[self sharedUser] yy_modelToJSONObject] forKey:userInfoKey];
    // 用 setBool: forKey: 存储用户状态
    [userDefault setBool:!!userInfo forKey:userStatusKey];
    // 同步一下
    [userDefault synchronize];
}

+ (void)logOff {
    // (1.)把用户model对象属性置空
    // 2.发送用户登出的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WLogOffSuccess object:nil];
    // 3.删除本地存储的用户信息
    [self saveUserInfo:nil];
}


@end

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

+ (CSUserModel *)sharedUser;

// 封装给外部两个方法
+ (void)loginWithInfo:(NSDictionary *)userInfo;
+ (void)logOff;

/**
 *  用户的手机号
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  头像图片地址
 */
@property (nonatomic, copy) NSString *avatar;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *gender;
/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  生日
 */
@property (nonatomic, copy) NSString *birthday;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;



@end

//
//  ViewController.m
//  SocialNet
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *parameter = @{
                                @"service": @"UserInfo.GetInfo",
                                @"uid": @"1",
                                };
    
    [NetworkTool getDataWithParameters:parameter completeBlock:^(BOOL success, id result) {
        
        if (success) {
            NSLog(@"用户信息-------%@",result);
        }else{
            NSLog(@"失败原因-----------%@",result);
        }
    }];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

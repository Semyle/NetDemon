//
//  CSViewController.m
//  SocialNet
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSViewController.h"
#import "CSUserModel.h"
#import "MainViewController.h"
#import "CSLoginViewController.h"

@interface CSViewController ()

@end

@implementation CSViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    将所有的控制器按照MVC的思想配置好，并且封装起来
    [self setUpViewController];
    
//    当用户没有登录的时候需要弹出登录界面


}


- (void)viewDidAppear:(BOOL)animated{
//    在这里养成一个习惯，要在声明周其方法中调用父类方法
    [super viewDidAppear:animated];
    if (![CSUserModel isLogin]) {
        [self showLoginViewController];
    }
    
    
    
}

- (void)showLoginViewController{
    
    CSLoginViewController *loginVC = [[CSLoginViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    //    用摸态视图弹出登录控制器
    [self presentViewController:navVC animated:YES completion:nil];
    
}


- (void)setUpViewController{
//    如何使用MVC的思想
    NSArray *controllerInfos = @[
//                                 数组里面没一个条目都是一个字典，里面配置了所有控制器显示的效果和类型
                                 @{
                                     @"class":[MainViewController class],
                                     @"title":@"首页",
                                     @"icon":@"tabBar1",
                                     
                                     },
                                 @{
                                     @"class":[UIViewController class],
                                     @"title":@"第二页",
                                     @"icon":@"tabBar2",
                                     
                                     },
                                 @{
                                     @"class":[UIViewController class],
                                     @"title":@"第四页",
                                     @"icon":@"tabBar3",
                                     
                                     },
                                 @{
                                     @"class":[UIViewController class],
                                     @"title":@"第五页",
                                     @"icon":@"tabBar4",
                                     
                                     },
                                 ];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:controllerInfos.count];
    
//    数组的枚举遍历法
//    id  _Nonnull obj:数组里面的元素，_Nonnull也可以具体到Dictionary
    [controllerInfos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        这里直接拿遍历传过来的字典，取出其中的控制器类型，然后创建一个控制器
        UIViewController *viewController = [[[obj objectForKey:@"class"] alloc]init];
        viewController.title = [obj objectForKey:@"title"];
        
//        再创建一个导航控制器 装入刚才创建的控制器
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:viewController];
    
//        需要将导航控制器加入到数组中
        [viewControllers addObject:navVC];
        
    }];
    
    self.viewControllers = viewControllers;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

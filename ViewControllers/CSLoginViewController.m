//
//  CSLoginViewController.m
//  SocialNet
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSLoginViewController.h"
#import <Masonry/Masonry.h>
//这里面封装了一个方法，可以让我们通过一个颜色生成一张纯色的图片
#import "UIImage+Color.h"
#import "UIButton+BackgroundColor.h"




@interface CSLoginViewController ()

@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    ;
    self.title = @"登录";
    [self setUpViews];
    


}
//页面将要消失
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
//页面将要出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];

    
}
//页面已经消失
- (void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
//页面已经出现
- (void)viewDidAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)setUpViews{
//    创建登录界面的控件布局
    
//    注意：使用Autolayout，就不需要将位置定死
    UITextField *phoneText = [[UITextField alloc]init];
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    
    UITextField *password = [[UITextField alloc]init];
    [self.view addSubview:password];
    password.backgroundColor = [UIColor whiteColor];
    
    phoneText.placeholder = @"输入邮箱或者手机号码";
    password.placeholder = @"输入密码";
    
    password.secureTextEntry = YES;
    
    UIImageView *phoneLeftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户图标"]];
    UIImageView *pwdleftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码图标"]];
    
    UIView *phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    UIView *passwordLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [phoneLeft addSubview:phoneLeftImg];
    [passwordLeft addSubview:pwdleftImg];
    [phoneLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        让视图居中：相对于父控件
        make.center.equalTo(@0);
    }];
    
    [pwdleftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
    }];
    
//    系统自带的左边视图，右边视图（但是不会自己显示，需要手动设置Mode）
    phoneText.leftView = phoneLeftImg;
    password.leftView = pwdleftImg;
    
//    手动设置一直都显示
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    password.leftViewMode = UITextFieldViewModeAlways;
    
//    手写输入框的布置
//    在写布局的时候，我们添加的所有约束必须能够唯一确定这个视图的位置和大小(至少四个有效约束)
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
        
//        上面两句可以合成一句:,前提是约束一样
        make.left.right.equalTo(@0);
        
        make.height.equalTo(@64);
        make.top.equalTo(@120);
        
//        Masonry的强大之处：充分考虑到了我们写约束的时候越简单越好，所以应用了链式写法
        
        
    }];
    
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phoneText.mas_bottom);
    }];
//    字重：可以简单理解为粗细
    phoneText.font = [UIFont systemFontOfSize:15 weight:-0.15];
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
//    加边框的的时候记得是CGColor
    phoneText.layer.borderColor = [UIColor grayColor].CGColor;
    phoneText.layer.borderWidth = 0.5;
    
    password.layer.borderColor = [UIColor grayColor].CGColor;
    password.layer.borderWidth = 0.5;
    
//    写自定义button一定要用这个工厂方法
    UIButton *forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass titleLabel].font = [UIFont systemFontOfSize:14];
    
    [forgetPass setFrame:CGRectMake(self.view.frame.size.width-80, 280, 80, 64)];
    [self.view addSubview:forgetPass];
/*
 我们用自动布局的时候，就不能再以某个视图的frame当做参数来用，此时视图的frame是不可靠的
 
 
 */
    
    
    
//    登录按钮
    UIButton *logininButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logininButton setTitle:@"登录" forState:UIControlStateNormal];
    [logininButton titleLabel].font = [UIFont systemFontOfSize:15];
    [logininButton setFrame:CGRectMake(0, 400, self.view.bounds.size.width, 64)];
    [self.view addSubview:logininButton];
    
    //    按钮一般有三个状态：普通状态，高亮状态，，不可用使的状态
    [logininButton setBackgroundColor:[UIColor colorWithRed:0.386 green:0.490 blue:0.667 alpha:1.000] forState:UIControlStateNormal];
    [logininButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [logininButton setBackgroundColor:[UIColor orangeColor] forState:UIControlStateHighlighted];


//    当我们不用Autolayout的时候，如何让视图自适应
//    让登录按钮的宽度和左边距离保持和父控件相对位置不变
     logininButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    
    
    
    
    
    
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

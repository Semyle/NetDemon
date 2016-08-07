//
//  CSLoginViewController.m
//  SocialNet
//
//  Created by qianfeng on 16/8/3.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSLoginViewController.h"
#import "CSForgetViewController.h"
#import "CSRegisterViewController.h"

//这里面封装了一个方法，可以让我们通过一个颜色生成一张纯色的图片
#import "UIImage+Color.h"
#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import "UIAlertView+Block.h"
#import "NSString+MD5.h"





@interface CSLoginViewController ()

@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.924 green:1.000 blue:0.940 alpha:1.000];
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
    // 创建手机号码输入框，密码输入框，登录按钮
    UITextField *phonetext = [[UITextField alloc] init];
    [self.view addSubview:phonetext];
    phonetext.backgroundColor = [UIColor whiteColor];
    
    UITextField *password = [[UITextField alloc] init];
    [self.view addSubview:password];
    password.backgroundColor = [UIColor whiteColor];
    
    phonetext.placeholder = @"输入邮箱或者手机号码";
    password.placeholder = @"输入密码";
    
    password.secureTextEntry = YES;
    
    UIImageView *phoneLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户图标"]];
    UIImageView *passLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码图标"]];
    UIView *phoneLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    UIView *passLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [phoneLeft addSubview:phoneLeftImage];
    [passLeft addSubview:passLeftImage];
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        // 让视图居中
        make.center.equalTo(@0);
    }];
    [passLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    
    phonetext.leftView = phoneLeft;
    password.leftView = passLeft;
    phonetext.leftViewMode = UITextFieldViewModeAlways;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    // 手写输入框的布局
    // 在写布局的时候，我们添加的所有约束必须能够唯一确定这个视图的位置和大小
    [phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        //		make.left.equalTo(@0);
        //		make.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(@120);
        make.left.right.equalTo(@0);
        // 因为 Masonry 在实现的时候，充分考虑到我们写约束的时候越简单越好，所以引入了链式写法，我们在写的时候，可以尽量的将一样的约束写到一起。
    }];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phonetext.mas_bottom);
    }];
    
    phonetext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    password.layer.borderColor = [UIColor grayColor].CGColor;
    password.layer.borderWidth = 0.5;
    
    // 写自定义 button 一定要用这个工厂方法。
    UIButton *forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass titleLabel].font = [UIFont systemFontOfSize:14];
    // 80 64
    // 我们用 autoLayout 时候，就不能再以某个视图的 frame 当做参数来用(此时，视图的 frame 是不可靠)
    [forgetPass setFrame:CGRectMake(self.view.frame.size.width - 80, 250, 80, 64)];
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
    
    [forgetPass setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [forgetPass handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        CSForgetViewController *forgetVC = [[CSForgetViewController alloc]init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(goToRegister)];
    
    [phonetext handleControlEvents:UIControlEventEditingChanged withBlock:^(id weakSender) {
        
        if (phonetext.text.length >= 11) {
            if (phonetext.text.length>11) {
                
                phonetext.text = [phonetext.text substringToIndex:11];
            }
            [password becomeFirstResponder];
        }
    }];
    RAC(logininButton,enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal,password.rac_textSignal] reduce:^(NSString *phone,NSString *pass){
        return @(phone.length >= 11 && pass.length >= 6);
    }];
    [logininButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        NSDictionary *paras = @{
                                @"service":@"User.Login",
                                @"phone":phonetext.text,
                                @"password":[password.text md532BitUpper]
                                };
        [NetworkTool getDataWithParameters:paras completeBlock:^(BOOL success, id result) {
            
            if (success) {
                NSLog(@"%@",result);
                [CSUserModel loginWithInfo:result];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{
                [UIAlertView alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"确定" otherButtonTitles: nil];
            }
        }];
    }];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)goToRegister{
    
    CSRegisterViewController *registerVC = [[CSRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
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

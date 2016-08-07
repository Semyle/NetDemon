//
//  CSRegisterViewController.m
//  SocialNet
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSRegisterViewController.h"

#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import <SMS_SDK/SMSSDK.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "NSTimer+Blocks.h"
#import "NSTimer+Addition.h"
#import "NSString+MD5.h"
#import "UIAlertView+Block.h"

@interface CSRegisterViewController ()

@property (nonatomic,strong)NSNumber *waitTime;     //验证码发送后的读秒
@property (nonatomic,strong)NSTimer *timer;         //定时器

@end

@implementation CSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.916 green:0.869 blue:1.000 alpha:1.000];
    self.title = @"注册页面";
    [self setupViews];


}

- (void)setupViews{
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
    UIView *phoneLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 48)];
    UIView *passLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 48)];
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
        make.height.equalTo(@48);
        make.top.equalTo(@120);
        make.left.right.equalTo(@0);
        // 因为 Masonry 在实现的时候，充分考虑到我们写约束的时候越简单越好，所以引入了链式写法，我们在写的时候，可以尽量的将一样的约束写到一起。
    }];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@48);
        make.top.equalTo(phonetext.mas_bottom);
    }];
    
    phonetext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    password.layer.borderColor = [UIColor grayColor].CGColor;
    password.layer.borderWidth = 0.5;
    
    // 注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton titleLabel].font = [UIFont systemFontOfSize:15];
    [registerButton setFrame:CGRectMake(0, 320, self.view.frame.size.width, 48)];
    [self.view addSubview:registerButton];
   
    // 一般我们的按钮，都会需要三个状态下的背景颜色，1,普通状态 2,高亮状态 3,不可同时候的状态
   
    [registerButton setBackgroundColor:[UIColor colorWithRed:0.497 green:0.956 blue:0.629 alpha:1.000] forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [registerButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    UITextField *veriText = [[UITextField alloc] init];
    veriText.placeholder = @"输入验证码";
    veriText.backgroundColor = [UIColor whiteColor];
    veriText.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [self.view addSubview:veriText];
    [veriText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@48);
        make.top.equalTo(password.mas_bottom).offset(16);
    }];
    veriText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    veriText.layer.borderWidth = 1.0f;
    UIView *veriLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 48)];
    UIImageView *veriLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [veriLeft addSubview:veriLeftImage];
    [veriLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    veriText.leftView = veriLeft;
    veriText.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:0.490 green:1.000 blue:0.147 alpha:1.000] forState:UIControlStateNormal];
    [rightButton titleLabel].font = [UIFont systemFontOfSize:14 weight:-0.15];
    [rightButton layer].borderColor = [UIColor lightGrayColor].CGColor;
    [rightButton layer].borderWidth = 1.0f;
    [rightButton layer].cornerRadius = 4.f;
    [rightButton layer].masksToBounds = YES;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 108, 48)];
    [rightView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.left.equalTo(@4);
    }];
    veriText.rightView = rightView;
    veriText.rightViewMode = UITextFieldViewModeAlways;
    // 设置用户输入框，只能输入数字。
    phonetext.keyboardType = UIKeyboardTypeNumberPad;
    
    // ReactiveCocoa 处理
   
    
    // RAC 帮我们实现了很多系统自带的信号，文本框的变化、按钮点击...
    // 我们去订阅这些信号，那么当信号一旦发生变化，就会通知我们
    [phonetext.rac_textSignal subscribeNext:^(NSString *phone) {
        if (phone.length >= 11) {
            // 当输入的手机号超过11位，直接将密码框设置为第一响应者
            [password becomeFirstResponder];
            if (phone.length > 11) {
                phonetext.text = [phone substringToIndex:11];
            }
        }
    }];
    
    // 我们给等待时间赋初值为-1
    self.waitTime = @-1;
    
    // 获取验证码按钮默认应该是不可点的
    rightButton.enabled = NO;
    // 我们可以直接将某个信号处理的返回结果，设置为某个对象的属性值。
    //	[RACSignal combineLatest:@[] reduce:];
    //	combineLatest 一堆信号的集合
    RAC(rightButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal, RACObserve(self, waitTime)] reduce:^(NSString *phone, NSNumber *waitTime){
        return @(phone.length >= 11 && waitTime.integerValue <= 0);
    }];
    // RAC可以将信号和处理写到一起，我们写项目的时候，不用再去来回找了。
    registerButton.enabled = NO;
    RAC(registerButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal, password.rac_textSignal, veriText.rac_textSignal] reduce:^(NSString *phone, NSString *pass, NSString *veri){
        return @(phone.length >= 11 && pass.length >=6 && veri.length == 4);
    }];
    
    
    // 如果在实际开发环境中，我们在做发送验证码的功能时，都会有一个等待时间
    // 1、为了节省成本
    // 一般开发中，用第三方短信提供商做发送验证码功能，一条/6-8/分钱,所以成本还是挺高的。
    // 2、为了用户体验
    [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        // 直接进入读秒
        self.waitTime = @60;
        //	发送验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phonetext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                // 如果失败，让等待时间变为-1
                self.waitTime = @-1;
            }else {
                NSLog(@"获取验证码成功");
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f block:^{
                    // 让等待时间减一
                    self.waitTime = [NSNumber numberWithInteger:self.waitTime.integerValue -1];
                    
                } repeats:YES];
            }
        }];
    }];
    
    // 用 RAC 监控数据的变化，显示相应的界面
    [RACObserve(self, waitTime) subscribeNext:^(NSNumber *waitTime) {
        if (waitTime.integerValue <= 0) {
            // 将定时器去除的操作写到这里也可以
            [self.timer invalidate];
            self.timer = nil;
            [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }else if(waitTime.integerValue > 0) {
            [rightButton setTitle:[NSString stringWithFormat:@"等待%@秒", waitTime] forState:UIControlStateNormal];
        }
    }];
    
    [[registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        
        NSString *pass = [password.text md532BitUpper];
        NSDictionary *paras = @{
                                @"service": @"User.Register",
                                @"phone": phonetext.text,
                                @"password": pass,
                                @"verificationCode": veriText.text,
                                };
        // 注册用户
        [NetworkTool getDataWithParameters:paras completeBlock:^(BOOL success, id result) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [UIAlertView alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"确定" otherButtonTitles:nil];
            }
        }];
    }];
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

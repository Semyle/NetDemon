//
//  CSAboutViewController.m
//  SocialNet
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSAboutViewController.h"
#import "UIButton+BackgroundColor.h"
#import <CoreTelephony/CTCall.h>  
#import <CoreTelephony/CTCallCenter.h>

#import <MessageUI/MessageUI.h>     //系统的，可以用来发短信，发邮件

@interface CSAboutViewController ()<MFMessageComposeViewControllerDelegate>{
    CTCallCenter *_CtCallCenter;
}

@end

@implementation CSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    关于我们这个界面，一般都是写死的，用XIB做最好，会包含应用的基本信息（版本，开发）和联系方式
//    打电话，发短信
    self.title = @"关于";
    self.view.backgroundColor = [UIColor colorWithRed:0.997 green:1.000 blue:0.917 alpha:1.000];
    [self setUpButtons];

//    我们如何去监控手机打电话的状态,去做相应的处理
//    
    CTCallCenter *callCenter = [[CTCallCenter alloc]init];
    [callCenter setCallEventHandler:^(CTCall * call) {
        NSLog(@"哈哈哈-------%@",[call callState]);
        
    }];

    
//    我们现在用的arc，如果对象不被应用的话会被直接销毁掉，所以我们虽然写了处理的block，
    _CtCallCenter = callCenter;
    
    
}

- (void)setUpButtons{
    NSArray *titles = @[@"打电话一",@"打电话二",@"发短信一",@"发短信二"];
    UIButton *lastButton = nil;
    for (int i = 0; i<titles.count; ++i) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blueColor]];
        [self.view addSubview:button];
//        我们用masonry设置这样的button约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@16);
            make.centerX.equalTo(@0);
            make.height.equalTo(@48);
            make.top.equalTo(lastButton ? lastButton.mas_bottom:self.view).offset(lastButton ? 16: 80);
        }];
        lastButton = button;
        button.tag = i+10;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    
}


- (void)tapButton:(UIButton *)sender{
    if (sender.tag ==10) {
//        最简单的打电话方式，调用电话APP 直接打给某一个号码，并且没有提示,但是会被AppStore拒绝我们的应用，不建议使用
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://114"]];
        
    }else if (sender.tag == 11){
//        用这种方式发短信，无法回到我们的应用,
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://120"]];
    }else if (sender.tag == 12){
//        我们甚至可以用webView 来打电话
        UIWebView *webView = [[UIWebView alloc]init];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://114"]]];
//        最后记得将webView 加到self.View上,这里的webView最好用懒加载的方式
        [self.view addSubview:webView];
    }else{
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
        if ([MFMessageComposeViewController canSendText] )  //返回类方法，所以用类去调用，而不是点属性
        {
            messageVC.body = @"青岛啤酒节开幕了";
            messageVC.recipients = @[@"110",@"120",@"119"];     //接收短信的对象，可群发
            messageVC.delegate = self;
            [self presentViewController:messageVC animated:YES completion:nil];
        }
        
    }
    
    
//    一般ios APP直接应用船只都是使用这种方式，一个APP一旦定义了自己的scheme，那么其他APP就可以直接打开它，我们在APPDELEGATE中可以根据传来的不同参数执行不同的功能
//    在ios9之后我们想要打开其他的APP需要经过用户同意才可以,并且需要现在plist文件中配置好对方的scheme
//    我们还可以通过这种方式去手机用户手机上都安装了哪些应用
    [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tencent://"]];
    [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"wechat://"]];
    
    
    
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
//    不管成功还是失败，我们要将控制器隐藏
    [controller dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%d",result);            //经验告诉我们，群发的人数不要超过50人，否则会在跳的时候很卡
    
    
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

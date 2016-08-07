//
//  CSEditNameViewController.m
//  CodeShare
//
//  Created by 王广威 on 16/8/5.
//  Copyright © 2016年 北京千锋-王广威. All rights reserved.
//

#import "CSEditNameViewController.h"

#import "UIControl+ActionBlocks.h"

@interface CSEditNameViewController ()

@end

@implementation CSEditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"更改姓名";
	self.view.backgroundColor = [UIColor colorWithRed:0.840 green:0.931 blue:0.914 alpha:1.000];
	
	UITextField *nickName = [[UITextField alloc] init];
	[self.view addSubview:nickName];
	[nickName mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(@0);
		make.top.equalTo(@80);
		make.height.equalTo(@48);
	}];
	nickName.backgroundColor = [UIColor whiteColor];
	nickName.placeholder = @"不得超过15个字母和字符";
	nickName.returnKeyType = UIReturnKeyDone;
	[nickName handleControlEvents:UIControlEventEditingDidEndOnExit withBlock:^(id weakSender) {
		// 在这里调用修改用户信息的接口
		NSDictionary *paras = @{
								@"service": @"UserInfo.UpdateInfo",
								@"uid": [CSUserModel sharedUser].ID,
								@"nickname": nickName.text,
								};
		[NetworkTool getDataWithParameters:paras completeBlock:^(BOOL success, id result) {
			if (success) {
				[self.navigationController popViewControllerAnimated:YES];
			}else {
				
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

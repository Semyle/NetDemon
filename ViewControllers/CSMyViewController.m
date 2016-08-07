//
//  CSMyViewController.m
//  CodeShare
//
//  Created by 王广威 on 16/8/5.
//  Copyright © 2016年 北京千锋-王广威. All rights reserved.
//

#import "CSMyViewController.h"
#import "UIControl+ActionBlocks.h"
#import "CSSettingViewController.h"

@interface CSMyViewController ()

// 如果一个界面被加入到父视图上面，就代表已经被强引用了，所以不需要再去强引用也不会被释放掉，所以我们用 xib 拖控件的时候，默认是 weak 引用。
// 平时我们写的时候，也可以尽量的写成 weak 引用，防止有特殊情况会发生循环引用
@property (nonatomic, weak) UIScrollView *scrollView;

// 内容视图，加在 scrollView 上面，所有其他视图需要加到这个视图上面，也实现了当内容不够的时候，界面也能有弹性滚动效果
@property (nonatomic, weak) UIView *contentView;

@end

@implementation CSMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"我的";
	self.view.backgroundColor = [UIColor colorWithWhite:0.934 alpha:1.000];
	
	// 整个界面在一个 scrollView 上面。
	[self setUpScrollView];
	// 配置界面上方的显示样式
	[self setUpTopViews];
}

- (void)setUpScrollView {
	UIScrollView *scrollView = [[UIScrollView alloc] init];
	[self.view addSubview:scrollView];
	scrollView.backgroundColor = [UIColor colorWithRed:0.950 green:1.000 blue:0.864 alpha:1.000];
	
	self.scrollView = scrollView;
	// 只有当 scrollView 的内容大于宽高才可以有滚动的效果
	UIView *contentView = [[UIView alloc] init];
	contentView.backgroundColor = [UIColor colorWithRed:0.587 green:0.720 blue:0.785 alpha:1.000];
	[scrollView addSubview:contentView];
	[contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.right.equalTo(self.view);
//		make.top.equalTo(self.view);
//		// offset 是偏移量，可以为正为负。
//		make.height.greaterThanOrEqualTo(self.view).offset(1);
		make.edges.equalTo(scrollView);
		make.width.equalTo(self.view);
		make.height.greaterThanOrEqualTo(self.view).offset(1 - 64 - 49);
		make.bottom.equalTo(scrollView);
	}];
	self.contentView = contentView;
	
	// 当我们在使用 autoLayout(不管是 xib 还是手写)，做 scrollView 的约束时候，都要定义一个内容视图将 scrollView 撑起来。
	[scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.top.right.equalTo(@0);
		// 让本视图的上下左右边都等于父视图
		make.edges.equalTo(self.view);
//		make.height.equalTo(contentView);
	}];
	// 如果控制器里有 scrollView ,并且有导航条或者 tabBar ，系统会默认将 scrollView 的上部留有 64 的高度，下部留 49 的高度，防止内容被挡住。
	// 但是在实际做项目的时候，我们为了方便的手动管理，会把这个特性去掉，然后自己写
	self.automaticallyAdjustsScrollViewInsets = NO;
	// 手动设置滚动指示器的 insets.
	scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
	// 手动设置 scrollView 的 insets ,防止内容被盖住
	scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
//	scrollView.contentSize
//	scrollView.contentOffset
	
}

- (void)setUpTopViews {
	UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景图片"]];
	[self.contentView addSubview:backImageView];
	[backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self.view);
		make.top.equalTo(@16);
		make.height.equalTo(@140);
	}];
	
	// 用户头像
	UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户头像"]];
	[backImageView addSubview:headImageView];
	[headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.equalTo(@16);
		make.width.height.equalTo(@48);
	}];
	// 用户昵称
	UILabel *nickNameLabel = [[UILabel alloc] init];
	nickNameLabel.font = [UIFont systemFontOfSize:16 weight:-0.15];
	nickNameLabel.textColor = [UIColor whiteColor];
	[backImageView addSubview:nickNameLabel];
	[nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(headImageView.mas_right).offset(8);
		make.top.equalTo(@16);
		make.width.equalTo(@200);
	}];
	// 用户邮箱
	UILabel *emailLabel = [[UILabel alloc] init];
	emailLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
	emailLabel.textColor = [UIColor whiteColor];
	[backImageView addSubview:emailLabel];
	[emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(nickNameLabel);
		make.top.equalTo(nickNameLabel.mas_bottom).offset(4);
		make.width.equalTo(@200);
	}];
	// 设置按钮
	UIButton *settings = [UIButton buttonWithType:UIButtonTypeCustom];
	[settings setTitle:@"设置" forState:UIControlStateNormal];
	[settings setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[settings titleLabel].font = [UIFont systemFontOfSize:15 weight:-0.15];
	[backImageView addSubview:settings];
	[settings mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(@-16);
		make.centerY.equalTo(@0);
		make.width.equalTo(@48);
		make.height.equalTo(@32);
	}];
	// 先完成设置界面，并且完善用户资料
	[settings handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
		CSSettingViewController *settingVC = [[CSSettingViewController alloc] init];
		settingVC.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:settingVC animated:YES];
	}];
	// 将ImageView 的用户交互打开
	backImageView.userInteractionEnabled = YES;
	
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

//
//  CSSettingViewController.m
//  CodeShare
//
//  Created by 王广威 on 16/8/5.
//  Copyright © 2016年 北京千锋-王广威. All rights reserved.
//

#import "CSSettingViewController.h"
#import "CSAboutViewController.h"

#import "CSInfoViewController.h"

static NSString *settingCellID = @"settingCellID";

@interface CSSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation CSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"设置";
	self.view.backgroundColor = [UIColor colorWithWhite:0.928 alpha:1.000];
	// 初始化数据
	[self initData];
	// 设置界面
	[self setUpTableView];
}

- (void)initData {
	// 我们用 MVC 的方式去写 tableView, 让 tableView 根据我们提前设置好的数据去展示就行了。
	self.dataArr = @[
					 @[
						 @{
							 @"title": @"个人信息",
							 @"subTitle": @"哈哈",
							 @"cellType": @"arrow",
							 },
						 ],
					 @[
						 @{
							 @"title": @"允许查看我的分享",
							 @"subTitle": @"允许查看我的下载",
							 @"cellType": @"switch",
							 },
						 @{
							 @"title": @"允许查看我的下载",
							 @"subTitle": @"哈哈",
							 @"cellType": @"switch",
							 },
						 @{
							 @"title": @"任何人允许添加我为好友",
							 @"subTitle": @"哈哈",
							 @"cellType": @"switch",
							 },
						 ],
					 @[
						 @{
							 @"title": @"保存到本地",
							 @"subTitle": @"哈哈",
							 @"cellType": @"arrow",
							 },
						 @{
							 @"title": @"账号绑定",
							 @"subTitle": @"QQ:123456789",
							 @"cellType": @"arrow",
							 },
						 ],
					 @[
						 @{
							 @"title": @"清除缓存",
							 @"subTitle": @"哈哈",
							 @"cellType": @"",
							 },
						 @{
							 @"title": @"用户反馈",
							 @"subTitle": @"哈哈",
							 @"cellType": @"arrow",
							 },
						 @{
							 @"title": @"关于我们",
							 @"subTitle": @"哈哈",
							 @"cellType": @"arrow",
							 },
						 ],
					 ];
}

- (void)setUpTableView {
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	tableView.backgroundColor = [UIColor colorWithWhite:0.897 alpha:1.000];
	[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:settingCellID];
	tableView.delegate = self;
	tableView.dataSource = self;
	[self.view addSubview:tableView];
	[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self.dataArr objectAtIndex:section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 42;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:settingCellID];
	NSDictionary *cellInfo = [[self.dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	settingCell.textLabel.text = [cellInfo objectForKey:@"title"];
	NSString *cellType = [cellInfo objectForKey:@"cellType"];
	settingCell.textLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
	
	if ([cellType isEqualToString:@"arrow"]) {
		settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}else if ([cellType isEqualToString:@"switch"]) {
		settingCell.accessoryView = [[UISwitch alloc] init];
	}else {
		settingCell.accessoryType = UITableViewCellAccessoryNone;
	}
	return settingCell;
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.section == 0) {
		CSInfoViewController *infoVC = [[CSInfoViewController alloc] init];
		[self.navigationController pushViewController:infoVC animated:YES];
	}
	
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

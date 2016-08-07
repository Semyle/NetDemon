//
//  CSInfoViewController.m
//  CodeShare
//
//  Created by 王广威 on 16/8/5.
//  Copyright © 2016年 北京千锋-王广威. All rights reserved.
//

#import "CSInfoViewController.h"
#import "UIButton+BackgroundColor.h"
#import "CSEditNameViewController.h"
#import "UIControl+ActionBlocks.h"

static NSString *infoCellID = @"InfoCellID";

@interface CSInfoViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) UIImageView *headImage;

@end

@implementation CSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"个人信息";
	self.view.backgroundColor = WArcColor;
	
	[self initData];
	[self setUpTableView];
	
}

- (void)initData {
	self.dataArr = @[
					 @{
						 @"title": @"昵称",
						 @"class": [CSEditNameViewController class],
						 },
					 @{
						 @"title": @"性别",
						 @"class": [UIViewController class],
						 },
					 @{
						 @"title": @"出生日期",
						 @"class": [UIViewController class],
						 },
					 @{
						 @"title": @"所在地",
						 @"class": [UIViewController class],
						 },
					 ];
}

- (void)setUpTableView {
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	[self.view addSubview:tableView];
	tableView.dataSource = self;
	tableView.delegate = self;
	[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	
	// 顶部头像
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
	UIImageView *headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户头像"]];
	[headerView addSubview:headImage];
	tableView.tableHeaderView = headerView;
	[headImage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(@0);
		make.width.height.equalTo(@100);
	}];
	[headImage setUserInteractionEnabled:YES];
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editAvatar)];
	[headImage addGestureRecognizer:tapGesture];
	self.headImage = headImage;
	
	// 底部退出登录按钮
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
	UIButton *logOffButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[logOffButton setTitle:@"退出登录" forState:UIControlStateNormal];
	[logOffButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[logOffButton setBackgroundColor:[UIColor colorWithRed:0.797 green:0.357 blue:0.500 alpha:1.000] forState:UIControlStateNormal];
	[logOffButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[footerView addSubview:logOffButton];
	tableView.tableFooterView = footerView;
	
	[logOffButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(@0);
		make.height.equalTo(@48);
		make.centerY.equalTo(@0);
	}];
	[logOffButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
		[CSUserModel logOff];
	}];
	
	// 注册 cell
	[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:infoCellID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 48;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
	
	infoCell.textLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
	infoCell.textLabel.text = [[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"title"];
	infoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return infoCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 8;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSDictionary *cellInfo = [self.dataArr objectAtIndex:indexPath.section];
	UIViewController *nextVC = [[[cellInfo objectForKey:@"class"] alloc] init];
	[self.navigationController pushViewController:nextVC animated:YES];
	
}

- (void)editAvatar {
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照", nil];
	[sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"%ld", buttonIndex);
	if (buttonIndex == 0) {
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		// 从图片库去选择图片
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		// 设置代理，处理图片选择完成的回调
		imagePicker.delegate = self;
		// 支持图片裁减
		imagePicker.allowsEditing = YES;
		// 将图片选择控制器弹出
		[self presentViewController:imagePicker animated:YES completion:nil];
		
	}else if(buttonIndex == 1) {
		
	}
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
	// 在代理方法中，要先将控制器隐藏
	[picker dismissViewControllerAnimated:YES completion:nil];
	
	// 将图片信息取出
	UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
	// 1. 将头像设置为这个图片
	[self.headImage setImage:editedImage];
	// 2. 将图片压缩上传
	// 无损压缩
//	NSData *imageData = UIImagePNGRepresentation(editedImage);
	
	// 有损压缩，一般我们去计算得到的图片文件过大，都会用有损压缩。
	// 压缩质量，0-1直接的数，越小，压缩的越厉害
	NSData *imageData = UIImageJPEGRepresentation(editedImage, 0.9);
	// 上传
	NSDictionary *paras = @{
							@"service": @"UserInfo.UpdateAvatar",
							@"uid": [CSUserModel sharedUser].ID,
							};
	[NetworkTool uploadImageData:imageData andParameters:paras completeBlock:^(BOOL success, id result) {
		
	}];
	
	NSLog(@"%@", info);
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

//
//  ViewController.m
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "ViewController.h"
#import "SCBasicUsageVC.h"
#import "SCCustomAnimationVC.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.data = @[@"Basic Usage(基本用法)", @"Custom animation with CAAnimation(使用CAAnimation自定义动画)"];
    
    self.title = @"SCPop";
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 64.f, self.view.frame.size.width, self.view.frame.size.height - (UIApplication.sharedApplication.statusBarFrame.size.height + 64.f));
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SCBasicUsageVC *basicUsageVC = [[SCBasicUsageVC alloc] init];
        basicUsageVC.title = self.data[indexPath.row];
        [self.navigationController pushViewController:basicUsageVC animated:YES];
    } else if (indexPath.row == 1) {
        SCCustomAnimationVC *customAnimVC = [[SCCustomAnimationVC alloc] init];
        customAnimVC.title = self.data[indexPath.row];
        [self.navigationController pushViewController:customAnimVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.f;
}

#pragma mark - Lazy Load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}


@end

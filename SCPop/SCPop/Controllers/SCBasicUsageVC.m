//
//  SCBasicUsageVC.m
//  SCPop
//
//  Created by samueler on 2018/12/24.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "SCBasicUsageVC.h"
#import "SCBasicPop.h"

@interface SCBasicUsageVC ()

@property (nonatomic, strong) SCBasicPop *pop;

@end

@implementation SCBasicUsageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"normal without maskColor(普通初始化，不能设置遮罩层背景颜色)", @"normal with maskColor(普通初始化，可设置遮罩层背景颜色)", @"block without maskColor(block方式初始化，不能设置遮罩层背景颜色)", @"block with maskColor(block方式初始化，可设置遮罩层背景颜色)"];
    
    for (NSInteger idx = 0; idx < titles.count; idx++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = idx;
        [btn setTitle:titles[idx] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showPop:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        btn.frame = CGRectMake(0, 100 + idx * 98, self.view.frame.size.width, 88.f);
    }
}

- (void)showPop:(UIButton *)btn {
    if (btn.tag == 0) {
        [self normalShowWithoutMaskColor];
    } else if (btn.tag == 1) {
        [self normalShowWithMaskColor];
    } else if (btn.tag == 2) {
        [self blockShowWithoutMaskColor];
    } else {
        [self blockShowWithMaskColor];
    }
}

- (void)normalShowWithoutMaskColor {
    self.pop = [SCBasicPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow];
    self.pop.touchDismiss = YES;
    [self popAddObserver];
}

- (void)normalShowWithMaskColor {
    self.pop = [SCBasicPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow maskColor:[UIColor colorWithWhite:0 alpha:0.3]];
    self.pop.touchDismiss = YES;
    [self popAddObserver];
}

- (void)blockShowWithoutMaskColor {
    __block typeof(self) weakSelf = self;
    self.pop = [SCBasicPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow showCompleted:^(BOOL finished) {
        if (finished) {
            NSLog(@"Show Animation Finished");
        }
    } dismissCompleted:^(BOOL finished) {
        if (finished) {
            NSLog(@"Dismiss Animation Finished");;
            
            [weakSelf.pop removeFromSuperview];
            weakSelf.pop = nil;
        }
    }];
    self.pop.touchDismiss = YES;
    self.pop.bounces = YES;
}

- (void)blockShowWithMaskColor {
    __block typeof(self) weakSelf = self;
    self.pop = [SCBasicPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow maskColor:[UIColor colorWithWhite:0 alpha:0.3] showCompleted:^(BOOL finished) {
        if (finished) {
            NSLog(@"Show Animation Finished");
        }
    } dismissCompleted:^(BOOL finished) {
        if (finished) {
            NSLog(@"Dismiss Animation Finished");;
            
            [weakSelf.pop removeFromSuperview];
            weakSelf.pop = nil;
        }
    }];
    self.pop.touchDismiss = YES;
}

- (void)popAddObserver {
    __block typeof(self) weakSelf = self;
    self.pop.showCompleted = ^(BOOL finished) {
        if (finished) {
            NSLog(@"Show Animation Finished");
        }
    };
    
    self.pop.dismissCompleted = ^(BOOL finished) {
        if (finished) {
            NSLog(@"Dismiss Animation Finished");;
            
            [weakSelf.pop removeFromSuperview];
            weakSelf.pop = nil;
        }
    };
}

@end

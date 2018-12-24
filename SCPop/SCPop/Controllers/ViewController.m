//
//  ViewController.m
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "ViewController.h"
#import "SCDefaultAnimaitonPop.h"

@interface ViewController ()

@property (nonatomic, strong) SCDefaultAnimaitonPop *pop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.pop = [SCDefaultAnimaitonPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow];
//    self.pop.bounces = YES;
//    self.pop.touchDismiss = YES;
    __weak typeof(self) weakSelf = self;
//    self.pop.dismissCompleted = ^(BOOL finished) {
//        [weakSelf.pop removeFromSuperview];
//        weakSelf.pop = nil;
//    };
    
    self.pop = [SCDefaultAnimaitonPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow showCompleted:nil dismissCompleted:^(BOOL finished) {
        [weakSelf.pop removeFromSuperview];
        weakSelf.pop = nil;
    }];
    self.pop.touchDismiss = YES;
}


@end

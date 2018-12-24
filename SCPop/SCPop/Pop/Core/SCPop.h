//
//  SCPop.h
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPopProtocol.h"

typedef void(^SCPopAnimationCompleted)(BOOL finished);

@interface SCPop : UIView <SCPopProtocol>

+ (instancetype)showPopOnTargetView:(UIView *)targetView
                      showCompleted:(SCPopAnimationCompleted)showCompleted
                   dismissCompleted:(SCPopAnimationCompleted)dismissCompleted;

+ (instancetype)showPopOnTargetView:(UIView *)targetView
                          maskColor:(UIColor *)maskColor
                      showCompleted:(SCPopAnimationCompleted)showCompleted 
                   dismissCompleted:(SCPopAnimationCompleted)dismissCompleted;

+ (instancetype)showPopOnTargetView:(UIView *)targetView;

+ (instancetype)showPopOnTargetView:(UIView *)targetView
                          maskColor:(UIColor *)maskColor;

/**
 Like UIScrollView's bounces property.
 
 default NO. if YES, lock vertical scrolling while dragging.
 */
@property (nonatomic, assign) BOOL bounces;

/**
 default NO. if YES, dismiss content when you touch the area of beyound the content.
 */
@property (nonatomic, assign) BOOL touchDismiss;

/**
 Show pop animation callback when animation finished.
 */
@property (nonatomic, copy) SCPopAnimationCompleted showCompleted;

/**
 Dismiss pop animation callback when animation finished.
 */
@property (nonatomic, copy) SCPopAnimationCompleted dismissCompleted;

- (void)showPop;
- (void)dismissPop;

@end

//
//  SCPop.m
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "SCPop.h"
#import "SCPopScrollView.h"

#define SCPop_defaultMaskColor [UIColor colorWithWhite:0 alpha:0.5]

@interface SCPop () <CAAnimationDelegate>

@property (nonatomic, strong) SCPopScrollView *scrollView;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) CAAnimation *innerShowAnimation;
@property (nonatomic, strong) CAAnimation *innerDismissAnimation;

@end

@implementation SCPop

#pragma mark - Initializaiton Functions

+ (instancetype)showPopOnTargetView:(UIView *)targetView {
    return [self showPopOnTargetView:targetView maskColor:SCPop_defaultMaskColor];
}

+ (instancetype)showPopOnTargetView:(UIView *)targetView maskColor:(UIColor *)maskColor {
    
    if (!targetView) {
        return nil;
    }
    
    if (!maskColor) {
        maskColor = SCPop_defaultMaskColor;
    }
    
    SCPop *pop = [[self alloc] initWithFrame:targetView.bounds];
    pop.backgroundColor = maskColor;
    [targetView addSubview:pop];
    return pop;
}

+ (instancetype)showPopOnTargetView:(UIView *)targetView
                      showCompleted:(SCPopAnimationCompleted)showCompleted
                   dismissCompleted:(SCPopAnimationCompleted)dismissCompleted {
    return [self showPopOnTargetView:targetView maskColor:SCPop_defaultMaskColor showCompleted:showCompleted dismissCompleted:dismissCompleted];
}

+ (instancetype)showPopOnTargetView:(UIView *)targetView
                          maskColor:(UIColor *)maskColor
                      showCompleted:(SCPopAnimationCompleted)showCompleted
                   dismissCompleted:(SCPopAnimationCompleted)dismissCompleted {
    SCPop *pop = [self showPopOnTargetView:targetView maskColor:maskColor];
    pop.showCompleted = [showCompleted copy];
    pop.dismissCompleted = [dismissCompleted copy];
    return pop;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sc_contentValid];
        [self sc_addSubviews];
        [self sc_layoutSubViews];
        [self sc_contentShowAnimation];
        [self sc_popScrollViewAddObserver];
    }
    return self;
}

#pragma mark - Public Functions

- (void)showPop {
    [self sc_contentShowAnimation];
}

- (void)dismissPop {
    [self sc_contentDismissAnimation];
}

#pragma mark - Private Functions

- (void)sc_contentValid {
    self.contentView = [self sc_popContentView];
    NSAssert(self.contentView, @"Please setup pop's content view, it isn't allowed to be nil!");
    
    self.contentSize = [self sc_popContentSize];
    NSAssert(!CGSizeEqualToSize(self.contentSize, CGSizeZero), @"Please setup pop's contentSize correctly!");
}

- (void)sc_addSubviews {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
}

- (void)sc_layoutSubViews {
    self.scrollView.frame = self.bounds;
    self.contentView.frame = (CGRect) {CGPointMake((self.bounds.size.width - self.contentSize.width) * 0.5, self.bounds.size.height), self.contentSize};
}

#pragma mark - Observe Functions

- (void)sc_popScrollViewAddObserver {
    __weak typeof(self) weakSelf = self;
    self.scrollView.touchOnContent = ^(BOOL touchOnContent) {
        if (weakSelf.touchDismiss && !touchOnContent) {
            [weakSelf dismissPop];
        }
    };
}

#pragma mark - Animation Functions

- (void)sc_contentShowAnimation {
    [self.contentView.layer removeAllAnimations];
    self.innerShowAnimation = [self sc_popShowAnimation];
//    self.innerShowAnimation.delegate = self;
    if (self.innerShowAnimation) {
        [self.contentView.layer addAnimation:self.innerShowAnimation forKey:@"sc_popShow"];
        return;
    }
    
    [self sc_defaultShowAnimation];
}

- (void)sc_contentDismissAnimation {
    [self.contentView.layer removeAllAnimations];
    self.innerDismissAnimation = [self sc_popDismissAnimation];
    if (self.innerDismissAnimation) {
        [self.contentView.layer addAnimation:self.innerDismissAnimation forKey:@"sc_popDismiss"];
        return;
    }
    
    [self sc_defaultDismissAnimation];
}

- (void)sc_defaultShowAnimation {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -(self.frame.size.height + self.contentSize.height) * 0.5);
    } completion:^(BOOL finished) {
        if (self.showCompleted) {
            self.showCompleted(finished);
        }
    }];
}

- (void)sc_defaultDismissAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (self.dismissCompleted) {
            self.dismissCompleted(finished);
        }
    }];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isEqual:self.innerShowAnimation]) {
        if (self.showCompleted) {
            self.showCompleted(flag);
        }
    } else if ([anim isEqual:self.innerDismissAnimation]) {
        if (self.dismissCompleted) {
            self.dismissCompleted(flag);
        }
    }
}

#pragma mark - SCPopProtocol

- (CGSize)sc_popContentSize {
    return CGSizeZero;
}

- (UIView *)sc_popContentView {
    return nil;
}

- (CAAnimation *)sc_popShowAnimation {
    return nil;
}

- (CAAnimation *)sc_popDismissAnimation {
    return nil;
}

#pragma mark - Setter

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    
    CGFloat contentHeight = self.contentSize.height;
    if (self.contentSize.height <= self.frame.size.height && bounces) {
        contentHeight = 1.f + self.frame.size.height;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
    self.scrollView.bounces = bounces;
}

#pragma mark - Lazy Load

- (SCPopScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[SCPopScrollView alloc] init];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.bounces = NO;
        _scrollView.contentSize = self.contentSize;
        _scrollView.contentView = self.contentView;
    }
    return _scrollView;
}

#pragma mark - Dealloc

- (void)dealloc {
    NSLog(@"Dealloc:%@", NSStringFromClass(self.class));
}

@end

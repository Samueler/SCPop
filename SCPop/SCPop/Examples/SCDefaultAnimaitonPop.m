//
//  SCDefaultAnimaitonPop.m
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "SCDefaultAnimaitonPop.h"

@interface SCDefaultAnimaitonPop () <CAAnimationDelegate>

@end

@implementation SCDefaultAnimaitonPop

- (UIView *)sc_popContentView {
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    return redView;
}

- (CGSize)sc_popContentSize {
    return CGSizeMake(200, 200);
}

- (CAAnimation *)sc_popShowAnimation {
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    transformAnimation.fromValue = @(0);
    transformAnimation.toValue = @(-((UIScreen.mainScreen.bounds.size.height - self.sc_popContentSize.height) * 0.5 + self.sc_popContentSize.height));
    transformAnimation.duration = 0.1;
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    transformAnimation.delegate = self;
    return transformAnimation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"====");
}

@end

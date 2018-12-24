//
//  SCCAAnimationPop.m
//  SCPop
//
//  Created by samueler on 2018/12/24.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "SCCAAnimationPop.h"

@implementation SCCAAnimationPop

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
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.toValue = @(M_PI *2);
    rotateAnimation.duration = 0.5;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[transformAnimation, rotateAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

- (CAAnimation *)sc_popDismissAnimation {
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    transformAnimation.toValue = @(0);
    transformAnimation.fromValue = @(-((UIScreen.mainScreen.bounds.size.height - self.sc_popContentSize.height) * 0.5 + self.sc_popContentSize.height));
    transformAnimation.duration = 0.1;
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    return transformAnimation;;
}
@end

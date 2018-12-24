//
//  SCBasicPop.m
//  SCPop
//
//  Created by samueler on 2018/12/24.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "SCBasicPop.h"

@implementation SCBasicPop

- (UIView *)sc_popContentView {
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    return redView;
}

- (CGSize)sc_popContentSize {
    return CGSizeMake(200, 200);
}

@end

//
//  SCPopScrollView.m
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import "SCPopScrollView.h"

@implementation SCPopScrollView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    BOOL touchOnContent = CGRectContainsPoint(self.contentView.frame, [touch locationInView:self]);
    if (self.touchOnContent) {
        self.touchOnContent(touchOnContent);
    }
}

- (void)dealloc {
    NSLog(@"Dealloc:%@", NSStringFromClass(self.class));
}

@end

//
//  SCPopScrollView.h
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCPopTouchOnContent)(BOOL touchOnContent);

@interface SCPopScrollView : UIScrollView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) SCPopTouchOnContent touchOnContent;

@end

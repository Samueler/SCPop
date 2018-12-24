//
//  SCPopProtocol.h
//  SCPop
//
//  Created by Samueler on 2018/12/20.
//  Copyright © 2018 Samueler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SCPopProtocol <NSObject>

@required

- (UIView *)sc_popContentView;

- (CGSize)sc_popContentSize;

@optional

- (CAAnimation *)sc_popShowAnimation;

- (CAAnimation *)sc_popDismissAnimation;

@end

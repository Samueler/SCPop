# SCPop
SCPop is convenient of setting pop.You just focus on drawing your ui.

# Features

- Supports show or dismiss anmation with `CAAnimation`.
- Supports observe show or dismiss animation when animation finished with blocks.
- Supports contentView bounces like UIScrollView.
- Supports settig dismiss pop when touch the area of beyound content.
- Works with ARC and iOS >= 8.

# Installation

### CocoaPods
The easiest way of installing SCSegment is via [CocoaPods](http://cocoapods.org/). 

```
pod 'SCPop'
```

### Old-fashioned way

- Add `SCPop` file to your project.

# Usage

Cteating a subclass of SCPop.Implementating the function of SCPopProtocol's required functions, then use the custom pop.

```  objective-c
// create pop without maskColor setting.
self.pop = [SCBasicPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow];
```

```  objective-c
// create pop with maskColor setting.
self.pop = [SCBasicPop showPopOnTargetView:UIApplication.sharedApplication.keyWindow maskColor:[UIColor colorWithWhite:0 alpha:0.3]];
```

```  objective-c
// create pop without maskColor setting by block style.
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
```

```  objective-c
// create pop with maskColor setting by block style.
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
```
set bounces

```  objective-c
self.pop.bounces = YES;
```

set touchDismiss

```  objective-c
self.pop.touchDismiss = YES;
```

You can observe animations finished by block like this:
```  objective-c
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
```

# Attention

1. You must implementating SCPopProtocol's required functions.
2. The return value of function 'sc_popContentView' can't be nil.
3. The return value of function 'sc_popContentSize' can't be CGSizeZero.

# License

SCPop is licensed under the terms of the MIT License.

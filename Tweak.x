#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook MMGrowTextViewExtConfig

- (BOOL)enableDictation {
    return YES;
}

- (void)setEnableDictation:(BOOL)arg1 {
    %orig(YES);
}

%end

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        %init;
    });
}
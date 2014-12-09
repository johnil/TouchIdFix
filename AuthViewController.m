//
//  AuthViewController.m
//  TouchIdFix
//
//  Created by Johnil on 14/12/9.
//  Copyright (c) 2014年 Johnil. All rights reserved.
//

#import "AuthViewController.h"
#import "TouchIdView.h"
#import "AppDelegate.h"
@implementation AuthViewController {
    BOOL cancelTouch;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)enterBG{
    cancelTouch = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAuth) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)showAuth{
    if (cancelTouch) {
        return;
    }
    cancelTouch = YES;
    TouchIdView *touchIdView = [[TouchIdView alloc] initWithFrame:self.view.bounds];
    [touchIdView showTouchIdOnComplet:^(BOOL success, NSError *authenticationError) {
        if (success) {
            [UIView animateWithDuration:.3 animations:^{
                self.view.alpha = 0;
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
            }];
            [(AppDelegate *)[UIApplication sharedApplication].delegate becomeActive];
        } else {
            cancelTouch = YES;
            NSLog(@"cancel", nil);
        }
    }];
    [self.view addSubview:touchIdView];
}

@end

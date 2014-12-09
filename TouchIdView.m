//
//  TouchIdView.m
//  TouchIdFix
//
//  Created by Johnil on 14/12/9.
//  Copyright (c) 2014年 Johnil. All rights reserved.
//

#import "TouchIdView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation TouchIdView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)showTouchIdOnComplet:(void (^)(BOOL success, NSError *authenticationError))complet{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"请使用 Touch ID 解锁。"
                          reply:^(BOOL success, NSError *authenticationError) {
                              if (!success) {
                                  [self removeFromSuperview];
                              }
                              if (complet) {
                                  complet(success, authenticationError);
                              }
                          }];
    }
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
}

@end

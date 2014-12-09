//
//  TouchIdView.h
//  TouchIdFix
//
//  Created by Johnil on 14/12/9.
//  Copyright (c) 2014年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchIdView : UIView

- (void)showTouchIdOnComplet:(void (^)(BOOL success, NSError *authenticationError))complet;

@end

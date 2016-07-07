//
//  XCMenuModel.m
//  ListenNovel
//
//  Created by 筱超 on 16/6/30.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "RECommonFunctions.h"
#import <UIKit/UIKit.h>

BOOL RESideMenuUIKitIsFlatMode(void)
{
    static BOOL isUIKitFlatMode = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (floor(NSFoundationVersionNumber) > 993.0) {
            // If your app is running in legacy mode, tintColor will be nil - else it must be set to some color.
            if (UIApplication.sharedApplication.keyWindow) {
                isUIKitFlatMode = [UIApplication.sharedApplication.delegate.window performSelector:@selector(tintColor)] != nil;
            } else {
                // Possible that we're called early on (e.g. when used in a Storyboard). Adapt and use a temporary window.
                isUIKitFlatMode = [[UIWindow new] performSelector:@selector(tintColor)] != nil;
            }
        }
    });
    return isUIKitFlatMode;
}
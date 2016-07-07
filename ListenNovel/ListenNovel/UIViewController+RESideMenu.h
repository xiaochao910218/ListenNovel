//
//  XCMenuModel.m
//  ListenNovel
//
//  Created by 筱超 on 16/6/30.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RESideMenu;

@interface UIViewController (RESideMenu)

@property (strong, readonly, nonatomic) RESideMenu *sideMenuViewController;

// IB Action Helper methods

- (IBAction)presentLeftMenuViewController:(id)sender;
- (IBAction)presentRightMenuViewController:(id)sender;

@end

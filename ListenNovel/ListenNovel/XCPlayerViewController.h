//
//  XCPlayerViewController.h
//  ListenNovel
//
//  Created by 筱超 on 16/7/6.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XCPlayerModel.h"
#import "XCRotatingView.h"
#import "UIImage+ImageEffects.h"
#import "AudioPlayer.pch"
static CGFloat topHeight = 64.0+20.0;
static CGFloat downHeight = 100.0+16.0;
@interface XCPlayerViewController : UIViewController


@property (strong, nonatomic) XCRotatingView *rotatingView;
/**
 *  背景模糊图
 */
@property (weak, nonatomic) IBOutlet UIImageView *underImageView;
/**
 *  第三方提示MBProgressHUD
 */
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

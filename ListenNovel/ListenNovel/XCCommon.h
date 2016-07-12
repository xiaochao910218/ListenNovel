//
//  XCCommon.h
//  ListenNovel
//
//  Created by 筱超 on 16/7/3.
//  Copyright © 2016年 筱超. All rights reserved.
//

#ifndef XCCommon_h
#define XCCommon_h
#import "AFNetworking.h"
#import "DataBaseFile.h"
#import "Masonry.h"
#import "RESideMenu.h"
#import "XCDataModel.h"
#import <SDCycleScrollView.h>
#import "UIImageView+WebCache.h"
#import "XCDataTableViewCell.h"
#import "XCPlayListTableViewController.h"
#import "XCDataBaseTool.h"
#import "XCMenuViewController.h"
#import "XCPlayerModel.h"
#import "XCListTableViewCell.h"
#import "XCPlayerViewController.h"

static NSString * const XCtitle = @"title";     //小说名字
static NSString * const XCintro = @"intro";     //小说简介
static NSString * const XCplaysCounts = @"playsCounts";     //小说点击量
static NSString * const XCcoverSmall = @"coverSmall";
static NSString * const XCcoverMiddle=@"coverMiddle";//小说图标
static NSString * const XCcoverLarge=@"coverLarge";
static NSString * const XCList =@"list";                 //小说类型
static NSString * const XCAlbumId=@"albumId";
static NSString * const XCnickname=@"nickname";
static NSString * const XCtracks=@"tracks";


//player

static NSString * const XCPlayerData =@"data";
static NSString * const XCPlayerTitle=@"title";
static NSString * const XCPlayerDataUrl=@"playUrl64";
static NSString * const XCPlayerDuration=@"duration";
static NSString * const XCPlayercoverSmall=@"coverSmall";
static NSString * const XCPlayercoverLarge=@"coverLarge";
static NSString * const XCPlayerplaytimes=@"playtimes";
static NSString * const XCPlayercreatedAt=@"createdAt";

#endif /* XCCommon_h */

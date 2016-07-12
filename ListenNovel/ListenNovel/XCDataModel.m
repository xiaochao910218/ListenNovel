//
//  XCDataModel.m
//  ListenNovel
//
//  Created by 筱超 on 16/7/3.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCDataModel.h"
#import "XCCommon.h"
@implementation XCDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        _novelTitle=dict[XCtitle];
        _novelIntro=dict[XCintro];
        _novelplaysCounts=dict[XCplaysCounts];
        _novelCoverSmall=dict[XCcoverSmall];
        _novelCoverMiddle=dict[XCcoverMiddle];
        _novelAlbumd=dict[XCAlbumId];
        _novelCoverLarge=dict[XCcoverLarge];
        _novelNickname=dict[XCnickname];
        _novelTracks=dict[XCtracks];
    }
    return self;
}
+ (instancetype)novelModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];

}
@end

//
//  XCPlayerModel.m
//  ListenNovel
//
//  Created by 筱超 on 16/7/4.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCPlayerModel.h"
#import "XCCommon.h"

@implementation XCPlayerModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        _playerTitle=dict[XCPlayerTitle];
        _playerUrl=dict[XCPlayerDataUrl];
        _playerDuration=dict[XCPlayerDuration];
        _playersmaImg=dict[XCPlayercoverSmall];
        _playercount=dict[XCPlayerplaytimes];
    }
    return self;
}
+ (instancetype)playerModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
@end

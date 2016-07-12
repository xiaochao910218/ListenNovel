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
        _playerlarImg=dict[XCPlayercoverLarge];
        _playercount=dict[XCPlayerplaytimes];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dict[XCPlayercreatedAt] integerValue]/1000];
        _playercreatedAt=[self dateStringForDate:date];
    }
    return self;
}
+ (instancetype)playerModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

-(NSString *)dateStringForDate:(NSDate *)date{
    //1.计算时间差
    NSTimeInterval interval= -[date timeIntervalSinceNow];
    //2.根据时间差确定时间的级别
    if (interval  <60) {//秒级
        return [NSString stringWithFormat:@"%d秒之前",(int)interval];
    }
    if (interval  <60*60) {//分级
        return [NSString stringWithFormat:@"%d分之前",(int)(interval/60)];
    }
    if (interval  <60*60*24) {//时级
        return [NSString stringWithFormat:@"%d小时之前",(int)(interval/(60*60))];
    }
    if (interval  <60*60*24*30) {//天级
        return [NSString stringWithFormat:@"%d天之前",(int)(interval/(60*60*24))];
    }
    if (interval  <60*60*24*30*12) {//月级
        return [NSString stringWithFormat:@"%d月之前",(int)(interval/(60*60*24*30))];
    }
    else{
        return [NSString stringWithFormat:@"%d年之前",(int)(interval/(60*60*24*30*12))];
    }
}

@end

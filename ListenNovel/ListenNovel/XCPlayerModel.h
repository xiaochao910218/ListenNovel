//
//  XCPlayerModel.h
//  ListenNovel
//
//  Created by 筱超 on 16/7/4.
//  Copyright © 2016年 筱超. All rights reserved.
//static NSString * const XCPlayerData =@"data";


#import <Foundation/Foundation.h>

@interface XCPlayerModel : NSObject
@property(nonatomic,strong) NSString *playerTitle;
@property(nonatomic,strong) NSString *playerUrl;
@property(nonatomic,strong) NSString *playerDuration;
@property(nonatomic,strong) NSString *playersmaImg;
@property(nonatomic,strong) NSString *playerlarImg;
@property(nonatomic,strong) NSString *playercount;
@property(nonatomic,strong) NSString *playercreatedAt;



- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)playerModelWithDictionary:(NSDictionary *)dict;
@end

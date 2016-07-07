//
//  XCDataModel.h
//  ListenNovel
//
//  Created by 筱超 on 16/7/3.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDataModel : NSObject
@property (nonatomic,strong) NSString *novelTitle; //小说名字
@property (nonatomic,strong) NSString *novelIntro; //小说简介
@property (nonatomic,strong) NSString *novelplaysCounts; //小说点击量
@property (nonatomic,strong) NSString *novelCoverSmall; //小说图片
@property (nonatomic,strong) NSString *novelCoverMiddle;
@property (nonatomic,strong) NSString *novelCoverLarge;
@property (nonatomic,strong) NSString *novelAlbumd;//小说类型
@property (nonatomic,strong) NSString *novelNickname;
@property (nonatomic,strong) NSString *novelTracks;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)novelModelWithDictionary:(NSDictionary *)dict;
@end

//
//  XCListTableViewCell.m
//  ListenNovel
//
//  Created by 筱超 on 16/7/5.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XCPlayerModel.h"

@interface XCListTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *playCount;

@property (weak, nonatomic) IBOutlet UILabel *durationLable;

@end

@implementation XCListTableViewCell

-(void)setPlayerModel:(XCPlayerModel *)playerModel{
    _playerModel=playerModel;
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:playerModel.playersmaImg] placeholderImage:[UIImage imageNamed:@"yushe"]];
    _logoImageView.layer.cornerRadius=25;
    _logoImageView.layer.masksToBounds=YES;
    _titleLable.text=playerModel.playerTitle;
    CGFloat count=[playerModel.playercount integerValue];
    NSString *times;
    if (count > 10000) {
        times =[NSString stringWithFormat:@"%.1f万",count/10000];
    }else{
        times=[NSString stringWithFormat:@"%0.f",count];
    }
    if (count == 0) {
        _playCount.hidden=YES;
    }
    _playCount.text=times;
    
    int longTime=[playerModel.playerDuration intValue];
    _durationLable.text=[NSString stringWithFormat:@"%d:%d",longTime/60,longTime%60];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  XCDataTableViewCell.m
//  ListenNovel
//
//  Created by 筱超 on 16/7/2.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCDataTableViewCell.h"
#import "XCDataModel.h"
#import "UIImageView+WebCache.h"

@interface XCDataTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLable;
@property (weak, nonatomic) IBOutlet UILabel *descLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;

@end

@implementation XCDataTableViewCell

-(void)setNovelModel:(XCDataModel *)novelModel{
    _novelModel=novelModel;
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:novelModel.novelCoverSmall] placeholderImage:[UIImage imageNamed:@"yushe.jpg"]];
    _titleNameLable.text=novelModel.novelTitle;
    _descLable.text=novelModel.novelIntro;
    CGFloat count = [novelModel.novelplaysCounts intValue];
    NSString *commentsall;
    //如果评论数 >10000,就换算成几点几万
    if (count > 10000) {
        commentsall = [NSString stringWithFormat:@"%.1f万",count / 10000];
    }else{
        commentsall = [NSString stringWithFormat:@"%.0f",count];
    }
    if (count == 0) {
        _countLable.hidden = YES;
    }
    _countLable.text = commentsall;
    
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

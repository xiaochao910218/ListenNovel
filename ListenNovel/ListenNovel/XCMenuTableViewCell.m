//
//  XCMenuTableViewCell.m
//  ListenNovel
//
//  Created by 筱超 on 16/6/30.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCMenuTableViewCell.h"
#import "XCMenuModel.h"


@interface XCMenuTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation XCMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _img.layer.cornerRadius=18;
    _img.layer.masksToBounds=YES;
    // Initialization code
}
-(void)setTitleModel:(XCMenuModel *)titleModel{
    _titleModel=titleModel;
    _titleLable.text=titleModel.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

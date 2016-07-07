//
//  XCDataTableViewCell.h
//  ListenNovel
//
//  Created by 筱超 on 16/7/2.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCDataModel;
@interface XCDataTableViewCell : UITableViewCell
@property(nonatomic,strong)XCDataModel *novelModel;
@end

//
//  XCMenuViewController.m
//  ListenNovel
//
//  Created by 筱超 on 16/6/30.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCMenuViewController.h"
#import "UIViewController+RESideMenu.h"
#import "XCDataTableViewController.h"
#import "XCMenuModel.h"
#import "XCMenuTableViewCell.h"
#import "Masonry.h"
#import "XCDataBaseTool.h"
#import "DataBaseFile.h"

#define WIDTH self.view.frame.size.width


@interface XCMenuViewController ()
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (nonatomic,strong)             NSArray     *titleArr;
@end

@implementation XCMenuViewController

static NSString *titleIndentifier =@"titleIndentifier";

-(NSArray *)titleArr{
    if (!_titleArr) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"titles" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *muArr=[NSMutableArray array];
        for (NSDictionary *dict in array) {
            XCMenuModel *model=[XCMenuModel titlesModelWithDictionary:dict];
            [muArr addObject:model];
        }
        _titleArr=muArr;
    }
    return _titleArr;
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, self.view.frame.size.height-100) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    UILabel *lab=[UILabel new];
    [titleView addSubview:lab];
    lab.text=@"列表";
    lab.textAlignment=NSTextAlignmentCenter;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(110);
        make.height.equalTo(titleView);
    }];
    
    lab.textColor=[UIColor cyanColor];
//    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:18];
    self.tableView.tableHeaderView=titleView;
    [self.view addSubview:self.tableView];
    UINib *nib=[UINib nibWithNibName:NSStringFromClass([XCMenuTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:titleIndentifier];
    
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XCMenuModel *urlModel=self.titleArr[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"send" object:nil userInfo:@{@"reUrl":urlModel.listurl,@"title":urlModel.title}];
     [XCDataBaseTool updateStatementsSql:Delete_HOMELIST withParsmeters:nil block:^(BOOL isOk, NSString *errorMsg) {
        if (isOk) {
            
        }
    }];

    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}


#pragma mark UITableView Datasource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.2, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:titleIndentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    XCMenuModel *model=self.titleArr[indexPath.row];
    cell.titleModel=model;
    
    return cell;
}




@end

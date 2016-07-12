//
//  XCPlayListTableViewController.m
//  ListenNovel
//
//  Created by 筱超 on 16/7/5.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCPlayListTableViewController.h"
#import "AFNetworking.h"
#import "XCCommon.h"
#import "XCPlayerModel.h"
#import "XCListTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "XCPlayerViewController.h"
#define WIDTH self.view.bounds.size.width

@interface XCPlayListTableViewController ()
@property(nonatomic)NSInteger pageId;
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray *listArr;
@property(nonatomic,strong) UIButton *footerBtn;
@property(nonatomic)        BOOL px;
@end

@implementation XCPlayListTableViewController
static NSString *isAsc;
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager=[AFHTTPSessionManager manager];
        _manager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}

-(void)getRequest{
    __weak XCPlayListTableViewController *vc=self;
    _url=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album/track?albumId=%@&pageId=%ld&isAsc=%@",self.ablumn,_pageId,isAsc];
    NSDictionary *parameters=@{@"page":@(_pageId)};
       [self.manager GET:_url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=(NSDictionary *)responseObject;
        NSDictionary *dataDic=dict[XCPlayerData];
        NSArray *array=dataDic[@"list"];
        for (NSDictionary *xcdict in array) {
            XCPlayerModel *model=[XCPlayerModel playerModelWithDictionary:xcdict];
            [vc.listArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageId=1;
    isAsc=@"true";
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    self.navigationItem.title=self.name;
    [self getRequest];
    UINib *nib =[UINib nibWithNibName:NSStringFromClass([XCListTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"playercell"];

    
    self.tableView.rowHeight=100;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backPlay:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=itemBtn;
    
}

-(void)backPlay:(UIButton *)sender{
    [self presentViewController:[XCPlayerViewController audioPlayerController] animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 220;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView=[[UIView alloc]init];
    headView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.6 alpha:0.5];
    UIImageView *image=[UIImageView new];
    UILabel *titleLab=[UILabel new];
    UILabel *auth=[UILabel new];
    UILabel *authour=[UILabel new];
    UILabel *count=[UILabel new];
    UILabel *countLab=[UILabel new];
    UILabel *update=[UILabel new];
    UILabel *updateLab=[UILabel new];
    UILabel *ascLab=[UILabel new];
    ascLab.text=@"排序:";
    ascLab.font=[UIFont systemFontOfSize:13];
    ascLab.textColor=[UIColor blueColor];
    ascLab.textAlignment=NSTextAlignmentRight;
    
    
    UIButton *ascBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if ([isAsc isEqualToString:@"true"]) {
        [ascBtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }else if([isAsc isEqualToString:@"false"]){
        [ascBtn setBackgroundImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    }
    
    [ascBtn addTarget:self action:@selector(changeIsAsc:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *intro=[UILabel new];
    UILabel *introLab=[UILabel new];
    [headView addSubview:image];
    [headView addSubview:titleLab];
    [headView addSubview:auth];
    [headView addSubview:authour];
    [headView addSubview:count];
    [headView addSubview:countLab];
    [headView addSubview:update];
    [headView addSubview:updateLab];
    [headView addSubview:ascBtn];
    [headView addSubview:ascLab];
    [headView addSubview:intro];
    [headView addSubview:introLab];
    
    CGFloat count1=[self.xccount integerValue];
    NSString *times;
    if (count1 > 10000) {
        times =[NSString stringWithFormat:@"%.1f万",count1/10000];
    }else{
        times=[NSString stringWithFormat:@"%g",count1];
    }
    updateLab.text=times;
    [image sd_setImageWithURL:[NSURL URLWithString:self.headImg] placeholderImage:[UIImage imageNamed:@"xcbook"]];
    titleLab.text=self.name;
    titleLab.numberOfLines=2;
    titleLab.font=[UIFont systemFontOfSize:16];
    auth.text=@"主播:";
    auth.textAlignment=NSTextAlignmentRight;
    auth.textColor=[UIColor blueColor];
    auth.font=[UIFont systemFontOfSize:13];
    authour.text=self.nickName;
    authour.font=[UIFont systemFontOfSize:14];
    count.text=@"集数:";
    count.textAlignment=NSTextAlignmentRight;
    count.textColor=[UIColor blueColor];
    count.font=[UIFont systemFontOfSize:13];
    countLab.text=[NSString stringWithFormat:@"共%@集",_tracks];
    countLab.font=[UIFont systemFontOfSize:14];
    update.text=@"播放:";
     update.textAlignment=NSTextAlignmentRight;
    update.textColor=[UIColor blueColor];
    update.font=[UIFont systemFontOfSize:13];
    updateLab.font=[UIFont systemFontOfSize:14];
    intro.text=@"简介:";
    intro.textAlignment=NSTextAlignmentCenter;
    intro.textColor=[UIColor blueColor];
    intro.font=[UIFont systemFontOfSize:16];
    introLab.font=[UIFont systemFontOfSize:14];
    introLab.numberOfLines=0;
    introLab.text=self.intro;
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(8);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(104);
    }];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image);
        make.left.equalTo(image.mas_right).with.offset(8);
        make.right.mas_equalTo(-8);
        make.width.mas_lessThanOrEqualTo(42);
    }];
    [auth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).with.offset(3);
        make.left.equalTo(titleLab);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(21);
    }];
    [authour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(auth);
        make.left.equalTo(auth.mas_right).with.offset(2);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(21);
    }];
    [update mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(auth);
        make.top.equalTo(auth.mas_bottom).with.offset(3);
    }];
    
    [updateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(update);
        make.left.equalTo(update.mas_right).with.offset(2);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_equalTo(21);
    }];
    
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(update);
        make.top.equalTo(update.mas_bottom).with.offset(3);
    }];
    
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(count);
        make.left.equalTo(count.mas_right).with.offset(2);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(21);
    }];
    
    [ascBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.centerY.equalTo(countLab);
        make.size.mas_equalTo(CGSizeMake(26, 16));
    }];
    [ascLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ascBtn.mas_left).with.offset(0);
        
        make.centerY.equalTo(countLab);
        make.width.height.equalTo(update);
    }];
    [intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(image.mas_bottom).with.offset(3);
        make.height.equalTo(update);
        make.width.mas_equalTo(42);
    }];
    [introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intro);
        make.left.equalTo(intro.mas_right).with.offset(3);
        make.right.mas_equalTo(-8);
        make.height.mas_lessThanOrEqualTo(120);
    }];
    return headView;
}

-(void)changeIsAsc:(UIButton *)sender{
    [self.listArr removeAllObjects];
    _px=!_px;
    if (_px==YES) {
        isAsc=@"false";
    }else{
    isAsc=@"true";
    }
    [self getRequest];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playercell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:0.5 green:0.4 blue:0.6 alpha:0.4];
    XCPlayerModel *model=self.listArr[indexPath.row];
    cell.playerModel=model;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    XCPlayerViewController *audio=[XCPlayerViewController audioPlayerController];
    [audio initWithArray:self.listArr index:indexPath.row];
    [self presentViewController:audio animated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [_footerBtn setTitle:@">>>>加载更多<<<<" forState:UIControlStateNormal];
    }else{
        [_footerBtn setTitle:@">>>>加载中<<<<" forState:UIControlStateNormal];
    }
}
//当停止拖动,将要减速的时候,判断是否需要加载更多
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [self loadMoreData];
    }
}
- (void)loadMoreData{
    _pageId += 1;
    [self getRequest];
    
}

@end

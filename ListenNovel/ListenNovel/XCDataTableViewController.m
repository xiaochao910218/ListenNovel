//
//  XCDataTableViewController.m
//  ListenNovel
//
//  Created by 筱超 on 16/6/30.
//  Copyright © 2016年 筱超. All rights reserved.
//

#import "XCDataTableViewController.h"
#import "RESideMenu.h"
#import "XCMenuViewController.h"
#import "AFNetworking.h"
#import "XCCommon.h"
#import "XCDataModel.h"
#import "XCDataTableViewCell.h"
#import "Masonry.h"
#import "XCPlayListTableViewController.h"
#import <SDCycleScrollView.h>

#define URL @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=3&device=android&pageSize=20&status=0&tagName=%E5%8D%9A%E9%9B%86%E5%A4%A9%E5%8D%B7"

#define WIDTH self.view.bounds.size.width
@interface XCDataTableViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic) NSInteger pageId;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property(nonatomic,strong)NSMutableArray *novelArr;
@property(nonatomic,strong)NSMutableArray *imageUrlArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *urlArr;
@property(nonatomic,strong) UIButton *footerBtn;
@end

@implementation XCDataTableViewController

static NSString *xcu=URL;
static NSString *xctitle=@"博集天卷";
-(AFHTTPSessionManager *)manager {
    if (!_manager) {
        //创建manager对象
        _manager=[AFHTTPSessionManager manager];
        //设置网络监听
        _manager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        //启动监听
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
    
}

-(void)getRequest{
    __weak XCDataTableViewController *vc=self;
    _dataUrl=[NSString stringWithFormat:@"%@&pageId=%ld",xcu,_pageId];
    NSDictionary *parameters=@{@"page":@(_pageId)};
    [self.manager GET:_dataUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *novelDict=(NSDictionary *)responseObject;
        NSArray *nArr=novelDict[XCList];
        for (NSDictionary *dict in nArr) {
            XCDataModel *model=[XCDataModel novelModelWithDictionary:dict];
            [vc.novelArr addObject:model];
            [vc.imageUrlArr addObject:model.novelCoverLarge];
            [vc.titleArr addObject:model.novelTitle];
            [vc.urlArr addObject:model];
        }
        [vc.imageUrlArr removeObjectsInRange:NSMakeRange(2, vc.imageUrlArr.count-3)];
        [vc.titleArr removeObjectsInRange:NSMakeRange(2, vc.titleArr.count-3)];
        [vc.urlArr removeObjectsInRange:NSMakeRange(2, vc.urlArr.count-3)];
        [vc.novelArr removeObjectsInRange:NSMakeRange(0, 3)];
        vc.dataArr =vc.novelArr;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc.tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageId=1;
    if (!_novelArr) {
        _novelArr=[NSMutableArray array];
    }
    if (!_imageUrlArr) {
        _imageUrlArr=[NSMutableArray array];
    }
    if (!_titleArr) {
        _titleArr=[NSMutableArray array];
    }
    if (!_urlArr) {
        _urlArr=[NSMutableArray array];
    }
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    [self getRequest];
    [self initHeadView];
    UINib *nib=[UINib nibWithNibName:NSStringFromClass([XCDataTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"datacell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextInfo:) name:@"send" object:nil];//通知中心传值
    self.navigationItem.title=xctitle;
    self.tableView.rowHeight=125;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.navigationController.navigationBar.translucent=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.792 green:0.761 blue:0.835 alpha:0.5];
}

- (void)initHeadView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 210)];
    view.backgroundColor=[UIColor colorWithRed:0.5 green:0.4 blue:0.6 alpha:0.4];
    UILabel *lable=[UILabel new];
    lable.text=[NSString stringWithFormat:@"TOP 3"];
    lable.font=[UIFont systemFontOfSize:19];
    lable.textAlignment=NSTextAlignmentCenter;
    [view addSubview:lable];
    CGFloat w = self.view.bounds.size.width;
    
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 32, w, 178) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleView.titlesGroup = self.titleArr;
    _cycleView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [view addSubview:_cycleView];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleView.imageURLStringsGroup = self.imageUrlArr;
    });

    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH);
        make.height.mas_equalTo(21);
        
    }];

    self.tableView.tableHeaderView=view;
   
}
-(void)changeTextInfo:(NSNotification *)notifition
{
    NSDictionary *dict =notifition.userInfo;
    NSString *list =dict[@"reUrl"];
    xcu=list;
    NSString *title=dict[@"title"];
    xctitle=title;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"datacell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:0.5 green:0.4 blue:0.6 alpha:0.4];
    XCDataModel *dataMod=self.dataArr[indexPath.row];
    cell.novelModel=dataMod;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XCDataModel *dataMod=self.dataArr[indexPath.row];
    XCPlayListTableViewController *play=[self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    play.ablumn=dataMod.novelAlbumd;
    play.name=dataMod.novelTitle;
    play.headImg=dataMod.novelCoverMiddle;
    play.nickName=dataMod.novelNickname;
    play.xccount=dataMod.novelplaysCounts;
    play.tracks=dataMod.novelTracks;
    [self.navigationController pushViewController:play animated:YES];
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [_footerBtn setTitle:@"loading More" forState:UIControlStateNormal];
    }else{
        [_footerBtn setTitle:@"Loading" forState:UIControlStateNormal];
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
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    XCDataModel *dataMod=self.urlArr[index];

    XCPlayListTableViewController *play=[self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    play.ablumn=dataMod.novelAlbumd;
    play.name=dataMod.novelTitle;
    play.headImg=dataMod.novelCoverMiddle;
    play.nickName=dataMod.novelNickname;
    play.xccount=dataMod.novelplaysCounts;
    play.tracks=dataMod.novelTracks;
    [self.navigationController pushViewController:play animated:YES];
}
@end

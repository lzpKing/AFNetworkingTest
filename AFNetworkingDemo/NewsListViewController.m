 //
//  NewsListViewController.m
//  FirstDemo
//
//  Created by chenjiahe on 15/7/21.
//  Copyright (c) 2015年 🍉. All rights reserved.
//

#import "NewsListViewController.h"
#import "INTERFACE.h"
#import "PMNetworkManager.h"
#import "NewsTableViewCell.h"
#import "NPNewsTableViewCell.h"
#import "NewsHSectionView.h"
#import "SDPieLoopProgressView.h"
#import "InvestModel.h"
#import "MJRefresh.h"

@interface NewsListViewController ()<MJRefreshBaseViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _newDataArray;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    NewsHSectionView * newHSV;
    
    NSInteger total;
    NSInteger curPage;
    
    NSInteger newTotal;
    NSInteger newCurPage;
    NSInteger witchOne;
}
@end

@implementation NewsListViewController
-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投资列表";
    
    total = 9999;
    curPage = 1;
    
    newTotal = 9999;
    newCurPage = 1;
    
    witchOne = 0;
    
    _dataArray = [[NSMutableArray alloc]init];
    _newDataArray = [[NSMutableArray alloc]init];
    [self prepareUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshNewData:) name:@"refreshNewPerDate" object:nil];
    
}

-(void)refreshNewData:(NSNotification *)notify
{
    NSInteger index = [notify.object integerValue];
    witchOne = index;
    newHSV.segment.selectedSegmentIndex = index;
    if (witchOne == 1) {
        if (_newDataArray.count == 0) {
            [self LoadNewPersonData];
        }else
        {
            [_tableView reloadData];
        }
    }else
    {
        if (_dataArray.count == 0) {
            [self LoadData];
        }else
        {
            [_tableView reloadData];
        }
        
    }
}
-(void)prepareUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kAl_SCREEN_WIDTH, kAL_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = bgColor;
    [self.view addSubview:_tableView];
    
    newHSV = [[[NSBundle mainBundle] loadNibNamed:@"NewsHSectionView" owner:self options:nil] lastObject];
    
    [newHSV.segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    _tableView.tableHeaderView = newHSV;

    //下拉刷新
    _header = [MJRefreshHeaderView header];
    __block UIViewController *blockSelf = self;
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView * view){
        //执行响应方法进行刷新
        [blockSelf performSelector:@selector(refreshAction:) withObject:view afterDelay:1];
    };

    //上拉加载
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView * view){
        [blockSelf performSelector:@selector(refreshAction:) withObject:view afterDelay:1];
    };
    
    newHSV.segment.selectedSegmentIndex = 0;
    [self LoadData];

}
#pragma mark ==============切换标的类型=============
-(void)segmentClick:(UISegmentedControl *)segment
{
    NSLog(@"%ld",segment.selectedSegmentIndex);
    witchOne = segment.selectedSegmentIndex;
    if (witchOne == 1) {
        if (_newDataArray.count == 0) {
            [self LoadNewPersonData];
        }else
        {
            [_tableView reloadData];
        }
    }else
    {
        if (_dataArray.count == 0) {
            [self LoadData];
        }else
        {
            [_tableView reloadData];
        }
        
    }
    
}
#pragma mark ==============tableView delegate=============
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (witchOne == 1) {
        return _newDataArray.count;
    }else
        return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (witchOne == 1) {
        static NSString * cellStr = @"newCell";
        NPNewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NPNewsTableViewCell" owner:self options:nil]lastObject ];
        }

        //选中颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        
        //显示数据
        InvestModel * imv;
        imv = [_newDataArray objectAtIndex:indexPath.row];
        
        cell.investTitle.text = [NSString stringWithFormat:@"%@",imv.itemLoanTitle];
        cell.moneyNum.text = [NSString stringWithFormat:@"%@",imv.itemLoanAmount];
        cell.monthNum.text = [NSString stringWithFormat:@"%@",imv.itemLoanTerm];
        cell.percentNum.text = [NSString stringWithFormat:@"%@",imv.itemComprehensiveRate];
        cell.bottomLabel.text = [NSString stringWithFormat:@"%@",imv.itemCount];
        if ([imv.itemLoanRepayment isEqualToString:@"2"]) {
            cell.dayLabel.text = @"天";
        }else
        {
            cell.dayLabel.text = @"个月";
        }
        if ([imv.itemBulkLoanStatus isEqualToString:@"1"]) {
            cell.investTitle.textColor = [UIColor colorWithRed:0.31f green:0.31f blue:0.32f alpha:1.00f];
            cell.percentNum.textColor = mainColor;
            cell.monthNum.textColor = [UIColor blackColor];
            cell.moneyNum.textColor = [UIColor blackColor];
            cell.starImg.image = [UIImage imageNamed:@"yellowStar"];
            cell.bottomLabel.textColor = mainColor;
            cell.shuImg1.image = [UIImage imageNamed:@"yellowShu"];
            cell.shuImg2.image = [UIImage imageNamed:@"yellowShu"];
            cell.firstLabel.textColor = [UIColor colorWithRed:0.31f green:0.31f blue:0.32f alpha:1.00f];
            cell.secondLabel.textColor = [UIColor colorWithRed:0.31f green:0.31f blue:0.32f alpha:1.00f];
            cell.thirdLabel.textColor = [UIColor colorWithRed:0.31f green:0.31f blue:0.32f alpha:1.00f];
        }else
        {
            cell.investTitle.textColor = ziColor;
            cell.percentNum.textColor = ziColor;
            cell.monthNum.textColor = ziColor;
            cell.moneyNum.textColor = ziColor;
            cell.starImg.image = [UIImage imageNamed:@"garyStar"];
            cell.bottomLabel.textColor = ziColor;
            cell.shuImg1.image = [UIImage imageNamed:@"blueShu"];
            cell.shuImg2.image = [UIImage imageNamed:@"blueShu"];
            cell.firstLabel.textColor = ziColor;
            cell.secondLabel.textColor = ziColor;
            cell.thirdLabel.textColor = ziColor;
        }
        return cell;

    }else
    {
        static NSString * cellStr = @"cell";
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil]lastObject ];
        }
        for (id obj in cell.contentView.subviews) {
            if ([obj isKindOfClass:[SDPieLoopProgressView class]]) {
                [obj removeFromSuperview];
            }
        }
        
        SDPieLoopProgressView * demoView = [[SDPieLoopProgressView alloc]initWithFrame:CGRectMake(kAl_SCREEN_WIDTH-80, 25, 60, 60)];
        [cell.contentView addSubview:demoView];
        
        //选中颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];

        //显示数据
        InvestModel * imv;
        imv = [_dataArray objectAtIndex:indexPath.row];
        
        demoView.delegate=imv.itemBulkLoanStatus;
        
        cell.investTitle.text = [NSString stringWithFormat:@"%@",imv.itemLoanTitle];
        cell.moneyNum.text = [NSString stringWithFormat:@"%@",imv.itemLoanAmount];
        cell.monthNum.text = [NSString stringWithFormat:@"%@",imv.itemLoanTerm];
        cell.percentNum.text = [NSString stringWithFormat:@"%@",imv.itemComprehensiveRate];
        cell.bottomLabel.text = [NSString stringWithFormat:@"%@",imv.itemCount];

        if ([imv.itemLoanRepayment isEqualToString:@"2"]) {
            cell.dayLabel.text = @"天";
        }else
        {
            cell.dayLabel.text = @"个月";
        }
        if ([demoView.delegate isEqualToString:@"1"]) {
            double tt = [imv.itemProgress doubleValue];
            demoView.progress = tt;
        }else
        {
            demoView.progress = 1;
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (witchOne == 1) {
        return 115;
    }else
    {
        return 110;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"跳转详情");
}

#pragma mark - =======MJRefresh=========
//开始刷新时调用
-(void)refreshAction:(MJRefreshBaseView *)refreshView
{
    NSLog(@"开始刷新的时候触发的方法");
    if (refreshView == _header) {
        
        if (witchOne == 1) {
            newCurPage = 1;
            [self LoadNewPersonData];
        }else
        {
            curPage = 1;
            [self LoadData];
        }
        
    }
    else if (refreshView == _footer)
    {
        NSInteger cp;
        NSInteger count;
        if (witchOne == 1) {
            cp = newCurPage ++;
            count = newTotal/10 == 0 ? newTotal/10 : newTotal/10+1;
        }else
        {
            cp = curPage ++;
            count = total/10 == 0 ? total/10 : total/10+1;
        }
        
        
        if (cp > count) {
            
            [refreshView endRefreshing];
            
            return;
        }
        
        if (witchOne == 1) {
            [self LoadNewPersonData];
        }else
        {
            [self LoadData];
        }
    }
}

#pragma mark ==============加载普通标数据=============
-(void)LoadData
{
    
    NSString *curpage = [NSString stringWithFormat:@"%ld",curPage];
    [[PMNetworkManager shareManager].manager GET:investUrl parameters:@{@"currentPageNo":curpage,@"pageSize":@"10"} success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *rootDict = (NSDictionary *)responseObject;
         NSLog(@"%@",rootDict);
         NSString * success = [[rootDict objectForKey:@"retCode"]stringValue];
         total = [[rootDict objectForKey:@"countTotal"]integerValue];
         NSArray *array = rootDict[@"list"];
         
         if (curPage == 1) {
             [_dataArray removeAllObjects];
         }
         
         for (NSMutableDictionary *dict1 in array) {
             InvestModel *modelData = [[InvestModel alloc] init];
             modelData.itemCount = VALUE([dict1 objectForKey:@"ppTerderminamount"]);
             modelData.itemProgress = VALUE([dict1 objectForKey:@"progress"]);
             modelData.itemLoanRepayment = VALUE([dict1[@"ppLoanrepayment"]stringValue]);//2：天 1：个月
             modelData.itemBulkLoanStatus = VALUE([dict1[@"ppBulkloanstatus"]stringValue]);//融资状态
             modelData.itemBulkLoanNumber = VALUE([dict1 objectForKey:@"ppProductno"]);
             
             modelData.itemLoanTitle = VALUE(dict1[@"ppLoantitle"]);//借款标题
             modelData.itemComprehensiveRate = VALUE(dict1[@"ppComprehensiverate"]);//年华利率
             modelData.itemLoanAmount = VALUE([dict1[@"ppLoanamount"]stringValue]);//借款金额
             modelData.itemLoanTerm = VALUE([dict1[@"ppLoanterm"]stringValue]);//借款期数
             modelData.itemType = VALUE([dict1 objectForKey:@"type"]);
            
             [_dataArray addObject:modelData];
             
         }
         
         [_header endRefreshing];
         [_footer endRefreshing];
         if ([success isEqualToString:@"1"]) {
             
             [_tableView reloadData];
         }
         else
         {
             NSLog(@"出现错误提示");
         }
         
     }failure:^(NSURLSessionDataTask *task, NSError *error){
         NSLog(@"Error: %@",[error userInfo]);
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败,请检查网络" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
         [alert show];
         
         [_header endRefreshing];
         [_footer endRefreshing];
     }];
}
#pragma mark ==============加载新手标数据=============
-(void)LoadNewPersonData
{
    
    NSString *curpage = [NSString stringWithFormat:@"%ld",curPage];
    [[PMNetworkManager shareManager].manager GET:newInvestUrl parameters:@{@"currentPageNo":curpage,@"pageSize":@"10",@"type":@"1"} success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *rootDict = (NSDictionary *)responseObject;
         NSLog(@"%@",rootDict);
         NSString * success = [[rootDict objectForKey:@"retCode"]stringValue];
         newTotal = [[rootDict objectForKey:@"countTotal"]integerValue];
         NSArray *array = rootDict[@"list"];

         if (newCurPage == 1) {
             [_newDataArray removeAllObjects];
         }

         for (NSMutableDictionary *dict1 in array) {
             InvestModel *modelData = [[InvestModel alloc] init];
             modelData.itemCount = VALUE([dict1 objectForKey:@"ppTerderminamount"]);
             modelData.itemProgress = VALUE([dict1 objectForKey:@"progress"]);
             
             modelData.itemBulkLoanStatus = VALUE([dict1[@"ppBulkloanstatus"]stringValue]);//融资状态
             modelData.itemBulkLoanNumber = VALUE([dict1 objectForKey:@"ppProductno"]);
             modelData.itemLoanRepayment = VALUE([dict1[@"ppLoanrepayment"]stringValue]);//2：天 1：个月
             modelData.itemLoanTitle = VALUE(dict1[@"ppLoantitle"]);//借款标题
             modelData.itemComprehensiveRate = VALUE(dict1[@"ppComprehensiverate"]);//年华利率
             modelData.itemLoanAmount = VALUE([dict1[@"ppLoanamount"]stringValue]);//借款金额
             modelData.itemLoanTerm = VALUE([dict1[@"ppLoanterm"]stringValue]);//借款期数
             modelData.itemType = VALUE([dict1 objectForKey:@"type"]);
             [_newDataArray addObject:modelData];
         }
         
         [_header endRefreshing];
         [_footer endRefreshing];
         if ([success isEqualToString:@"1"]) {
             
             [_tableView reloadData];
         }
         else
         {
             NSLog(@"错误提示");
         }
         
     }failure:^(NSURLSessionDataTask *task, NSError *error){
         NSLog(@"Error: %@",[error userInfo]);
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败,请检查网络" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
         [alert show];
         
         [_header endRefreshing];
         [_footer endRefreshing];
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

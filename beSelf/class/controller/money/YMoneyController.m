//
//  YMoneyController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YMoneyController.h"
#import "YMoneyTotalController.h"

@interface YMoneyController ()<GroupTableViewDelegate,YMoneyTotalControllerDelegate>

//主表格
@property (nonatomic,strong)GroupTableView *myTable;
//主表格数据
@property (nonatomic,strong)NSMutableArray *tableData;
//表头数据
@property (nonatomic,strong)NSMutableArray *sectionData;
//header
@property (nonatomic,strong)UIView *tableHeaderView;
/**
 *  targetResut
 */
@property (nonatomic,strong)targetResult *result;
//emptyView
@property (strong, nonatomic) YEmptyView *emptyView;
//时间总额
@property (nonatomic,copy)NSString *moneyTotal;

@end

@implementation YMoneyController

#pragma mark--0,生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置导航栏
    //设置导航栏
    UIButton *rightItem = [[UIButton alloc]initWithFrame:CGRectMake(yUIScreenWidth-btnWidth_44, 0, btnWidth_44, btnWidth_44)];
    [rightItem setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    
    [rightItem addTarget:self action:@selector(rightBarButtonItemDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightItem];

    [self.view addSubview:self.myTable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--1,设置表格
- (GroupTableView *)myTable{
    if (!_myTable) {
        _myTable = [[GroupTableView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, yUIScreenHeight) style:UITableViewStylePlain];
        _myTable.group_delegate = self;
        _myTable.tableHeaderView = self.tableHeaderView;
    }
    return _myTable;
}
- (UIView *)tableHeaderView{
    rootHeader *headerView = [[rootHeader alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, 150)];
    TableObject *headerObject = [[TableObject alloc]init];
    headerObject.subTitle = @"财富总额（元）";
    headerObject.color = moneyColor;
    if (IsMock) {
        headerObject.title = mData.moneyTotal;
    }else{
        headerObject.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"totalMoney"];
    }

    headerObject.time = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    [headerView setContentWithObject:headerObject];
    return headerView;
}

//行高
- (CGFloat)tableRowHeightAtIndex:(NSIndexPath *)indexPath{
    
    TableObject *tmpObj = self.tableData[indexPath.row];
    return tmpObj.cellHeight;
}
#pragma mark--2,获取表格数据
- (void)getData{
    if (IsMock) {
        self.result = mData.targetResult;
    }else{
        self.result = [yCache readerTargetResult];
    }
    self.moneyTotal = [[NSUserDefaults standardUserDefaults] valueForKey:@"totalMoney"];

    if (self.result.targetArray.count>0&&self.moneyTotal.length>0) {
        [self.emptyView removeFromSuperview];
        [self setData];
    }else{
        [self.view addSubview:self.emptyView];
    }
 

}

#pragma mark--3,设置表格数据
- (void)setData{
    self.tableData = [NSMutableArray array];

    for (targetModal *moneyObject in self.result.targetArray) {
        TableObject *moneyObj = [[TableObject alloc]init];
        moneyObj.cellHeight = 88;
        moneyObj.cellString = @"moneyRootCell";
        moneyObj.title = moneyObject.targetTitle;
        moneyObj.subTitle = moneyObject.moneyUse;
        moneyObj.value = moneyObject.targetMoney;
        [self.tableData addObject:moneyObj];
    }
    self.myTable.tableData = self.tableData;
}
#pragma mark--4,点击右边按钮，输入内容
- (void)rightBarButtonItemDidTap:(id)sender{
    YMoneyTotalController *controller = [[YMoneyTotalController alloc]initWithNibName:@"YMoneyTotalController" bundle:nil];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark--5，响应代理
- (void)didSaveTotalMoney{
    [self getData];
}

#pragma mark--初始化
- (YEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[YEmptyView alloc]initWithFrame:self.view.bounds];
        TableObject *obj = [[TableObject alloc]init];
        obj.title = @"赶快去记录财富吧";
        _emptyView.object = obj;
    }
    return _emptyView;
}
@end

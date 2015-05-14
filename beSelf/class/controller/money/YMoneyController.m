//
//  YMoneyController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YMoneyController.h"
#import "YMoneyTotalController.h"

@interface YMoneyController ()<GroupTableViewDelegate>

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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(rightBarButtonItemDidTap:)];
    self.navigationItem.rightBarButtonItem = rightItem;

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
    [self setData];

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
    [self.navigationController pushViewController:controller animated:YES];}
@end

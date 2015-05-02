//
//  YTimeController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTimeController.h"

#import "YTotalTimeViewController.h"
@interface YTimeController ()<GroupTableViewDelegate>

//主表格
@property (nonatomic,strong)GroupTableView *myTable;
//主表格数据
@property (nonatomic,strong)NSMutableArray *tableData;
//表头数据
@property (nonatomic,strong)NSMutableArray *sectionData;
//存储数据
@property (nonatomic,strong)targetResult *result;
//header
@property (nonatomic,strong)UIView *tableHeaderView;

@end

@implementation YTimeController
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
    
    //set background
    self.view.backgroundColor = [UIColor whiteColor];
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
    headerObject.subTitle = @"时间总额（天）";
    if (IsMock) {
        headerObject.title = mData.timeTotal;
    }
    headerObject.time = [timeTool getCurrentTimeWithFormat:@"yyyy/mm/dd"];
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
    if (self.result.targetArray.count>0) {
        [self setData];
    }
}

#pragma mark--3,设置表格数据
- (void)setData{
    self.tableData = [NSMutableArray array];
    
    for (targetModal *timeObject in self.result.targetArray) {
        TableObject *timeObj = [[TableObject alloc]init];
        timeObj.cellHeight = 130;
        timeObj.cellString = @"timeRootCell";
        timeObj.title = timeObject.targetTitle;
        timeObj.time = timeObject.startTime;
        timeObj.subTime = timeObject.endTime;
        NSInteger days = [timeTool daysWithStartDay:timeObject.startTime andEndDay:timeObject.endTime andFormat:@"yyyy/mm/dd"];
        timeObj.value =  [NSString stringWithFormat:@"%ld",(long)days];
        [self.tableData addObject:timeObj];
    }
    self.myTable.tableData = self.tableData;
}
#pragma mark--4,点击左边按钮，输入内容
- (void)rightBarButtonItemDidTap:(id)sender{
    YTotalTimeViewController *controller = [[YTotalTimeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

@end

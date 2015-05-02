//
//  YGoalController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTargetController.h"
#import "YTargetWriteController.h"

@interface YTargetController ()<GroupTableViewDelegate,YTargetWriteControllerDelegate>
//表数据
@property (nonatomic,strong)NSMutableArray *tableData;
//表头数据
@property (nonatomic,strong)NSMutableArray *sectionData;
//myTable
@property (nonatomic,strong)GroupTableView *GroupTable;
/**
 *  目标
 */
@property (nonatomic,strong)targetResult *result;


@end

@implementation YTargetController
//生命周期
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
    
    //add tableview
    [self.view addSubview:self.GroupTable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--0,设置table
//0.1初始化表格
- (GroupTableView *)GroupTable{
    if (!_GroupTable) {
        _GroupTable = [[GroupTableView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, yUIScreenHeight) style:UITableViewStylePlain];
        _GroupTable.group_delegate = self;
        _GroupTable.tableData = self.tableData;
        _GroupTable.tableSectionHeaderData = self.sectionData;
    }
    return _GroupTable;
}
//0.2表格代理
//sectionHeight
- (CGFloat)tableViewHeightForHeaderInSection:(NSInteger)section{
    if (self.sectionData.count>0) {
        SectionObject *tmpObject = self.sectionData[section];
        return tmpObject.sectionHight;
    }else{
        return 0;
    }

}
- (CGFloat)tableRowHeightAtIndex:(NSIndexPath *)indexPath{
    id tmpObject = self.tableData[indexPath.section];
    
    NSArray *tmpArr = nil;
    
    if([tmpObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *tmpDic = tmpObject;
        tmpArr = tmpDic.allValues[0];
    }
    else
    {
        tmpArr = tmpObject;
    }
    
    TableObject *tmpObj = tmpArr[indexPath.row];
    return tmpObj.cellHeight;
}
#pragma mark--1,获取数据
- (void)getData{
    if(IsMock){
        self.result = mData.targetResult;
    }else{
        self.result = [yCache readerTargetResult];
    }

    [self setData];

}

#pragma mark--2,设置数据
- (void)setData{
    
    self.tableData = [NSMutableArray array];
    self.sectionData = [NSMutableArray array];
  
    for (targetModal *target in  self.result.targetArray) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        NSMutableArray *tempArray = [NSMutableArray array];
  
        SectionObject *sectionObj = [[SectionObject alloc]init];
        sectionObj.sectionHight = ySectionSpace;
        sectionObj.titleString = target.startTime;
        [self.sectionData addObject:sectionObj];
        
        TableObject *object = [[TableObject alloc]init];
        object.cellString = @"targetRootCell";
        object.cellHeight = 120;
        object.title = target.targetTitle;
        object.money = target.targetMoney;
        object.subMoney = target.moneyUse;
        NSInteger days = [timeTool daysWithStartDay:target.startTime andEndDay:target.endTime andFormat:@"yyyy/mm/dd"];
        object.time = [NSString stringWithFormat:@"%ld",(long)days];
        NSInteger leftDays = [timeTool daysWithStartDay:[timeTool getCurrentTimeWithFormat:@"yyyy/mm/dd"] andEndDay:target.endTime andFormat:@"yyyy/mm/dd"];
        object.subTime = [NSString stringWithFormat:@"%ld",(long)leftDays];
        
        [tempArray addObject:object];
        [tempDic setObject:tempArray forKey:@"titleSectionView"];
        [self.tableData addObject:tempDic];
        
    }

    self.GroupTable.tableData =  self.tableData;

}
#pragma mark--4,点击左边按钮，输入内容
- (void)rightBarButtonItemDidTap:(id)sender{
    YTargetWriteController *controller = [[YTargetWriteController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    nav.navigationBar.tintColor = self.view.backgroundColor;
    [self presentViewController:nav animated:YES completion:^{
        controller.delegate = self;
    }];
}
#pragma mark--5,保存目标后回调
- (void)didSaveTarget{
    self.tableData = nil;
    [self getData];
}
@end

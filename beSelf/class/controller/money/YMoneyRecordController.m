//
//  YMoneyRecordController.m
//  beSelf
//
//  Created by 木 on 15/4/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YMoneyRecordController.h"

@interface YMoneyRecordController ()<GroupTableViewDelegate>
/**
 *  主表
 */
@property (nonatomic,strong)GroupTableView *myTable;
/**
 *  表数据
 */
@property (nonatomic,strong)NSMutableArray *tableData;
/**
 *  表节数据
 */
@property (nonatomic,strong)NSMutableArray *sectionData;
/**
 *  收支记录
 */
@property (nonatomic,strong)moneyResult *resut;


@end

@implementation YMoneyRecordController
#pragma mark========================0,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self.view addSubview:self.myTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark========================1,初始化控件
#pragma mark--myTable
- (GroupTableView *)myTable{
    if (!_myTable) {
        _myTable = [[GroupTableView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, yUIScreenHeight) style:UITableViewStylePlain];
        _myTable.group_delegate = self;
        _myTable.tableData = self.tableData;
        _myTable.tableSectionHeaderData = self.sectionData;
        
    }
    return _myTable;
}
- (CGFloat)tableViewHeightForHeaderInSection:(NSInteger)section{
    return 25;
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
        tmpArr = self.tableData;
    }
    
    TableObject *tmpObj = tmpArr[indexPath.row];
    return tmpObj.cellHeight;
}
#pragma mark--talbeData
- (NSMutableArray *)tableData{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
}
#pragma mark--sectionData
- (NSMutableArray *)sectionData{
    if (!_sectionData) {
        _sectionData = [NSMutableArray array];
    }
    return _sectionData;
}
#pragma mark=======================2,获取数据并设置数据
#pragma mark--获取数据
- (void)getData{
    if (IsMock) {
        self.resut = mData.mResult;
    }else{
        self.resut = [yCache readerMoneyResult];
    }
    if (self.resut) {
        [self setData];
    }
}
#pragma mark--设置数据
- (void)setData{
    for (moneyRecord *record in self.resut.mRecordArray) {
        
        SectionObject *sObj = [[SectionObject alloc]init];
        sObj.sectionHight = 25;
        [self.sectionData addObject:sObj];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        TableObject *object = [[TableObject alloc]init];
        object.cellString = @"moneyRecordCell";
        object.cellHeight = 66;
        object.title = record.type;
        object.money = record.value;
        object.subTitle = record.subTitle;
        [tempArray addObject:object];
        
        [tempDic setObject:tempArray forKey:@"titleSectionView"];
        [self.tableData addObject:tempDic];
        
    }

    
}
@end

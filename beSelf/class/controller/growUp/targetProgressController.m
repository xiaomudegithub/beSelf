//
//  targetProgressController.m
//  beSelf
//
//  Created by 木柳 on 15/5/14.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "targetProgressController.h"
#import "targetProgressCell.h"

@interface targetProgressController ()<GroupTableViewDelegate>
//table
@property (strong, nonatomic) GroupTableView *myTable;
//tableData
@property (strong, nonatomic) NSMutableArray *tableData;
//get targetResult
@property (strong, nonatomic) targetStep *result;
//emptyView
@property (strong, nonatomic) YEmptyView *emptyView;
@end

@implementation targetProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark==============1,生命周期

#pragma mark==============2，UI搭建
#pragma mark--初始化
//myTable
- (GroupTableView *)myTable{
    if (!_myTable) {
        _myTable = [[GroupTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTable.group_delegate = self;
    }
    return _myTable;
}
//emptyView
- (YEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[YEmptyView alloc]init];
        _emptyView.frame = self.view.frame;
        TableObject *obj = [[TableObject alloc]init];
        obj.title = @"目标尚未分解,无法查看进度";
        _emptyView.object = obj;
    }
    return _emptyView;
}
//tableData
- (NSMutableArray *)tableData{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
}
//targetResult
- (targetStep *)result{
    if (!_result) {
        targetParam *param = [[targetParam alloc]init];
        param.targetId = self.targetIndex+1;
        _result = [yCache readerTargetStepWithParam:param];
    }
    return _result;
}
#pragma mark==============3，数据渲染
- (void)getData{
    if (self.result) {
        [self.view addSubview:self.myTable];
        [self setData];
    }else{
        [self.view addSubview:self.emptyView];
    }
}
- (void)setData{
    //设置数据
    
    for (NSInteger i=0; i<5; i++) {
        switch (i) {
            case 0:
                [self creatObjWithTitle:self.result.firstStep];
                break;
            case 1:
                 [self creatObjWithTitle:self.result.secordStep];
                break;
            case 2:
                 [self creatObjWithTitle:self.result.thirdStep];
                break;
            case 3:
                 [self creatObjWithTitle:self.result.forthStep];
                break;
            case 4:
                 [self creatObjWithTitle:self.result.fifthStep];
                break;
            default:
                break;
        }
    }
 
  
  
    
    //刷新数据
    if (self.tableData.count>0) {
        self.myTable.tableData = self.tableData;
    }
 
}
#pragma mark==============4，操作

#pragma mark==============5，公用方法
#pragma mark--tableview's delegate
- (CGFloat)tableRowHeightAtIndex:(NSIndexPath *)indexPath{
    return cellHeight_60;
}

- (void)creatObjWithTitle:(NSString *)title{
    if (title.length>0) {
        TableObject *obj = [[TableObject alloc]init];
        obj.title = nil;
        obj.cellString = @"targetProgressCell";
        obj.cellHeight = cellHeight_60;
        [self.tableData addObject:obj];
    }

}
@end

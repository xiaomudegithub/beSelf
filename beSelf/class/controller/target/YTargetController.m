//
//  YGoalController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTargetController.h"
#import "YTargetWriteController.h"
#import "YTargetCheckController.h"


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
//emptyView
@property (strong, nonatomic) YEmptyView *emptyView;


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
    UIButton *rightItem = [[UIButton alloc]initWithFrame:CGRectMake(yUIScreenWidth-btnWidth_44, 0, btnWidth_44, btnWidth_44)];
    [rightItem setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    
    [rightItem addTarget:self action:@selector(rightBarButtonItemDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightItem];
    
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
- (void)tabledidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell对应的对象
    NSDictionary *tempDic =  self.tableData[indexPath.section];
    NSArray *tempArray =  tempDic.allValues[0];
    TableObject *cellObj = tempArray[0];
    
    //跳转到分解目标界面
    YTargetCheckController *controller= [[YTargetCheckController alloc]init];
    controller.title = cellObj.title;
    controller.targetId = indexPath.section;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark--1,获取数据
- (void)getData{
    if(IsMock){
        self.result = mData.targetResult;
    }else{
        self.result = [yCache readerTargetResult];
    }

    if (self.result.targetArray.count>0) {//有数据
        [self.emptyView removeFromSuperview];
        [self setData];
    }else{//没有数据
        [self.view addSubview:self.emptyView];
    }

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
        NSInteger days = [timeTool daysWithStartDay:target.startTime andEndDay:target.endTime andFormat:@"YYYY/MM/dd"];
        object.time = [NSString stringWithFormat:@"%ld",(long)days];
        NSInteger leftDays = [timeTool daysWithStartDay:[timeTool getCurrentTimeWithFormat:@"YYYY/MM /dd"] andEndDay:target.endTime andFormat:@"YYYY/MM/dd"];
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
    controller.delegate = self;
    controller.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark--5,保存目标后回调
- (void)didSaveTarget{
    self.tableData = nil;
    [self getData];
}
#pragma mark--初始化控件
- (YEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[YEmptyView alloc]initWithFrame:self.view.bounds];
        TableObject *obj = [[TableObject alloc]init];
        obj.title = @"还未有时间总额";
        _emptyView.object = obj;
    }
    return _emptyView;
}



@end

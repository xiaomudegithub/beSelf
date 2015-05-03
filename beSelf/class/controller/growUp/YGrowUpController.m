//
//  YGrowUpController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YGrowUpController.h"
#import "growUpRootCellData.h"
#import "growUpRecordController.h"

@interface YGrowUpController ()<GroupTableViewDelegate>
//选择控制器
@property (nonatomic,strong)UISegmentedControl *seg;
//内容table
@property (nonatomic,strong)GroupTableView *myTable;
//数据数组
@property (nonatomic,strong)NSMutableArray *dataArray;
//section数组
@property(nonatomic,strong)NSMutableArray *sectionArray;

@end

@implementation YGrowUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    //设置导航栏
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(rightBarButtonItemDidTap:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //在view上添加控件
    [self.view addSubview:self.seg];
    [self.view addSubview:self.myTable];
    [self getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--1,添加选择控制器
//1.1初始化选择控制器
- (UISegmentedControl *)seg{
    if (!_seg) {
        _seg = [[UISegmentedControl alloc]initWithItems:@[@"成长积累",@"今日事"]];
        _seg.frame = CGRectMake(ySideInset, yViewTopInset+64, yUIScreenWidth-2*ySideInset, segHeight);
        _seg.selectedSegmentIndex = 0;
        _seg.tintColor = growColor;
        [_seg addTarget:self action:@selector(mainChose:) forControlEvents:UIControlEventValueChanged];
    }
    return _seg;
}
//1.2监听选择控制器的点击
- (void)mainChose:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.myTable.hidden =  NO;
            break;
            
        default:
            self.myTable.hidden = YES;
            break;
    }
    
}

#pragma mark--2,添加内容table
//2.1初始化table
- (GroupTableView *)myTable{
    if (!_myTable) {
        _myTable = [[GroupTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.seg.frame)+yViewTopInset, yUIScreenWidth, yUIScreenHeight-CGRectGetMaxY(self.seg.frame)-yViewTopInset) style:UITableViewStylePlain];
        _myTable.group_delegate = self;
  
    }
    _myTable.tableSectionHeaderData = self.sectionArray;
    _myTable.tableData = self.dataArray;
    return _myTable;
}
//点击
- (void)tabledidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id tmpObject = self.dataArray[indexPath.section];
    
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
    
    growUpRootCellData *tmpObj = tmpArr[indexPath.row];
    growUpRecordController *controller = [[growUpRecordController alloc]init];
    controller.object = tmpObj.object;
    [self.navigationController pushViewController:controller animated:YES];
}
//行高
- (CGFloat)tableRowHeightAtIndex:(NSIndexPath *)indexPath{
    NSDictionary *tempDic =  self.dataArray[indexPath.section];
    NSArray *tempArray = tempDic.allValues[0];
    growUpRootCellData *data =  tempArray[indexPath.row];
    return data.rowHeight;
}
//section的header高度
- (CGFloat)tableViewHeightForHeaderInSection:(NSInteger)section{
    SectionObject *sectionObj = self.sectionArray[section];
    return sectionObj.sectionHight;
}

#pragma mark--3，模拟数据
- (void)getData{
    if (IsMock) {
        
    }else{
        
    }
    [self setData];
}
- (void)setData{
    self.dataArray = [NSMutableArray array];
    self.sectionArray = [NSMutableArray array];
    
    for (int i = 0; i<3; i++) {
        SectionObject *sectionObj = [[SectionObject alloc]init];
        sectionObj.titleString = @"20110405";
        sectionObj.valueString = @"";
        sectionObj.sectionHight = ySectionSpace;
        [self.sectionArray addObject:sectionObj];
    }
    
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *tempArray = [NSMutableArray array];
        TableObject *object = [[TableObject alloc]init];
        object.title = @"个人成长十分重要";
        object.subTitle = @"个人成长是一个人一辈子的事情，如果你能坚持做好一件事，你一定会成功";
        
        growUpRootCellData *growUpRootObject = [[growUpRootCellData alloc]init];
        growUpRootObject.object= object;
        growUpRootObject.cellString = @"growUpCell";
        
        [tempArray addObject:growUpRootObject];
        
        [dic setObject:tempArray forKey:@"titleSectionView"];
        [self.dataArray addObject:dic];
    }
    
    [self.myTable reloadData];
}
#pragma mark--4,点击左边按钮，输入内容
- (void)rightBarButtonItemDidTap:(id)sender{
    growUpRecordController *controller = [[growUpRecordController alloc]initWithNibName:@"growUpRecordController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    nav.navigationBar.tintColor = self.view.backgroundColor;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
@end

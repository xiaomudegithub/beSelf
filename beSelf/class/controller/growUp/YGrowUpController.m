//
//  YGrowUpController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YGrowUpController.h"
#import "growUpRootObject.h"
#import "growUpRecordController.h"
#import "targetProgressController.h"


@interface YGrowUpController ()<GroupTableViewDelegate,growUpRecordControllerDelegate>
//myTable's view
@property (strong, nonatomic) UIView *contentView;
//选择控制器
@property (nonatomic,strong)UISegmentedControl *seg;
//内容table
@property (nonatomic,strong)GroupTableView *myTable;
//数据数组
@property (nonatomic,strong)NSMutableArray *dataArray;
//section数组
@property(nonatomic,strong)NSMutableArray *sectionArray;
//从数据库中读取的成长记录对象
@property (nonatomic, strong)growUpResult *result;
//从数据库中读取的目标对象
@property (nonatomic, strong)targetResult *tResult;
//空页面
@property (strong, nonatomic) YEmptyView *emptyView;


@end

@implementation YGrowUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置导航栏
    UIButton *rightItem = [[UIButton alloc]initWithFrame:CGRectMake(yUIScreenWidth-btnWidth_44, 0, btnWidth_44, btnWidth_44)];
    [rightItem setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    
    [rightItem addTarget:self action:@selector(rightBarButtonItemDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightItem];


    
    //在view上添加控件
    [self.view addSubview:self.seg];
    [self.view addSubview:self.contentView];
    [self getData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--0,contenView
- (UIView *)contentView{
    if (!_contentView) {
        CGFloat _contentViewH =  yUIScreenHeight -CGRectGetMaxY(self.seg.frame)-yViewTopInset-viewHeight_50-margin_64;
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.seg.frame)+yViewTopInset, yUIScreenWidth,_contentViewH)];
        [_contentView addSubview:self.myTable];
    }
    return _contentView;
}

#pragma mark--1,添加选择控制器
//1.1初始化选择控制器
- (UISegmentedControl *)seg{
    if (!_seg) {
        _seg = [[UISegmentedControl alloc]initWithItems:@[@"成长积累",@"今日事"]];
        _seg.frame = CGRectMake(ySideInset, yViewTopInset, yUIScreenWidth-2*ySideInset, segHeight);
        _seg.selectedSegmentIndex = 0;
        _seg.tintColor = growColor;
        [_seg addTarget:self action:@selector(mainChose:) forControlEvents:UIControlEventValueChanged];
    }
    return _seg;
}
//1.2监听选择控制器的点击
- (void)mainChose:(UISegmentedControl *)seg{
    
    //切换数据
    [self.dataArray removeAllObjects];
    [yAnimation fanzhuanDownWithView:self.myTable];

    [self getData];
    
}

#pragma mark--2,添加内容table
//2.1初始化table
- (GroupTableView *)myTable{
    if (!_myTable) {
        _myTable = [[GroupTableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _myTable.group_delegate = self;
        _myTable.contentInset = UIEdgeInsetsMake(0, 0, margin_64, 0);
  
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
    
    if (self.seg.selectedSegmentIndex==0) {
        //查看目标
        growUpRootObject *tmpObj = tmpArr[indexPath.row];
        growUpRecordController *controller = [[growUpRecordController alloc]init];
        controller.growLastObj = tmpObj;
        controller.growUpId = indexPath.section;
        controller.delegate = self;
//        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        //查看目标进度
        targetProgressController *controller = [[targetProgressController alloc]init];
        controller.targetIndex = indexPath.section;
//        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    }

}
//行高
- (CGFloat)tableRowHeightAtIndex:(NSIndexPath *)indexPath{
    NSDictionary *tempDic =  self.dataArray[indexPath.section];
    NSArray *tempArray = tempDic.allValues[0];
    if (self.seg.selectedSegmentIndex==0) {
        growUpRootObject *data =  tempArray[indexPath.row];
        return data.rowHeight;
    }else{
        TableObject *data = tempArray[indexPath.row];
        return data.cellHeight;
    }
}
//section的header高度
- (CGFloat)tableViewHeightForHeaderInSection:(NSInteger)section{
    if (self.seg.selectedSegmentIndex==1&&section==0) {
        return 0;
    }else{
        return ySectionSpace;
    }
   
}

#pragma mark--3，获取数据
- (void)getData{
    if (self.seg.selectedSegmentIndex==0) {
        self.result = nil;
        self.result = [yCache readerGrowUpResult];
        if (self.result.grows.count>0) {
            [self.emptyView removeFromSuperview];
            [self setData];
        }else{
            [self.contentView addSubview:self.emptyView];
        }
        
    }else{
        self.tResult = [yCache readerTargetResult];
        if (self.tResult.targetArray.count>0) {
            [self.emptyView removeFromSuperview];
            [self setTagetData];
        }else{
            [self.contentView addSubview:self.emptyView];

        }
    }
    
}
- (void)setData{
    
    self.dataArray = [NSMutableArray array];
    self.sectionArray = [NSMutableArray array];
    for (NSInteger i =0; i<self.result.grows.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        growUpRootObject *grow = self.result.grows[i];
        
        SectionObject *sectionObj = [[SectionObject alloc]init];
        sectionObj.titleString = grow.object.time;
        sectionObj.valueString = @"";
        sectionObj.sectionHight = ySectionSpace;
        [self.sectionArray addObject:sectionObj];


        [tempArray addObject:grow];
        
        [dic setObject:tempArray forKey:@"titleSectionView"];
        [self.dataArray addObject:dic];
        
    }
    

    [self.myTable reloadData];
}

- (void)setTagetData{
    
    self.dataArray = [NSMutableArray array];
    self.sectionArray = [NSMutableArray array];
    for (NSInteger i =0; i<self.tResult.targetArray.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        SectionObject *sectionObj = [[SectionObject alloc]init];
        sectionObj.titleString = @"";
        sectionObj.valueString = @"";
        sectionObj.sectionHight = ySectionSpace;
        [self.sectionArray addObject:sectionObj];
        
        targetModal *target = self.tResult.targetArray[i];
        
        TableObject *obj = [[TableObject alloc]init];
        obj.cellHeight = yCellHeight;
        obj.cellString = @"growUpTodayThingsCell";
        obj.title =  target.targetTitle;
        [tempArray addObject:obj];
        
        [dic setObject:tempArray forKey:@"titleSectionView"];
        [self.dataArray addObject:dic];
        
}
    
    [self.myTable reloadData];
}

#pragma mark--4,点击左边按钮，输入内容
- (void)rightBarButtonItemDidTap:(id)sender{
    growUpRecordController *controller = [[growUpRecordController alloc]initWithNibName:@"growUpRecordController" bundle:nil];
    controller.delegate = self;
//    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark--5,响应成长记录控制器代理，刷新数据
- (void)didSaveGrowUpRecord{
    [self getData];
}
#pragma  mark--初始化控件
- (YEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[YEmptyView alloc]initWithFrame:self.contentView.bounds];
        TableObject *obj = [[TableObject alloc]init];
        obj.title = @"还未有成长记录，赶快去添加吧";
        _emptyView.object = obj;
    }
    return _emptyView;
}
@end

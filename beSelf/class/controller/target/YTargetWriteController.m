//
//  YTargetWriteController.m
//  beSelf
//
//  Created by 木 on 15/4/17.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTargetWriteController.h"

@interface YTargetWriteController ()<GroupTableViewDelegate,UITextFieldDelegate,YDatePickerViewDelegate,YDatePickViewControllerDelegate>
/**
 *  表
 */
@property (nonatomic,strong)GroupTableView *myTable;
/**
 *  表数据
 */
@property (nonatomic,strong)NSMutableArray *tableData;
/**
 *  输入数据
 */
@property (nonatomic,strong)targetModal *target;
/**
 *  日期选择器
 */
@property (nonatomic,strong)YDatePickerView *datePicker;
/**
 *  开始日期
 */
@property (nonatomic,strong)UITextField *startTimeField;
/**
 *  结束日期
 */
@property (nonatomic,strong)UITextField *endTimeField;

//endOrBegain:end-yes
@property (nonatomic, assign)BOOL endOrBegain;

//第几行
@property (nonatomic, assign)CGFloat selectCellMaxY;

//moveHeight
@property (nonatomic, assign)CGFloat moveHeight;

@end

@implementation YTargetWriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNav];
    
    [self setData];
    
    [self.view addSubview:self.myTable];
    
    [self.view addSubview:self.datePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark======================0,初始化控件
#pragma mark--设置导航栏
- (void)setNav{
    self.title = @"有目标才有方向";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
      self.navigationItem.rightBarButtonItem.tintColor = targetColor;
}

#pragma mark--myTable
- (GroupTableView *)myTable{
    if (!_myTable) {
        _myTable = [[GroupTableView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, yUIScreenHeight) style:UITableViewStylePlain];
        _myTable.group_delegate = self;
        _myTable.cellDelegateObject = self;
        _myTable.tableData = self.tableData;
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTable;
}
//myTable's Delegate
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
- (void)tableDidScorll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark--tableData
- (NSMutableArray *)tableData{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
}
#pragma mark--target
- (targetModal *)target{
    if (!_target) {
        _target = [[targetModal alloc]init];
    }
    return _target;
}
#pragma mark--datePick
- (YDatePickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[YDatePickerView alloc]initWithFrame:CGRectMake(0, yUIScreenHeight, yUIScreenWidth, 216)];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

#pragma mark=====================1,设置数据
- (void)setData{
    NSArray *cellName = @[@"请输入目标",@"请输入开始时间",@"请输入结束时间",@"请输入计划投入金额",@"投入金额用途"];
    for (NSInteger i = 101; i<101+cellName.count; i++) {
        TableObject *object = [[TableObject alloc]init];
        object.cellString = @"targetWriteCell";
        object.cellHeight = cellHeight_60;
        object.subTitle = cellName[i-101];
        object.tag = i;
        [self.tableData addObject:object];
    }
}
#pragma mark====================2,保存数据并返回
#pragma mark--2.1调取不同的键盘

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.selectCellMaxY = cellHeight_60*(textField.tag-100);
    CGFloat height = self.selectCellMaxY+216;
    if (height > yUIScreenHeight-margin_64) {
        self.moveHeight = height - yUIScreenHeight+margin_64+margin_20;
        [yAnimation moveUpView:self.view WithHeight:self.moveHeight];
    }
    switch (textField.tag) {
        case targetTag:
            
            self.target.targetTitle = textField.text;
            return YES;
            break;
        case startTimeTag:{
            [self.view endEditing:YES];
            textField.placeholder = nil;
            self.startTimeField = textField;
            self.endOrBegain = NO;
            [self startDatePickModalController];
        }
            return NO;
            break;
        case endTimeTag:
            [self.view endEditing:YES];
            textField.placeholder = nil;
            self.endTimeField = textField;
            self.endOrBegain = YES;
            [self startDatePickModalController];
            return NO;
            break;
        case moneyTag:
            
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            return YES;
            break;
        case moneyUseTag:
            
            return YES;
            break;
        default:
            return YES;
            break;
    }
}
#pragma mark--2.2获取输入数据
//收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

//获取数据
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [yAnimation moveDownView:self.view WithHeight:self.moveHeight];
    switch (textField.tag) {
        case targetTag:
            self.target.targetTitle = textField.text;
            break;
        case startTimeTag:
            self.target.startTime = textField.text;
            break;
        case endTimeTag:
            self.target.endTime = textField.text;
            break;
        case moneyTag:
            self.target.targetMoney = textField.text;
            break;
        case moneyUseTag:
            self.target.moneyUse = textField.text;
            break;
        default:
            break;
    }

}

#pragma mark--2.3保存并返回
- (void)save{
    //保存数据
    [yCache cacheTarget:self.target];
    if ([self.delegate respondsToSelector:@selector(didSaveTarget)]) {
        [self.delegate didSaveTarget];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--公共方法
//吊起日期选择器
- (void)startDatePickModalController{
    YDatePickViewController *controller = [[YDatePickViewController alloc]init];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.mainColor = targetColor;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
//确认选择日期
- (void)didDatePickWithDateString:(NSString *)dateString{
    if (self.endOrBegain) {
        self.endTimeField.text = dateString;
        self.target.endTime = dateString;
    }else{
        self.startTimeField.text = dateString;
        self.target.startTime = dateString;
    }
    
}
//取消选择日期
- (void)cancelDatePick{
    if (self.endOrBegain) {
        self.endTimeField.text = nil;
        self.target.startTime = nil;
        self.endTimeField.placeholder = @"请输入结束时间";
    }else{
        self.startTimeField.text = nil;
        self.target.endTime = nil;
        self.startTimeField.placeholder = @"请输入开始时间";
    }

}
@end

//
//  YTimeViewController.m
//  beSelf
//
//  Created by 木 on 15/4/22.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTotalTimeViewController.h"

@interface YTotalTimeViewController ()<UITextFieldDelegate,YDatePickerViewDelegate>
//属性
@property (weak, nonatomic) IBOutlet yLabel *timeTotalLab;
@property (weak, nonatomic) IBOutlet yLabel *currentTime;
@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *endTimeText;
@property (weak, nonatomic) IBOutlet UIButton *cofirmBtn;

//方法
- (IBAction)confirm:(UIButton *)sender;
//日期选择器
@property (nonatomic,strong)YDatePickerView *datePicker;
//开始时间或者结束时间
@property(nonatomic,assign)BOOL startOrEnd;

@end

@implementation YTotalTimeViewController
#pragma mark==============1,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"时间总额";
    
    [self setUpEverything];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark==============2，UI搭建
#pragma mark--初始化
- (void)setUpEverything{
    //totalTimeLab
    self.timeTotalLab.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"timeTotal"];
    
    //currentTime
    self.currentTime.text = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    self.startTimeText.layer.borderColor = UIColorWithRGB(110, 253, 103).CGColor;
    
    //datePicker
    [self.view addSubview:self.datePicker];
    
}
//datePicker
- (YDatePickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[YDatePickerView alloc]initWithFrame:CGRectMake(0, yUIScreenHeight, yUIScreenWidth, 216)];
        _datePicker.delegate = self;
    }
    return _datePicker;
}
#pragma mark==============3，数据渲染

#pragma mark==============4，操作
#pragma mark--4.1选择日期
- (void)didSelectDate:(NSString *)date{
    if (self.startOrEnd) {
        self.startTimeText.text = date;
    }else{
        self.endTimeText.text = date;
    }
}
#pragma mark--4.2确认
- (IBAction)confirm:(UIButton *)sender {
    NSInteger days = [timeTool daysWithStartDay:self.startTimeText.text andEndDay:self.endTimeText.text andFormat:@"YYYY/MM/dd"];
    if (days>0) {
        
        //渲染数据
        self.timeTotalLab.text = [NSString stringWithFormat:@"%ld",days];
        //存储数据
        [[NSUserDefaults standardUserDefaults]setObject:self.timeTotalLab.text forKey:@"timeTotal"];
        //通知代理
        if ([self.delegate respondsToSelector:@selector(didSaveTotalMoney)]) {
            [self.delegate didSaveTotalMoney];
        }
        
        //返回主页面
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"时间输入错误" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alterView show];
    }
}
#pragma mark==============5，公用方法
//关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.datePicker closeDatePicker ];
}
//开始选择时间
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.startTimeText) {
        self.startOrEnd = YES;
    }else if (textField == self.endTimeText){
        self.startOrEnd = NO;
    }
    textField.placeholder = @"";
    [self.datePicker openDatePicker];
    return NO;
}


@end

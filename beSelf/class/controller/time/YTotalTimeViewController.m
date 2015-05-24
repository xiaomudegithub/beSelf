//
//  YTimeViewController.m
//  beSelf
//
//  Created by 木 on 15/4/22.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTotalTimeViewController.h"

@interface YTotalTimeViewController ()<UITextFieldDelegate,YDatePickViewControllerDelegate>
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
    NSString *totalTime =  [[NSUserDefaults standardUserDefaults]valueForKey:@"timeTotal"];
    self.timeTotalLab.text = totalTime;
    
    //currentTime
    self.currentTime.text = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    
    //confirmBtn
    [self.cofirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cofirmBtn.layer.cornerRadius = 5;
    self.cofirmBtn.backgroundColor = timeColor;
    
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
        self.timeTotalLab.text = [NSString stringWithFormat:@"%d",days];
        //存储数据
        [[NSUserDefaults standardUserDefaults]setObject:self.timeTotalLab.text forKey:@"timeTotal"];
        //通知代理
        if ([self.delegate respondsToSelector:@selector(didSaveTotalTime)]) {
            [self.delegate didSaveTotalTime];
        }
        
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
    
    [self getUpDateKeyboard];
    
    return NO;
}

//调起日期键盘
- (void)getUpDateKeyboard{
    
    YDatePickViewController *controller = [[YDatePickViewController alloc]init];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.mainColor = timeColor;
    controller.delegate =  self;
    [self presentViewController:controller animated:YES completion:nil];
}
//日期键盘代理
//确定
- (void)didDatePickWithDateString:(NSString *)dateString{
    if (self.startOrEnd) {
        self.startTimeText.text = dateString;
    }else{
        self.endTimeText.text = dateString;
    }
}
//取消
- (void)cancelDatePick{
    if (self.startOrEnd) {
        self.startTimeText.text = nil;
        self.startTimeText.placeholder = @"请输入开始时间";
    }else{
        self.endTimeText.text = nil;
        self.endTimeText.placeholder = @"请输入结束时间";
    }

}
@end

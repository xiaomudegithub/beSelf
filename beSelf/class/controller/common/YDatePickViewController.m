//
//  YDatePickViewController.m
//  beSelf
//
//  Created by 木柳 on 15/5/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YDatePickViewController.h"

@interface YDatePickViewController ()
//属性
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
//方法
- (IBAction)choseDate:(id)sender;

- (IBAction)cancelChose:(id)sender;

- (IBAction)confrimChose:(id)sender;

//日期字符串
@property (copy, nonatomic)NSString* dateString;
@end

@implementation YDatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark--UI搭建
- (void)setUpUI{
    //self.view
    self.view.backgroundColor = [UIColor clearColor];
    
    //bgView
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    //cancelBtn
    self.cancelBtn.layer.cornerRadius = 5;
    [self.cancelBtn setBackgroundColor:self.mainColor];
    
    //confrimBtn
    self.confirmBtn.layer.cornerRadius = 5;
    [self.confirmBtn setBackgroundColor:self.mainColor];
    
    //datePick
    [self choseDate:self.datePicker];
}

#pragma mark--选择日期
- (IBAction)choseDate:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    self.dateString = [timeTool stringWihDate:picker.date andFormat:@"YYYY/MM/dd"];
    
    if ([self.delegate respondsToSelector:@selector(didDatePickWithDateString:)]) {
        [self.delegate didDatePickWithDateString:self.dateString];
    }
    
}
#pragma mark--取消选择
- (IBAction)cancelChose:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancelDatePick)]) {
        [self.delegate cancelDatePick];
    }
    //关闭模态视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--确认选择
- (IBAction)confrimChose:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didDatePickWithDateString:)]) {
        [self.delegate didDatePickWithDateString:self.dateString];
    }
    //关闭模态视图
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

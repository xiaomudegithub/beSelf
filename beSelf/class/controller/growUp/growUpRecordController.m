//
//  growUpRecordController.m
//  beSelf
//
//  Created by 木 on 15/4/9.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "growUpRecordController.h"

@interface growUpRecordController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet yLabel *timeLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, strong)growUpRootObject   *growObject;
@end

@implementation growUpRecordController
#pragma mark--0,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"温故而知新，可以为师矣";
    self.view.backgroundColor = growColor;
    if (!self.object) {
       
    }
    [self setControllItem];
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
#pragma mark--1,输入标题
//1.1更改标题
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.growObject.object.title = textField.text;
}
//1.2关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark--2，输入内容
//2.1编辑内容
- (void)textViewDidChange:(UITextView *)textView{
    self.growObject.object.subTitle = textView.text;
}
//2.2关闭键盘
#pragma mark--3,存储数据并返回
- (void)save:(id)sender{
    //3.1存储数据
    [yCache cacheGrowUpRecord:self.growObject];
    //3.2.1通知代理
    if([self.delegate respondsToSelector:@selector(didSaveGrowUpRecord)]){
        [self.delegate didSaveGrowUpRecord];
    };
    //3.2返回
    [self dismissViewControllerAnimated:YES completion:^{
      
    }];
}
#pragma mark--初始化控件
- (void)setControllItem{
    
    //titleTextField
    self.titleTextField.text = self.object.title;
    self.titleTextField.delegate = self;
    
    //timeLabel
    self.timeLab.text = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    self.timeLab.textColor = [UIColor whiteColor];
    
    //line
    self.lineView.backgroundColor = [UIColor whiteColor];
    
    //输入内容
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.contentTextView.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.contentTextView.text = self.object.subTitle;
    self.contentTextView.layer.borderWidth = 0.33;
    self.contentTextView.delegate = self;

}
- (growUpRootObject *)growObject{
    if (!_growObject) {
        _growObject = [[growUpRootObject alloc]init];
        _growObject.object.time = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    }
    return _growObject;
}
@end

//
//  YTabbarController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTabbarController.h"
#import "YTimeController.h"
#import "YMoneyController.h"
#import "YTargetController.h"
#import "YGrowUpController.h"

@interface YTabbarController ()
//背景视图
@property (nonatomic,strong)UIView *backView ;

@end

@implementation YTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, 50)];
    [self.tabBar insertSubview:self.backView atIndex:0];
    //添加子控制器
    [self addChildController];
}
- (void)addChildController{
    
    //添加个人成长控制器
    YGrowUpController *growUpController = [[YGrowUpController alloc]init];
    [self creatChildControllerWithController:growUpController andTitle:@"成长" andImageName:nil andColor:growColor];
    
    //添加目标管理控制器
    YTargetController *goalController = [[YTargetController alloc]init];
    [self creatChildControllerWithController:goalController andTitle:@"目标" andImageName:nil andColor:targetColor];

    //添加时间管理控制器
    YTimeController *timeController = [[YTimeController alloc]init];
    [self creatChildControllerWithController:timeController andTitle:@"时间" andImageName:@"time" andColor:timeColor];
 
    //添加财富管理控制器
    YMoneyController *moneyController = [[YMoneyController alloc]init];
    [self creatChildControllerWithController:moneyController andTitle:@"财富" andImageName:nil andColor:moneyColor];
   
}
#pragma mark--方法
- (void)creatChildControllerWithController:(UIViewController *)controller andTitle:(NSString *)title andImageName:(NSString *)imageName andColor:(UIColor *)color{
    //controller的属性
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:@"time"];
    controller.title = title;
    controller.view.backgroundColor = bgColor;
    //包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:nav];
    
    //设置tabbar的背景色
    self.backView.backgroundColor = [UIColor clearColor];
    
    //设置导航栏的字体属性
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    [nav.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
    
    //设置导航栏的背景
  
    //设置导航栏的返回按钮
 
    //添加tabbarline
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 44, yUIScreenWidth, 2)];
    lineView.backgroundColor = color;
    [nav.navigationBar addSubview:lineView];

}


@end

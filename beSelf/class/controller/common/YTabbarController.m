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
    //add backView
    self.backView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, 50)];
    self.backView.backgroundColor = bgColor;
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
    YNavigationController *nav = [[YNavigationController alloc]initWithRootViewController:controller];
    
    //设置导航栏的字体属性
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    nav.backBtnTitle = @"返回";
    nav.backBtnColor = color;
    
    //设置导航栏透明
    nav.navigationBar.translucent = NO;
    
    //add tabbarItem
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:nil selectedImage:nil];
    NSDictionary *textDic = @{NSForegroundColorAttributeName:color};
    [item setTitleTextAttributes:textDic forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:textDic forState:UIControlStateNormal];
 
    //添加tabbarline
    UIView *navlineView =[[UIView alloc]initWithFrame:CGRectMake(0, 44, yUIScreenWidth, 2)];
    navlineView.backgroundColor = color;
    [nav.navigationBar addSubview:navlineView];
    
    [self addChildViewController:nav];

}


@end

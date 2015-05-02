//
//  GroupTableView.h
//  MyGroupTableView
//
//  Created by chenchen.lcc on 15-2-12.
//  Copyright (c) 2015年 chenchen.lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupTableViewDelegate <NSObject>

@optional
//加载行高
- (CGFloat) tableRowHeightAtIndex:(NSIndexPath *)indexPath;
//点击代理事件
- (void) tabledidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//footer header View 高
- (CGFloat) tableViewHeightForFooterInSection:(NSInteger)section;
- (CGFloat) tableViewHeightForHeaderInSection:(NSInteger)section;

@end

@interface GroupTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *cellString;

//数组  数组成员是字典
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSArray *tableSectionHeaderData;
@property (nonatomic, strong) NSArray *tableSectionFooterData;

//cell回调代理
@property (weak) id cellDelegateObject;

//表的代理
@property (nonatomic, weak) id<GroupTableViewDelegate> group_delegate;

- (void)reloadTableData;

@end

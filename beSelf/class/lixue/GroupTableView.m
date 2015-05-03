//
//  GroupTableView.m
//  MyGroupTableView
//
//  Created by chenchen.lcc on 15-2-12.
//  Copyright (c) 2015年 chenchen.lcc. All rights reserved.
//

#import "GroupTableView.h"

#define CELLNAMEKEY @"cellString"
#define SECTIONKEY @"sectoinString"
#define IDENTIFIER @"identifier"

@implementation GroupTableView

- (void)dealloc
{
    self.dataSource = nil;
    self.delegate = nil;
    _tableData = nil;
    _cellDelegateObject = nil;
    _group_delegate = nil;
    self.tableHeaderView = nil;
    self.tableFooterView = nil;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        
        //去掉多余的线条
        self.tableFooterView = [[UIView alloc] init];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - custom method
/**
 *  用于设置section的header和footer
 *
 *  @param dataObject header和footer的数据
 *  @param tableView  表
 *  @param section    section的index
 *
 *  @return 返回自定义的section的header和footerview
 */
- (UIView *) sectionViewWithObject:(id) dataObject tableView:(UITableView *) tableView section:(NSInteger) section
{
    //读取section的classstring
    NSString *classString = [[_tableData objectAtIndex:section] allKeys][0];
    
    if (classString.length == 0)
    {
        return nil;
    }
    
    //和表的cell使用相似 
    NSString *identifier = classString;
    UIView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if (!sectionView)
    {
        sectionView = [[NSClassFromString(classString) alloc] init];
    }
    
    if ([sectionView respondsToSelector:@selector(setContentWithObject:AtSection:)])
    {
        [sectionView performSelector:@selector(setContentWithObject:AtSection:) withObject:dataObject withObject:[NSNumber numberWithInteger:section]];
    }
    
    return sectionView;
}

- (void) setTableData:(NSArray *)tableData
{
    _tableData = tableData;
    
    if (_tableData)
    {
        [self reloadData];
    }
}

- (void) setTableSectionFooterData:(NSArray *)tableSectionFooterData
{
    _tableSectionFooterData = tableSectionFooterData;
    if (_tableSectionFooterData)
    {
        [self reloadData];
    }
    
}

- (void)setTableSectionHeaderData:(NSArray *)tableSectionHeaderData
{
    _tableSectionHeaderData = tableSectionHeaderData;
    if (_tableSectionHeaderData)
    {
        [self reloadData];
    }
    
}

#pragma mark - 表的代理方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //判断是否有section
    if (self.tableData.count>0) {
        id tmpObj = _tableData[0];
        if ([tmpObj isKindOfClass:[NSDictionary class]]) {
            
            return _tableData.count;
        }
        else
        {
            return 1;
        }
    }else{
        return 0;
    }
    
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id tmpObj = _tableData[section];
    
    //判断是否是对象还是Dictionary
    if ([tmpObj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *tmpDic = (NSDictionary *)tmpObj;
        NSArray *tmpArr = tmpDic.allValues[0];
        
        return tmpArr.count;
    }
    else
    {
        return _tableData.count;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = IDENTIFIER;
    
    //获取section
    id tmpObj = _tableData[indexPath.section];
    
    NSArray *tmpArr = nil;
    
    //判断是否是对象还是Dictionary
    if ([tmpObj isKindOfClass:[NSDictionary class]]) {
        
        //如果是有多个section，需要取出每个section的数据源
        NSDictionary *tmpDic = (NSDictionary *)tmpObj;
        
        //获取section的数据源
        tmpArr = tmpDic.allValues[0];
    }
    else
    {
        //就是不同的对象
        tmpArr = _tableData;
    }
    //根据cellString初始化不同的cell
    if (self.cellString == nil)
    {
        //获取对象
        id object = tmpArr[indexPath.row];
        
        //获取对象所有key
        identifier = [object valueForKey:CELLNAMEKEY];
        
    }
    else
    {
        identifier = self.cellString;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if ([cell respondsToSelector:@selector(setContentWithObject: AtIndexPath:)])
    {
        [cell performSelector:@selector(setContentWithObject: AtIndexPath:) withObject:_tableData withObject:indexPath];
    }
    
    if ([cell respondsToSelector:@selector(setCellDelegate:)])
    {
        [cell performSelector:@selector(setCellDelegate:) withObject:_cellDelegateObject];
    }
    
    //添加分隔线
    return cell;
}

//行单击
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.group_delegate respondsToSelector:@selector(tabledidSelectRowAtIndexPath:)])
    {
        [self.group_delegate tabledidSelectRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0.0f;
    
    if ([self.group_delegate respondsToSelector:@selector(tableRowHeightAtIndex:)])
    {
        rowHeight = [self.group_delegate tableRowHeightAtIndex:indexPath];
    }
    
    return rowHeight;
}

//section headerView 高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    
    if ([self.group_delegate respondsToSelector:@selector(tableViewHeightForHeaderInSection:)])
    {
        height = [self.group_delegate tableViewHeightForHeaderInSection:section];
    }
    
    return height;
}

//section headerView
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionViewWithObject:_tableSectionHeaderData tableView:tableView section:section];
}

//section footerView 高度
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    
    if ([self.group_delegate respondsToSelector:@selector(tableViewHeightForFooterInSection:)])
    {
        height = [self.group_delegate tableViewHeightForFooterInSection:section];
    }
    
    return height;
}

//section footerView
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self sectionViewWithObject:_tableSectionFooterData tableView:tableView section:section];
}

- (void)reloadTableData{
    [self reloadData];
}

#pragma mark--------mu
- (UIView *)separatorLineview{
    if (!_separatorLineview) {
        _separatorLineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, yUIScreenWidth, 0.33)];
        _separatorLineview.backgroundColor = bgColor;
    }
    return _separatorLineview;
}


@end

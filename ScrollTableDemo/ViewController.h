//
//  ViewController.h
//  ScrollTableDemo
//
//  Created by csdc-iMac on 15/10/21.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIView *headView;// 标题view
@property (strong, nonatomic) UIScrollView *buttonScrollView;// 滑动标签栏
@property (strong, nonatomic) UIScrollView *tableScrollView;// 左右滑动列表
@property (strong, nonatomic) UITableView *tableView;// 当前显示列表
@property (strong, nonatomic) NSMutableArray *btnTitleArray;// 按钮标题数组
@property (strong, nonatomic) NSMutableArray *btnArray;// 按钮数组
@property (strong, nonatomic) NSMutableArray *tableArray;// 列表数组
@property (strong, nonatomic) NSMutableArray *datasources;// 列表数据源数组
@property (assign) NSInteger currentPage;// 当前选中的界面


@end


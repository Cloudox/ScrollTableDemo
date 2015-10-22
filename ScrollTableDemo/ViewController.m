//
//  ViewController.m
//  ScrollTableDemo
//
//  Created by csdc-iMac on 15/10/21.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import "ViewController.h"
#import "CMCutLineView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self headTitleView];
    
    [self scrollBtnView];
    
    [self initDataSource];
    
    [self allTableScrollView];
    
    [self initDownTables];
}

// 顶部标题view
- (void)headTitleView {
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 87)];
    self.headView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:76.0/255.0 blue:103.0/255.0 alpha:1.0];
    [self.view addSubview:self.headView];
    
    // 标题label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, [UIScreen mainScreen].bounds.size.width - 20, 16)];
    titleLabel.text = @"XXX国家自然科学基金项目";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    // 自动换行
    titleLabel.numberOfLines = 0;
    titleLabel.opaque = NO;
    NSString *text = titleLabel.text;
    CGSize size = CGSizeMake(300,70);
    CGSize labelsize = [text sizeWithFont:titleLabel.font constrainedToSize:size lineBreakMode:titleLabel.lineBreakMode];
    CGRect newFrame = titleLabel.frame;
    newFrame.size.height = labelsize.height;
    titleLabel.frame = newFrame;
    // 如果换行了，增加headview高度
    if (titleLabel.frame.size.height > 20) {
        self.headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 71 + labelsize.height);
//        yearAndDirectorLabel.frame = CGRectMake(0, 42 + labelsize.height, [UIScreen mainScreen].bounds.size.width, 13);
    }
    [self.headView addSubview:titleLabel];
    
    // 年份、作者label
    UILabel *yearAndDirectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 58, [UIScreen mainScreen].bounds.size.width, 13)];
    yearAndDirectorLabel.text = @"2015 | Cloudox";
    yearAndDirectorLabel.backgroundColor = [UIColor clearColor];
    yearAndDirectorLabel.textColor = [UIColor colorWithRed:142.0/255.0 green:195.0/255.0 blue:241.0/255.0 alpha:1];
    yearAndDirectorLabel.textAlignment = NSTextAlignmentCenter;
    [yearAndDirectorLabel setFont:[UIFont systemFontOfSize:13]];
    // 如果换行了，增加headview高度
    if (titleLabel.frame.size.height > 20) {
        self.headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 71 + labelsize.height);
        yearAndDirectorLabel.frame = CGRectMake(0, 42 + labelsize.height, [UIScreen mainScreen].bounds.size.width, 13);
    }
    [self.headView addSubview:yearAndDirectorLabel];
    
}

// 滑动标签栏
- (void)scrollBtnView {
    self.buttonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 30)];
    self.buttonScrollView.backgroundColor = [UIColor whiteColor];
    self.buttonScrollView.scrollEnabled = YES;// 可滚动
    self.buttonScrollView.bounces = NO;// 到边界不弹回
    self.buttonScrollView.showsHorizontalScrollIndicator = NO;// 不显示横向滚动条
    
    self.btnTitleArray = [[NSMutableArray alloc] initWithObjects:@"基本信息", @"资助项目", @"发表信息", @"奖励信息", nil];
    
    self.btnArray = [[NSMutableArray alloc] init];
    
    self.buttonScrollView.contentSize = CGSizeMake(20 + [self.btnTitleArray count] * 100, 30);// 设置显示内容的多少
    
    for (int i = 0; i < [self.btnTitleArray count]; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 + i * 100, 0, 80, 25)];
        [btn setTitle:[self.btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];// 设置标题
        if (i == 0) {
            // 将第一个按钮变为红色
            [btn setTitleColor:[UIColor colorWithRed:228.0/255.0 green:117.0/255.0 blue:97.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];// 添加响应
        [self.buttonScrollView addSubview:btn];
        [self.btnArray addObject:btn];
    }
    // 底部分割线
    CMCutLineView *cutLineView = [[CMCutLineView alloc] initWithFrame:CGRectMake(0, self.buttonScrollView.frame.size.height - 1, self.buttonScrollView.contentSize.width, 1) lineColor:[UIColor blackColor] alpha:0.07 isDashLine:NO lineWidth:1];
    [self.buttonScrollView addSubview:cutLineView];
    [self.view addSubview:self.buttonScrollView];
}

// 点击标签响应
- (void)selectButton:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    // 将未选中按钮变为黑色
    for (int i = 0; i < [self.btnArray count]; i++) {
        UIButton *btn = (UIButton *)self.btnArray[i];
        if (![btn.titleLabel.text isEqualToString:sender.titleLabel.text]) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    // 将选中按钮变为红色
    [sender setTitleColor:[UIColor colorWithRed:228.0/255.0 green:117.0/255.0 blue:97.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    if (sender.frame.origin.x + sender.bounds.size.width - self.buttonScrollView.contentOffset.x > [UIScreen mainScreen].bounds.size.width) {// 标签内容超出了屏幕右边边界
        [self.buttonScrollView setContentOffset:CGPointMake(sender.frame.origin.x - ([UIScreen mainScreen].bounds.size.width - sender.bounds.size.width - 20), 0) animated:YES];
    }
    
    if (sender.frame.origin.x - self.buttonScrollView.contentOffset.x < 20) {// 标签内容超出了屏幕左边边界
        [self.buttonScrollView setContentOffset:CGPointMake(sender.frame.origin.x - 20, 0) animated:YES];
    }
    
    // 更改下方显示的table
    [self.tableScrollView setContentOffset:CGPointMake(sender.tag*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
}

// 初始化列表数据源
//仅测试用
-(void) initDataSource{
    self.datasources = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.btnTitleArray count]; i++) {
        
        NSMutableArray *tempArray  = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (int j = 0; j < 10; j++) {
            
            NSString *tempStr = [NSString stringWithFormat:@"我是第%d个TableView%@的第%d条数据。", i + 1, self.btnTitleArray[i], j];
            [tempArray addObject:tempStr];
        }
        
        [self.datasources addObject:tempArray];
    }
}

//下方的多个tableview在同一个scrollview里，初始化这个scrollview。
-(UIScrollView *)allTableScrollView{
    if(nil == self.tableScrollView){
        self.tableScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height + self.buttonScrollView.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.headView.frame.size.height - self.buttonScrollView.frame.size.height)];
        self.tableScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * [self.btnTitleArray count], [UIScreen mainScreen].bounds.size.height - self.headView.frame.size.height - self.buttonScrollView.frame.size.height);
        self.tableScrollView.backgroundColor = [UIColor yellowColor];
        self.tableScrollView.showsHorizontalScrollIndicator = NO;
        self.tableScrollView.pagingEnabled = YES;
        self.tableScrollView.bounces = NO;
        self.tableScrollView.directionalLockEnabled = YES;
        self.tableScrollView.delegate = self;
        [self.view addSubview:self.tableScrollView];
    }
    return self.tableScrollView;
}

//初始化下方的TableViews
-(void) initDownTables{
    self.tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.btnTitleArray count]; i ++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, self.tableScrollView.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //去除多余的列表线条
        tableView.tableFooterView = [[UIView alloc] init];
        [self.tableArray addObject:tableView];
        [self.tableScrollView addSubview:tableView];
    }
    
}

#pragma mark - scrollView delegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    // 确定当前界面，更新当前tableview
    if ([scrollView isEqual:self.tableScrollView]) {
        self.currentPage = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        UITableView *currentTable = (UITableView *)self.tableArray[self.currentPage];
        [currentTable reloadData];
        
        // 更改上方选中的按钮
        [self selectButton:self.btnArray[self.currentPage]];
        
        return;
    }
    
}

#pragma mark -- talbeView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tempArray = self.datasources[self.currentPage];
    return tempArray.count;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *SimpleCell = @"SimpleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleCell];
    if(nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleCell];
    }
//    NSLog(@"%ld", (long)self.currentPage);
    cell.textLabel.text = self.datasources[self.currentPage][[indexPath row]];
    cell.userInteractionEnabled = NO;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

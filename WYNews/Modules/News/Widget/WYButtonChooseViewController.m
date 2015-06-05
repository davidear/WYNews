//
//  WYButtonChooseViewController.m
//  WYButtonChooseView
//
//  Created by dai.fengyi on 15/6/3.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYButtonChooseViewController.h"
#import "WYButtonChooseView.h"
#import "WYTopic.h"
#define kHeaderHeight       36
#define kDefaultY           20
@interface WYButtonChooseViewController () <LabelChooseDelegate>
@property (strong, nonatomic) WYButtonChooseView *topChooseView;
@property (strong, nonatomic) WYButtonChooseView *bottomChooseView;
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UIView *header;
@end

@implementation WYButtonChooseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)setSelectedArray:(NSMutableArray *)selectedArray
{
    _selectedArray = selectedArray;
    if (_selectedArray != nil) {
        for (WYTopic *topic in _selectedArray) {
            [_topChooseView addButtonWith:topic.tname position:CGPointZero];
            [_bottomChooseView addButtonWith:topic.tname position:CGPointZero];
        }
    }
    [self refreshView];
}

- (void)setUnSelectedArray:(NSMutableArray *)unSelectedArray
{
    _unSelectedArray = unSelectedArray;
    if (_unSelectedArray != nil) {
        for (WYTopic *topic in _unSelectedArray) {
            [_topChooseView addButtonWith:topic.tname position:CGPointZero];
            [_bottomChooseView addButtonWith:topic.tname position:CGPointZero];
        }
    }
    [self refreshView];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self.view];
    CGRect frame = view.bounds;
    frame.origin.y = -frame.size.height;
    self.view.frame = frame;
    [UIView animateWithDuration:kDuration animations:^{
        self.view.frame = view.bounds;
    } completion:^(BOOL finished) {
        
    }];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self initSubviews];
//    [self loadData];
//}
//
//- (void)loadData
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSHBookLabels" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    for (NSString *title in array) {
//        [_topChooseView addButtonWith:title position:CGPointZero];
//        [_bottomChooseView addButtonWith:title position:CGPointZero];
//    }
//    [self refreshView];
//}

- (void)initSubviews
{
//    self.view.clipsToBounds = YES;
    [self prefersStatusBarHidden];
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
//    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderHeight)];
    _header.backgroundColor = kTopicHeaderBgColor;
    [self.view addSubview:_header];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMarginW, 0, 80, kHeaderHeight)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"切换栏目";
    [_header addSubview:label];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - kMarginW - kHeaderHeight, 0, 30, kHeaderHeight)];
    [button1 setImage:[UIImage imageNamed:@"channel_nav_arrow"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(spreadAction:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.frame.origin.x - kMarginW - 65, 0, 60, kHeaderHeight)];
    [button2 setTitle:@"排序删除" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button2 setBackgroundImage:[UIImage imageNamed:@"channel_edit_button_bg"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"channel_edit_button_selected_bg"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:button2];
    
    _topChooseView = [[WYButtonChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_header.frame), [UIScreen mainScreen].bounds.size.width, 200)];
    _topChooseView.chooseDelegate = self;
    _topChooseView.dragable = YES;
    [self.view addSubview:_topChooseView];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topChooseView.frame) + 100, [UIScreen mainScreen].bounds.size.width, 30)];
    _label.backgroundColor = [UIColor grayColor];
    _label.text = @"separator label";
    [self.view addSubview:_label];

    _bottomChooseView = [[WYButtonChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_label.frame) + kMarginH, [UIScreen mainScreen].bounds.size.width, 200)];
    _bottomChooseView.chooseDelegate = self;
    _bottomChooseView.dragable = NO;
    [self.view addSubview:_bottomChooseView];
    
    _topChooseView.clipsToBounds = NO;
    _bottomChooseView.clipsToBounds = NO;
}

- (void)refreshView
{
    [UIView animateWithDuration:kDuration animations:^{
        _label.frame = CGRectMake(0, CGRectGetMaxY(_topChooseView.frame) + kMarginH, [UIScreen mainScreen].bounds.size.width, 30);
        _bottomChooseView.frame = CGRectMake(0, CGRectGetMaxY(_label.frame) + kMarginH, [UIScreen mainScreen].bounds.size.width, 200);
    }];
}
#pragma mark - button Action
- (void)switchAction:(UIButton *)sender
{
    UILabel *label = _header.subviews[0];
    UIButton *button2 = _header.subviews[2];
    if ([button2.titleLabel.text isEqualToString:@"排序删除"]) {
        label.text = @"拖动排序";
        [button2 setTitle:@"完成" forState:UIControlStateNormal];
        _topChooseView.edit = YES;
        _bottomChooseView.hidden = YES;
    }else {
        label.text = @"切换栏目";
        [button2 setTitle:@"排序删除" forState:UIControlStateNormal];
        _topChooseView.edit = NO;
        _bottomChooseView.hidden = NO;
    }
}
- (void)spreadAction:(UIButton *)sender
{
    [UIView animateWithDuration:kDuration animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -frame.size.height;
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}
#pragma mark - ChooseButtonView delegate
- (void)didSelectedButton:(WYLabelButton *)button
{
    if (button.superview == _topChooseView) {
        //收起并跳转到该栏目新闻
        if (button.isEdit) {
            [_bottomChooseView addButtonWith:button.titleLabel.text position:[_bottomChooseView convertPoint:button.frame.origin fromView:_topChooseView]];
            [_topChooseView removeButton:button];
        }
    }else {
        [_topChooseView addButtonWith:button.titleLabel.text position:[_topChooseView convertPoint:button.frame.origin fromView:_bottomChooseView]];
        [_bottomChooseView removeButton:button];
    }
    [self refreshView];
}

- (void)didSetEditable:(id)chooseView
{
    [self switchAction:_header.subviews[2]];
}
@end

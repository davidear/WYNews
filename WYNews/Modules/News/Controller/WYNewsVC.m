//
//  WYNewsVC.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/26.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNewsVC.h"
#import "WYTopicScrollView.h"
#import "WYNewsScrollView.h"
#import "WYNewsTableController.h"
@interface WYNewsVC () <UIScrollViewDelegate>

@end

@implementation WYNewsVC
{
    WYTopicScrollView *_topicScrollView;
    WYNewsScrollView *_newsScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    [self loadData];
    [self addChildVCs];
}
- (void)initSubviews
{
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 48, 44);
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    [button1 setImage:[UIImage imageNamed:@"top_navi_bell_normal"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage  imageNamed:@"top_navi_bell_highlight"] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(newsFor24Hours) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 48, 44);
    button2.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    [button2 setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    //    [button2 setImage:[UIImage  imageNamed:@"top_navi_bell_highlight"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(naviRightBarButtonAciton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    _topicScrollView = [[WYTopicScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopicScrollViewHeight)];
    _topicScrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_topicScrollView];
    
    _newsScrollView = [[WYNewsScrollView alloc] initWithFrame:CGRectMake(0, kTopicScrollViewHeight, kScreenWidth, kScreenHeight - kTopicScrollViewHeight - kDockHeight - 64)];
    _newsScrollView.backgroundColor = [UIColor yellowColor];
    
    _newsScrollView.delegate = self;
    [self.view addSubview:_newsScrollView];
}
- (void)loadData
{
    _topicScrollView.topicArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs" ofType:@"plist"]];
    _topicScrollView.offsetX = 0;
}
- (void)addChildVCs
{
    for (NSDictionary *dic in _topicScrollView.topicArray) {
        WYNewsTableController *NewsTC = [[WYNewsTableController alloc] initWithStyle:UITableViewStylePlain];
        NewsTC.url = [dic objectForKey:@"urlString"];
        [self addChildViewController:NewsTC];
    }
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
//        CGSize size = CGSizeMake(kScreenWidth, _newsScrollView.bounds.size.height);
        WYNewsTableController *newsTC = self.childViewControllers[i];
        newsTC.tableView.frame = (CGRect){CGPointMake(kScreenWidth * i, 0), _newsScrollView.bounds.size};
        [_newsScrollView addSubview:newsTC.tableView];
    }
    _newsScrollView.contentSize = CGSizeMake(kScreenWidth * _topicScrollView.topicArray.count, 0);
}

#pragma mark - button action
- (void)newsFor24Hours
{
    
}
- (void)naviRightBarButtonAciton
{
    
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _newsScrollView) {
//        [_topicScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x * _topicScrollView.contentSize.width / scrollView.contentSize.width, 0) animated:YES];
        _topicScrollView.offsetX = scrollView.contentOffset.x / scrollView.bounds.size.width;
    }
    
}
@end

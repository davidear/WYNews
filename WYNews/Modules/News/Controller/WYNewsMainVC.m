//
//  WYNewsVC.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/26.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNewsMainVC.h"
#import "WYNetwork.h"
#import "WYTopicHeader.h"
#import "WYTopicScrollView.h"
#import "WYNewsScrollView.h"
#import "WYNewsTableController.h"

#import "WYTopic.h"
@interface WYNewsMainVC () <UIScrollViewDelegate,TopicScrollViewDelegate>

@end

@implementation WYNewsMainVC
{
    WYTopicScrollView *_topicScrollView;
    WYNewsScrollView *_newsScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    [self loadData];
//    [self addChildVCs];
}
- (void)initSubviews
{
//    [self.navigationController setNavigationBarHidden:NO];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 48, 30);
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    [button1 setImage:[UIImage imageNamed:@"top_navi_bell_normal"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage  imageNamed:@"top_navi_bell_highlight"] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(newsFor24Hours) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 48, 30);
    button2.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    [button2 setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    //    [button2 setImage:[UIImage  imageNamed:@"top_navi_bell_highlight"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(naviRightBarButtonAciton) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    _newsScrollView = [[WYNewsScrollView alloc] initWithFrame:CGRectMake(0, kTopicHeaderHeight, kScreenWidth, kScreenHeight - kTopicHeaderHeight - kDockHeight - kNavigationBarHeight - kStatusBarHeight)];
    _newsScrollView.backgroundColor = [UIColor yellowColor];
    _newsScrollView.delegate = self;
    [self.view addSubview:_newsScrollView];
    
    WYTopicHeader *header = [[WYTopicHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopicHeaderHeight)];
    //    _header.backgroundColor = [UIColor blueColor];
//    header.delegate = self;
    _topicScrollView = header.topicScrollView;
    _topicScrollView.topicDelegate = self;
    [self.view addSubview:header];
}
- (void)loadData
{

}
//- (void)addChildVCs
//{
//    for (WYTopic *topic in _topicScrollView.topicArray) {
//        WYNewsTableController *NewsTC = [[WYNewsTableController alloc] initWithStyle:UITableViewStylePlain];
//        NewsTC.url = [NSString stringWithFormat:@"/nc/article/list/%@/0-20.html",topic.tid];
////         "tid":"T1370583240249"
////        /nc/article/list/T1348649654285/0-20.html
//        [self addChildViewController:NewsTC];
//    }
//    
//    for (int i = 0; i < self.childViewControllers.count; i++) {
////        CGSize size = CGSizeMake(kScreenWidth, _newsScrollView.bounds.size.height);
//        WYNewsTableController *newsTC = self.childViewControllers[i];
//        newsTC.tableView.frame = (CGRect){CGPointMake(kScreenWidth * i, 0), _newsScrollView.bounds.size};
//        [_newsScrollView addSubview:newsTC.tableView];
//    }
//    _newsScrollView.contentSize = CGSizeMake(kScreenWidth * _topicScrollView.topicArray.count, 0);
//}

- (void)refreshChildVCs
{
    //1. 筛选self.childViewControllers
    NSMutableArray *mutArray = [NSMutableArray array];
    for (WYTopic *topic in _topicScrollView.topicArray) {
        __block BOOL isContained = NO;
        [self.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            WYNewsTableController *newsTC = obj;
            if ([newsTC.tid isEqualToString:topic.tid]) {
                [mutArray addObject:newsTC];
                isContained = YES;
                *stop = YES;
            }
        }];
        if (!isContained) {
            WYNewsTableController *newsTC = [[WYNewsTableController alloc] initWithStyle:UITableViewStylePlain];
            newsTC.tid = topic.tid;
            [mutArray addObject:newsTC];
        }
    }
    
    //2. 将self.childViewControllers清空，并重新附上新数组
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (WYNewsTableController *newsTC in mutArray) {
        [self addChildViewController:newsTC];
    }

    
    //3. 刷新数组中VC对应的tableView的frame，加入到_newsScrollView
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
#pragma mark - TopicHeaderDelegate
- (void)topicScrollViewDidChanged:(NSArray *)selectedArray
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [self refreshChildVCs];
//    });
}

- (void)topicScrollViewDidSelectButton:(NSInteger)selectedButtonIndex
{
    [_newsScrollView setContentOffset:CGPointMake(_topicScrollView.offsetX * _newsScrollView.bounds.size.width, 0)
     ];
}
@end

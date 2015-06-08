//
//  WYTopicHeader.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//
//所有topick数据归于buttonChooseVC的两个数组
#import "WYTopicHeader.h"
#import "WYTopic.h"
#import "WYNetwork.h"
#define kButtonW         40
@implementation WYTopicHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self loadData];
    }
    return self;
}

- (void)initSubviews
{
//    self.clipsToBounds = NO;
    self.backgroundColor = kTopicHeaderBgColor;
    CGRect frame = self.frame;
    _topicScrollView = [[WYTopicScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - kButtonW, frame.size.height)];
    [self addSubview:_topicScrollView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_left_more"]];
    leftView.frame = (CGRect){CGPointZero, leftView.frame.size};
    [self addSubview:leftView];
    
    UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_right_more"]];
    rightView.frame = (CGRect){CGPointMake(frame.size.width - rightView.bounds.size.width - kButtonW, 0), rightView.frame.size};
    [self addSubview:rightView];
    
    UIButton *spreadButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - kButtonW, 0, kButtonW, frame.size.height)];
    spreadButton.imageView.transform = CGAffineTransformMakeScale(1, -1);
    spreadButton.backgroundColor = [UIColor clearColor];
    [spreadButton setImage:[UIImage imageNamed:@"channel_nav_arrow"] forState:UIControlStateNormal];
    [spreadButton addTarget:self action:@selector(spreadChooseView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:spreadButton];
    
    _buttonChooseVC = [[WYButtonChooseViewController alloc] init];
    _buttonChooseVC.topicDelegate = self;
}

- (void)loadData
{
    //网络获取topicList
    [[WYNetwork sharedWYNetwork] HttpGet:kWYNetworkTopicListURLStr parameter:nil success:^(id responseObject) {
        NSLog(@"responseObject is %@", responseObject);
        if (responseObject != nil) {
            //根据hasIcon加到不同的数组
            NSMutableArray *selectedMutArray = [NSMutableArray array];
            NSMutableArray *unselectedMutArray = [NSMutableArray array];
            NSArray *array = [responseObject objectForKey:@"tList"];
            for (NSDictionary *dic in array) {
                WYTopic *topic = [[WYTopic alloc] initWithDic:dic];
                if (selectedMutArray.count < 24) {
                    [selectedMutArray addObject:topic];
                }else {
                    [unselectedMutArray addObject:topic];
                }
            }
            _buttonChooseVC.selectedArray = selectedMutArray;
            _buttonChooseVC.unSelectedArray = unselectedMutArray;
            _topicScrollView.topicArray = _buttonChooseVC.selectedArray;
            [self.delegate topicArrayDidChanged:_buttonChooseVC.selectedArray];
        }
    } failure:^(NSError *error) {
        
    }];
    //相关赋值
}
- (void)spreadChooseView:(UIButton *)sender
{
//    //数组赋值
//    if (_buttonChooseVC.selectedArray == nil) {
//        _buttonChooseVC.selectedArray = [NSMutableArray arrayWithArray:_topicScrollView.topicArray];
//    }
//    if (_buttonChooseVC.unSelectedArray == nil) {
//        _buttonChooseVC.unSelectedArray = [NSMutableArray arrayWithArray:_topicScrollView.topicArray];
//    }
    
    //showInView
    [_buttonChooseVC showInView:sender.superview.superview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - WYTopicSelectionDelegate
- (void)topicArrayDidChange:(NSArray *)topicArray
{
    _topicScrollView.topicArray = _buttonChooseVC.selectedArray;
    [self.delegate topicArrayDidChanged:_buttonChooseVC.selectedArray];
}
@end

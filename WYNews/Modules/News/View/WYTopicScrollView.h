//
//  WYTopicScrollView.h
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYBaseScrollView.h"
#import "WYButtonChooseViewController.h"
@protocol TopicScrollViewDelegate <NSObject>
- (void)topicScrollViewDidChanged:(NSArray *)selectedArray;
- (void)topicScrollViewDidSelectButton:(NSInteger)selectedButtonIndex;
@end
@interface WYTopicScrollView : WYBaseScrollView <WYButtonChooseDelegate>
@property (weak, nonatomic) id<TopicScrollViewDelegate> topicDelegate;
@property (strong, nonatomic) WYButtonChooseViewController *buttonChooseVC;
@property (weak, nonatomic) NSArray *topicArray;
@property (assign, nonatomic) CGFloat offsetX;  //两个scrollView靠offsetX联系起来
@end

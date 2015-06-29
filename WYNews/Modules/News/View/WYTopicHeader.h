//
//  WYTopicHeader.h
//  WYNews
//
//  Created by dai.fengyi on 15/6/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYButtonChooseViewController.h"
#import "WYTopicScrollView.h"
//@protocol TopicHeaderDelegate <NSObject>
//- (void)topicScrollViewDidChanged:(NSArray *)selectedArray;
//@end
@interface WYTopicHeader : UIView 
//@property (weak, nonatomic) id<TopicHeaderDelegate> delegate;
//@property (strong, nonatomic) WYButtonChooseViewController *buttonChooseVC;
@property (strong, nonatomic) WYTopicScrollView *topicScrollView;
@end

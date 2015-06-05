//
//  WYTopicScrollView.h
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYBaseScrollView.h"

@interface WYTopicScrollView : WYBaseScrollView
@property (weak, nonatomic) NSArray *topicArray;
@property (assign, nonatomic) CGFloat offsetX;  //两个scrollView靠offsetX联系起来
@end

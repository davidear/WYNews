//
//  WYTopicScrollView.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYTopicScrollView.h"
#import "WYCategoryLabel.h"
#define kWidthMargin        0
@implementation WYTopicScrollView
{
    CGFloat _offsetX;
}
- (void)setupUI
{
    [super setupUI];
}

- (void)setTopicArray:(NSArray *)topicArray
{
    _topicArray = topicArray;
    for (int i = 0; i < _topicArray.count; i++) {
        WYCategoryLabel *label = [[WYCategoryLabel alloc] init];
        label.text = [_topicArray[i] objectForKey:@"title"];;
        if (self.subviews.count == 0) {
            label.frame = (CGRect){CGPointMake(kWidthMargin, 0), label.bounds.size};
        }else {
            label.frame = (CGRect){CGPointMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0), label.bounds.size};
        }
        [self addSubview:label];
    }
    
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0);
}

-(void)setOffsetX:(CGFloat)offsetX
{
    _offsetX = offsetX;
    float abc_offsetX = ABS(_offsetX);
    int index = (int)abc_offsetX;
    float delta = abc_offsetX - index;
    WYCategoryLabel *oldLabel = self.subviews[index];
    NSLog(@"old is %d , new is %d+1\n", index, index);
    oldLabel.scale = 1 - delta;
    //最后一个
    if (index < _topicArray.count - 1) {
        WYCategoryLabel *newLabel = self.subviews[index + 1];
        newLabel.scale = delta;
    }
}

- (CGFloat)offsetX
{
    return _offsetX;
}
@end
//
//  WYTopicScrollView.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYTopicScrollView.h"
#import "WYCategoryLabel.h"
#import "WYTopic.h"
#import "WYNetwork.h"
#define kWidthMargin        0
@implementation WYTopicScrollView
{
    CGFloat _offsetX;
}
- (void)setupUI
{
    [super setupUI];
    _buttonChooseVC = [[WYButtonChooseViewController alloc] init];
    _buttonChooseVC.topicDelegate = self;
    
    [self loadData];
}

- (void)setTopicArray:(NSArray *)topicArray
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _topicArray = topicArray;
    for (int i = 0; i < _topicArray.count; i++) {
        WYTopic *topic = _topicArray[i];
        
        WYCategoryLabel *label = [[WYCategoryLabel alloc] init];
        label.text = topic.tname;
        if (self.subviews.count == 0) {
            label.frame = (CGRect){CGPointMake(kWidthMargin, 0), label.bounds.size};
        }else {
            label.frame = (CGRect){CGPointMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0), label.bounds.size};
        }
        [self addSubview:label];
    }
    self.offsetX = 0;
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0);
    
}

-(void)setOffsetX:(CGFloat)offsetX
{
    _offsetX = offsetX;
    if (!_topicArray) {
        return;
    }
    float abc_offsetX = ABS(_offsetX);
    int index = (int)abc_offsetX;
    float delta = abc_offsetX - index;
    WYCategoryLabel *oldLabel = self.subviews[index];
    //    NSLog(@"old is %d , new is %d+1\n", index, index);
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


- (void)loadData
{
    //网络获取topicList
    [[WYNetwork sharedWYNetwork] HttpGet:kWYNetworkTopicListURLStr parameter:nil success:^(id responseObject) {
        //        NSLog(@"responseObject is %@", responseObject);
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
            self.topicArray = _buttonChooseVC.selectedArray;
            [self.topicDelegate topicArrayDidChanged:_buttonChooseVC.selectedArray];
        }
    } failure:^(NSError *error) {
        
    }];
    //相关赋值
}
#pragma mark - WYTopicSelectionDelegate
- (void)topicArrayDidChange:(NSArray *)topicArray
{
    self.topicArray = _buttonChooseVC.selectedArray;
    [self.topicDelegate topicArrayDidChanged:_buttonChooseVC.selectedArray];
}

- (void)chooseViewDidSelected:(NSString *)tname
{
    for (int i = 0; i < _topicArray.count; i++) {
        WYTopic *topic = _topicArray[i];
        if ([tname isEqualToString:topic.tname]) {
            _offsetX = i;
        }
    }
}
@end
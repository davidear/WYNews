//
//  WYTopicScrollView.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYTopicScrollView.h"
#import "WYCategoryButton.h"
#import "WYTopic.h"
#import "WYNetwork.h"
#define kWidthMargin        0
@interface WYTopicScrollView ()
@property (assign, nonatomic) NSInteger oldIndex;
@end
@implementation WYTopicScrollView
{
    CGFloat _offsetX;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self loadData];
        [self registerNotification];
    }
    return self;
}
#pragma mark - 初始化
- (void)setupUI
{
    [super setupUI];
    _buttonChooseVC = [[WYButtonChooseViewController alloc] init];
    _buttonChooseVC.topicDelegate = self;
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
            [self.topicDelegate topicScrollViewDidChanged:_buttonChooseVC.selectedArray];
        }
    } failure:^(NSError *error) {
        
    }];
    //相关赋值
}

- (void)registerNotification
{
    [self addObserver:self forKeyPath:@"oldIndex" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)setTopicArray:(NSArray *)topicArray
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _topicArray = topicArray;
    for (int i = 0; i < _topicArray.count; i++) {
        WYTopic *topic = _topicArray[i];
        
        WYCategoryButton *button = [[WYCategoryButton alloc] init];
//        button.text = topic.tname;
        [button setTitle:topic.tname forState:UIControlStateNormal];
        [button addTarget:self action:@selector(categoryButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        if (self.subviews.count == 0) {
            button.frame = (CGRect){CGPointMake(kWidthMargin, 0), button.bounds.size};
        }else {
            button.frame = (CGRect){CGPointMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0), button.bounds.size};
        }
        [self addSubview:button];
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
    WYCategoryButton *oldButton = self.subviews[index];
//    NSLog(@"old is %d , new is %d+1\n, index is %d", _oldIndex, _oldIndex + 1, index);
    oldButton.scale = 1 - delta;
    //最后一个
    if (index < _topicArray.count - 1) {
        WYCategoryButton *newbutton = self.subviews[index + 1];
        newbutton.scale = delta;
    }
    _oldIndex = index;
}

- (CGFloat)offsetX
{
    return _offsetX;
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}

#pragma mark - Button Action
- (void)categoryButtonSelected:(WYCategoryButton *)sender
{
    //可优化,实现新旧按钮的变化
    _offsetX = [self.subviews indexOfObject:sender];
    WYCategoryButton *oldButton = self.subviews[_oldIndex];
    oldButton.scale = 0;
    sender.scale = 0;
    _oldIndex = _offsetX;
    
    [self.topicDelegate topicScrollViewDidSelectButton:_offsetX];
}
#pragma mark - WYButtonChooseViewDelegate
- (void)topicArrayDidChange:(NSArray *)topicArray
{
    self.topicArray = _buttonChooseVC.selectedArray;
    [self.topicDelegate topicScrollViewDidChanged:_buttonChooseVC.selectedArray];
}

- (void)chooseViewDidSelected:(NSString *)tname
{
    for (int i = 0; i < _topicArray.count; i++) {
        WYTopic *topic = _topicArray[i];
        if ([tname isEqualToString:topic.tname]) {
            [self categoryButtonSelected:self.subviews[i]];
        }
    }
}
@end
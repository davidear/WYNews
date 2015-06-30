//
//  WYButtonChooseView.h
//  WYNews
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYLabelButton.h"
#define kMarginH            10
#define kCountOfARow        4
#define kMarginW            ([UIScreen mainScreen].bounds.size.width - 4 *kButtonW) / 5

#define kDuration       0.5f
@class WYButtonChooseView;
@protocol LabelChooseDelegate <NSObject>
- (void)didSelectedButton:(WYLabelButton *)button;
- (void)didSetEditable:(WYButtonChooseView *)chooseView;
@end
@interface WYButtonChooseView : UIScrollView
@property (weak, nonatomic) id<LabelChooseDelegate> chooseDelegate;
//@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (assign, nonatomic, getter = isEdit) BOOL edit;
@property (assign, nonatomic, getter=isDragable) BOOL dragable;


- (void)addButtonWith:(NSString *)title position:(CGPoint)originPoint;
- (void)removeButton:(UIButton *)button;


- (void)refreshView;//should be public ?


@end

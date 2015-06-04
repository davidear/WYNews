//
//  WYButtonChooseViewController.h
//  WYButtonChooseView
//
//  Created by dai.fengyi on 15/6/3.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYButtonChooseViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *selectedArray;//装字典
@property (strong, nonatomic) NSMutableArray *unSelectedArray;//装字典


- (void)showInView:(UIView *)view;
@end

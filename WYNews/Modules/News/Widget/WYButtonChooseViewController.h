//
//  WYButtonChooseViewController.h
//  WYButtonChooseView
//
//  Created by dai.fengyi on 15/6/3.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYButtonChooseViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *selectedArray;
@property (strong, nonatomic) NSMutableArray *unSelectedArray;


- (void)showInView:(UIView *)view;
@end

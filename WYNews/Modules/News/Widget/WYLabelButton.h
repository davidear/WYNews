//
//  WYLabelButton.h
//  WYNews
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kButtonW    70
#define kButtonH    30
@interface WYLabelButton : UIButton
@property (assign, nonatomic, getter = isEdit) BOOL edit;
@end

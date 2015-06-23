//
//  WYNewsDetailVC.h
//  WYNews
//
//  Created by dai.fengyi on 15/6/23.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYNews;
@interface WYNewsDetailVC : UIViewController
@property (copy, nonatomic) NSString *docid;
@property (weak, nonatomic) WYNews *news;
@end

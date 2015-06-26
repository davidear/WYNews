//
//  WYNavigationController.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/26.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNavigationController.h"

@interface WYNavigationController ()

@end

@implementation WYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    [self setNavigationBarHidden:NO];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
}
@end

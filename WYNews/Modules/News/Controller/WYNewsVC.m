//
//  WYNewsVC.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/26.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNewsVC.h"

@interface WYNewsVC ()

@end

@implementation WYNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:<#(NSString *)#>] style:UIBarButtonItemStylePlain target:<#(id)#> action:<#(SEL)#>
}
@end

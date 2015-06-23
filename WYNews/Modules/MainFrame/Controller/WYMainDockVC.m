//
//  WYMainDockVC.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/26.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYMainDockVC.h"
#import "WYNewsMainVC.h"
#import "WYReadVC.h"
#import "WYVedioVC.h"
#import "WYDiscoverVC.h"
#import "WYMeVC.h"
@interface WYMainDockVC ()

@end

@implementation WYMainDockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildVC];
    
    [_dock setBackgroundColor:[UIColor whiteColor]];
    [self addDockItems];
}

- (void)addChildVC
{
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:[[WYNewsMainVC alloc] init]]];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:[[WYReadVC alloc] init]]];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:[[WYVedioVC alloc] init]]];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:[[WYDiscoverVC alloc] init]]];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:[[WYMeVC alloc] init]]];
}
- (void)addDockItems
{
    [_dock addItemWithIcon:@"tabbar_icon_news_normal" selectedIcon:@"tabbar_icon_news_highlight" title:@"新闻"];
    [_dock addItemWithIcon:@"tabbar_icon_reader_normal" selectedIcon:@"tabbar_icon_reader_highlight" title:@"阅读"];
    [_dock addItemWithIcon:@"tabbar_icon_media_normal" selectedIcon:@"tabbar_icon_media_highlight" title:@"视听"];
    [_dock addItemWithIcon:@"tabbar_icon_found_normal" selectedIcon:@"tabbar_icon_found_highlight" title:@"发现"];
    [_dock addItemWithIcon:@"tabbar_icon_me_normal" selectedIcon:@"tabbar_icon_me_highlight" title:@"我"];
}
@end

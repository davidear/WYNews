//
//  WYTabbarController.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/26.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYTabbarController.h"
#import "WYNewsMainVC.h"
#import "WYReadVC.h"
#import "WYVedioVC.h"
#import "WYDiscoverVC.h"
#import "WYMeVC.h"
#import "Dock.h"
@interface WYTabbarController ()<DockDelegate>

@end

@implementation WYTabbarController
{
    Dock *_myDock;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

// self = [super init]; 这个方法会直接调用viewDidload，先于if(self) {}， 很奇怪
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    [self initChildVCs];
    [self initDock];
}

- (void)initChildVCs
{
    [self setViewControllers:@[[[WYNewsMainVC alloc] init],
                               [[WYReadVC alloc] init],
                               [[WYVedioVC alloc] init],
                               [[WYDiscoverVC alloc] init],
                               [[WYMeVC alloc] init]
                               ]];
}

- (void)initDock
{
    _myDock = [[Dock alloc] initWithFrame:self.tabBar.bounds];
    [self.view addSubview:_myDock];
    _myDock.delegate = self;
    [self.tabBar addSubview:_myDock];
    
    [_myDock addItemWithIcon:@"tabbar_icon_news_normal" selectedIcon:@"tabbar_icon_news_highlight" title:@"新闻"];
    [_myDock addItemWithIcon:@"tabbar_icon_reader_normal" selectedIcon:@"tabbar_icon_reader_highlight" title:@"阅读"];
    [_myDock addItemWithIcon:@"tabbar_icon_media_normal" selectedIcon:@"tabbar_icon_media_highlight" title:@"视听"];
    [_myDock addItemWithIcon:@"tabbar_icon_found_normal" selectedIcon:@"tabbar_icon_found_highlight" title:@"发现"];
    [_myDock addItemWithIcon:@"tabbar_icon_me_normal" selectedIcon:@"tabbar_icon_me_highlight" title:@"我"];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    self.selectedIndex = [self.tabBar.items indexOfObject:item];
}

- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to
{
    [self tabBar:self.tabBar didSelectItem:self.tabBar.items[to]];
}
@end

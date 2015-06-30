//
//  WYCommon.h
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#ifndef WYNews_WYCommon_h
#define WYNews_WYCommon_h

//全局
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kWYRed                      [UIColor colorWithRed:221.0/255 green:50.0/255 blue:55.0/255 alpha:1]

//dock
#define kDockBgColor                [UIColor colorWithRed:133.0/255 green:133.0/255 blue:133.0/255 alpha:1]
//Network
#define kWYNetworkBaseURLStr                @"http://c.m.163.com"
#define kWYNetworkTopicListURLStr           @"/nc/topicset/ios/subscribe/manage/listspecial.html"
#define kWYNetWorkNewsListBaseStr           @"/nc/article/list"
#define kWYNetWorkNewsListFetchOnceCount    20
#define kWYNetWorkNewsDetailURLStr          @"http://c.3g.163.com/nc/article/%@/full.html"//%@为WYNews的docid

//Dock
#define kDockHeight 49
//NavigationBar
#define kNavigationBarHeight    44
#define kStatusBarHeight        20


//WYNewsVC
#define kTopicHeaderHeight      36
#define kTopicHeaderBgColor         [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1]

//WYButtonChooseView
#define kButtonChooseViewSelectedTopicMaxCount  24
#endif

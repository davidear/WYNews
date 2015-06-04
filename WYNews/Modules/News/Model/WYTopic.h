//
//  WYTopic.h
//  WYNews
//
//  Created by dai.fengyi on 15/6/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYModel.h"
/*
 {
 "template":"manual",
 "topicid":"00040BGE",
 "hasCover":false,
 "alias":"The Truth",
 "subnum":"6.6万",
 "recommendOrder":0,
 "isNew":0,
 "img":"http://img2.cache.netease.com/m/newsapp/banner/zhenhua.png",
 "isHot":0,
 "hasIcon":true,
 "cid":"C1348654575297",
 "recommend":"0",
 "headLine":false,
 "color":"",
 "bannerOrder":105,
 "tname":"原创",
 "ename":"zhenhua",
 "showType":"comment",
 "special":0,
 "tid":"T1370583240249"
 }
 */
@interface WYTopic : WYModel
@property (copy, nonatomic) NSString *templateStr;
@property (copy, nonatomic) NSString *topicid;
@property (readonly, nonatomic) BOOL hasCover;
@property (copy, nonatomic) NSString *alias;
@property (copy, nonatomic) NSString *subnum;
@property (readonly, nonatomic) long long recommendOrder;
@property (readonly, nonatomic) BOOL isNew;
@property (copy, nonatomic) NSString *img;
@property (readonly, nonatomic) BOOL isHot;
@property (readonly, nonatomic) BOOL hasIcon;
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *recommend;
@property (readonly, nonatomic) BOOL headLine;
@property (copy, nonatomic) NSString *color;
@property (readonly, nonatomic) int bannerOrder;
@property (copy, nonatomic) NSString *tname;
@property (copy, nonatomic) NSString *ename;
@property (copy, nonatomic) NSString *showType;
@property (readonly, nonatomic) int special;
@property (copy, nonatomic) NSString *tid;

@end

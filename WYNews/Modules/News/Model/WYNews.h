//
//  WYNews.h
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 boardid = "mobile_bbs";
 digest = "\U91c7\U75284.3\U82f1\U5bf8WVGA\U5c4f\Uff0c\U642d\U53cc\U6838CPU\Uff0c\U5185\U7f6e512MB RAM\U3002";
 docid = AQK7C85I0011179O;
 imgsrc = "http://img2.cache.netease.com/3g/2015/5/27/2015052710301118f20.jpg";
 lmodify = "2015-05-27 10:25:01";
 priority = 73;
 ptime = "2015-05-27 10:25:01";
 replyCount = 78;
 source = "\U624b\U673a\U4e2d\U56fd";
 subtitle = "";
 title = "\U4e09\U661f\U5c06\U63a8Galaxy J1 Pop";
 url = "http://3g.163.com/mobile/15/0527/10/AQK7C85I0011179O.html";
 "url_3w" = "http://mobile.163.com/15/0527/10/AQK7C85I0011179O.html";
 votecount = 53;
 }

 */
@interface WYNews : NSObject
@property (readonly, nonatomic) NSString *boardid;
@property (readonly, nonatomic) NSString *digest;
@property (readonly, nonatomic) NSString *docid;
@property (readonly, nonatomic) NSString *imgsrc;
@property (readonly, nonatomic) NSString *lmodify;
@property (readonly, nonatomic) int priority;
@property (readonly, nonatomic) NSString *ptime;
@property (readonly, nonatomic) int replyCount;
@property (readonly, nonatomic) NSString *source;
@property (readonly, nonatomic) NSString *subtitle;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *url;
@property (readonly, nonatomic) NSString *url_3w;
@property (readonly, nonatomic) int votecount;
//in addition
@property (readonly, nonatomic) NSArray *imgextra;//有，表示3图，该数组有后两图，第一图在imagesrc
@property (readonly, nonatomic) NSInteger imgType;//值为1, 表示1张cell宽大图
- (id)initWithDic:(NSDictionary *)dic;
@end

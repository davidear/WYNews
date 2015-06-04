//
//  WYTopic.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYTopic.h"

@implementation WYTopic
/*
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
 */
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _templateStr = dic[@"template"];
        _topicid = dic[@"topicid"];
        _hasCover = [dic[@"hasCover"] boolValue];;
        _alias = dic[@"alias"];
        _subnum = dic[@"subnum"];
        _recommendOrder = [dic[@"recommendOrder"] longLongValue];
        _isNew = [dic[@"isNew"] boolValue];
        _img = dic[@"img"];
        _isHot = [dic[@"isHot"] boolValue];
        _hasIcon = [dic[@"hasIcon"] boolValue];
        _cid = dic[@"cid"];
        _recommend = dic[@"recommend"];
        _headLine = [dic[@"headLine"] boolValue];
        _color = dic[@"color"];
        _bannerOrder = [dic[@"bannerOrder"] intValue];
        _tname = dic[@"tname"];
        _ename = dic[@"ename"];
        _showType = dic[@"showType"];
        _special = [dic[@"special"] intValue];
        _tid = dic[@"tid"];
    }
    return self;
}
@end

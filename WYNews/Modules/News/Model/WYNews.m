//
//  WYNews.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNews.h"

@implementation WYNews
/*
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
 */
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _boardid = dic[@"boardid"];
        _digest = dic[@"digest"];
        _docid = dic[@"docid"];
        _imgsrc = dic[@"imgsrc"];
        _lmodify = dic[@"lmodify"];
        _priority = [dic[@"priority"] intValue];
        _ptime = dic[@"ptime"];
        _replyCount = [dic[@"replyCount"] intValue];
        _source = dic[@"source"];
        _subtitle = dic[@"subtitle"];
        _title = dic[@"title"];
        _url = dic[@"url"];
        _url_3w = dic[@"url_3w"];
        _votecount = [dic[@"votecount"] intValue];
        
        if ([dic objectForKey:@"imgextra"]) {
            _imgextra = dic[@"imgextra"];
        }
        if ([dic objectForKey:@"imgType"]) {
            _imgType = [dic[@"imgType"] integerValue];
        }
    }
    return self;
}
@end

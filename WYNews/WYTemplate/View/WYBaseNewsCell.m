//
//  WYBaseNewsCell.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYBaseNewsCell.h"

@implementation WYBaseNewsCell
+ (id)cell
{
    return nil;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNews:(WYNews *)news
{
    _news = news;
}
@end

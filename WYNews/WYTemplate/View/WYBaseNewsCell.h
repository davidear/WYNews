//
//  WYBaseNewsCell.h
//  WYNews
//
//  Created by dai.fengyi on 15/6/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "WYNews.h"
@interface WYBaseNewsCell : UITableViewCell
{
    __weak IBOutlet UILabel *_title;
    __weak IBOutlet UIButton *_votecount;
    __weak IBOutlet UIImageView *_singleImageView;
}
@property (strong, nonatomic) WYNews *news;
+ (id)cell;
@end

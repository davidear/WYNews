//
//  WYNewsCell.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYDefaultNewsCell.h"
#import "UIImage+WY.h"
@interface WYDefaultNewsCell()
{
    __weak IBOutlet UILabel *_digest;
}
@end
@implementation WYDefaultNewsCell
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
+ (id)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DefaultNews" owner:nil options:nil] lastObject];
}


- (void)setNews:(WYNews *)news
{
    [super setNews:news];
    [_singleImageView sd_setImageWithURL:[NSURL URLWithString:self.news.imgsrc] placeholderImage:[UIImage imageNamed:@"contentview_image_default"] options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    _title.text = self.news.title;
    _digest.text = self.news.digest;
    
    [_votecount setTitle:[NSString stringWithFormat:@"%d跟帖", self.news.votecount] forState:UIControlStateDisabled];
//    _votecount.bounds = [_votecount.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, _votecount.bounds.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : _votecount.titleLabel.font} context:nil];
}
@end

//
//  WYLabel.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYCategoryLabel.h"
#define kLabelSideMargin        15
#define kTopicLabelFont         14
@implementation WYCategoryLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:kTopicLabelFont];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kTopicLabelFont]}];
    size.height = kTopicScrollViewHeight;
    size.width += size.width + kLabelSideMargin;
    self.frame = (CGRect){self.bounds.origin, size};
}

//black rgb 000000
//#define kWYRed              [UIColor colorWithRed:221.0/255 green:50.0/255 blue:55.0/255 alpha:1]
//scale表示scrollView.contentOffset.x - label.bounds.origin.x与width的百分比
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    NSLog(@"scale is %f", _scale);
    self.textColor = [UIColor colorWithRed:scale * 221.0/255 green:scale * 50.0/255 blue:scale * 55/255 alpha:1];
    NSLog(@"\ncolor is %@", self.textColor);
//    self.layer.transform = CATransform3DMakeScale(1 + 0.3 * scale, 1 + 0.3 * scale, 1);
    self.transform = CGAffineTransformMakeScale(1 + 0.3 * scale, 1 + 0.3 * scale);

}
@end

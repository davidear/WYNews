//
//  WYLabelButton.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYLabelButton.h"

@implementation WYLabelButton
{
    UIImageView *_delete;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.layer.cornerRadius = 5;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.frame = (CGRect){self.frame.origin, CGSizeMake(kButtonW, kButtonH)};
    [self setBackgroundImage:[UIImage imageNamed:@"channel_grid_circle"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    _delete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"channel_edit_delete"]];
    _delete.bounds = CGRectMake(0, 0, 15, 15);
    _delete.center = CGPointMake(6, 6);
    _delete.hidden = YES;
    [self addSubview:_delete];
}
- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    if (_edit == YES) {
        _delete.hidden = NO;
    }else {
        _delete.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  WYButtonChooseView.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

//通过改变按钮的数组次序，然后重新铺排数组来完成效果
//1 增加一个占位button，在每次拖动按钮到其他button区域内时，修改button数组，删除旧placeholder，重新加入placeholder到指定位置，并refreshview
//2 1情况中，第一次时，placeholder为nil时，初始化placeholder，删除拖动按钮，加入placeholder至指定位置
//3 在松手时，两步：
//3.1 将拖动button替换placeholder
//3.2 恢复button的属性，alpha和scale

#import "WYButtonChooseView.h"
@implementation WYButtonChooseView
{
    WYLabelButton *_placeHolder;
}

- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)addButtonWith:(NSString *)title  position:(CGPoint)originPoint
{
    CGSize buttonSize = CGSizeMake(kButtonW,kButtonH);
    
    WYLabelButton *button = [[WYLabelButton alloc] initWithFrame:(CGRect){originPoint, buttonSize}];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (self.isDragable) {
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [button addGestureRecognizer:longGesture];
    }
    button.edit = NO;
    [self addSubview:button];
    [self.buttonArray addObject:button];
    
    [self refreshView];
}

- (void)removeButton:(UIButton *)button
{
    [self.buttonArray removeObject:button];
    [button removeFromSuperview];
    [self refreshView];
}

- (void)refreshView
{
//    self.backgroundColor = [UIColor blueColor];
    [UIView animateWithDuration:kDuration animations:^{
        
        for (int i  = 0; i < self.buttonArray.count; i++) {
            WYLabelButton *button = self.buttonArray[i];
            CGFloat buttonX = 0;
            CGFloat buttonY = 0;
            if (i == 0) {
                buttonX = kMarginW;
                buttonY = kMarginH;
            }else {
                WYLabelButton *foreButton = self.buttonArray[i - 1];
                buttonX = CGRectGetMaxX(foreButton.frame) + kMarginW;
                buttonY = foreButton.frame.origin.y;
                if (buttonX + button.bounds.size.width > [UIScreen mainScreen].bounds.size.width) {
                    buttonX = kMarginW;
                    buttonY = CGRectGetMaxY(foreButton.frame) + kMarginH;
                }
            }
            button.frame = (CGRect){CGPointMake(buttonX, buttonY), button.bounds.size};
            
            //根据最后一个button设置本self的frame和contentsize
            if (i == self.buttonArray.count - 1) {
                CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(button.frame) + kMarginH);
//                if (size.height > [UIScreen mainScreen].bounds.size.height * 0.6) {
//                    size.height = [UIScreen mainScreen].bounds.size.height * 0.4;
//                }
                
                //尺寸调整放到外面
//                self.frame = (CGRect){self.frame.origin, size};
//                self.contentSize = self.frame.size;
                
                self.contentSize = size;
            }
        }
        if (self.buttonArray.count == 0) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
            self.contentSize = CGSizeZero;
        }
    }];
}

- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    for (WYLabelButton *button in self.buttonArray) {
        button.edit = _edit;
    }
}

- (void)selectWithButton:(WYLabelButton *)button
{
    if ([self.chooseDelegate respondsToSelector:@selector(didSelectedButton:)]) {
        [self.chooseDelegate didSelectedButton:button];
    }
}
#pragma mark Gesture Action
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    WYLabelButton *button = (WYLabelButton *)sender.view;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.edit = YES;
            if ([self.chooseDelegate respondsToSelector:@selector(didSetEditable:)]) {
                [self.chooseDelegate didSetEditable:self];
            }

            
            if (_placeHolder == nil) {
                _placeHolder = [[WYLabelButton alloc] initWithFrame:button.frame];
                [self.buttonArray insertObject:_placeHolder atIndex:[self.buttonArray indexOfObject:button]];
                [self.buttonArray removeObject:button];
            }
            [UIView animateWithDuration:kDuration animations:^{
                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
                button.alpha = 0.7;
            }];
            

        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint newPoint = [sender locationInView:self];
            CGFloat Xdelta = newPoint.x - button.center.x;
            CGFloat Ydelta = newPoint.y - button.center.y;
//            NSLog(@"xdelta is %f, ydelta is %f", Xdelta, Ydelta);
            button.center = CGPointMake(button.center.x + Xdelta, button.center.y + Ydelta);
            //检测是否进入其他button区域
            NSInteger newIndex = [self indexOfButtonWithMovingButton:button];
            if (newIndex < 0) {
            
            }else {
                if (_placeHolder == nil) {
                    _placeHolder = [[WYLabelButton alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(kButtonW, kButtonH)}];
                    [self.buttonArray removeObject:button];
                }else {
                    [self.buttonArray removeObject:_placeHolder];
                }
                [self.buttonArray insertObject:_placeHolder atIndex:newIndex];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_placeHolder != nil) {
                [self.buttonArray replaceObjectAtIndex:[self.buttonArray indexOfObject:_placeHolder] withObject:button];
                _placeHolder = nil;
            }
            [UIView animateWithDuration:kDuration animations:^{
                button.transform = CGAffineTransformIdentity;
                button.alpha = 1;
            }];
        }
            break;
        default:
            break;
    }
    [self refreshView];
}

- (NSInteger)indexOfButtonWithMovingButton:(WYLabelButton *)movingButton
{
    for (NSInteger i = 0;i<self.buttonArray.count;i++)
    {
        WYLabelButton *button = self.buttonArray[i];
        if (button != movingButton)
        {
            if (CGRectContainsPoint(button.frame, movingButton.center))
            {
                return i;
            }
        }
    }
    return -1;
}

@end

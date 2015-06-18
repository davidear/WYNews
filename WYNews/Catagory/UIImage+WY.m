//
//  UIImage+WY.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/8.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "UIImage+WY.h"

@implementation UIImage (WY)
+(UIImage *)imageResizedWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize size = image.size;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(size.width * 0.5, size.height * 0.5, size.width * 0.5, size.height * 0.5)];
}
@end

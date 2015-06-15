//
//  WYTool.m
//  WYNews
//
//  Created by dai.fengyi on 4/28/15.
//  Copyright (c) 2015 childrenOurFuture. All rights reserved.
//

#import "WYTool.h"
#import "MBProgressHUD.h"
#define APP [UIApplication sharedApplication]
@implementation WYTool
#pragma mark - HUD
+ (MBProgressHUD *)Hud
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:APP.keyWindow];
    if (hud){
        [hud removeFromSuperview];
    }else{
        hud = [[MBProgressHUD alloc] initWithWindow:APP.keyWindow];
        hud.removeFromSuperViewOnHide = YES;
    }
    [APP.keyWindow addSubview:hud];
    return hud;
}

+ (void)showMsg:(NSString *)message
{
    MBProgressHUD *hud = [self Hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.labelFont = [UIFont systemFontOfSize:13];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

+ (void)showLoading
{
    [self showLoading:@"请稍候..."];
}

+ (void)showLoading:(NSString *)message
{
    MBProgressHUD *hud = [self Hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont = [UIFont systemFontOfSize:13];
    [hud show:YES];
}

+ (void)hideHUD
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:APP.keyWindow];
    [hud hide:YES];
}
#pragma mark - 
//检测手机号码是否合法
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    /**
     * 虚拟运营商 170
     */
    NSString * VO = @"^1(7[0-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestvo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VO];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestvo evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 
@end

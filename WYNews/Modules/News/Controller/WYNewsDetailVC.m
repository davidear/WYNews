//
//  WYNewsDetailVC.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/23.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNewsDetailVC.h"
#import "MGTemplateEngine.h"
#import "WYNewsDetail.h"
#import "WYNetwork.h"
#import "MJExtension.h"
#import "ICUTemplateMatcher.h"
#import "WYNews.h"
@interface WYNewsDetailVC ()<MGTemplateEngineDelegate>

@end

@implementation WYNewsDetailVC
{
    WYNewsDetail *_newsDetail;
    UIWebView *_webView;
    MGTemplateEngine *_engine;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initSubviews];
    [self initTemplateEngine];

}

- (void)loadData
{
    NSString *urlStr = [NSString stringWithFormat:kWYNetWorkNewsDetailURLStr, _docid];
    __block typeof(self) blockSelf = self;
    [[WYNetwork sharedWYNetwork] HttpGet:urlStr parameter:nil success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            _newsDetail = [WYNewsDetail objectWithKeyValues:[responseObject objectForKey:_docid]];
            [blockSelf makeTemplate];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)initSubviews
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth - 8 * 2, kScreenHeight)];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
}

- (void)initTemplateEngine
{
    _engine = [MGTemplateEngine templateEngine];
    _engine.delegate = self;
    [_engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:_engine]];
}

- (void)makeTemplate
{
//    [_engine setObject:_newsDetail.body forKey:@"body"];
//    [_engine setObject:@"content.css" forKey:@"_customcss"];
//    [_engine setObject:@YES forKey:@"_hasYouku"];
//    [_engine setObject:@"宋体" forKey:@"normalFont"];
//    [_engine setObject:@NO forKey:@"boldFont"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];
//    NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:@"boldFont", @"宋体", @"_isDuanZi", @NO, @"title", _newsDetail.title, @"digest", _news.digest,  @"ec", @NO, @"source_url", @NO, @"_up_down", @NO, nil];
//    NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:_newsDetail.title, @"title", nil];
    NSDictionary *variables = @{
                                @"title" : _newsDetail.title,
                                @"boldFont" : @NO,
                                @"normalFont" : @"宋体",
                                @"_hasYouku" : @NO,
                                @"_customcss" : @"content.css",
                                @"body" : _newsDetail.body,
                                @"digest" : _news.digest,
                                @"ec" : @NO,
                                @"source_url" : @NO,
                                @"_up_down" : @NO
                                };
    NSString *result = [_engine processTemplateInFileAtPath:path withVariables:variables];
    NSLog(@"\n\n\nresult is %@", result);
    
    [_webView loadHTMLString:result baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
}
@end

//
//  WYNewsTableController.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "WYNewsTableController.h"
#import "MJRefresh.h"
#import "WYNetwork.h"
#import "WYNews.h"
#import "WYDefaultNewsCell.h"
#import "WYImagesNewsCell.h"
#import "WYWideImageNewsCell.h"
#import "WYNewsDetailVC.h"
#import "WYtool.h"
@interface WYNewsTableController ()<UIScrollViewDelegate>

@end
//typedef enum {
//    DefaultNews,
//    ImagesNews,
//    Advertisement,
//} NewsStyle;
@implementation WYNewsTableController
{
    NSMutableArray *_dataArray;
    NSInteger _page;
    MJRefreshHeader *_header;
    MJRefreshFooter *_footer;
}
/*
 DefaultNews,
 ImagesNews,
 Advertisement,
 */
//static NSString *reuseDefaultNewsIdentifier = @"DefaultNews";
//static NSString *reuseImagesNewsIdentifier = @"ImagesNews";
//static NSString *reuseAdvertisementIdentifier = @"Advertisement";
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    self.tableView.preservesSuperviewLayoutMargins = NO;
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.delegate = self;
    _header = [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _footer = [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)setTid:(NSString *)tid
{
    _tid = tid;
}
#pragma mark - Refresh
- (void)loadMoreData
{
//    if (_footer.state == MJRefreshFooterStateIdle) {
        NSLog(@"loadmoreData");
        NSMutableString *url = [NSMutableString stringWithString:kWYNetWorkNewsListBaseStr];
        [url appendFormat:@"/%@/%ld-%d.html", _tid, kWYNetWorkNewsListFetchOnceCount * _page, kWYNetWorkNewsListFetchOnceCount];
        [[WYNetwork sharedWYNetwork] HttpGetNews:url success:^(id responseObject) {
//            NSLog(@"abc");
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                return;
            }
            if (![[responseObject allObjects] isKindOfClass:[NSArray class]]) {
                return;
            }
            for (NSDictionary *dic in [[responseObject allObjects] lastObject]) {
                WYNews *news = [[WYNews alloc] initWithDic:dic];
                [_dataArray addObject:news];
            }
            _page++;
            [_footer endRefreshing];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"\nerror is %@", [error localizedDescription]);
            [_footer endRefreshing];
        }];
//    }else [_footer endRefreshing];
}

- (void)loadNewData
{
//    if (_header.state == MJRefreshHeaderStateIdle) {
        NSMutableString *url = [NSMutableString stringWithString:kWYNetWorkNewsListBaseStr];
        [url appendFormat:@"/%@/%d-%d.html", _tid, 0, kWYNetWorkNewsListFetchOnceCount];
        [[WYNetwork sharedWYNetwork] HttpGetNews:url success:^(id responseObject) {
//            NSLog(@"abc");
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                return;
            }
            if (![[responseObject allObjects] isKindOfClass:[NSArray class]]) {
                return;
            }
            [_dataArray removeAllObjects];
            for (NSDictionary *dic in [[responseObject allObjects] lastObject]) {
                WYNews *news = [[WYNews alloc] initWithDic:dic];
                [_dataArray addObject:news];
            }
            _page = 1;
            [_header endRefreshing];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"\nerror is %@", [error localizedDescription]);
            [_header endRefreshing];
        }];
//    }else [_header endRefreshing];
}

#pragma mark - ScrollView Delegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //在最低部时，contentOffset.y = contentSize.height - scrollView.bounds.size.height
//    NSLog(@"did end dragging %f", scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height - 250) {
//        [self loadMoreData];
//    }
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    //在最低部时，contentOffset.y = contentSize.height - scrollView.bounds.size.height
//    NSLog(@"did end dragging %f", scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height - 250) {
//        [self loadMoreData];
//    }
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"\ndid scroll contentoffset.y %f, contentsize.height %f", scrollView.contentOffset.y, scrollView.contentSize.height);
//}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYNews *news = _dataArray[indexPath.row];
    if (news.imgextra) {
        return 118;
    }else if (news.imgType) {
        return 178;
    }
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _dataArray ?  _dataArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    WYNews *news = (WYNews *)_dataArray[indexPath.row];
    if (news.imgextra) {
        reuseIdentifier = @"ImagesNews";
    }else if (news.imgType) {
        reuseIdentifier = @"WideImageNews";
    }else {
        reuseIdentifier = @"DefaultNews";
    }
//    NSClassFromString([NSString stringWithFormat:@"WY%@Cell", reuseIdentifier]);
    WYBaseNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [NSClassFromString([NSString stringWithFormat:@"WY%@Cell", reuseIdentifier]) cell];
    }
    // Configure the cell...
    cell.news = news;
//    cell.textLabel.text = news.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WYNewsDetailVC *vc = [[WYNewsDetailVC alloc] init];
//    WYNews *news = _dataArray[indexPath.row];
//    vc.docid = news.docid;
//    vc.news = news;
//    [self.navigationController pushViewController:vc animated:YES];
    [WYTool showMsg:@"why I can't get in?"];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

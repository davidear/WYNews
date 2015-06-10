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
@interface WYNewsTableController ()

@end
//typedef enum {
//    DefaultNews,
//    ImagesNews,
//    Advertisement,
//} NewsStyle;
@implementation WYNewsTableController
{
    NSMutableArray *_dataArray;
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
}

- (void)setTid:(NSString *)tid
{
    _tid = tid;
    NSString *url = [NSString stringWithFormat:@"/nc/article/list/%@/0-20.html", tid];
    [[WYNetwork sharedWYNetwork] HttpGetNews:url success:^(id responseObject) {
        NSLog(@"abc");
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (![[responseObject allObjects] isKindOfClass:[NSArray class]]) {
            return;
        }
//            NSMutableArray *mutArr = [NSMutableArray array];
            for (NSDictionary *dic in [[responseObject allObjects] lastObject]) {
                WYNews *news = [[WYNews alloc] initWithDic:dic];
//                [mutArr addObject:news];
                [_dataArray addObject:news];
            }
            [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"\nerror is %@", [error localizedDescription]);
    }];
}
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

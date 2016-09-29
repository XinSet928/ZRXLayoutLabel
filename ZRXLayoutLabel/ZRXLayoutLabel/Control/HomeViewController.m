//
//  HomeViewController.m
//  ZRXLayoutLabel
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "HomeTabelView.h"
#import "WBLayout.h"
#import "WBModel.h"

#define access_token @"XXXXXXXXXXXXXXXXXXXXX"

@interface HomeViewController (){
    HomeTabelView *_tableView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInfo];
    
    _tableView = [[HomeTabelView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];



}

- (void)loadInfo{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramet = @{@"access_token":access_token};
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:paramet success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"statuses"];
        
        NSMutableArray * state = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            WBModel *model = [[WBModel alloc] initWithDictionary:dic error:nil];
            WBLayout *layout = [[WBLayout alloc] init];
            layout.model = model;
            [state addObject:layout];
        }
        _tableView.dataArr = state;
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


















@end

//
//  HomeTabelView.h
//  Weibo62
//
//  Created by phc on 16/8/24.
//  Copyright © 2016年 phc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTabelView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

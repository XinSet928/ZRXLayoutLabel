//
//  HomeTabelView.m
//  Weibo62
//
//  Created by phc on 16/8/24.
//  Copyright © 2016年 phc. All rights reserved.
//

#import "HomeTabelView.h"
#import "HomeTableViewCell.h"
static NSString *ident = @"cell_02";
@implementation HomeTabelView

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        
//        [self creactConfig];
//    }
//    return self;
//    
//}

-(instancetype)init{
    return [self initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self != nil) {
        
        [self creactConfig];
    }
    return self;
}

- (void)creactConfig{
    
    self.delegate =self;
    self.dataSource =self;
    
    [self registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:ident];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    
    cell.layout = _dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算
    WBLayout *layout = _dataArr[indexPath.row];
    
    return layout.cellHeight;
}
@end

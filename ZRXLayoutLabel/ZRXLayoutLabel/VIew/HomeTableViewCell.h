//
//  HomeTableViewCell.h
//  Weibo62
//
//  Created by phc on 16/8/24.
//  Copyright © 2016年 phc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBModel.h"
#import "WBLayout.h"
#import "ZRXLabel.h"
@interface HomeTableViewCell : UITableViewCell<ZRXLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tilmeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property(nonatomic,strong)WBLayout *layout;

@property (nonatomic ,strong)ZRXLabel *weiboTextLable;

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UIImageView *reweetBgImgView;
@property (nonatomic ,strong)ZRXLabel *reweetTextLabel;

@property(nonatomic,strong)UIImageView *reweetImgView;

@property(nonatomic,strong)NSMutableArray *imgViewArr;//图片数组

@property (nonatomic ,strong)NSMutableArray *reweetImgViewArr;//转发
@end

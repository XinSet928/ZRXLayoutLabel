//
//  WBLayout.h
//  ZRXWeCo
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBModel.h"
#import <UIKit/UIKit.h>

@interface WBLayout : NSObject

@property (nonatomic,strong)WBModel *model;
@property (nonatomic,assign)CGFloat cellHeight;//单元格高度
@property (nonatomic,assign)CGRect textFrame;//文字内容frame
@property (nonatomic,assign)CGRect imageFrame;//图片的frame
@property (nonatomic,assign)CGRect  retweedBgFrame;//转发背景frame
@property (nonatomic,assign)CGRect retweedTextFrame;//转发文字内容
@property (nonatomic,assign)CGRect retweedImageFrame;//转发图片
@property (nonatomic,strong)NSMutableArray *imageViewFrameArray;//创建这个数组用来存储图片的frame
@property (nonatomic,strong)NSMutableArray *retweedImageFrameArray;

@end

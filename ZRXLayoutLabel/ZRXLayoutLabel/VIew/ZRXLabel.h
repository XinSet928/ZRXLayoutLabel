//
//  ZRXLabel.h
//  ZRXLayoutLabel
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRXLabel;

//设置代理
@protocol ZRXLabelDelegate <NSObject>

@optional
//手指离开当前超链接文本响应
- (void)touchEndZRXLabel:(ZRXLabel *)zexLabel withContext:(NSString *)context;
//手指接触到当前超链接文本
- (void)touchBeginZRXLabel:(ZRXLabel *)zrxLabel withContext:(NSString *)context;

//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(ZRXLabel *)wxLabel;
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(ZRXLabel *)wxLabel;
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(ZRXLabel *)wxLabel;

//检索文本中图片的正则表达式的字符串(比如一些表情等)
- (NSString *)imagesOfRegexStringWithWXLabel:(ZRXLabel *)wxLabel;

@end

@interface ZRXLabel : UILabel

@property(nonatomic,assign)id<ZRXLabelDelegate> zrxLabelDelegate;//代理对象
@property(nonatomic,assign)CGFloat linespace;//行间距   default = 0.0f
@property(nonatomic,assign)CGFloat mutiHeight;//行高(倍数) default = 1.0f
@property(nonatomic,assign)CGFloat textHeight;


//计算文本内容的高度
+ (float)getTextHeight:(float)fontSize
                 width:(float)width
                  text:(NSString *)text
             linespace:(CGFloat)linespace;





@end

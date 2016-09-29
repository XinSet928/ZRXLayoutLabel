//
//  WBLayout.m
//  ZRXWeCo
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBLayout.h"
#import "ZRXLabel.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define Screenheight  [UIScreen mainScreen].bounds.size.height

#define TextFont [UIFont systemFontOfSize:15]
#define headSpace 60
#define footSpace 18
#define space 10
#define picSpace 5


@implementation WBLayout

-(void)setModel:(WBModel *)model{
    _model = model;
    
    [self setTextLabelFrame];

}

#pragma mark -各种控件的计算
-(void)setTextLabelFrame{
    
    CGFloat cellHeight = headSpace + footSpace;
  
    //-------------------设置正文
//    CGRect Mtextframe = [self sizeWithString:_model.text font:TextFont maxSize:CGSizeMake(ScreenWidth-2*space, 1000)];
    
    CGFloat textLabelW = ScreenWidth-2*space;
//    CGFloat textLabelH = Mtextframe.size.height ;
    
   CGFloat textHeight = [ZRXLabel getTextHeight:15 width:ScreenWidth-2*space text:_model.text  linespace:0];
  
    self.textFrame = CGRectMake(space, headSpace , textLabelW, textHeight+10);
    cellHeight += self.textFrame.size.height + space ;

    //-------------------设置九宫格图片
    CGFloat picSize = (ScreenWidth-2*space-2*picSpace)/3;
    if (_model.pic_urls) {
        for (int i=0; i<_model.pic_urls.count; i++) {
            CGFloat row = i/3;//行
            CGFloat culom = i%3;//列
            CGFloat imageY = CGRectGetMaxY(self.textFrame)+space;
            CGRect imageFra = CGRectMake(space + (picSize+picSpace)*culom, imageY + (picSize + picSpace)*row, picSize, picSize);
            [self.imageViewFrameArray replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:imageFra]];
        }
        //确定行数
        NSInteger line = (_model.pic_urls.count+2)/3;//0~3
        //                                       两个值取最大         取最小
        cellHeight += picSize*line + picSpace * MAX(0, line-1)+space*MIN(line, 1);
    }
    
    //-------------------转发微博
    if (_model.retweeted_status) {
        //--------转发转发背景
        CGFloat reweedBgX = CGRectGetMinX(self.textFrame);
        CGFloat reweedBgY = CGRectGetMaxY(self.textFrame);
        CGFloat reweedBgWidth = ScreenWidth-2*space;
        self.retweedBgFrame = CGRectMake(reweedBgX, reweedBgY, reweedBgWidth, 0);
        //--------转发文字
        CGFloat reweedTextX = CGRectGetMinX(self.retweedBgFrame) + space;
        CGFloat reweedTextY = CGRectGetMinY(self.retweedBgFrame) + space;
        CGFloat reweedTextWidth = CGRectGetWidth(self.retweedBgFrame)-2*space;
        //文字高度
        NSString *str = [NSString stringWithFormat:@"%@:%@",_model.retweeted_status.user.name,_model.retweeted_status.text];
        
//        CGRect textframe = [self sizeWithString:str font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(ScreenWidth-2*space, 1000)];

       CGFloat retweedHeight = [ZRXLabel getTextHeight:14 width:ScreenWidth-2*space text:str linespace:0];
        
        
        //文字的frame
        self.retweedTextFrame = CGRectMake(reweedTextX,reweedTextY, reweedTextWidth, retweedHeight);
        //背景的frame
        self.retweedBgFrame = CGRectMake(reweedBgX, reweedBgY, reweedBgWidth,self.retweedTextFrame.size.height+2*space);
        
        
        //--------转发图片九宫格
   //---------------------------------------------
        CGFloat reSpace = 10;
        CGFloat rePicSpace = 5;
        CGFloat repicSize = (self.retweedBgFrame.size.width-2*reSpace-2*rePicSpace)/3;
        if (_model.retweeted_status.pic_urls) {
            for (int i=0; i<_model.retweeted_status.pic_urls.count; i++) {
                CGFloat row = i/3;//行
                CGFloat culom = i%3;//列
                CGFloat imagex = CGRectGetMinX(self.retweedTextFrame);
                CGFloat imagey = CGRectGetMaxY(self.retweedTextFrame)+space;
                CGRect imageFra = CGRectMake(imagex + (repicSize+rePicSpace)*culom, imagey + (repicSize + rePicSpace)*row, repicSize, repicSize);
                [self.retweedImageFrameArray replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:imageFra]];
            }
            //确定行数
            NSInteger line = (_model.retweeted_status.pic_urls.count+2)/3;//0~3
            //                                       两个值取最大         取最小
            CGFloat reimageh= repicSize*line + rePicSpace * MAX(0, line-1)+reSpace*MIN(line, 1);
            //设置背景图的frame
            CGRect frame = self.retweedBgFrame;
            frame.size.height += reimageh;
            self.retweedBgFrame = frame;
            cellHeight += self.retweedBgFrame.size.height;

            }else{
                cellHeight += self.retweedBgFrame.size.height +reSpace;
            }
            
     //---------------------------------------------
    
    }
      self.cellHeight = cellHeight ;
}


#pragma mark -返回文字内容的frame
-(CGRect)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
//    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
//    return size;
    
    CGRect frame = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return frame;
}

#pragma mark -懒加载正文图片数组
-(NSMutableArray *)imageViewFrameArray
{
    
    if (_imageViewFrameArray == nil) {
        _imageViewFrameArray = [NSMutableArray array];
        for (int i=0; i<9; i++) {
            [_imageViewFrameArray addObject:[NSValue valueWithCGRect:CGRectZero]];
        }
    }
    
    return _imageViewFrameArray;
}

#pragma mark -懒加载转发图片数组
-(NSMutableArray *)retweedImageFrameArray{
    if (_retweedImageFrameArray == nil) {
        _retweedImageFrameArray = [NSMutableArray array];
        for (int i=0; i<9; i++) {
            [_retweedImageFrameArray addObject:[NSValue valueWithCGRect:CGRectZero]];
        }
    }
    return _retweedImageFrameArray;
}


@end

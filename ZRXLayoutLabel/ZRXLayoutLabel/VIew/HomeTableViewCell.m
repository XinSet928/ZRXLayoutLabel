//
//  HomeTableViewCell.m
//  Weibo62
//   @"@\\w+" @"http(s)?://([A-Za-z0-9._-]+(/)?)*" @"#\\w+#"
//  Created by phc on 16/8/24.
//  Copyright © 2016年 phc. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation HomeTableViewCell

-(void)awakeFromNib{

    _weiboTextLable =  [[ZRXLabel alloc] init];
    _weiboTextLable.numberOfLines = 0;
    _weiboTextLable.zrxLabelDelegate = self;
    _weiboTextLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_weiboTextLable];
}

- (void)setLayout:(WBLayout *)layout{
    _layout = layout;
     [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_userImg sd_setImageWithURL:[NSURL URLWithString:_layout.model.user.profile_image_url]];
    _userName.text = _layout.model.user.name;
    [self creactTime];
    _sourceLabel.text = [self changeSource:_layout.model.source]
    ;
    //微博正文
    self.weiboTextLable.text = _layout.model.text;
    self.weiboTextLable.frame = _layout.textFrame;
    /*
    //带有图片
    self.imgView.frame = _layout.imgViewFrame;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_layout.model.thumbnail_pic]];
     */
    for (int i = 0; i<self.imgViewArr.count; i++) {
        //frame
        UIImageView *imgView = self.imgViewArr[i];
        
        imgView.frame = [_layout.imageViewFrameArray[i] CGRectValue];
    }
    for (int i = 0; i<_layout.model.pic_urls.count; i++) {
        //图片
        UIImageView *imgView = self.imgViewArr[i];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:_layout.model.pic_urls[i][@"thumbnail_pic"]]];
    }
     //转发背景
    self.reweetBgImgView.frame = _layout.retweedBgFrame;
//    self.reweetBgImgView.image = [UIImage imageNamed:@"timeline_rt_border_9.png"];
    self.reweetBgImgView.backgroundColor = [UIColor colorWithRed:1.000 green:0.918 blue:0.950 alpha:1.000];
    //转发微博
    self.reweetTextLabel.frame = _layout.retweedTextFrame;
    NSString *str = [NSString stringWithFormat:@"@%@:%@",_layout.model.retweeted_status.user.name,_layout.model.retweeted_status.text];
    self.reweetTextLabel.text = str;;
    
    //转发图片
//    self.reweetImgView.frame = _layout.reweetImgFrame;
//    [self.reweetImgView sd_setImageWithURL:[NSURL URLWithString:_layout.model.retweeted_status.thumbnail_pic]];
    for (int i = 0; i< self.reweetImgViewArr.count; i++) {
        
        UIImageView *imgView = self.reweetImgViewArr[i];
        imgView.frame = [self.layout.retweedImageFrameArray[i] CGRectValue];
    }
    for (int i = 0; i< self.layout.model.retweeted_status.pic_urls.count; i++){
        
        UIImageView *imgView =  self.reweetImgViewArr[i];
        
        NSString *str= self.layout.model.retweeted_status.pic_urls[i][@"thumbnail_pic"];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:str]];
        
    }
    
}
#pragma mark - 懒加载
- (NSMutableArray *)reweetImgViewArr{
    if (_reweetImgViewArr == nil) {
        _reweetImgViewArr = [NSMutableArray array];
        
        for (int i = 0; i <9; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:imgView];
            [_reweetImgViewArr addObject:imgView];
        }
    }
    
    return _reweetImgViewArr;
    
    
}
- (NSMutableArray *)imgViewArr{
    if (_imgViewArr == nil) {
        _imgViewArr = [NSMutableArray array];
        
        for (int i = 0; i<9; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            [self.contentView addSubview:imgView];
            [_imgViewArr addObject:imgView];
        }
    }
    return _imgViewArr;
    
}


- (UIImageView *)reweetImgView{
    if (_reweetImgView == nil) {
        _reweetImgView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_reweetImgView];
    }
    return _reweetImgView;
}
- (UIImageView *)reweetBgImgView{
    if (_reweetBgImgView == nil) {
        _reweetBgImgView=[[UIImageView alloc] init];
        
        [self.contentView addSubview:_reweetBgImgView];
    }
    return _reweetBgImgView;
}
- (UILabel *)reweetTextLabel{
    if (_reweetTextLabel == nil) {
        _reweetTextLabel=[[ZRXLabel alloc] init];
        _reweetTextLabel.zrxLabelDelegate = self;
        _reweetTextLabel.numberOfLines = 0;
        _reweetTextLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_reweetTextLabel];
    }
    return _reweetTextLabel;
}
- (UIImageView *)imgView{
    
    if (_imgView== nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
    
}

//改变来源
- (NSString *)changeSource:(NSString *)str{
    //"<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
   NSUInteger start = [str rangeOfString:@">"].location;
   NSUInteger end =  [str rangeOfString:@"<" options:NSBackwardsSearch].location;
    
    //容错处理
    if(start != NSNotFound && end != NSNotFound){
       return  [str substringWithRange:NSMakeRange(start+1, end-start-1)];
    }else{
        return str;
    }
}
//改变时间
- (void)creactTime{
     //Tue May 31 17:46:55 +0800 2011
    //日期格式化
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式
    formatter.dateFormat = @"E MMM dd HH:mm:ss Z yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSDate *date = [formatter dateFromString:_layout.model.created_at];
    //设置格式
    formatter.dateFormat = @"MM-dd HH:mm";

    NSString *timeStr = [formatter stringFromDate:date];
    
     _tilmeLabel.text = timeStr;
    //获取当前手机的语言标识
//    [[NSLocale currentLocale] localeIdentifier];
    
}

#pragma mark - WxLabelDelegate
//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(ZRXLabel *)wxLabel;{
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    return [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
}
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(ZRXLabel *)wxLabel{

    return [UIColor blueColor];
}
//手指离开当前超链接文本响应的协议方法
- (void)toucheEndWXLabel:(ZRXLabel *)wxLabel withContext:(NSString *)context;{
    
    NSLog(@"%@",context);
}
//检索文本中图片的正则表达式的字符串
- (NSString *)imagesOfRegexStringWithWXLabel:(ZRXLabel *)wxLabel;{
    
    return @"\\[\\w+\\]";
}
@end

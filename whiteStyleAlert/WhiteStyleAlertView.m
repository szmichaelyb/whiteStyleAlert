//
//  whiteStyleAlertView.m
//  whiteStyleAlert
//
//  Created by wordoor－z on 15/12/11.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import "WhiteStyleAlertView.h"
@implementation WhiteStyleAlertView
{
    UIView * backView;
    BOOL _isCreate;
}
-(instancetype)initWithFrame:(CGRect)frame andHeadStr:(NSString *)headStr andTitle:(NSString *)title
{
    if (self == [super initWithFrame:frame])
    {
        self.alpha = 0;
        UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * ve = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        ve.frame = self.frame;
        [self addSubview:ve];
        
        _duration = 0.3;
        _isCreate = NO;
    
        CGFloat space = 5;
        CGFloat headHeight = [self boundingRectWithTitle:headStr andFont:[UIFont boldSystemFontOfSize:20]] + 2*space;
        CGFloat labelHeight = [self boundingRectWithTitle:title andFont:[UIFont systemFontOfSize:15]] + 2*space;
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(50, (self.frame.size.height - labelHeight - headHeight)/2.0, self.frame.size.width - 100, labelHeight + headHeight + space)];
        backView.clipsToBounds = YES;
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(2 * space, 0, backView.frame.size.width - 4*space, headHeight)];
        headLabel.text = headStr;
        headLabel.font = [UIFont boldSystemFontOfSize:20];
        headLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:headLabel];

        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(2 *space,  headHeight, backView.frame.size.width - 4*space, labelHeight)];
        label.text = title;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:label];
        
        backView.alpha = 0;
    }
    return self;
}
-(void)addSureBtn:(NSString *)sureStr andSureBlock:(void(^)())sureBlock andCancelBtn:(NSString *)cancelStr andCancelBlock:(void(^)())cancelBlock
{
    if (_isCreate == NO)
    {
        _sureBlock = sureBlock;
        _cancelBlock = cancelBlock;
        
        CGFloat btnHeight = 40;
        CGRect backViewRect = backView.frame;
        backViewRect.origin.y -= (btnHeight + 10);
        backViewRect.size.height += (btnHeight + 10);
        backView.frame = backViewRect;
        if (sureStr != nil && cancelStr !=nil)
        {
            UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [sureBtn setTitle:sureStr forState:UIControlStateNormal];
            sureBtn.frame = CGRectMake(10, backView.frame.size.height - btnHeight - 5, (backView.frame.size.width - 20 - 5)/2.0, btnHeight);
            sureBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
            [sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:sureBtn];
            
            UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
            cancelBtn.frame = CGRectMake(10 + 5 + sureBtn.frame.size.width, backView.frame.size.height - btnHeight - 5, (backView.frame.size.width - 20 - 5)/2.0, btnHeight);
            cancelBtn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6];
            [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:cancelBtn];
        }
        else if(sureStr == nil && cancelStr !=nil)
        {
            UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
            cancelBtn.frame = CGRectMake(10 , backView.frame.size.height - btnHeight - 5, backView.frame.size.width - 20 , btnHeight);
            cancelBtn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6];
            [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:cancelBtn];

        }
        else if(sureStr != nil && cancelStr ==nil)
        {
            UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [sureBtn setTitle:sureStr forState:UIControlStateNormal];
            sureBtn.frame = CGRectMake(10, backView.frame.size.height - btnHeight - 5, backView.frame.size.width - 20, btnHeight);
            sureBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            [sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:sureBtn];
        }
        else
        {
            
        }
        _isCreate = YES;
    }
}
-(void)addSureBtn:(NSString *)sureStr andSureBlock:(void(^)())sureBlock
{
    [self addSureBtn:sureStr andSureBlock:sureBlock andCancelBtn:nil andCancelBlock:nil];
}
-(void)addCancelBtn:(NSString *)cancelStr andCancelBlock:(void(^)())cancelBlock
{
    [self addSureBtn:nil andSureBlock:nil andCancelBtn:cancelStr andCancelBlock:cancelBlock];
}
-(void)sureClick:(UIButton *)sender
{
    if (_sureBlock)
    {
        _sureBlock();
    }
}
-(void)cancelClick:(UIButton *)sender
{
    if ( _cancelBlock)
    {
         _cancelBlock();
    }
}
-(void)show
{
    [UIView animateWithDuration:_duration animations:^{
        backView.alpha = 1;
        self.alpha = 1;
    }];
}
-(void)hide
{
    [UIView animateWithDuration:_duration animations:^{
         backView.alpha = 0;
         self.alpha = 0;
    }];
}
- (CGFloat)boundingRectWithTitle:(NSString *)title andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGFloat labelHeight = [title boundingRectWithSize:CGSizeMake(self.frame.size.width - 100, MAXFLOAT)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size.height;
    
    return labelHeight;
}
@end

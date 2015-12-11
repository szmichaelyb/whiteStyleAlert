//
//  whiteStyleAlertView.h
//  whiteStyleAlert
//
//  Created by wordoor－z on 15/12/11.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhiteStyleAlertView : UIView

-(instancetype)initWithFrame:(CGRect)frame andHeadStr:(NSString *)headStr andTitle:(NSString *)title;
//消失和出现的时间 默认0.3
@property(nonatomic,assign) CGFloat duration;
@property(nonatomic,copy)void (^sureBlock)();
@property(nonatomic,copy)void (^cancelBlock)();
//创建按钮的方法只会执行一次
//创建确定按钮和取消按钮
-(void)addSureBtn:(NSString *)sureStr andSureBlock:(void(^)())sureBlock andCancelBtn:(NSString *)CancelStr andCancelBlock:(void(^)())cancelBlock;
//创建确定按钮
-(void)addSureBtn:(NSString *)sureStr andSureBlock:(void(^)())sureBlock;
//创建取消按钮
-(void)addCancelBtn:(NSString *)cancelStr andCancelBlock:(void(^)())cancelBlock;

//出现
-(void)show;
//隐藏
-(void)hide;
@end

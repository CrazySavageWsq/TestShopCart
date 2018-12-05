//
//  PPNumberButton.h
//  PPNumberButton
//
//  Created by AndyPang on 16/8/31.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPNumberButton;
@protocol PPNumberButtonDelegate <NSObject>
@optional

/**
 加减代理回调
 
 @param numberButton 按钮
 @param number 结果
 @param increaseStatus 是否为加状态
 */
- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus;

@end


IB_DESIGNABLE
@interface PPNumberButton : UIView

- (instancetype)initWithFrame:(CGRect)frame;
+ (instancetype)numberButtonWithFrame:(CGRect)frame;

/** 加减按钮的Block回调*/
@property (nonatomic, copy) void(^resultBlock)(PPNumberButton *ppBtn,CGFloat number, BOOL increaseStatus/* 是否为加状态*/);
/** 代理*/
@property (nonatomic, weak) id<PPNumberButtonDelegate> delegate;

#pragma mark - 自定义样式属性设置
/** 是否开启抖动动画, default is NO*/
@property (nonatomic, assign ) IBInspectable BOOL shakeAnimation;
/** 为YES时,初始化时减号按钮隐藏(饿了么/百度外卖/美团外卖按钮模式),default is NO*/
@property (nonatomic, assign ) IBInspectable BOOL decreaseHide;
/** 是否可以使用键盘输入,default is YES*/
@property (nonatomic, assign, getter=isEditing) IBInspectable BOOL editing;

/** 设置边框的颜色,如果没有设置颜色,就没有边框 */
@property (nonatomic, strong ) IBInspectable UIColor *borderColor;

/** 输入框中的内容 */
@property (nonatomic, assign ) CGFloat currentNumber;
/** 递增步长，默认步长为1 */
@property (nonatomic, assign ) CGFloat stepValue;

/** 输入框中的字体大小 */
@property (nonatomic, assign ) IBInspectable CGFloat inputFieldFont;

/** 长按加减的时间间隔,默认0.1s,设置为 CGFLOAT_MAX 则关闭长按加减功能*/
@property (nonatomic, assign ) IBInspectable CGFloat longPressSpaceTime;

/** 加减按钮的字体大小 */
@property (nonatomic, assign ) IBInspectable CGFloat buttonTitleFont;
/** 加按钮背景图片 */
@property (nonatomic, strong ) IBInspectable UIImage *increaseImage;
/** 减按钮背景图片 */
@property (nonatomic, strong ) IBInspectable UIImage *decreaseImage;
/** 加按钮标题 */
@property (nonatomic, copy   ) IBInspectable NSString *increaseTitle;
/** 减按钮标题 */
@property (nonatomic, copy   ) IBInspectable NSString *decreaseTitle;

/** 最小值, default is 0 */
@property (nonatomic, assign ) IBInspectable CGFloat minValue;
/** 最大值 */
@property (nonatomic, assign ) CGFloat maxValue;
/** 目前支持一位小数的递增 */
@property (nonatomic, assign ) BOOL decimalNum;

@end

#pragma mark - NSString分类
@interface NSString (PPNumberButton)
/**
 字符串 nil, @"", @"  ", @"\n" Returns NO;
 其他 Returns YES.
 */
- (BOOL)pp_isNotBlank;
@end


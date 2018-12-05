//
//  WBottomView.h
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBottomViewDelegate <NSObject>


/**
 WBottomViewDelegate 代理回调事件

 @param index 0 全选 1 去支付
 @param state 按钮的状态（index为0时,Yes为全选；index为1时,Yes为删除）
 */
@optional
- (void)clikWhichButton:(NSInteger )index andBtnSatade:(BOOL)state;

@end


@interface WBottomView : UIView

/* 全选按钮 */
@property(nonatomic, strong) UIButton *chooseAllBtn;
/* 选中产品的金额 */
@property(nonatomic, strong) UILabel *chooseMoneyL;
/* 结算按钮 */
@property(nonatomic, strong) UIButton *payBtn;
/* 整个列表是否处于编辑状态 */
@property(nonatomic, assign)BOOL isEdit;
/* 代理属性 */
@property(nonatomic, weak) id<WBottomViewDelegate>delegate;


@end

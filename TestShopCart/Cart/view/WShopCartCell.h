//
//  WShopCartCell.h
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WShopCartModel.h"

typedef void(^chooseBtnBlock)(BOOL state);
typedef void(^deleteBtnBlock)(void);

@interface WShopCartCell : UITableViewCell

#pragma mark ---- 正常状态下的
/* 商品的图片 */
@property(nonatomic, strong) UIImageView *goodsImage;
/* 商品的标题 */
@property(nonatomic, copy) UILabel *goodsTitleL;
/* 商品的价格 */
@property(nonatomic, copy) UILabel *goodsPriceL;
/* 商品的销量 */
@property(nonatomic, copy) UILabel *goodsSalesL;
/* 商品的库存 */
@property(nonatomic, copy) UILabel *goodsInventoryL;
/* 商品的数量 */
@property(nonatomic, copy) UILabel *goodsNumber;
/* 选中的按钮 */
@property(nonatomic, copy) UIButton *chooseBtn;

@property(nonatomic, copy) chooseBtnBlock btnBlock;



#pragma mark ----  编辑状态下的
/* 遮盖住正常状态下的view */
@property(nonatomic, strong) UIView *coverView;
/* 加减的view */
@property(nonatomic, strong) UIView *addAndDownView;
/* 删除的按钮 */
@property(nonatomic, copy) UIButton *deleBtn;

@property(nonatomic, copy) deleteBtnBlock deleBlock;



/**
 赋值

 @param model 商品详情的模型
 */
-(void)setUIValue:(WShopGoodsDetailModel *)model;


@end

//
//  WShopCartSectionHeadView.h
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/5.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WShopCartModel.h"
typedef void(^isEdiotBtnBlock)(BOOL state);
typedef void(^choosShopBtnBlock)(BOOL state);
@interface WShopCartSectionHeadView : UITableViewHeaderFooterView

/* 全选本店的按钮 */
@property(nonatomic, copy) UIButton *choosShopBtn;
/* 商店的图片 */
@property(nonatomic, strong) UIImageView *goodsImage;
/* 商店的名 */
@property(nonatomic, copy) UILabel *goodsTitleL;
/* 编辑的按钮 */
@property(nonatomic, copy) UIButton *isEdiotBtn;

@property(nonatomic, copy) isEdiotBtnBlock btnBlock;
@property(nonatomic, copy) choosShopBtnBlock choosebBlock;

-(void)setSelfUIVule:(WShopCartModel *)model;

@end

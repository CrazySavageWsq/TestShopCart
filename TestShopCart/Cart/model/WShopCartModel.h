//
//  WShopCartModel.h
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WShopGoodsDetailModel;

#pragma mark ---- 购物车的模型
@interface WShopCartModel : NSObject

/* 商店名 */
@property(nonatomic, copy) NSString *shopName;
/* 商店id */
@property(nonatomic, copy) NSString *shopId;
/* 商店是否收藏 */
@property(nonatomic, copy) NSString *isColletion;
/* 商品信息 */
@property(nonatomic, strong) NSArray< WShopGoodsDetailModel *> *shopData;
/* 商店是否处于选中状态 */
@property(nonatomic, assign) BOOL isChoose;
/* 商店是否处于编辑状态 */
@property(nonatomic, assign) BOOL isEdit;

@end



#pragma mark ----  商品详情模型
@interface WShopGoodsDetailModel : NSObject

/* 商品名 */
@property(nonatomic, copy) NSString *goodsTitle;
/* 商品价格 */
@property(nonatomic, copy) NSString *goodsPrice;
/* 商品数量 */
@property(nonatomic, copy) NSString *goodsNumber;
/* 商品销量 */
@property(nonatomic, copy) NSString *goodsSales;
/* 商品库存 */
@property(nonatomic, copy) NSString *goodsInventory;
/* 商品是否选中 */
@property(nonatomic, assign) BOOL chooseState;
/* 商店是否处于编辑状态 */
@property(nonatomic, assign) BOOL isEdit;



@end

//
//  WShopCartModel.m
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import "WShopCartModel.h"

@implementation WShopCartModel

//+ (NSDictionary *)objectClassInArray{ //mj的
//    return @{@"shopData" : [WShopGoodsDetailModel class]};
//}


-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];

    if ([key isEqualToString:@"shopData"]) {
        NSMutableArray *tempArray = [NSMutableArray array];
        if ([value isKindOfClass:[NSArray class]]) {
            
            if ([(NSArray *)value count] >0 ) {
                for (NSDictionary *dicss in (NSArray *)value) {
                    
                    WShopGoodsDetailModel *model = [[WShopGoodsDetailModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dicss];
                    [tempArray addObject:model];
                }
                
                self.shopData = tempArray;
            }else{
                self.shopData = [NSArray array];

            }
            
        }else{
            self.shopData = [NSArray array];

        }
        
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forKey:key];;

    
}
-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end


@implementation WShopGoodsDetailModel


-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end

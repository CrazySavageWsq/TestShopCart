//
//  WShopCartSectionHeadView.m
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/5.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import "WShopCartSectionHeadView.h"

@implementation WShopCartSectionHeadView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0  blue:235/255.0  alpha:0.2];

        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    
    /** 点击编辑 */
    _isEdiotBtn = [[UIButton alloc]init];
    _isEdiotBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_isEdiotBtn];
    [_isEdiotBtn setTitle:@"编辑"  forState:UIControlStateNormal];
    [_isEdiotBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_isEdiotBtn setTitle:@"完成"  forState:UIControlStateSelected];
    [_isEdiotBtn addTarget:self action:@selector(chooseBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [_isEdiotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(NEW_WIDTH(40));
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    
    /** 点击本店全选 */
    _choosShopBtn = [[UIButton alloc]init];
    [self.contentView addSubview:_choosShopBtn];
    [_choosShopBtn setImage:[UIImage imageNamed:@"icon_orderpay_normal"] forState:UIControlStateNormal];
    [_choosShopBtn setImage:[UIImage imageNamed:@"icon_orderpay_selected"] forState:UIControlStateSelected];
    [_choosShopBtn addTarget:self action:@selector(chooseShopBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [_choosShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(NEW_WIDTH(40));
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    
    
    /** 图片 */
    _goodsImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_goodsImage];
    _goodsImage.image = [UIImage  imageNamed:@"goods1"];
    _goodsImage.contentMode = UIViewContentModeScaleAspectFill;
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.choosShopBtn.mas_right).offset(8);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.contentView.mas_centerY).offset(5);
    }];
    
    /** 标题内容 */
    _goodsTitleL = [[UILabel alloc] init];
    _goodsTitleL.numberOfLines = 2;
    _goodsTitleL.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_goodsTitleL];
    [_goodsTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.right.equalTo(self.isEdiotBtn.mas_left).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}


/** 按钮点击事件 */
- (void)chooseBtnClik:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (self.btnBlock) {
        self.btnBlock(btn.selected);
    }
    
}

/** 全选本店按钮点击事件 */
- (void)chooseShopBtnClik:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (self.choosebBlock) {
        self.choosebBlock(btn.selected);
    }
    
    
}


//赋值
- (void)setSelfUIVule:(WShopCartModel *)model{
    
    _goodsImage.image = [UIImage imageNamed:@"goods5"];
    _goodsTitleL.text = model.shopName;
    _isEdiotBtn.selected = model.isEdit;
    _choosShopBtn.selected = model.isChoose;
    
}

@end

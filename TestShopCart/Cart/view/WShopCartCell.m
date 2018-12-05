//
//  WShopCartCell.m
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import "WShopCartCell.h"
#import "PPNumberButton.h"

@interface WShopCartCell()<PPNumberButtonDelegate>

@end

@implementation WShopCartCell
{
    PPNumberButton * AddNumBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}

//创建UI
- (void)createView{
    
    /** 点击的选中按钮 */
    _chooseBtn = [[UIButton alloc]init];
    [self.contentView addSubview:_chooseBtn];
    [_chooseBtn setImage:[UIImage imageNamed:@"icon_orderpay_normal"] forState:UIControlStateNormal];
    [_chooseBtn setImage:[UIImage imageNamed:@"icon_orderpay_selected"] forState:UIControlStateSelected];
    [_chooseBtn addTarget:self action:@selector(chooseBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.size.mas_equalTo(CGSizeMake(NEW_WIDTH(40), NEW_HEIGHT(40)));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
     /** 图片 */
    _goodsImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_goodsImage];
    _goodsImage.image = [UIImage  imageNamed:@"goods1"];
    _goodsImage.contentMode = UIViewContentModeScaleAspectFill;
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.chooseBtn.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    
#pragma mark ---- 正常状态下的
    
    /** 标题内容 */
    _goodsTitleL = [[UILabel alloc] init];
    _goodsTitleL.numberOfLines = 2;
    _goodsTitleL.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_goodsTitleL];
    [_goodsTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(42);
    }];
    
    /** 价格 */
    _goodsPriceL = [[UILabel alloc] init];
    _goodsPriceL.numberOfLines = 1;
    _goodsPriceL.font = [UIFont systemFontOfSize:16.0f];
    _goodsPriceL.textColor = [UIColor redColor];
    [self.contentView addSubview:_goodsPriceL];
    [_goodsPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.goodsTitleL.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
    }];
    
    
    /** 销量 */
    _goodsSalesL = [[UILabel alloc] init];
    _goodsSalesL.numberOfLines = 1;
    _goodsSalesL.font = [UIFont systemFontOfSize:14.0f];
    _goodsSalesL.textColor = [UIColor blackColor];
    [self.contentView addSubview:_goodsSalesL];
    [_goodsSalesL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.top.equalTo(self.goodsPriceL.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    /** 库存 */
    _goodsInventoryL = [[UILabel alloc] init];
    _goodsInventoryL.numberOfLines = 1;
    _goodsInventoryL.font = [UIFont systemFontOfSize:14.0f];
    _goodsInventoryL.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_goodsInventoryL];
    [_goodsInventoryL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.top.equalTo(self.goodsSalesL.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    /** 数量 */
    _goodsNumber = [[UILabel alloc] init];
    _goodsNumber.numberOfLines = 1;
    _goodsNumber.font = [UIFont systemFontOfSize:14.0f];
    _goodsNumber.textColor = [UIColor blackColor];
    [self.contentView addSubview:_goodsNumber];
    [_goodsNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.goodsInventoryL.mas_bottom).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    
    /** 分割线 */
    UIImageView *line = [[UIImageView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:211/255.0 alpha:0.5];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.goodsNumber.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    
#pragma mark --- 编辑时出现的样式
    
    /** 覆盖view*/
    _coverView = [[UIView alloc] init];
    _coverView.hidden =YES;
    _coverView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_coverView];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);

    }];
    
    /** 删除 */
    _deleBtn = [[UIButton alloc]init];
    [self.coverView addSubview:_deleBtn];
    [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleBtn.backgroundColor = [UIColor redColor];
    [_deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleBtn addTarget:self action:@selector(deleBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.coverView.mas_right);
        make.width.mas_equalTo(NEW_WIDTH(50));
        make.top.equalTo(self.coverView.mas_top);
        make.bottom.equalTo(self.coverView.mas_bottom);
    }];
    
    /** 加减view */
    _addAndDownView = [[UIView alloc] init];
    _addAndDownView.backgroundColor = [UIColor whiteColor];
    [self.coverView addSubview:_addAndDownView];
    [_addAndDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverView.mas_left).offset(0);
        make.right.equalTo(self.deleBtn.mas_left).offset(-10);
        make.top.equalTo(self.coverView.mas_top).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    AddNumBtn= [[PPNumberButton alloc]init];
    AddNumBtn.increaseTitle = @"+";
    AddNumBtn.decreaseTitle = @"-";
    AddNumBtn.currentNumber = 1;
    AddNumBtn.minValue = 1;
    AddNumBtn.borderColor = RGB_gray(217);
    AddNumBtn.inputFieldFont = 12.0f;
    AddNumBtn.delegate =self;
    [_addAndDownView addSubview:AddNumBtn];
    [AddNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addAndDownView.mas_top).offset(0);
        make.left.equalTo(self.addAndDownView.mas_left).offset(0);
        make.right.equalTo(self.addAndDownView.mas_right).offset(0);
        make.bottom.equalTo(self.addAndDownView.mas_bottom).offset(0);

    }];
    
}

/** 按钮点击事件 */
- (void)chooseBtnClik:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (self.btnBlock) {
        self.btnBlock(btn.selected);
    }
    
}
/** 删除按钮点击事件 */
- (void)deleBtnClik:(UIButton *)btn{
    
    if (self.deleBtn) {
        self.deleBlock();
    }

    
}
/** 加减按钮的代理 */
- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus{
    
}



/** 赋值 */
- (void)setUIValue:(WShopGoodsDetailModel *)model{
#pragma mark ---- 正常状态下的赋值
    _goodsTitleL.text = model.goodsTitle;
    _goodsPriceL.text = [NSString stringWithFormat:@"￥%@",model.goodsPrice];
    _goodsNumber.text = [NSString stringWithFormat:@"X%@",model.goodsNumber];
    _goodsSalesL.text = [NSString stringWithFormat:@"月售:%@",model.goodsSales];
    _goodsInventoryL.text = [NSString stringWithFormat:@"库存:%@",model.goodsInventory];
    
    _chooseBtn.selected = model.chooseState;
    NSLog(@"model.chooseStatez:%d",model.chooseState);
#pragma mark --- 编辑时出现的赋值
    _coverView.hidden = !model.isEdit;
    AddNumBtn.currentNumber = [model.goodsNumber integerValue];
    
    
    
}

@end

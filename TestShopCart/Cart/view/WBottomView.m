//
//  WBottomView.m
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import "WBottomView.h"

@implementation WBottomView
{
    BOOL wEdit;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIFrame];
    }
    return self;
    
}

//创建并设置UI
- (void)createUIFrame{
//    WS(wself);
    CGFloat withW = self.bounds.size.width /3.0;
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:211/255.0 alpha:0.5];
    [self addSubview:line];
    
    /** 全选 */
    _chooseAllBtn = [[UIButton alloc]init];
    _chooseAllBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_chooseAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chooseAllBtn.tag = 520;
    [_chooseAllBtn setImage:[UIImage imageNamed:@"icon_orderpay_normal"] forState:UIControlStateNormal];
    [_chooseAllBtn setImage:[UIImage imageNamed:@"icon_orderpay_selected"] forState:UIControlStateSelected];
    [_chooseAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    _chooseAllBtn .contentVerticalAlignment= UIControlContentHorizontalAlignmentCenter;
    _chooseAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _chooseAllBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    _chooseAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    [_chooseAllBtn addTarget:self action:@selector(btnclik:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_chooseAllBtn];
    [_chooseAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(withW/1.5);

    }];



      /** 立即购买 */
    _payBtn = [[UIButton alloc]init];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
  [_chooseAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _payBtn.backgroundColor = [UIColor orangeColor];
    _payBtn.tag = 521;
    [_payBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_payBtn addTarget:self action:@selector(btnclik:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_payBtn];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(withW);

    }];

    /** 钱 */
    _chooseMoneyL = [[UILabel alloc]init];
    _chooseMoneyL.font = [UIFont systemFontOfSize:15.0f];
    _chooseMoneyL.textColor = [UIColor redColor];
    [_chooseMoneyL sizeToFit];
    _chooseMoneyL.text = @"合计：￥0.00";
    [self addSubview:_chooseMoneyL];
    [_chooseMoneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.payBtn.mas_left);
        make.left.equalTo(self.chooseAllBtn.mas_right).offset(10);
//        make.width.mas_equalTo(withW);
        
    }];

    

}


//按钮的点击事件
- (void)btnclik:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    NSInteger index = btn.tag -520;
    BOOL  state;
    
    if (index ==1) {
        state = wEdit;
    }else{
        state= btn.selected;
    }
    
    if ([self.delegate respondsToSelector:@selector(clikWhichButton:andBtnSatade:)]) {
        
        [self.delegate clikWhichButton:index andBtnSatade:state];
    }
    
    
}


- (void)setIsEdit:(BOOL)isEdit{
    wEdit = isEdit;
    if (isEdit) {
        [_payBtn setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        [_payBtn setTitle:@"立即购买" forState:UIControlStateNormal];

    }
}


@end

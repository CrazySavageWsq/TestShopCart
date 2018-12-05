//
//  WShopCartVC.m
//  TestShopCart
//
//  Created by Crazy Wang on 2018/12/4.
//  Copyright © 2018年 Crazy Wang. All rights reserved.
//

#import "WShopCartVC.h"
#import "WBottomView.h"
#import "WShopCartModel.h"
#import "WShopCartCell.h"
#import "WShopCartSectionHeadView.h"

@interface WShopCartVC ()<WBottomViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) WBottomView *bottonView;//底部view
@property(nonatomic, strong) UITableView *wTableView;//列表
@property(nonatomic, strong) NSMutableArray *wDataSouce;//数据源
@property(nonatomic, assign) CGFloat chooseMoney; //选中商品的总价钱
@end

@implementation WShopCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
    [self setNavacationRightView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _wDataSouce = [NSMutableArray new];
    
    [self createBomeView];
    [self createDataSouce];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- 设置导航栏右键
- (void) setNavacationRightView{
    UIButton *editButton = [UIButton new];
    editButton.frame = CGRectMake(0, 0, 40, 40);
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitle:@"完成" forState:UIControlStateSelected];
    editButton.backgroundColor = [UIColor clearColor];
    editButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editAllGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
// 导航栏上的大编辑
- (void)editAllGoods:(UIButton *)item{
    
    item.selected =!item.selected;
   
    for (WShopCartModel *seModel in _wDataSouce) {
        seModel.isEdit = item.selected;
        
    }
    
    _bottonView.isEdit = item.selected;
    
    [self wTableViewRefresh];
       
}
#pragma mark ---- 获取数据源
- (void)createDataSouce{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shopCart" ofType:@"plist"];
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if ([dataDict[@"code"] integerValue] ==1) {
        
        
        NSArray *sb = [WShopCartModel mj_objectArrayWithKeyValuesArray:dataDict[@"data"]];//mj的数据转model
        
        [_wDataSouce addObjectsFromArray:sb];
        [_wTableView reloadData];
        
    }else{
        NSLog(@"网络出错");
    }
}


#pragma mark ---- 创建购物车底下按钮
- (void)createBomeView{
    
    _bottonView = [[WBottomView alloc]initWithFrame:CGRectMake(0, HEIGHT - NEW_HEIGHT(50), WIDTH, NEW_HEIGHT(50))];
    _bottonView.delegate =self;
    [self.view addSubview:_bottonView];
    
}

/**
 WBottomViewDelegate 代理回调事件
 
 @param index 0 全选 1 去支付
 @param state 按钮的状态（index为0时,Yes为全选；index为1时,Yes为删除）
 */
-(void)clikWhichButton:(NSInteger)index andBtnSatade:(BOOL)state{
    
    NSLog(@"index：%ld state：%d",(long)index,state);
    
    if (index == 0) {

        for (WShopCartModel *seMode in _wDataSouce) {
 
            for (WShopGoodsDetailModel *goodsDeModel in seMode.shopData) {
                
                goodsDeModel.chooseState = state;
            }
        }
        
    }else if (index ==1){
        
        if (state) {//删除全部
            
            if (_wDataSouce.count >0) {

                [self deleteMuchChoos];
               
            }
            
        }else{NSLog(@"跳到立即购买");
            return;
        }
        
    }
    
    //计算钱数
    [self calculatesTheSelectedrice];
     //刷新列表
     [self delayTwoSecondsRefresh];
    
}


#pragma mark ---- 创建列表
- (void)createTableView{
    _wTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,  HEIGHT  - CGRectGetHeight(_bottonView.frame)) style:UITableViewStyleGrouped];
    _wTableView.delegate = self;
    _wTableView.dataSource = self;
    _wTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_wTableView];
    
    _wTableView.estimatedRowHeight = 0;
    _wTableView.estimatedSectionHeaderHeight = 0;
    _wTableView.estimatedSectionFooterHeight = 0;
    _wTableView.sectionFooterHeight =0.0;
    
    [_wTableView registerClass:[WShopCartCell class] forCellReuseIdentifier:@"shopCell"];
    [_wTableView registerClass:[WShopCartSectionHeadView class] forHeaderFooterViewReuseIdentifier:@"sectionHeadView"];
    
}

/**
  列表的代理协议
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return _wDataSouce.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    WShopCartModel *shopMode = _wDataSouce[section];
    
    NSLog(@"shopMode.shopData.count：%ld",shopMode.shopData.count);
    return shopMode.shopData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 153;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    WShopCartModel * seModel = _wDataSouce[section];
    NSArray *daArr = seModel.shopData;
    if (daArr.count>0) {
        return 40;
    }else{
      return   0.00001;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(wself);
    WShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    
    if (_wDataSouce.count >0) {
        
        WShopCartModel * seModel = _wDataSouce[indexPath.section];
        NSArray *daArr = seModel.shopData;
        WShopGoodsDetailModel *goodsModel = daArr[indexPath.row];
        goodsModel.isEdit = seModel.isEdit;
        [cell setUIValue:goodsModel];
        
        //点击cell上的选中
        cell.btnBlock = ^(BOOL state) {
            goodsModel.chooseState = state;
            [wself calculatesTheSelectedrice];
            [wself setTheShopFullSelectButton:indexPath.section andRefreshSection:YES];

        };
        
        //编辑状态下的删除
        cell.deleBlock = ^{
            [wself deleteCurrentIndexPath:indexPath];
             [wself calculatesTheSelectedrice];
        };
        
        cell.selectionStyle = 0;
    }
    
    return cell;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(wself);
    WShopCartSectionHeadView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeadView"];
    if (_wDataSouce.count >0) {
        WShopCartModel * seModel = _wDataSouce[section];

        if (seModel.shopData.count >0) {
            [sectionView setSelfUIVule:seModel];
            
             //点击了商店的编辑按钮
            sectionView.btnBlock = ^(BOOL state) {
                
                seModel.isEdit =state;
                [wself refreshCurrentSection:section];
            };
            
            //点击了商店的全选按钮
            sectionView.choosebBlock = ^(BOOL state) {
                
                seModel.isChoose = state;
                for (WShopGoodsDetailModel *goodsModel in seModel.shopData) {
                    goodsModel.chooseState = state;
                }
                
                [wself refreshCurrentSection:section];
                [wself calculatesTheSelectedrice];
            };
            
            return sectionView;
        }else{
            return nil;
        }
        
    }
   
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0  blue:224/255.0  alpha:0.5];
    return nil;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //第二组可以左滑删除
        return YES;
 
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSLog(@"点击了删除");
        [self deleteCurrentIndexPath:indexPath];
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


/**
 设置组上的全选按钮
 
 @param section 组数据
 */
- (void)setTheShopFullSelectButton:(NSInteger )section andRefreshSection:(BOOL)ref{
    
    WShopCartModel * sectionCarModel = _wDataSouce[section];
    
    for (WShopGoodsDetailModel *goodsModel in sectionCarModel.shopData) {
        
        if (goodsModel.chooseState == NO) {
            
            sectionCarModel.isChoose = NO;
            
            break;
        }else{
            sectionCarModel.isChoose = YES;
        }
    }
    if (ref) {
        [self refreshCurrentSection:section];

    }
}


/**
 刷新当前组

 @param section 要刷新的组
 */
- (void)refreshCurrentSection:(NSInteger)section{
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [_wTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //一个cell刷新
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
//    [_wTtableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

    
}


/**
  大编辑状态下多选删除
 */
-(void)deleteMuchChoos{
    
    for (WShopCartModel *seModel in _wDataSouce) {
        
        NSMutableArray *carGoodsArr = [seModel.shopData mutableCopy];
        NSMutableArray *carGoodsArr_1 = [seModel.shopData mutableCopy];
        if (carGoodsArr.count >0) {
            for (WShopGoodsDetailModel *goodsModel in carGoodsArr_1) {
                if (goodsModel.chooseState) {
                    [carGoodsArr removeObject:goodsModel];
                  }
            }
            seModel.shopData = carGoodsArr;
        }
    }
    
}


/**
 删除某组或组中的row

 @param indexPath 组 行
 */
- (void)deleteCurrentIndexPath:(NSIndexPath *)indexPath{
    
    
    
    WShopCartModel * seModel = _wDataSouce[indexPath.section];
    
    if (seModel.shopData.count > 0) {
        
        NSMutableArray *carGoodsArr = [seModel.shopData mutableCopy];
        [carGoodsArr removeObjectAtIndex:indexPath.row];
        seModel.shopData = carGoodsArr;

    } else {
        [_wDataSouce removeObjectAtIndex:indexPath.section];
    }
    
    //刷新删除的组
    [self setTheShopFullSelectButton:indexPath.section andRefreshSection:NO];
    
    //刷新列表
    [self delayTwoSecondsRefresh];
  
}

// 延迟0.5秒再刷新显得没那么突兀
- (void)delayTwoSecondsRefresh{
    
    [self performSelector:@selector(wTableViewRefresh) withObject:self afterDelay:0.5];
}
-(void)wTableViewRefresh{
       [_wTableView reloadData];
}



/**
  计算选中的总价格
 */
- (void)calculatesTheSelectedrice{
    
    _chooseMoney = 0.0;
    
    for (WShopCartModel *seMode in _wDataSouce) {
        
        for (WShopGoodsDetailModel *goodsDeModel in seMode.shopData) {
            
            if (goodsDeModel.chooseState) {
                
                _chooseMoney = _chooseMoney + [goodsDeModel.goodsPrice floatValue] * [goodsDeModel.goodsNumber floatValue];
            }
        }
        
    }
    
    _bottonView.chooseMoneyL.text = [NSString stringWithFormat:@"合计：￥%.2f",_chooseMoney];
    
}


@end

//
//  TestCollectionViewController.m
//  TABAnimatedDemo
//
//  Created by tigerAndBull on 2018/10/12.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "WaterFlowLayoutViewController.h"

#import "Game.h"
#import "TABDefine.h"
#import "TABAnimatedWaterFallLayout.h"
#import "LawyerCollectionViewCell.h"
#import "WaterFlowCollectionViewCell.h"

@import TABAnimated;

@interface WaterFlowLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource, TABAnimatedWaterFallLayoutDelegate> {
    NSMutableArray *dataArray;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WaterFlowLayoutViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
    
    // 启动动画
    // 默认延迟时间0.4s
    [self.collectionView tab_startAnimationWithCompletion:^{
        // 请求数据
        // ...
        // 获得数据
        // ...
        [self afterGetData];
    }];
}

- (void)reloadViewAnimated {
    _collectionView.tabAnimated.canLoadAgain = YES;
    [_collectionView tab_startAnimationWithCompletion:^{
        [self afterGetData];
    }];
}

#pragma mark - Target Methods

/**
 获取到数据后
 */
- (void)afterGetData {
    
    // 模拟数据
    for (int i = 0; i < 10; i ++) {
        Game *game = [[Game alloc]init];
        game.gameId = [NSString stringWithFormat:@"%d",i];
        game.title = [NSString stringWithFormat:@"这里是测试数据%d",i+1];
        game.cover = @"test2.jpg";
        [dataArray addObject:game];
    }
    
    // 停止动画,并刷新数据
    [self.collectionView tab_endAnimationEaseOut];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFlowCollectionViewCell *cell = [WaterFlowCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
    [cell updateWithModel:dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)waterFallLayout:(TABAnimatedWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth {
    return index % 2 ? 100.f: 150.f;
}

- (NSUInteger)numberColumnsInWaterFallLayout:(TABAnimatedWaterFallLayout *)waterFallLayout {
    return 2;
}

#pragma mark - Initize Methods

- (void)initData {
    dataArray = [NSMutableArray array];
}

/**
 initialize view
 初始化视图
 */
- (void)initUI {
    [self.view addSubview:self.collectionView];
}

#pragma mark - Lazy Methods

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        TABAnimatedWaterFallLayout *flowLayout = [[TABAnimatedWaterFallLayout alloc] init];
        flowLayout.lineSpacing = 10;
        flowLayout.columnSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight)            collectionViewLayout:flowLayout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor tab_normalDynamicBackgroundColor];
        
        CGFloat height = WaterFlowCollectionViewCell.cellSize.height + 20;
        NSArray <NSNumber *>* heightArray = @[@(height), @(height + 20), @(height + 40), @(height), @(height), @(height)];
        TABCollectionAnimated *tabAnimated =
        [TABCollectionAnimated animatedWaterFallLayoutWithCellClass:WaterFlowCollectionViewCell.class
                                                        heightArray:heightArray
                                                          heightSel:@selector(waterFallLayout:heightForItemAtIndex:itemWidth:)];
        tabAnimated.closeCache = YES;
        _collectionView.tabAnimated = tabAnimated;
    }
    return _collectionView;
}

@end

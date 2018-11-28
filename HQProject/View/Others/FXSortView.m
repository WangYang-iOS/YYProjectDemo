//
//  FXSortView.m
//  FXQL
//
//  Created by yons on 2018/10/19.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXSortView.h"

static FXSortView *_sortView;
static UIView *_shadowView;

@interface FXSortCell : UICollectionViewCell
@property(strong, nonatomic) UILabel *titleLabel;
@end

@implementation FXSortCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
    return self;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:PingFangSCRegular(13) textColor:@"#666C77"];
    }
    return _titleLabel;
}
@end


@interface FXSortView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(strong, nonatomic) UICollectionView *collectionView;
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
@property(strong, nonatomic) NSArray *kindArray;
@property(assign, nonatomic) NSInteger lastIndex;
@property(assign, nonatomic) FXSortType sortType;
@property(copy, nonatomic) void(^complete)(NSInteger index);
@end

@implementation FXSortView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.kindArray = [NSMutableArray arrayWithCapacity:0];
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[FXSortCell class] forCellWithReuseIdentifier:@"FXSortCell"];
    }
    return self;
}

- (void)setKindArray:(NSArray *)kindArray {
    _kindArray = kindArray;
    [self.collectionView reloadData];
}

- (void)setLastIndex:(NSInteger)lastIndex {
    _lastIndex = lastIndex;
    [self.collectionView reloadData];
}

- (void)setSortType:(FXSortType)sortType {
    _sortType = sortType;
    if (self.sortType == TotalType) {
        self.layout.minimumLineSpacing = 0;
        self.layout.minimumInteritemSpacing = 0;
        self.layout.sectionInset = UIEdgeInsetsMake(10, 24, 10, 24);
    }else {
        self.layout.minimumLineSpacing = 24;
        self.layout.minimumInteritemSpacing = 24;
        self.layout.sectionInset = UIEdgeInsetsMake(24, 24, 24, 24);
    }
    [self.collectionView reloadData];
}

#pragma mark
#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.kindArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FXSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FXSortCell" forIndexPath:indexPath];
    if (indexPath.row == self.lastIndex) {
        cell.titleLabel.textColor = [UIColor colorWithHexString:@"#1E6DFF"];
    }else {
        cell.titleLabel.textColor = [UIColor colorWithHexString:@"#666C77"];
    }
    cell.titleLabel.text = self.kindArray[indexPath.item];
    return cell;
}

#pragma mark
#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [FXSortView tapShadow:nil];
    if (self.complete) {
        self.complete(indexPath.item);
    }
}
#pragma mark
#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sortType == TotalType) {
        return CGSizeMake(SCREENW - 24 * 2, 36);
    }else {
        return CGSizeMake((SCREENW - 24 * 3)/2.0, 13);
    }
}

#pragma mark
#pragma mark -- UI

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:RECT(0, 0, [self getWidth], [self getHeight]) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 24, 10, 24);
        _layout = layout;
    }
    return _layout;
}

#pragma mark
#pragma mark -- pravate methods

+ (void)showSortView:(FXSortType)sortType lastIndex:(NSInteger)lastIndex vc:(UIViewController *)vc complete:(void (^)(NSInteger))complete {
    if (_shadowView) {
        [_shadowView removeFromSuperview];
    }
    if (_sortView) {
        [_sortView removeFromSuperview];
    }
    
    _shadowView = [[UIView alloc] initWithFrame:RECT(0, 45, SCREENW, [vc.view getHeight] - 45)];
    _shadowView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
    [vc.view addSubview:_shadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShadow:)];
    [_shadowView addGestureRecognizer:tap];
    
    CGFloat height = 128;
    
    if (sortType == TotalType) {
        height = 128;
    }else {
        height = 172;
    }
    
    _sortView = [[FXSortView alloc] initWithFrame:RECT(0, 45, SCREENW, height)];
    _sortView.lastIndex = lastIndex;
    _sortView.sortType = sortType;
    _sortView.complete = complete;
    [vc.view addSubview:_sortView];
    
    switch (sortType) {
        case TotalType:
        {
            //0综合 1发布时间 2浏览次数
            _sortView.kindArray = @[@"综合排序",@"按发布时间",@"按浏览次数"];
        }
            break;
        case GongType:
        {
//            NSArray *array = [FXFileManager getCustomModels:FXSupplyDemand];
            NSMutableArray *titles = @[@"不限"].mutableCopy;
//            [array enumerateObjectsUsingBlock:^(FXKindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [titles addObject:obj.name];
//            }];
            _sortView.kindArray = titles;
        }
            break;
        case XuType:
        {
//            NSArray *array = [FXFileManager getCustomModels:FXSupplyDemand];
            NSMutableArray *titles = @[@"不限"].mutableCopy;
//            [array enumerateObjectsUsingBlock:^(FXKindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [titles addObject:obj.name];
//            }];
            _sortView.kindArray = titles;
        }
            break;
        case ConnectionType:
        {
//            NSArray *array = [FXFileManager getCustomModels:FXConnection];
            NSMutableArray *titles = @[@"不限"].mutableCopy;
//            [array enumerateObjectsUsingBlock:^(FXKindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [titles addObject:obj.name];
//            }];
            _sortView.kindArray = titles;
        }
            break;
            
        default:
            break;
    }
}

+ (void)tapShadow:(UITapGestureRecognizer *)tap {
    if (_shadowView) {
        [_shadowView removeFromSuperview];
    }
    if (_sortView) {
        [_sortView removeFromSuperview];
    }
}

@end

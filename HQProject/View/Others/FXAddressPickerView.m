//
//  FXAddressPickerView.m
//  FXQL
//
//  Created by yons on 2018/11/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXAddressPickerView.h"


#define pickerH 230
#define topH 50

@interface FXAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(strong, nonatomic) UIView *contentView;
@property(strong, nonatomic) UIView *topView;
@property(strong, nonatomic) UILabel *titleLabel;
@property(copy, nonatomic) void (^complete)(NSString *area, NSString *code);

@property (strong, nonatomic) NSArray *areaArray;
@property (strong, nonatomic) NSArray *cityArray;

@end
@implementation FXAddressPickerView

+ (FXAddressPickerView *)showAddressPickerViewComplete:(void(^)(NSString *area, NSString *code))complete {
    FXAddressPickerView *pickerView = [[FXAddressPickerView alloc] initWithFrame:RECT(0, 0, SCREENW, SCREENH)];
    pickerView.complete = complete;
    [MainWindow addSubview:pickerView];
    
    UIPickerView *pickerV = [[UIPickerView alloc] initWithFrame:RECT(0, topH, SCREENW, pickerH - topH)];
    pickerV.delegate = pickerView;
    pickerV.dataSource = pickerView;
    [pickerView.contentView addSubview:pickerV];
    pickerView.pickerView = pickerV;
    
    [UIView animateWithDuration:0.25 animations:^{
        pickerView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        pickerView.contentView.frame = RECT(0, SCREENH - pickerH, SCREENW, pickerH);
    }];
    
    return pickerView;
}

#pragma mark
#pragma mark -- 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0];
        self.contentView = [[UIView alloc] initWithFrame:RECT(0, SCREENH, SCREENW, pickerH)];
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [self addSubview:self.contentView];
        self.topView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREENW, topH)];
        [self.contentView addSubview:self.topView];
        self.titleLabel = [UILabel labelWithFont:FONT(17) textColor:@"2B3343" textAlignment:NSTextAlignmentCenter];
        self.titleLabel.text = @"选择地区";
        [self.topView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.topView);
        }];
        UIButton *cancelButton = [UIButton buttonWithTitle:@"取消" titleColor:@"999999" font:FONT(16)];
        [cancelButton addTarget:self action:@selector(removePickerView) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.offset(50);
        }];
        UIButton *sureButton = [UIButton buttonWithTitle:@"确定" titleColor:@"1E6DFF" font:FONT(16)];
        [sureButton addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:sureButton];
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.offset(0);
            make.width.offset(50);
        }];
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, topH - 1, SCREENW, 1)];
        [lineV setBackgroundColor:color_line];
        [self.topView addSubview:lineV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePickerView)];
        [self addGestureRecognizer:tap];
        
        [HQNetworkManager postRequestWithDitionary:nil url:@"api/V1/Member/GetAllArea" block:^(BOOL success, ResponseMessage *responseMessage) {
            if (success) {
//                NSArray *array = [FXAreaModel mj_objectArrayWithKeyValuesArray:responseMessage.bussinessData];
//                self.areaArray = array;
//                FXAreaModel *model = array.firstObject;
//                self.cityArray = model.child;
//                [self.pickerView reloadAllComponents];
            }
        }];
        
    }
    return self;
}


#pragma mark
#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.areaArray.count;
    }else {
        return self.cityArray.count;
    }
}
#pragma mark
#pragma mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREENW / 2;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
    
    NSString *address = @"";
//    if (component == 0) {
//        FXAreaModel *model = self.areaArray[row];
//        address = model.area_name;
//    }else if (component == 1) {
//        FXCityModel *model = self.cityArray[row];
//        address = model.area_name;
//    }
    
    if (!label) {
        label = [UILabel labelWithText:[NSString stringWithFormat:@"%@",address] font:PingFangSCRegular(17) textColor:@"0f0f0f" textAlignment:NSTextAlignmentCenter];
    }
    //隐藏两条线
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = color_line;
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = color_line;
    
    UILabel *currentLabel = (UILabel *)[pickerView viewForRow:row forComponent:component];
    currentLabel.font = PingFangSCRegular(22);
    
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
//        FXAreaModel *model = self.areaArray[row];
//        self.cityArray = model.child;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        _lastArea = row;
        _lastCity = 0;
    } else if (component == 1) {
        _lastCity = row;
    }
}

#pragma mark
#pragma mark -- interface

- (void)removePickerView {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0];
        self.contentView.frame = RECT(0, SCREENH, SCREENW, pickerH);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)clickSureButton {
    [self removePickerView];
//    FXAreaModel *areaModel = self.areaArray[self.lastArea];
//    FXCityModel *cityModel = areaModel.child[self.lastCity];
//    
//    NSString *address = [NSString stringWithFormat:@"%@%@",areaModel.area_name,cityModel.area_name];
//    if (self.complete) {
//        self.complete(address, cityModel.area_id);
//    }
}

@end

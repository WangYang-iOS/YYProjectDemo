//
//  FXDatePickerView.m
//  FXQL
//
//  Created by yons on 2018/11/13.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXDatePickerView.h"
#import "YYDatePickerTool.h"

#define pickerH 230
#define topH 50

@interface FXDatePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(strong, nonatomic) UIView *contentView;
@property(strong, nonatomic) UIView *topView;
@property(strong, nonatomic) UILabel *titleLabel;
@property(copy, nonatomic) void (^complete)(NSString *title);

@property (strong, nonatomic) NSMutableArray *yearArray;
@property (strong, nonatomic) NSMutableArray *monthArray;
@property (strong, nonatomic) NSMutableArray *dayArray;



@end

@implementation FXDatePickerView


+ (FXDatePickerView *)showPickerViewWithTime:(NSString *)time complete:(void(^)(NSString *title))complete {
    FXDatePickerView *pickerView = [[FXDatePickerView alloc] initWithFrame:RECT(0, 0, SCREENW, SCREENH)];
    pickerView.complete = complete;
    [MainWindow addSubview:pickerView];
    
    if (time.length == 0) {
        time = [HQCommenMethods stringWithDate:[NSDate date] formatter:@"yyyy-MM-dd"];
    }else {
//        time = [HQCommenMethods stringWithTimeString:time fromFormatter:@"yyyy/MM/dd" toFormatter:@"yyyy-MM-dd"];
    }
    
    pickerView.lastYear = [[HQCommenMethods stringWithTimeString:time fromFormatter:@"yyyy-MM-dd" toFormatter:@"yyyy"] integerValue];
    pickerView.lastMonth = [[HQCommenMethods stringWithTimeString:time fromFormatter:@"yyyy-MM-dd" toFormatter:@"MM"] integerValue];
    pickerView.lastDay = [[HQCommenMethods stringWithTimeString:time fromFormatter:@"yyyy-MM-dd" toFormatter:@"dd"] integerValue];
    
    UIPickerView *pickerV = [[UIPickerView alloc] initWithFrame:RECT(0, topH, SCREENW, pickerH - topH)];
    pickerV.delegate = pickerView;
    pickerV.dataSource = pickerView;
    [pickerView.contentView addSubview:pickerV];
    pickerView.pickerView = pickerV;
    
    [UIView animateWithDuration:0.25 animations:^{
        pickerView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        pickerView.contentView.frame = RECT(0, SCREENH - pickerH, SCREENW, pickerH);
    }];
    
    [pickerV selectRow:pickerView.lastYear inComponent:0 animated:YES];
    [pickerV selectRow:pickerView.lastMonth - 1 inComponent:1 animated:YES];
    [pickerV selectRow:pickerView.lastDay - 1 inComponent:2 animated:YES];
    
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
        self.titleLabel.text = @"生日";
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
        
        _yearArray = [NSMutableArray arrayWithCapacity:0];
        _monthArray = [NSMutableArray arrayWithCapacity:0];
        _dayArray = [NSMutableArray arrayWithCapacity:0];
        
        NSMutableArray *yearArray = [YYDatePickerTool years];
        [_yearArray addObjectsFromArray:yearArray];
        
        NSArray *monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
        [_monthArray addObjectsFromArray:monthArray];
        
        NSArray *dayArray = [YYDatePickerTool dayWithYear:[yearArray[0] integerValue] month:1];
        [_dayArray addObjectsFromArray:dayArray];
    }
    return self;
}


#pragma mark
#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
    }else if (component == 1) {
        return self.monthArray.count;
    }else {
        return self.dayArray.count;
    }
}
#pragma mark
#pragma mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREENW / 3;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
    
    NSString *time = @"";
    NSString *string;
    if (component == 0) {
        time = self.yearArray[row];
        string = @"年";
    }else if (component == 1) {
        time = self.monthArray[row];
        string = @"月";
    }else {
        time = self.dayArray[row];
        string = @"日";
    }
    
    if (!label) {
        label = [UILabel labelWithText:[NSString stringWithFormat:@"%@%@",time,string] font:PingFangSCRegular(17) textColor:@"0f0f0f" textAlignment:NSTextAlignmentCenter];
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
        NSInteger year = [_yearArray[row] integerValue];
        NSArray *dayArray = [YYDatePickerTool dayStopNowWithYear:year month:_lastMonth];
        [_dayArray removeAllObjects];
        [_dayArray addObjectsFromArray:dayArray];
        [pickerView reloadComponent:2];
        _lastYear = [_yearArray[row] integerValue];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        _lastDay = [_dayArray[0] integerValue];
    } else if (component == 1) {
        NSInteger month = [_monthArray[row] integerValue];
        NSArray *dayArray = [YYDatePickerTool dayStopNowWithYear:_lastYear month:month];
        [_dayArray removeAllObjects];
        [_dayArray addObjectsFromArray:dayArray];
        [pickerView reloadComponent:2];
        _lastMonth = [_monthArray[row] integerValue];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        _lastDay = [_dayArray[0] integerValue];
    } else {
        _lastDay = [_dayArray[row] integerValue];
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
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)_lastYear,(long)_lastMonth,(long)_lastDay];
    if (self.complete) {
        self.complete(dateString);
    }
}
@end

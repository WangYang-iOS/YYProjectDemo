//
//  CQUploadImgsManager.m
//  Chengqu
//
//  Created by wangyang on 2018/1/15.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "CQUploadImgsManager.h"

@interface CQUploadImgsManager ()

/** 保存 上传成功后的图片路径，根据对应的index作为key */
@property (nonatomic, strong) NSMutableDictionary *mDic;
//@property (nonatomic, assign) NSInteger upImgCount;
/** 需要上传的图片张数（去除已经上传成功的图片） */
@property (nonatomic, assign) NSInteger needUpCount;
/** 已经上传成功的图片张数 */
@property (nonatomic, assign) NSInteger hasUpCount;

@property (nonatomic, copy) upImgBlock block;

@end

@implementation CQUploadImgsManager

- (NSMutableDictionary *)mDic {
    if (!_mDic) {
        _mDic = [NSMutableDictionary dictionary];
    }
    return _mDic;
}

+ (CQUploadImgsManager *)shareUpImgManager {
    static dispatch_once_t onceToken;
    static CQUploadImgsManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[CQUploadImgsManager alloc] init];
    });
    return manager;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//
//    if ([keyPath isEqualToString:@"mDic"]) {
//
//
//    }
//
//}

//+ (void)uploadImgs:(NSArray *)imgs type:(uploadImgType)upImgType callBack:(upImgBlock)block {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if (imgs && [imgs isKindOfClass:[NSArray class]]) {
////            [CQUploadImgsManager shareUpImgManager].upCount = 0;
//            [CQUploadImgsManager shareUpImgManager].hasUpCount = 0;
//            [CQUploadImgsManager shareUpImgManager].needUpCount = imgs.count;
//            [CQUploadImgsManager shareUpImgManager].block = block;
//            [CQUploadImgsManager shareUpImgManager].mDic = [NSMutableDictionary dictionary];
//
//            for (NSInteger i = 0; i < imgs.count; i++) {
//                UIImage *upImg = imgs[i];
//                
//                if ([upImg isKindOfClass:[ALAsset class]]) {
//                    [HQAlbumManager formatSourceImg:(ALAsset *)upImg sourceImg:^(UIImage *sourceImg) {
//                        [CQUploadImgsManager uploadImg:sourceImg key:IntegerToString(i) typ:upImgType];
//                    }];
//                } else if ([upImg isKindOfClass:[UIImage class]]) {
//                    [CQUploadImgsManager uploadImg:upImg key:IntegerToString(i) typ:upImgType];
//                } else if ([upImg isKindOfClass:[NSString class]]) {
//                    [[CQUploadImgsManager shareUpImgManager].mDic setObject:upImg forKey:IntegerToString(i)];
//                    [CQUploadImgsManager shareUpImgManager].needUpCount -= 1;
//                    if ([CQUploadImgsManager shareUpImgManager].needUpCount == 0) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [CQUploadImgsManager shareUpImgManager].block(imgs);
//                        });
//                    }
//                }
//            }
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [CQUploadImgsManager shareUpImgManager].block(imgs);
//            });
//        }
//    });
//}
//
//+ (void)uploadImg:(UIImage *)dataImg key:(NSString *)ketStr typ:(uploadImgType)type {
//    
//    [NetManager uploadImg:[Commen compressImage:dataImg toTargetWidth:400] key:ketStr type:type result:^(NSInteger code, NSString *keyStr, NSString *imgpath) {
//        
//        if (code == code_success) {
//            [CQUploadImgsManager shareUpImgManager].hasUpCount += 1;
//            [[CQUploadImgsManager shareUpImgManager].mDic setObject:imgpath forKey:ketStr];
////            NSInteger wholeCount = [CQUploadImgsManager shareUpImgManager].upImgCount;
//            if (([CQUploadImgsManager shareUpImgManager].hasUpCount == [CQUploadImgsManager shareUpImgManager].needUpCount)) {
//                NSMutableArray *backArr = [NSMutableArray array];
//                for (NSInteger i = 0; i < [CQUploadImgsManager shareUpImgManager].mDic.allValues.count; i ++) {
//                    NSString *imgStr = [CQUploadImgsManager shareUpImgManager].mDic[IntegerToString(i)];
//                    [backArr addObject:imgStr];
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [CQUploadImgsManager shareUpImgManager].block(backArr);
//                });
//            }
//        }
//    }];
//}

@end

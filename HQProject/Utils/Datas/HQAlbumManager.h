//
//  HQAlbumManager.h
//  customerPro
//
//  Created by wangyang on 17/3/13.
//  Copyright © 2017年 tw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>  // 必须导入

// caches路径
#define KCachesPath   \
[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 照片原图路径
#define KOriginalPhotoImagePath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OriginalPhotoImages"]

// 视频URL路径
#define videoCacheDir       [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/UploadPhoto/"]


typedef enum : NSUInteger {
    albumType_img = 1,
    albumType_video,
    albumType_gif,
    albumType_other
} albumType;

typedef enum : NSUInteger {
    addPicType_beauty = 1,
    addPicType_funny,
    addPicType_video,
    addPicType_all
} addPicType;

typedef void (^albumData)(NSArray *groupArr, NSArray *contGifArr, NSArray *imgArr, NSArray *videoArr, BOOL success);
typedef void (^albumBlock)(NSArray *groupArr);
typedef void (^sourceImgBlock)(UIImage *sourceImg);
typedef void (^copyVideoBlock)(BOOL isSuccess);

@interface HQAlbumGroupM : NSObject
@property (nonatomic, strong) ALAssetsGroup *assetGroup;
@property (nonatomic, strong) NSArray *dataArr;
@end


@interface HQAlbumModel : NSObject

@property (nonatomic, assign) albumType albumType;
@property (nonatomic, strong) UIImage *thumbImg;
@property (nonatomic, strong) UIImage *sourceImg;
@property (nonatomic, strong) NSURL *pathUrl;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *filePathUrl;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSData *gifData;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) ALAsset *asset;

//@property (nonatomic, assign) uploadImgType uploadType;
//+ (void )formatAlbumM:(ALAsset *)asset ;

@end

@interface HQAlbumManager : NSObject
@property (nonatomic, strong) ALAssetsLibrary *lib;
+ (HQAlbumManager *)shareAlbumManager;
- (void)getAlbumAllDataType:(addPicType)type backBlock:(albumBlock)backBlock ;
- (void)getAlbumGroupDataType:(addPicType)type result:(albumBlock)backBlock ;

+ (NSArray *)formatAssetDara:(NSArray *)arr ;
+ (NSString *)formatFileName:(ALAsset *)asset ;
+ (NSString *)formatDuration:(ALAsset *)asset ;
+ (NSURL *)formatPathUrl:(ALAsset *)asset ;
+ (albumType)formatAlbumType:(ALAsset *)asset;
+ (NSData *)gifData:(ALAsset *)gif;
+ (void )formatThumbImg:(ALAsset *)asset img:(sourceImgBlock)sourceImg ;
+ (void )formatSourceImg:(ALAsset *)asset sourceImg:(sourceImgBlock)sourceImg;

/** 文件夹 缩略图 */
+ (void )formatCoverImg:(ALAssetsGroup *)asset img:(sourceImgBlock)sourceImg ;
/** 文件夹名称 */
+ (NSString *)formatGroupFileName:(ALAssetsGroup *)asset ;

/** 获取视频封面 */
+ (void)movieToImage:(ALAsset *)Masset img:(sourceImgBlock)sourceImg;

//获取视频时间
+ (NSString *)getVideoDuration:(NSURL*) URL;

//+ (void)getAlbumGroupData:(albumBlock)result;
//+ (NSArray *)getAllAssetsWithGroup:(ALAssetsGroup *)group;

//+ (void)getAlbumDataNeedImg:(BOOL)needImg needVideo:(BOOL)needVideo albumData:(albumData)albumData;
+ (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName callback:(copyVideoBlock)block;
+ (void)compressVideo:(NSURL *)url callback:(void(^)(NSString *path,NSString *videoPath,NSData *data))callback;
@end

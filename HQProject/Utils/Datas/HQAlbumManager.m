//
//  HQAlbumManager.m
//  customerPro
//
//  Created by wangyang on 17/3/13.
//  Copyright © 2017年 tw. All rights reserved.
//

#import "HQAlbumManager.h"
#import <Photos/Photos.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MPMoviePlayerController.h>


#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
@implementation HQAlbumGroupM


@end

@implementation HQAlbumModel

//+ (void )formatAlbumM:(ALAsset *)asset {
//    HQAlbumModel *model = [[HQAlbumModel alloc] init];
//    model.thumbImg = [UIImage imageWithCGImage:[asset thumbnail]];
////    model.sourceImg = [HQAlbumManager getBigIamgeWithALAsset:asset];
////    model.fileName = [[asset defaultRepresentation] filename];
//    NSInteger duratInt = [[asset valueForProperty:ALAssetPropertyDuration] integerValue];
//    model.duration = [NSString stringWithFormat:@"%02.2ld:%02.2ld", duratInt/60, duratInt%60];
//    model.pathUrl = [[asset defaultRepresentation] url];
//    return model;
//}

//- (UIImage *)formatThumbImg:(ALAsset *)asset {
//    if (!_thumbImg) {
//        _thumbImg = [UIImage imageWithCGImage:[asset thumbnail]];
//    }
//    return _thumbImg;
//}
//
//- (UIImage *)sourceImg {
//    if (!_sourceImg) {
//        _sourceImg = [UIImage imageWithCGImage:self.asset.defaultRepresentation.fullResolutionImage
//                                                        scale:self.asset.defaultRepresentation.scale
//                                                  orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];;
//    }
//    return _sourceImg;
//}
//
//-(NSString *)fileName {
//    if (!_fileName) {
//        _fileName = [[self.asset defaultRepresentation] filename];
//    }
//    return _fileName;
//}
//
//- (NSString *)duration {
//    if (!_duration) {
//        NSInteger duratInt = [[self.asset valueForProperty:ALAssetPropertyDuration] integerValue];
//        _duration = [NSString stringWithFormat:@"%02.0ld:%02.0ld", duratInt/60, duratInt%60];
//    }
//    return _duration;
//}
//
//-(NSURL *)pathUrl {
//    if (!_pathUrl) {
//        _pathUrl = [[self.asset defaultRepresentation] url];
//    }
//    return _pathUrl;
//}


@end


@implementation HQAlbumManager

+ (HQAlbumManager *)shareAlbumManager {
    
    static HQAlbumManager *tool;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        tool = [[[self class] alloc] init];
        tool.lib = [[ALAssetsLibrary alloc] init];
    });
    
    return tool;
}

- (void)getAlbumAllDataType:(addPicType)type backBlock:(albumBlock)backBlock {
    NSString *statusType = ALAssetTypePhoto;
    bool onlyPic = NO;
    if (type == addPicType_video) {
        statusType = ALAssetTypeVideo;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataArr = [NSMutableArray array];
        __block ALAssetsGroup *selectGp ;
        [_lib enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                if ([group numberOfAssets] > [selectGp numberOfAssets]) {
                    selectGp = group;
                }
            } else {
                [selectGp enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        if (type == addPicType_all) {
                            [dataArr addObject:result];
                        } else {
                            NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                            if ([assetType isEqualToString:statusType]) {
                                if (!(onlyPic && [HQAlbumManager isGif:result])) {
                                    [dataArr addObject:result];
                                }
                            }
                        }
                    }
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (dataArr.count > 0) {
                        (!backBlock)?:backBlock([dataArr copy]);
                    } else {
                        (!backBlock)?:backBlock(nil);
                    }
                });
            }
        } failureBlock:^(NSError *error) {
            (!backBlock)?:backBlock(nil);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请开启相册权限后重试"
                                                                   message:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil, nil, nil];
                [alertView show];
            });
        }];
    });
}

- (void)getAlbumGroupDataType:(addPicType)type result:(albumBlock)backBlock {
    NSString *statusType = ALAssetTypePhoto;
    bool onlyPic = NO;
    if (type == addPicType_video) {
        statusType = ALAssetTypeVideo;
    }
    if (type == addPicType_beauty) {
        onlyPic = YES;
    }
    
    NSMutableArray *groupArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [_lib enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            if (group) {
                NSMutableArray *dataArr = [NSMutableArray array];
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    
                    NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                    if ([assetType isEqualToString:statusType]) {
                        if (!(onlyPic && [HQAlbumManager isGif:result])) {
                            [dataArr addObject:result];
                        }
                    }
                    
                }];
                if (dataArr.count > 0) {
                    HQAlbumGroupM *m = [[HQAlbumGroupM alloc] init];
                    m.assetGroup = group;
                    m.dataArr = dataArr;
                    [groupArr addObject:m];
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (groupArr.count > 0) {
                        (!backBlock)?:backBlock([groupArr copy]);
                    }
                });
            }
            
            
        } failureBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请开启相册权限后重试"
                                                                   message:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil, nil, nil];
                [alertView show];
            });
        }];
    });
}

+ (NSData *)gifData:(ALAsset *)gif
{
    if (!gif) {
        return nil;
    }
    
    ALAssetRepresentation *re = [gif representationForUTI:(__bridge NSString *)kUTTypeGIF];;
    long long size = re.size;
    uint8_t *buffer = malloc(size);
    NSError *error;
    NSUInteger bytes = [re getBytes:buffer fromOffset:0 length:size error:&error];
    NSData *data = [NSData dataWithBytes:buffer length:bytes];
    free(buffer);
    return data;
}

+ (BOOL)isGif:(ALAsset *)gif
{
    ALAssetRepresentation *re = [gif representationForUTI: (__bridge NSString *)kUTTypeGIF];
    if (re) {
        return YES;
    }
    return NO;
}

// 将原始图片的URL转化为NSData数据,写入沙盒
- (void)imageWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    // 进这个方法的时候也应该加判断,如果已经转化了的就不要调用这个方法了
    // 如何判断已经转化了,通过是否存在文件路径
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    // 创建存放原始图的文件夹--->OriginalPhotoImages
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:KOriginalPhotoImagePath]) {
        [fileManager createDirectoryAtPath:KOriginalPhotoImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (url) {
            // 主要方法
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
                NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:((unsigned long)rep.size) error:nil];
                NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                NSString * imagePath = [KOriginalPhotoImagePath stringByAppendingPathComponent:fileName];
                [data writeToFile:imagePath atomically:YES];
            } failureBlock:nil];
        }
    });
}

// 将原始视频的URL转化为NSData数据,写入沙盒
+ (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName callback:(copyVideoBlock)block
{
    // 解析一下,为什么视频不像图片一样一次性开辟本身大小的内存写入?
    // 想想,如果1个视频有1G多,难道直接开辟1G多的空间大小来写?
    
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (url) {
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                if (asset) {
                    ALAssetRepresentation *rep = [asset defaultRepresentation];
                    if (![[NSFileManager defaultManager] fileExistsAtPath:videoCacheDir]) {
                        [[NSFileManager defaultManager] createDirectoryAtPath:videoCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                    NSString * videoPath = [videoCacheDir stringByAppendingPathComponent:fileName];

                    char const *cvideoPath = [videoPath UTF8String];
                    FILE *file = fopen(cvideoPath, "a+");
                    if (file) {
                        const int bufferSize = 1024 * 1024;
                        // 初始化一个1M的buffer
                        Byte *buffer = (Byte*)malloc(bufferSize);
                        NSUInteger read = 0, offset = 0, written = 0;
                        NSError* err = nil;
                        if (rep.size != 0)
                        {
                            do {
                                read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
                                written = fwrite(buffer, sizeof(char), read, file);
                                offset += read;
                            } while (read != 0 && !err);//没到结尾，没出错，ok继续
                        }
                        // 释放缓冲区，关闭文件
                        free(buffer);
                        buffer = NULL;
                        fclose(file);
                        file = NULL;
                        if (block) {
                            block(YES);
                        }
                    }
                }else {
                    if (block) {
                        block(YES);
                    }
                }
            } failureBlock:^(NSError *error) {

                if (block) {
                    block(NO);
                }
            }];
        }
    });
}

+ (void)compressVideo:(NSURL *)url callback:(void(^)(NSString *path,NSString *videoPath,NSData *data))callback {
    
    NSTimeInterval date = [NSDate date].timeIntervalSince1970;
    NSString *lastPathComponent = [NSString stringWithFormat:@"%.0f%u.mp4", date,arc4random()];
    NSString *videoPath = [videoCacheDir stringByAppendingPathComponent:lastPathComponent];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:urlAsset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:videoPath];
    exportSession.outputFileType = AVFileTypeMPEG4;
        
    if ([[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        if (callback) {
            callback(lastPathComponent,videoPath,[NSData dataWithContentsOfFile:videoPath]);
        }
        return;
    }
        
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                if (callback) {
                    callback(lastPathComponent,videoPath,nil);
                }
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"视频转码成功");
                NSData *data = [NSData dataWithContentsOfFile:videoPath];
                if (callback) {
                    callback(lastPathComponent,videoPath,data);
                }
            }
        }
    }];
}

////保存视频完成之后的回调
//+ (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    if (error) {
//        NSLog(@"保存视频失败%@", error.localizedDescription);
//    } else {
//        NSLog(@"保存视频成功");
//    }
//}

- (void)getThumbnailImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
        }];
    }
}


+ (void )formatCoverImg:(ALAssetsGroup *)asset img:(sourceImgBlock)sourceImg {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *thumbImg = [UIImage imageWithCGImage:[asset posterImage]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sourceImg) {
                sourceImg(thumbImg);
            }
        });
        
    });
    
}
+ (NSString *)formatGroupFileName:(ALAssetsGroup *)asset{
    return [asset valueForProperty:ALAssetsGroupPropertyName];
}

+ (NSArray *)formatAssetDara:(NSArray *)arr {
    
    NSMutableArray *formatArr = [NSMutableArray array];
//    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [formatArr addObject:[HQAlbumModel formatAlbumM:obj]];
//    }];
    return [formatArr copy];
}

+ (void)formatSourceImg:(ALAsset *)asset sourceImg:(sourceImgBlock)sourceImg {
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *img = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage
                                           scale:asset.defaultRepresentation.scale
                                     orientation:(UIImageOrientation)asset.defaultRepresentation.orientation];
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        UIImage *source = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sourceImg) {
                sourceImg(source);
            }
        });
       
    });
}

+ (void )formatThumbImg:(ALAsset *)asset img:(sourceImgBlock)sourceImg {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *assetType = [asset valueForProperty:ALAssetPropertyType];

        if ([assetType isEqualToString:ALAssetTypeVideo]) {
            [HQAlbumManager movieToImage:asset img:sourceImg];
            
        } else {
            UIImage *thumbImg = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sourceImg) {
                    sourceImg(thumbImg);
                }
            });
        }
        
        
    });
}

+ (NSString *)formatFileName:(ALAsset *)asset {
    NSString *fileName = [[asset defaultRepresentation] filename];
    return fileName;
}

+ (NSString *)formatDuration:(ALAsset *)asset  {
    NSInteger duratInt = [[asset valueForProperty:ALAssetPropertyDuration] integerValue];
    NSString *duration = [NSString stringWithFormat:@"%02ld:%02ld", duratInt/60, duratInt%60];
    return duration;
}

+ (NSURL *)formatPathUrl:(ALAsset *)asset  {
    NSURL *pathUrl = [[asset defaultRepresentation] url];
    return pathUrl;
}

+ (albumType)formatAlbumType:(ALAsset *)asset {
    NSString *assetType = [asset valueForProperty:ALAssetPropertyType];
    if ([assetType isEqualToString:ALAssetTypePhoto]) {
        if ([HQAlbumManager isGif:asset]) {
            return albumType_gif;
        } else {
            return albumType_img;
        }
    } else if([assetType isEqualToString:ALAssetTypeVideo]) {
        return albumType_video;
    } else {
        return albumType_other;
    }
    
}

//获取视频时间
+ (NSString *) getVideoDuration:(NSURL*) URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    NSInteger dura = (NSInteger)second;
    NSString *duraStr = [NSString stringWithFormat:@"%02ld:%02ld", dura/60, dura%60];
    return duraStr;
}

/**获取视频封面*/
+ (void)movieToImage:(ALAsset *)Masset img:(sourceImgBlock)sourceImg {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:[[Masset defaultRepresentation] url] options:nil];
        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generator.appliesPreferredTrackTransform=TRUE;
        CMTime thumbTime = CMTimeMakeWithSeconds(5,30);
        
        AVAssetImageGeneratorCompletionHandler handler =
        ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
            if (result != AVAssetImageGeneratorSucceeded) {       }//没成功
            
            UIImage *thumbImg = [UIImage imageWithCGImage:im];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sourceImg) {
                    sourceImg(thumbImg);
                }
            });
        };
        
        generator.maximumSize = CGSizeMake(SCREEN.width, 210);
        [generator generateCGImagesAsynchronouslyForTimes:
         [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
        
    });
}


@end

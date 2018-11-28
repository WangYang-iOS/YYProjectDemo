//
//  FXFileManager.m
//  FXQL
//
//  Created by yons on 2018/11/5.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

#import "FXFileManager.h"

@implementation FXFileManager

+ (NSString *)getCacheFile {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *createPath = [pathDocuments stringByAppendingPathComponent:@"FX_CacheFile"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return createPath;
}

+ (NSString *)getCachePath:(NSString *)fileName {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *createPath = [[FXFileManager getCacheFile] stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return createPath;
}

+ (id)getCustomModels:(NSString *)key {
    NSString *keyPath = [FXFileManager getCachePath:@"History"];
    keyPath = [keyPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.fxCache", key]];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:keyPath];
    return array;
}

+ (void)saveCustomModels:(id)data key:(NSString *)key {
    NSString *keyPath = [FXFileManager getCachePath:@"History"];
    keyPath = [keyPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.fxCache", key]];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:keyPath]) {
        NSData *data = [fileManager contentsAtPath:keyPath];
        [fileManager createFileAtPath:keyPath contents:data attributes:nil];
    }
    [NSKeyedArchiver archiveRootObject:data toFile:keyPath];
}

+ (void)deleteCustomModels:(NSString *)key {
    NSString *keyPath = [FXFileManager getCachePath:@"History"];
    keyPath = [keyPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.fxCache", key]];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error;
    if ([fileManager removeItemAtPath:keyPath error:&error]) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}
@end

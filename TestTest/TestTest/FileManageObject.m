//
//  FileManageObject.m
//  TestTest
//
//  Created by 程海峰 on 16/9/1.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "FileManageObject.h"

@implementation FileManageObject

+(NSString*)getAppPath//得到数据库文件在App目录下的路径
{
    return [[NSBundle mainBundle]resourcePath];
    
}
+(NSString*)getDocPath//得到数据库文件在Doc目录下的路径
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //找出文件下所有文件目录
    NSString *docPath = ([paths count] > 0)?[paths objectAtIndex:0]:nil;
    //找到Docutement目录
    return docPath;
}

+(BOOL) writeStringToFileWithFileName:(NSString *)fileName  andContentString:(NSString *) string
{
    BOOL writeSucess = NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *finalFileName = [NSString stringWithFormat:@"%@%@",fileName,[dateFormatter stringFromDate:[NSDate date]]];
    return writeSucess;
}

@end

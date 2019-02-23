//
//  WritePlist.m
//  ShopingListProject
//
//  Created by Admin on 2/17/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

#import "WritePlist.h"

@implementation WritePlist





+ (NSString*)pathDocumentWithFileName:(NSString *)plistFileName{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath=path[0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@.plist",dirPath,plistFileName];
    return filePath;
}

+(void)writeToPlistWithPath:(NSString*)documentPath Data:(NSMutableDictionary*)dataToSaved   {
    //[NSKeyedArchiver archiveRootObject:dataToSaved toFile:documentPath];
    if ( [dataToSaved writeToFile:documentPath atomically:YES]){
        NSLog(@"the plist %@ created ...",documentPath);
    };


}
+ (NSString*)ReturnFullDirPath{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath=path[0];
    return dirPath;
}



@end

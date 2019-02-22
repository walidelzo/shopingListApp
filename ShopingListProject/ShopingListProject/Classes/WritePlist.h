//
//  WritePlist.h
//  ShopingListProject
//
//  Created by Admin on 2/17/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WritePlist : NSObject
+(NSString*)pathDocumentWithFileName:(NSString*) plistFileName;
+(void)writeToPlistWithPath:(NSString*)documentPath Data:(id)dataToSaved;
@end

NS_ASSUME_NONNULL_END

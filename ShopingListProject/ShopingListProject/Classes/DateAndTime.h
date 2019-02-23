//
//  DateAndTimeClass.h
//  ShopingListProject
//
//  Created by Admin on 2/23/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateAndTime : NSObject

+(NSString*)dateAndTimeWithFormat:(NSString*)format;
+(NSString*)dateAndTimeNow;

@end

NS_ASSUME_NONNULL_END

//
//  DateAndTimeClass.m
//  ShopingListProject
//
//  Created by Admin on 2/23/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

#import "DateAndTime.h"

@implementation DateAndTime
+(NSString*)dateAndTimeWithFormat:(NSString*)format{
    
    NSDateFormatter *formatter=[NSDateFormatter new];
    [formatter setDateFormat:format];
    NSString *ItemDate= [formatter stringFromDate:[NSDate date]];
    return ItemDate;
}

+ (NSString *)dateAndTimeNow{
    NSDateFormatter *formatter=[NSDateFormatter new];
    [formatter setDateFormat:@"dd-MM-yyyy HH:MM"];
    NSString *ItemDate= [formatter stringFromDate:[NSDate date]];
    return ItemDate;
}





@end

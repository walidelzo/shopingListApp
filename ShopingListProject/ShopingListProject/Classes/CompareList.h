//
//  CompareList.h
//  ShopingListProject
//
//  Created by Admin on 2/26/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompareList : NSObject
+(NSMutableArray<ShopingListsClass*> *)compare:(NSMutableArray<ShopingListsClass *> *)listA and:(NSMutableArray<ShopingListsClass *> *)listB;
@end

NS_ASSUME_NONNULL_END

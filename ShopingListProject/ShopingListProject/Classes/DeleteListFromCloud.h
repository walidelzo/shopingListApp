#import <Foundation/Foundation.h>
#import "AppData.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface DeleteListFromCloud : NSObject
+(void)DeleteFromCloud:(ShopingListsClass*)inpList;
@end

NS_ASSUME_NONNULL_END

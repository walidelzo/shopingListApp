#import <Foundation/Foundation.h>
#import "AppData.h"
@import Firebase;
NS_ASSUME_NONNULL_BEGIN

@interface SaveItemToCloud : NSObject
+(void)saveItemToCloudWithItem:(ItemClass *)inpItem andInpList:(ShopingListsClass*) inpList;


@end

NS_ASSUME_NONNULL_END

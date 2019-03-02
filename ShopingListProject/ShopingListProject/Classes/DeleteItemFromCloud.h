#import <Foundation/Foundation.h>
#import "AppData.h"
@import Firebase;
NS_ASSUME_NONNULL_BEGIN

@interface DeleteItemFromCloud : NSObject
+(void)deleteItem:(ItemClass*)inpItem inList:(ShopingListsClass*) inpList;

@end

NS_ASSUME_NONNULL_END

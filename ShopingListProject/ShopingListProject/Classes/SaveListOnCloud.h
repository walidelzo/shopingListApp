
#import <Foundation/Foundation.h>
#import "ShopingListsClass.h"
#import "AppData.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface SaveListOnCloud : NSObject
@property(nonatomic,retain)NSString *sharedInstance;

+(void)Save:(ShopingListsClass *)inpList;
@end

NS_ASSUME_NONNULL_END

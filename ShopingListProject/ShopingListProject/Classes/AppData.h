#import <Foundation/Foundation.h>
#import "ShopingListsClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
@property(nonatomic,retain)UserClass* curUser;
@property(nonatomic,retain)NSMutableArray<ShopingListsClass*> * curLST;
@property(nonatomic,retain)NSMutableArray <ShopingListsClass*> * offlineLST;

+(id)SharedManager;
@end

NS_ASSUME_NONNULL_END

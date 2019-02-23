#import <Foundation/Foundation.h>
#import "ShopingListsClass.h"
#import "DateAndTime.h"
@import Firebase;
NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
@property(nonatomic,retain)UserClass* curUser;
@property(nonatomic,retain)NSMutableArray<ShopingListsClass*> * curLST;
@property(nonatomic,retain)NSMutableArray <ShopingListsClass*> * offlineLST;
@property(nonatomic,retain)NSMutableArray<ShopingListsClass*> *onlineLST;
@property(nonatomic)FIRDatabaseReference *rootNode;
@property(nonatomic)FIRDatabaseReference *userNode;
@property(nonatomic)FIRDatabaseReference *dataNode;




+(id)SharedManager;
@end

NS_ASSUME_NONNULL_END

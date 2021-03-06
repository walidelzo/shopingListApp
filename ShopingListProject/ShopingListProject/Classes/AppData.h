#import <Foundation/Foundation.h>
#import "ShopingListsClass.h"
#import "DateAndTime.h"
#import "InvitationClass.h"
@import Firebase;
NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
@property(nonatomic,retain)UserClass* curUser;
@property(nonatomic,retain)NSMutableArray <ShopingListsClass*> * curLST;
@property(nonatomic,retain)NSMutableArray <ShopingListsClass*> * offlineLST;
@property(nonatomic,strong)NSMutableArray <ShopingListsClass*> * onlineLST;
@property(nonatomic,strong)NSMutableArray <ShopingListsClass*> * invitationLST;
@property(nonatomic,strong)NSMutableArray <InvitationClass*>   * invitationsCoords;
@property(nonatomic)FIRDatabaseReference *rootNode;
@property(nonatomic)FIRDatabaseReference *userNode;
@property(nonatomic)FIRDatabaseReference *dataNode;




+(id)SharedManager;
@end

NS_ASSUME_NONNULL_END

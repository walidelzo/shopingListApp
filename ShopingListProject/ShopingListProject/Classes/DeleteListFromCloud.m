#import "DeleteListFromCloud.h"
@implementation DeleteListFromCloud
+ (void)DeleteFromCloud:(ShopingListsClass *)inpList{
    
    if (FIRAuth.auth.currentUser.uid == nil)
        return;
    
    AppData *sharedInstance=[AppData SharedManager];
    FIRDatabaseReference *nodeToRemove;
    nodeToRemove =[[sharedInstance.dataNode child:inpList.listOwner.uid]child:inpList.listName];
    
    [nodeToRemove removeValue];
    
}
@end

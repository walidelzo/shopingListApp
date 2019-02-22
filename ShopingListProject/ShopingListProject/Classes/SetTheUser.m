#import "SetTheUser.h"
#import "WriteUserToDisk.h"
@implementation SetTheUser

+(void)setWithName:(NSString*)inpName AndEmail:(NSString*)inpEmail AndUid:(NSString*)inpUid{

    AppData *sharedInstance=[AppData SharedManager];
    
    UserClass *tempUser=[[UserClass alloc]initWithnName:inpName AndEmail:inpEmail AndUid:inpUid];
    
    for (ShopingListsClass *any in sharedInstance.curLST) {
        if (any.listOwner.uid==sharedInstance.curUser.uid){
            any.listOwner=tempUser;
        }
    }
    
    sharedInstance.curUser=tempUser;
    [WriteUserToDisk Write];
    
}

@end

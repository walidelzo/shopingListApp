#import "ReadInvitations.h"

@implementation ReadInvitations
+ (void)readCoordinates{
    
    AppData *sharedInstance=[AppData SharedManager];
    
    NSMutableArray *coordsReads =[NSMutableArray new];
    NSString *userId=FIRAuth.auth.currentUser.uid;

    [[sharedInstance.userNode child:userId]
     observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        //
        if ([snapshot hasChildren]){
        NSDictionary *resultInDic=snapshot.value;
        if ([resultInDic[@"invitations"] allValues ].count == 0){
            return ;
        }
        NSDictionary *dic=resultInDic[@"invitations"];
        
        for (NSDictionary *any in dic.allValues ) {
            
            NSString *thisListName=any[@"listName"];
            UserClass *thisUser=[[UserClass alloc]initWithnName:any[@"ListOwner"] AndEmail:any[@"email"] AndUid:any[@"uid"]];
           
            InvitationClass *getingInvitation= [[InvitationClass alloc]initWithListName:thisListName  andListOwner:thisUser];
            
            [coordsReads  addObject:getingInvitation];
            sharedInstance.invitationsCoords=coordsReads;
            
        }
        }
    }];
    
//    NSLog(@" --| coords is  |=====-> %@",sharedInstance.invitationLST[0].listOwner.name);

}
@end

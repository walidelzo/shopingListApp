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
            UserClass *thisUser=[[UserClass alloc]initWithnName:resultInDic[@"name"] AndEmail:any[@"email"] AndUid:any[@"uid"]];
           
            InvitationClass *getingInvitation= [[InvitationClass alloc]initWithListName:thisListName  andListOwner:thisUser];
            
            [coordsReads  addObject:getingInvitation];
            sharedInstance.invitationsCoords=coordsReads;
        }
        NSLog(@" --| coords is  |=====-> %li",sharedInstance.invitationsCoords.count);
        }
    }];
    

}
@end

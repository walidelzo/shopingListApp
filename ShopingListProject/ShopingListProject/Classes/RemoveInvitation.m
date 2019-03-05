#import "RemoveInvitation.h"

@implementation RemoveInvitation
+(void)RemoveWithInivitation:(InvitationClass *)inpInvitation
{
    if (FIRAuth.auth.currentUser==nil)
    {
        return;
    }
    AppData *sharedInstance=[AppData SharedManager];
    
    
    NSString *invitationTitle=[NSString stringWithFormat:@"%@|%@",inpInvitation.listOwner.uid,inpInvitation.listName];
    
    FIRDatabaseReference *invitationRef=[[[sharedInstance.userNode child:inpInvitation.listOwner.uid]child:@"invitations"]child:invitationTitle];
   
    [invitationRef removeValue];
    
}
@end

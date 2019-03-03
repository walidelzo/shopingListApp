#import "InvitationClass.h"

@implementation InvitationClass
- (id)initWithListName:(NSString *) inpListName andListOwner:(UserClass *) inpOwnerOfList{
    _listName=inpListName;
    _listOwner=inpOwnerOfList;
    return self;
}
@end

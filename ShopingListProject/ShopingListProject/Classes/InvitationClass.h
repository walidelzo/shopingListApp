
#import <Foundation/Foundation.h>
#import "UserClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface InvitationClass : NSObject

@property(nonatomic,retain) NSString * listName;
@property(nonatomic,retain) UserClass *listOwner;

-(id)initWithListName:(NSString*) inpListName andListOwner:(UserClass*) inpOwnerOfList;

@end

NS_ASSUME_NONNULL_END

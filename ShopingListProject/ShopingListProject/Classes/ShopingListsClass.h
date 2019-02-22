

#import <Foundation/Foundation.h>
#import"ItemClass.h"
#import "UserClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopingListsClass : NSObject<NSCoding>
@property(nonatomic,retain)NSString *listName;
@property(nonatomic,retain) UserClass* listOwner;
@property(nonatomic,retain) NSMutableArray <ItemClass*> * listItems;

-(id)initWithName:(NSString*)inpName
     AndlistOwner:(UserClass*)inpOwner
    AndSavedItems:(NSMutableArray<ItemClass*>*)inpItems;



@end

NS_ASSUME_NONNULL_END


#import "ShopingListsClass.h"

@implementation ShopingListsClass
- (id)initWithName:(NSString *)inpName
      AndlistOwner:(UserClass *)inpOwner
     AndSavedItems:(NSMutableArray<ItemClass *> *)inpItems{
    _listName=inpName;
    _listOwner=inpOwner;
    _listItems=inpItems;
    
    return self;
    
}
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_listName forKey:@"listName"];
    [aCoder encodeObject:_listOwner forKey:@"listOwner"];
    [aCoder encodeObject:_listItems forKey:@"items"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
   
    NSString* thisListName=[aDecoder decodeObjectForKey:@"listName"];
    UserClass* thisListOwner=[aDecoder decodeObjectForKey:@"listOwner"];
    NSMutableArray<ItemClass*>* thisListItems=[aDecoder decodeObjectForKey:@"items"];
    
    return [self initWithName:thisListName AndlistOwner:thisListOwner AndSavedItems:thisListItems];
}

@end

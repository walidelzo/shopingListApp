#import "ItemClass.h"

@implementation ItemClass

- (id)initWithName:(NSString *)inpName
       AnditemTime:(NSString *)inpTime
       AndItemPurchased:(BOOL)inpPurchased{
    
    _itemName=inpName;
    _itemTime=inpTime;
    _itemPuchased=inpPurchased;
    
    return self;

}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_itemName forKey:@"itemName"];
    [aCoder encodeObject:_itemTime forKey:@"itemTime"];
    [aCoder encodeBool:_itemPuchased forKey:@"itemPurchased"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    
    NSString* thisItemName=[aDecoder decodeObjectForKey:@"itemName"];
    NSString* thisItemTime=[aDecoder decodeObjectForKey:@"itemTime"];
    BOOL  thisItemPurchased =[aDecoder decodeBoolForKey:@"itemPurchased"];
    return [self initWithName:thisItemName AnditemTime:thisItemTime AndItemPurchased:thisItemPurchased];
}

@end

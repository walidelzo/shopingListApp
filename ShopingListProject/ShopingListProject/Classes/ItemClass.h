
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemClass : NSObject<NSCoding>
@property(nonatomic,retain) NSString* itemName;
@property(nonatomic,retain) NSString* itemTime;
@property(nonatomic)BOOL itemPuchased;

-(id)initWithName:(NSString*) inpName  AnditemTime:(NSString*)inpTime  AndItemPurchased : (BOOL)inpPurchased;


@end

NS_ASSUME_NONNULL_END

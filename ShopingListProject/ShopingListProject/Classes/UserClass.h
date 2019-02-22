
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserClass : NSObject <NSCoding>
@property(nonatomic,retain) NSString* name;
@property(nonatomic,retain) NSString* email;
@property(nonatomic,retain) NSString* uid;

-(id)initWithnName:(NSString*)inpName
          AndEmail:(NSString*)inpEmail
            AndUid:(NSString*)inpUid;


@end

NS_ASSUME_NONNULL_END

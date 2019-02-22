
#import "UserClass.h"

@implementation UserClass
- (id)initWithnName:(NSString *)inpName
           AndEmail:(NSString *)inpEmail
             AndUid:(NSString *)inpUid{
    _name=inpName;
    _email=inpEmail;
    _uid=inpUid;
    return self;
}
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    NSString* thisName=[aDecoder decodeObjectForKey:@"name"];
    NSString* thisEmail=[aDecoder decodeObjectForKey:@"email"];
    NSString*thisUid=[aDecoder decodeObjectForKey:@"uid"];
    
    return [self initWithnName:thisName AndEmail:thisEmail AndUid:thisUid];
}

@end

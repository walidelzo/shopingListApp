#import "AppData.h"

@implementation AppData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _curLST=[NSMutableArray new];
    }
    return self;
}

+(id)SharedManager
{
    static AppData *SharedManager=nil;
    static dispatch_once_t tokenOnce;
    dispatch_once(&tokenOnce ,^{
        SharedManager=[[self alloc] init];
    });
    
    
    
    return SharedManager;
}


@end

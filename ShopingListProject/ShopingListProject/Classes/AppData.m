#import "AppData.h"

@implementation AppData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _curLST=[NSMutableArray new];
        _onlineLST=[NSMutableArray new];
        [FIRApp configure];
        _rootNode=[[FIRDatabase database]reference];
        _userNode=[_rootNode child:@"Users"];
        _dataNode=[_rootNode child:@"Data"];
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

#import "WriteUserToDisk.h"

@implementation WriteUserToDisk
+(void)Write{
    
    AppData *sharedInstance=[AppData SharedManager];
    
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath=path[0];
    NSString *filePath=[NSString stringWithFormat:@"%@/user.plist",dirPath];

    [NSKeyedArchiver archiveRootObject:sharedInstance.curUser toFile:filePath];
    NSLog(@"write new user");
}
@end

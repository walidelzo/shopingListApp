#import "ReadUserFromDisk.h"

@implementation ReadUserFromDisk
+(void)read{
    AppData* sharedInstance=[AppData SharedManager];
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath=path[0];
    NSString *filePath=[NSString stringWithFormat:@"%@/user.plist",dirPath ];
    NSFileManager *fileManager=[NSFileManager defaultManager ];
    if ([fileManager fileExistsAtPath:filePath]){
        sharedInstance.curUser=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    
}
@end

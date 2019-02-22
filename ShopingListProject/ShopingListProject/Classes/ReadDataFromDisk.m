#import "ReadDataFromDisk.h"

@implementation ReadDataFromDisk
+(void)readData{
    
    AppData *sharedInstance=[AppData SharedManager];
    /////get the path
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath=path[0];
    NSString *filePath=[NSString stringWithFormat:@"%@/data.plist",dirPath];
    
    ////check if file exits
    NSFileManager *fileManger=[NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:filePath]){
        sharedInstance.offlineLST=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
    }
    
    
    
    
}
@end

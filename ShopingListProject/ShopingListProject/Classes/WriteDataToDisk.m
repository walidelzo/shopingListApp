#import "WriteDataToDisk.h"

@implementation WriteDataToDisk

+ (void)WriteData{
    
    AppData *sharedInstance=[AppData SharedManager];
    sharedInstance.offlineLST=[NSMutableArray new];
    
    for (ShopingListsClass* any in sharedInstance.curLST)
    {
        if (sharedInstance.curUser.uid == any.listOwner.uid){
            [sharedInstance.offlineLST addObject:any];
        }
    }
    ///write to disk
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dirPath=paths [0];
    NSString* filePath=[NSString stringWithFormat:@"%@/data.plist",dirPath];
    NSLog(@"Write New Data");
   // NSLog(@"%@",dirPath);
    [NSKeyedArchiver archiveRootObject:sharedInstance.offlineLST toFile:filePath];
    
}

@end

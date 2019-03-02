#import "SaveItemToCloud.h"

@implementation SaveItemToCloud

+ (void)saveItemToCloudWithItem:(ItemClass *)inpItem andInpList:(ShopingListsClass *)inpList{
    
    if (FIRAuth.auth.currentUser.uid == nil)
        return;
    
    NSString *itemPurchased=inpItem.itemPuchased ? @"True" : @"False";
    NSDictionary *itemDic=[[NSDictionary alloc]initWithObjectsAndKeys:inpItem.itemName ,@"Item name",itemPurchased,@"purchased",inpItem.itemTime,@"time", nil];
   
    AppData *sharedInstance=[AppData SharedManager];
  
    [[[[[sharedInstance.dataNode child:inpList.listOwner.uid]
       child:inpList.listName]
      child:@"listItems"]
     child:inpItem.itemName]
    setValue:itemDic];
    
    
    
}
@end

#import "SaveListOnCloud.h"
@implementation SaveListOnCloud
+ (void)Save:(ShopingListsClass *)inpList{
    
    if (FIRAuth.auth.currentUser==nil)
        return;
    
    NSString *listName=inpList.listName;
    
    NSMutableDictionary *listDic=[NSMutableDictionary new];
    
    [listDic setObject:listName forKey:@"listName"];
    
    NSDictionary *listOwner=[[NSDictionary alloc]initWithObjectsAndKeys:inpList.listOwner.name,@"userName",
                             inpList.listOwner.email,@"Email",
                             inpList.listOwner.uid,@"uid", nil];
    
    
    [listDic setObject:listOwner forKey:@"listUser"];
    NSMutableDictionary *items=[NSMutableDictionary new];
    for (ItemClass *any in inpList.listItems){
        
        NSString *itemIsPurchased=any.itemPuchased ?@"True" : @"False";
        
        NSMutableDictionary *newItemAsADictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:any.itemName,@"item Name",itemIsPurchased,@"purchased",any.itemTime,@"time", nil];
        [items setObject:newItemAsADictionary forKey:any.itemName];
    }
    
    [listDic setObject:items forKey:@"listItems"];
    
    
    AppData *sharedInstance=[AppData SharedManager];


    [[[sharedInstance.dataNode child:sharedInstance.curUser.uid]
      child:inpList.listName ]setValue:listDic];
    //NSLog(@"%@",listDic);
}
@end

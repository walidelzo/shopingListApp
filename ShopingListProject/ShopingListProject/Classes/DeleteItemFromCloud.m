//
//  DeleteItemFromCloud.m
//  ShopingListProject
//
//  Created by Admin on 3/1/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

#import "DeleteItemFromCloud.h"

@implementation DeleteItemFromCloud
+ (void)deleteItem:(ItemClass *)inpItem inList:(ShopingListsClass *)inpList{
    
    if (FIRAuth.auth.currentUser.uid == nil)
        return;
    AppData *sharedInstance=[AppData SharedManager];
    
  FIRDatabaseReference*  itemNode=[[[[sharedInstance.dataNode child:sharedInstance.curUser.uid]child:inpList.listName]child:@"listItems"]child:inpItem.itemName];
    [itemNode removeValue];
    
    
}
@end

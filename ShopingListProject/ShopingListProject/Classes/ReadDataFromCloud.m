#import "ReadDataFromCloud.h"

@implementation ReadDataFromCloud

+ (void)read{
    AppData* sharedInstance=[AppData SharedManager];
    
    
    NSMutableArray *onlineList=[NSMutableArray new];
    NSString*userId= FIRAuth.auth.currentUser.uid;
    [[sharedInstance.dataNode child:userId] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *lists=snapshot.value;
        //NSLog(@"=====   %@",lists.allValues);
        
        if (lists !=nil){
            for (NSDictionary *any in lists.allValues)
            {
                NSString*listName=[any objectForKey:@"listName"];
                
                NSDictionary *listOwner=[any objectForKey:@"listUser"];
                
                UserClass *onlineUser=[[UserClass alloc]initWithnName:listOwner[@"userName"] AndEmail:listOwner[@"Email"] AndUid:listOwner[@"uid"]];
                
                NSMutableArray <ItemClass*> *listitems=[NSMutableArray new];
                if (any[@"listItems"]!=nil){
                    NSMutableDictionary *thisListItems=any[@"listItems"];
                    
                    for (NSDictionary *eachItem in thisListItems.allValues){
                        
                        NSDictionary *item=eachItem;
                        NSString*readItemName=item[@"item Name"];
                        NSString*itemPurchasedS=item[@"purchased"];
                        NSString*itemTime=item[@"time"];
                        
                        bool itemPurchased=false;
                        if ([itemPurchasedS isEqualToString:@"True"] || [itemPurchasedS isEqualToString:@"true"]){
                            itemPurchased=true;
                        }
                        
                        ItemClass *itemCollected=[[ItemClass alloc]initWithName:readItemName AnditemTime:itemTime AndItemPurchased:itemPurchased];
                        
                        [listitems addObject:itemCollected];
                    }
                    
                }
                ShopingListsClass *thisList=[[ShopingListsClass alloc]initWithName:listName AndlistOwner:onlineUser AndSavedItems:listitems];
                
                [onlineList addObject:thisList];
               // NSLog(@"%@",thisList.listName);
                sharedInstance.onlineLST=onlineList;

                
            }
        }
    }];



}
@end

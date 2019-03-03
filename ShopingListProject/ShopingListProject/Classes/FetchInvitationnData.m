#import "FetchInvitationnData.h"

@implementation FetchInvitationnData

+ (void)FetchInvitationList{
    
    AppData *sharedInstance=[AppData SharedManager];
    NSMutableArray *fetchedArr=[NSMutableArray new];
    
    for (InvitationClass *anyCoords in sharedInstance.invitationsCoords) {
        
        [[sharedInstance.dataNode child:anyCoords.listOwner.uid]observeEventType:FIRDataEventTypeValue andPreviousSiblingKeyWithBlock:^(FIRDataSnapshot * _Nonnull snapshot, NSString * _Nullable prevKey) {
            //
            if (snapshot.hasChildren){
                NSDictionary* Fetchedlists=snapshot.value;
                for (NSDictionary *onelist in Fetchedlists.allValues) {
                    if (anyCoords.listName == onelist[@"listName"] ){
                        // NSLog(@"%@",onelist[@"listItems"]);
                        NSMutableArray *itemsFetched=[NSMutableArray new];
                        for (NSDictionary *item  in [onelist[@"listItems"] allValues]) {
                            
                            
                            BOOL itemPurchased;
                            if([item[@"purchased"] isEqualToString: @"True"]){
                                itemPurchased =true;
                            }else{
                                itemPurchased=false;
                            }
                            
                            ItemClass *itemsToObjects=[[ItemClass alloc]initWithName:item[@"item Name"] AnditemTime:item[@"time"] AndItemPurchased:itemPurchased];
                            
                            [itemsFetched addObject:itemsToObjects];
                        }
                        ShopingListsClass *thisList=[[ShopingListsClass alloc]initWithName:anyCoords.listName AndlistOwner:anyCoords.listOwner AndSavedItems:itemsFetched];
                        [fetchedArr addObject:thisList];
                        sharedInstance.invitationLST =fetchedArr;
                    }
                }
            }
        }];
    }
    
    
}

@end

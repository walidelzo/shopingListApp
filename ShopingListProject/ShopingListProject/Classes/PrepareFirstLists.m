#import "PrepareFirstLists.h"
//make tow lists list1 milk , bread and list2 pen , paper
@implementation PrepareFirstLists

+(void)prepare{
    
    AppData *SharedInstance=[AppData SharedManager];
    //make date formmatter
    NSString*ItemDate= [DateAndTime dateAndTimeNow];

    ///make item
    ItemClass *sampleItem=[[ItemClass alloc]
                      initWithName:@"test item"
                      AnditemTime:ItemDate
                      AndItemPurchased:NO];
    
//add all items in array lists
    NSMutableArray *items1=[[NSMutableArray alloc]initWithObjects:sampleItem, nil];
    
    ShopingListsClass *list1=[[ShopingListsClass alloc]initWithName:@"Sample List " AndlistOwner:SharedInstance.curUser AndSavedItems:items1];
    
    [SharedInstance.curLST addObject:list1];
    
}
@end

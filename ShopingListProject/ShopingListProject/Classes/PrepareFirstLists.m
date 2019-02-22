#import "PrepareFirstLists.h"
//make tow lists list1 milk , bread and list2 pen , paper
@implementation PrepareFirstLists

+(void)prepare{
    
    AppData *SharedInstance=[AppData SharedManager];
    //make date formmatter
    NSDateFormatter *formatter=[NSDateFormatter new];
    [formatter setDateFormat:@"dd-dd-yyyy HH:MM"];
    NSString *ItemDate= [formatter stringFromDate:[NSDate date]];
    
    ///make item
    ItemClass *item1=[[ItemClass alloc]
                      initWithName:@"Milk"
                      AnditemTime:ItemDate
                      AndItemPurchased:YES];
    
    ItemClass *item2=[[ItemClass alloc]
                      initWithName:@"Bread"
                      AnditemTime:ItemDate
                      AndItemPurchased:NO];
    //the office items
    ItemClass *item4=[[ItemClass alloc]
                      initWithName:@"Pens"
                      AnditemTime:ItemDate
                      AndItemPurchased:YES];
    ItemClass *item5=[[ItemClass alloc]
                                       initWithName:@"Paper"
                                        AnditemTime:ItemDate
                                   AndItemPurchased:NO];
    
//add all items in array lists
    NSMutableArray *items1=[[NSMutableArray alloc]initWithObjects:item1,item2, nil];
    NSMutableArray *items2=[[NSMutableArray alloc]initWithObjects:item4,item5,nil];
    
    ShopingListsClass *list1=[[ShopingListsClass alloc]initWithName:@"Ketchen List " AndlistOwner:SharedInstance.curUser AndSavedItems:items1];
    
    ShopingListsClass *list2=[[ShopingListsClass alloc]initWithName:@"Office List" AndlistOwner:SharedInstance.curUser AndSavedItems:items2];
    
    [SharedInstance.curLST addObject:list1];
    [SharedInstance.curLST addObject:list2];
    
}
@end

#import "CompareList.h"
@implementation CompareList


+(NSMutableArray<ShopingListsClass*> *)compare:(NSMutableArray<ShopingListsClass *> *)listA and:(NSMutableArray<ShopingListsClass *> *)listB
{
    NSMutableArray<ShopingListsClass *>* combinedLists = [NSMutableArray new];
    
    for (ShopingListsClass *a in listA)
    {
        BOOL aIsUnique = true;
        for (ShopingListsClass *anyList in listB)
        {
            if ( [a.listName isEqualToString: anyList.listName])
                aIsUnique = false;
        }
        if ( aIsUnique )
            [combinedLists addObject: a];
    }
    
    for (ShopingListsClass *b in listB)
    {
        BOOL bIsUnique = true;
        for (ShopingListsClass *anyList in listA)
        {
            if ( [b.listName isEqualToString: anyList.listName])
                bIsUnique = false;
        }
        if ( bIsUnique )
            [combinedLists addObject: b];
    }
    
    // now remove the unique and added from each of the two lists
    for (ShopingListsClass* any in combinedLists)
    {
        if ([listA containsObject: any])
            [listA removeObject: any];
        else if ([listB containsObject: any])
            [listB removeObject: any];
    }
    
    // this is comparing twi lists with the same name
    for (ShopingListsClass* anyListA in listA)
    {
        NSMutableArray<ItemClass *> * thisListResultItems = [NSMutableArray new];
        ShopingListsClass * counterPartList;
        
        for (ShopingListsClass * anyListB in listB)
        {
            if ([anyListB.listName isEqualToString: anyListA.listName])
            {
                counterPartList = anyListB;
                break;
            }
        }
        for (ItemClass * anyItem in anyListA.listItems)
        {
            BOOL thisItemWasFound = false;
            
            for (ItemClass * counterItem in counterPartList.listItems)
            {
                if ( [anyItem.itemName isEqualToString: counterItem.itemName])
                {
                    thisItemWasFound = true;
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
                    
                    NSDate* readTimeAnyItem = [formatter dateFromString:anyItem.itemTime];
                    NSDate* readTimeCounterItem = [formatter dateFromString:counterItem.itemTime];
                    
                    if (readTimeAnyItem > readTimeCounterItem)
                    {
                        [thisListResultItems addObject:anyItem];
                    }
                    else
                    {
                        [thisListResultItems addObject: counterItem];
                    }
                }
            }
            // if we reached here and the item wasn't found
            if ( thisItemWasFound == false)
            {
                [thisListResultItems addObject:anyItem];
            }
        }
        
        
        for (ItemClass* anyCounterItem in counterPartList.listItems)
        {
            BOOL thisItemIsAreadyAdded = false;
            for (ItemClass* anyItem in anyListA.listItems)
            {
                if ( [anyCounterItem.itemName isEqualToString: anyItem.itemName])
                    thisItemIsAreadyAdded = true;
            }
            if (thisItemIsAreadyAdded == false)
                [thisListResultItems addObject: anyCounterItem];
        }
        
        ShopingListsClass* resList = [[ShopingListsClass alloc]
                                      initWithName:anyListA.listName AndlistOwner:anyListA.listOwner AndSavedItems:thisListResultItems];
                                      
        [combinedLists addObject: resList];
    }
    
    return combinedLists;




}
@end

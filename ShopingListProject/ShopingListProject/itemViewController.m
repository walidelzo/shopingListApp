#import "itemViewController.h"

@interface itemViewController ()

@end

@implementation itemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedInstance =[AppData SharedManager];
    _nameOfList.text=_sharedInstance.curLST[_curLSTInt].listName;
    _textField.returnKeyType=UIReturnKeyDone;
    _textField.delegate=self;

}

#pragma mark - textFeild Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString*timeNow=[DateAndTime dateAndTimeNow];
    
    ItemClass *newItem=[[ItemClass alloc]initWithName:_textField.text AnditemTime:timeNow AndItemPurchased:NO];
    [_sharedInstance.curLST[_curLSTInt].listItems addObject:newItem];
    [WriteDataToDisk WriteData];
    [_itemTableView reloadData];
    _textField.text=@"";
    
}






- (IBAction)shareBtnAction:(UIButton *)sender {
}

#pragma mark - uitable view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sharedInstance.curLST[_curLSTInt].listItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"itemCell"];

    ItemClass *itemToCell=_sharedInstance.curLST[_curLSTInt].listItems[indexPath.row];
    cell.textLabel.text=itemToCell.itemName;
    if (itemToCell.itemPuchased)
    {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        cell.textLabel.font=[UIFont systemFontOfSize:18];
        cell.backgroundColor=[UIColor darkGrayColor];
        cell.textLabel.textColor=[UIColor lightGrayColor];
        //add attribute to cell 
        NSMutableAttributedString *attr=[[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
        [attr addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, cell.textLabel.text.length)];
        cell.textLabel.attributedText=attr;
    }
    else
    {
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.textLabel.font=[UIFont systemFontOfSize:20];
        cell.backgroundColor=[UIColor lightGrayColor];
        cell.textLabel.textColor=[UIColor blackColor];
        //remove attribute String from cell
        NSMutableAttributedString *attr=[[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
        [attr addAttribute:NSStrikethroughStyleAttributeName value:@0 range:NSMakeRange(0, cell.textLabel.text.length)];
        cell.textLabel.attributedText=attr;
        
        
    }
    
    
    
    return cell;
    
}

#pragma  mark - select uitableViewItems

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //change item purchased status
    _sharedInstance.curLST[_curLSTInt].listItems[indexPath.row].itemPuchased=!_sharedInstance.curLST[_curLSTInt].listItems[indexPath.row].itemPuchased;
    
    /// update date and time to item
    NSString* timeNow=[DateAndTime dateAndTimeNow];
    
    _sharedInstance.curLST[_curLSTInt].listItems[indexPath.row].itemTime=timeNow;
    
    ///write date to disk
    [_itemTableView reloadData];
    [WriteDataToDisk WriteData];
    
    
}

#pragma mark - Edit UITableView Cells
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete this item?";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemClass *itemToRemove=_sharedInstance.curLST[_curLSTInt].listItems[indexPath.row];
    [_sharedInstance.curLST[_curLSTInt].listItems removeObject:itemToRemove];
    [_itemTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [WriteDataToDisk WriteData];
    
    
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    
}
@end

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
    
    if (![textField.text isEqualToString:@""])
    {NSString*timeNow=[DateAndTime dateAndTimeNow];
        
        ItemClass *newItem=[[ItemClass alloc]initWithName:_textField.text AnditemTime:timeNow AndItemPurchased:NO];
        [_sharedInstance.curLST[_curLSTInt].listItems addObject:newItem];
        [WriteDataToDisk WriteData];
        [_itemTableView reloadData];
        [SaveItemToCloud saveItemToCloudWithItem:newItem andInpList:_sharedInstance.curLST[_curLSTInt]];
        
        _textField.text=@"";
        
    }
    
}






- (IBAction)shareBtnAction:(UIButton *)sender

{
    if (FIRAuth.auth.currentUser.uid==nil)
    {
        [self showAlertWithTitle:@"login error" AndBody:@"you Must Login before share list"];
        return;
    }
    
    UIAlertController *sharAlert=[UIAlertController alertControllerWithTitle:@"share" message:@"to share this list please Enter Email Address " preferredStyle:UIAlertControllerStyleAlert ];
    
    [sharAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Enter Email Address";
        textField.font=[UIFont systemFontOfSize:22];
        textField.keyboardType  = UIKeyboardTypeEmailAddress;
        
    }];
    
    [sharAlert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                          //here code to share list with email address
                                            if ([sharAlert.textFields[0].text isEqualToString:@""])
                                            {
                                                [self showAlertWithTitle:@"Empty Field" AndBody:@"Please Enter the emai address"];
                                            }
                                            else
                                            {
                                            [self inviteUserWithEmail:sharAlert.textFields[0].text];
                                            }
                                        
                                        }] ];
    
    [sharAlert addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:sharAlert animated:YES completion:nil];
    
}

#pragma mark - helper Mothed
-(void)inviteUserWithEmail:(NSString*)inpEmail{
    
    __block UserClass *ownerUser=_sharedInstance.curLST[_curLSTInt].listOwner;
    __block UserClass *inviteeUser;/// we will search in nodes to get it
    NSString*listName= _sharedInstance.curLST[_curLSTInt].listName;
    
    [_sharedInstance.userNode observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        NSDictionary *AllUsers =[[NSDictionary alloc]init];
        
            AllUsers=snapshot.value;
      
        for (NSDictionary * any in AllUsers.allValues) {
            
            if ([any[@"email"] isEqualToString:inpEmail ] ){
                
                inviteeUser=[[UserClass alloc]initWithnName:[any objectForKey:@"name"]
                                                   AndEmail:[any objectForKey:@"email"]
                                                     AndUid:[any objectForKey:@"uiid"]];
                break;
            }
        }
        ///here we did not found any email equal inpEmail
        if (inviteeUser == nil){
            [self showAlertWithTitle:@"Non user found" AndBody:@"please try another Email Address"];
            return ;
        }
        
        NSString *inivitationTitle=[NSString stringWithFormat:@"%@|%@",ownerUser.uid ,listName];
        
        NSDictionary *inviteeDic=[[NSDictionary alloc]initWithObjectsAndKeys:
                                  listName,@"listName",
                                  inviteeUser.email,@"email",
                                  inviteeUser.uid,@"uid", nil];
       
        FIRDatabaseReference *invitationNode=[[[self.sharedInstance.userNode
                                          child:inviteeUser.uid]
                                          child:@"invitations"]
                                          child:inivitationTitle];
        
        [invitationNode setValue:inviteeDic];
        
    }];
    [self showAlertWithTitle:@"success" AndBody:@"your Invitation sent successfully"];
    
    
    
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
    
    //save item purchased state to cloud
    ShopingListsClass *thisList=_sharedInstance.curLST[_curLSTInt];
    ItemClass *thisItem=thisList.listItems[indexPath.row];
    [SaveItemToCloud saveItemToCloudWithItem:thisItem andInpList:thisList];
    
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
    //delete item from cloud
    [DeleteItemFromCloud deleteItem:itemToRemove inList:_sharedInstance.curLST[_curLSTInt]];
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark - alert methods
//make alert message with parameter
- (void)showAlertWithTitle:(NSString *)inpTitle AndBody:(NSString *)body{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:inpTitle
                                                                 message:body
                                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}



@end

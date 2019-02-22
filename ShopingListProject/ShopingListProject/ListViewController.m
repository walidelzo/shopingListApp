#import "ListViewController.h"
#import "Classes/WritePlist.h"
@interface ListViewController ()

@end

@implementation ListViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_listTableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sharedInstance=[AppData SharedManager];
      [self readData];
}

#pragma - :mark  button actions

- (IBAction)newListBtnAction:(UIButton *)sender
{

    UIAlertController *alert=[UIAlertController
                              alertControllerWithTitle:@"Add new List "
                              message:@"please enter list name"
                              preferredStyle:UIAlertControllerStyleAlert];
    
   [ alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder=@"List name" ;
       textField.font=[UIFont systemFontOfSize:20];
       textField.textAlignment=NSTextAlignmentCenter;
        
   }];
    
    UIAlertAction *action=[UIAlertAction
                           actionWithTitle:@"OK"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action)
                           {
                               if (![alert.textFields[0].text isEqualToString:@""]){
                                   [self addNewList: alert.textFields[0].text];}
                           }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)offlineBtnAction:(UIButton *)sender
{

}

#pragma mark helper Method
-(void)addNewList:(NSString*)listName{
    ShopingListsClass *newList=[[ShopingListsClass alloc]initWithName:listName AndlistOwner:_sharedInstance.curUser AndSavedItems:[NSMutableArray new ]];
    [_sharedInstance.curLST addObject:newList];
    [_listTableView reloadData];
    [WriteDataToDisk WriteData];
    
    
}


-(void)readData{
  
    [ReadUserFromDisk read];
    if (_sharedInstance.curUser!=nil)
    {
       // NSLog(@"old data");
        [ReadDataFromDisk readData];
        _sharedInstance.curLST=_sharedInstance.offlineLST;
      //  NSLog(@"new  data  of user.....%@",_sharedInstance.curUser.name);

    }else{
       // NSLog(@"default data .....");
        _sharedInstance.curUser =[[UserClass alloc]initWithnName:@"ME" AndEmail:@"defEmail" AndUid:@"defUid"];
        [PrepareFirstLists prepare];
        [WriteUserToDisk Write];
        [WriteDataToDisk WriteData];
    }
    
}



#pragma mark  -   tableView_DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@"%lu",_sharedInstance.curLST.count);
    return _sharedInstance.curLST.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"listCell"
                                                          forIndexPath:indexPath];
    cell.textLabel.text=_sharedInstance.curLST[indexPath.row].listName;
    cell.detailTextLabel.text=[NSString stringWithFormat: @"%lu items for %@",
                               _sharedInstance.curLST[indexPath.row].listItems.count,
                               _sharedInstance.curUser.name
                               
                               ];
    return cell;
}


#pragma  mark - edit TableView Elements
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Delete this list?";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopingListsClass *listToDelete=_sharedInstance.curLST[indexPath.row];
    [_sharedInstance.curLST removeObject:listToDelete];
    [WriteDataToDisk WriteData];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma  mark - tableView select cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toItems_Segue" sender:indexPath];
}

#pragma  mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  //  if ([segue.destinationViewController isKindOfClass:[itemViewController class]]){
    itemViewController *itemVC=segue.destinationViewController;
        NSIndexPath *indexPath=sender;
        itemVC.curLSTInt=indexPath.row;
    //}
}

@end

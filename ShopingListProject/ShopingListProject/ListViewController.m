#import "ListViewController.h"
#import "Classes/WritePlist.h"
@interface ListViewController ()

@end

@implementation ListViewController


#pragma mark - view method

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_listTableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sharedInstance=[AppData SharedManager];
      [self readData];
    [self testFirebase];
}





#pragma mark  - button actions

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
    [self showProfileAlert];
}

#pragma mark - helper Method
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


#pragma  mark - Firebase Methods

-(void)testFirebase{
    
    /*  [[FIRAuth auth]createUserWithEmail:@"walidelzo" password:@"qaws@123" completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
     if (error != nil){
     
     [self showAlertWithTitle:@"test firebase" AndBody:@"you have connected to firebase susccesfully.." ];
     }
     }]; */
    
    NSMutableDictionary *dicToTest=[NSMutableDictionary new];
    [dicToTest setObject:@"test value" forKey:@"test Key"];
    [[_sharedInstance.rootNode child:@"test"]setValue:dicToTest];
    
}

-(void)registerUserWithName:(NSString*)inpName  AndEmail:(NSString*)inpEmail AndPassWord:(NSString*)inpPassword{
    //create email registration with firebase auth
    [FIRAuth.auth createUserWithEmail:inpEmail password:inpPassword completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error==nil)
        {
            return ;
        }
        //change name profile with name input
        FIRUserProfileChangeRequest *changeRequest=[FIRAuth.auth currentUser].profileChangeRequest ;
        changeRequest.displayName=inpName;
        [changeRequest commitChangesWithCompletion:^(NSError * _Nullable profileError) {
            if (profileError==nil)
                return ;
        }];
        
    }];
    
    
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

                                    //////profile alert action

-(void)showProfileAlert{
    UIAlertController *alert=[UIAlertController
                              alertControllerWithTitle:@"Profile"
                              message:@"What do you want to do?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *signUpAction=[UIAlertAction actionWithTitle:@"Sign Up"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self registerAlert];
                                                           
                                                       }];
    
    [alert addAction:signUpAction];
    
    UIAlertAction *loginAction=[UIAlertAction actionWithTitle:@"log in"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        //code here
    }];
    
    [alert addAction:loginAction];
    
    UIAlertAction *logOutAction =[UIAlertAction actionWithTitle:@"log Out"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
        //code here
    }];
    
    [alert addAction:logOutAction];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

                ///register alert
-(void)registerAlert{
    UIAlertController *registerAlert=[UIAlertController alertControllerWithTitle:@"Register view"
                                                                         message:@"please fill this date to register." preferredStyle:UIAlertControllerStyleAlert ];
    [registerAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"User name";
        textField.font=[UIFont systemFontOfSize:20];
        
    }];
    
    [registerAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Email";
        textField.font=[UIFont systemFontOfSize:20];
        textField.keyboardType=UIKeyboardTypeEmailAddress;
    }];
    
    [registerAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"Password";
        textField.secureTextEntry=true;
        textField.font=[UIFont systemFontOfSize:20];
        
    } ];
    
    [registerAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"confirm Password";
        textField.secureTextEntry=true;
        textField.font=[UIFont systemFontOfSize:20];
        
    } ];
    
    
    [registerAlert addAction:[UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([registerAlert.textFields[0].text isEqualToString:@""] ||
            [registerAlert.textFields[1].text isEqualToString:@""] ||
            [registerAlert.textFields[2].text isEqualToString:@""] ||
            [registerAlert.textFields[3].text isEqualToString:@""]
            ){
            [self showAlertWithTitle:@"emtpy fields" AndBody:@"please fill empty Fields"];
            
        }else if (![registerAlert.textFields[2].text isEqualToString:registerAlert.textFields[3].text])
        
        {
            [self showAlertWithTitle:@"password alert" AndBody:@"password and Confirm password not Equal"];
        }else {
            
            [self registerUserWithName:registerAlert.textFields[0].text
                              AndEmail:registerAlert.textFields[1].text
                           AndPassWord:registerAlert.textFields[2].text];

            
            
            
        }

        
        
        
   
    
    }] ];
    
    [registerAlert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil] ];
    
    [self presentViewController:registerAlert animated:YES completion:nil];
    
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

#pragma  mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  //  if ([segue.destinationViewController isKindOfClass:[itemViewController class]]){
    itemViewController *itemVC=segue.destinationViewController;
        NSIndexPath *indexPath=sender;
        itemVC.curLSTInt=indexPath.row;
    //}
}

@end

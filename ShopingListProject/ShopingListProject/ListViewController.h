#import <UIKit/UIKit.h>
#import "Classes/AppData.h"
#import "Classes/PrepareFirstLists.h"
#import "Classes/ReadUserFromDisk.h"
#import "Classes/ReadDataFromDisk.h"
#import "Classes/WriteUserToDisk.h"
#import "Classes/WriteDataToDisk.h"
#import "itemViewController.h"
#import "Classes/SetTheUser.h"
#import "Classes/SaveListOnCloud.h"
@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

//our outlets
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;

//our Actions
- (IBAction)newListBtnAction:(UIButton *)sender;
- (IBAction)offlineBtnAction:(UIButton *)sender;

@property(nonatomic,retain)AppData *sharedInstance;
-(void)showAlertWithTitle:(NSString*)inpTitle AndBody:(NSString*) body;
@end


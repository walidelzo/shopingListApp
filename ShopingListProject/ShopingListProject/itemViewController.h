#import <UIKit/UIKit.h>
#import "Classes/AppData.h"
#import "Classes/WriteDataToDisk.h"
#import "Classes/SaveItemToCloud.h"
#import "Classes/DeleteItemFromCloud.h"
NS_ASSUME_NONNULL_BEGIN

@interface itemViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameOfList;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *itemTableView;
- (IBAction)shareBtnAction:(UIButton *)sender;
@property(nonatomic)NSInteger curLSTInt;
@property (nonatomic,retain)AppData *sharedInstance;
- (IBAction)backAction:(UIButton *)sender;



@end

NS_ASSUME_NONNULL_END

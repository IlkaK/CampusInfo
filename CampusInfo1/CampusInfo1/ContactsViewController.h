//
//  ContactsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController<UITableViewDelegate>
{

    IBOutlet UITableView        *_contactsTable;
    IBOutlet UITableViewCell    *_contactsOverviewTableCell;
    IBOutlet UITableViewCell    *_contactsPhoneTableCell;
    IBOutlet UITableViewCell    *_contactsPlaceTableCell;
    IBOutlet UITableViewCell    *_contactsSocialMediaTableCell;
    
    NSString                    *_currentEmail;
    NSString                    *_currentPhoneNumber;
    
    IBOutlet UILabel            *_titleLabel;
    IBOutlet UIButton           *_backButton;
    IBOutlet UILabel            *_backLabel;
}

@property (nonatomic, retain) IBOutlet UITableView          *_contactsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsOverviewTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPhoneTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPlaceTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsSocialMediaTableCell;

@property (nonatomic, retain) NSString                      *_currentEmail;
@property (nonatomic, retain) NSString                      *_currentPhoneNumber;

@property (nonatomic, retain) IBOutlet UILabel              *_titleLabel;
@property (nonatomic, retain) IBOutlet UIButton             *_backButton;
@property (nonatomic, retain) IBOutlet UILabel              *_backLabel;

- (IBAction)moveBackToContactsOverview:(id)sender;

@end

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
    IBOutlet UITableViewCell    *_contactsPhoneTableCell;
    IBOutlet UITableViewCell    *_contactsPlaceTableCell;
    
    NSString                    *_currentEmail;
    NSString                    *_currentPhoneNumber;
    
    IBOutlet UINavigationBar    *_titleNavigationBar;
    IBOutlet UINavigationItem   *_titleNavigationItem;
    IBOutlet UILabel            *_titleNavigationLabel;
}

@property (nonatomic, retain) IBOutlet UITableView          *_contactsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPhoneTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPlaceTableCell;

@property (nonatomic, retain) NSString                      *_currentEmail;
@property (nonatomic, retain) NSString                      *_currentPhoneNumber;

@property (nonatomic, retain) IBOutlet UINavigationBar      *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem     *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel              *_titleNavigationLabel;

@end

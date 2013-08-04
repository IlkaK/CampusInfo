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

    IBOutlet UINavigationItem   *_backToSettingsNavigationItem;
    IBOutlet UITableView        *_contactsTable;
    IBOutlet UITableViewCell    *_contactsOverviewTableCell;
    IBOutlet UITableViewCell    *_contactsPhoneTableCell;
    IBOutlet UITableViewCell    *_contactsPlaceTableCell;
}

@property (nonatomic, retain) IBOutlet UINavigationItem     *_backToSettingsNavigationItem;
@property (nonatomic, retain) IBOutlet UITableView          *_contactsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsOverviewTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPhoneTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_contactsPlaceTableCell;

@end

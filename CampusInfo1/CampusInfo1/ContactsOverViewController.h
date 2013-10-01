//
//  ContactsOverViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.08.13.
//
//

#import <UIKit/UIKit.h>
#import "ContactsViewController.h"
#import "EmergencyViewController.h"
#import "ServiceDeskViewController.h"
#import "ColorSelection.h"

@interface ContactsOverViewController : UIViewController<UITableViewDelegate>
{
    IBOutlet ContactsViewController     *_contactsVC;
    IBOutlet EmergencyViewController    *_emergencyVC;
    IBOutlet ServiceDeskViewController  *_serviceDeskVC;
    
    IBOutlet UITableView                *_menuTableView;
    IBOutlet UITableViewCell            *_menuTableCell;
    
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;

    ColorSelection                      *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet ContactsViewController       *_contactsVC;
@property (nonatomic, retain) IBOutlet EmergencyViewController      *_emergencyVC;
@property (nonatomic, retain) IBOutlet ServiceDeskViewController    *_serviceDeskVC;

@property (nonatomic, retain) IBOutlet UITableView                  *_menuTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_menuTableCell;

@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@end

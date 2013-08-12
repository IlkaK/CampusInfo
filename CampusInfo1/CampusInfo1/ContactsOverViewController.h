//
//  ContactsOverViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.08.13.
//
//

#import <UIKit/UIKit.h>
#import <ContactsViewController.h>
#import <EmergencyViewController.h>


@interface ContactsOverViewController : UIViewController
{

    IBOutlet UILabel                    *_titleLabel;

    IBOutlet ContactsViewController     *_contactsVC;
    IBOutlet EmergencyViewController    *_emergencyVC;
}

@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;

@property (nonatomic, retain) IBOutlet ContactsViewController       *_contactsVC;
@property (nonatomic, retain) IBOutlet EmergencyViewController      *_emergencyVC;

- (IBAction)moveToSecretaryContacts:(id)sender;

- (IBAction)moveToEmergencyContacts:(id)sender;

@end

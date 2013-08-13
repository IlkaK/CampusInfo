//
//  ContactsOverViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.08.13.
//
//

#import "ContactsOverViewController.h"

@interface ContactsOverViewController ()

@end

@implementation ContactsOverViewController
@synthesize _titleLabel;
@synthesize _contactsVC;
@synthesize _emergencyVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];

    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    if (_contactsVC == nil)
    {
		_contactsVC = [[ContactsViewController alloc] init];
	}
    _contactsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_emergencyVC == nil)
    {
		_emergencyVC = [[EmergencyViewController alloc] init];
	}
    _emergencyVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _titleLabel = nil;
    _contactsVC = nil;
    _emergencyVC = nil;
    [super viewDidUnload];
}
- (IBAction)moveToSecretaryContacts:(id)sender
{
    [self presentModalViewController:_contactsVC animated:YES];
}

- (IBAction)moveToEmergencyContacts:(id)sender
{
    [self presentModalViewController:_emergencyVC animated:YES];
}

- (IBAction)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

@end

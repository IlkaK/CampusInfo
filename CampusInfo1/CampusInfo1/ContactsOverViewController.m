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

@synthesize _menuTableView;
@synthesize _menuTableCell;


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
    _menuTableView = nil;
    _menuTableCell = nil;
    [super viewDidUnload];
}


- (IBAction)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}


//---------- Handling of menu table -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
    {
        return 1;
	}
	else
    {
		return 1;
	}
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    if (_cellSelection == 0)
    {
        [self presentModalViewController:_contactsVC animated:YES];
    }
    else
    {
        [self presentModalViewController:_emergencyVC animated:YES];
    }
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellSelection = indexPath.section; //indexPath.section;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
   // [_menuButton addTarget:self action:@selector(moveToSecretaryContacts1  :event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (_cellSelection == 0)
    {
        cell.textLabel.text = @"Sekretariat";
        
        //NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:@"Sekretariat"];
        //[_menuButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        //[_menuButton addTarget:self action:@selector(moveToSecretaryContacts  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell.textLabel.text = @"Notfall";
        //NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:@"Notfall"];
        //[_menuButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        //[_menuButton addTarget:self action:@selector(moveToEmergencyContacts  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
     
        
    return cell;
}







@end

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

@synthesize _contactsVC;
@synthesize _emergencyVC;
@synthesize _serviceDeskVC;

@synthesize _menuTableView;
@synthesize _menuTableCell;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
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
    
    if (_serviceDeskVC == nil)
    {
		_serviceDeskVC = [[ServiceDeskViewController alloc] init];
	}
    _serviceDeskVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = @"Kontakte";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_backgroundColor set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_backgroundColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _contactsVC = nil;
    _emergencyVC = nil;
    _menuTableView = nil;
    _menuTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _serviceDeskVC = nil;
    [super viewDidUnload];
}


- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}


//---------- Handling of menu table -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
    if (_cellSelection == 1)
    {
        [self presentModalViewController:_emergencyVC animated:YES];
    }
    if (_cellSelection == 2)
    {
        [self presentModalViewController:_serviceDeskVC animated:YES];
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
        cell.textLabel.text = @"Sekretariate";
        
        //NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:@"Sekretariat"];
        //[_menuButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        //[_menuButton addTarget:self action:@selector(moveToSecretaryContacts  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_cellSelection == 1)
    {
        cell.textLabel.text = @"Notfall";
        //NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:@"Notfall"];
        //[_menuButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        //[_menuButton addTarget:self action:@selector(moveToEmergencyContacts  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_cellSelection == 2)
    {
        cell.textLabel.text = @"Service Desk";
    }
        
    return cell;
}


@end

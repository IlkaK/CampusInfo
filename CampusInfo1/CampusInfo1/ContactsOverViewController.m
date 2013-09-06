//
//  ContactsOverViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.08.13.
//
//

#import "ContactsOverViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

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
    
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = ContactsOverVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    
    
    // set view controllers
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
    
    if (_cellSelection == 0)
    {
        cell.textLabel.text = ContactsVCTitle;
    }
    if (_cellSelection == 1)
    {
        cell.textLabel.text = EmergencyVCTitle;
    }
    if (_cellSelection == 2)
    {
        cell.textLabel.text = ServiceDeskVCTitle;
    }
        
    return cell;
}


@end

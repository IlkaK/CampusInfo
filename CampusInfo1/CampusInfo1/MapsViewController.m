//
//  MapsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import "MapsViewController.h"

@interface MapsViewController ()

@end

@implementation MapsViewController
@synthesize _titleLabel;
@synthesize _technikumVC;
@synthesize _zurichVC;
@synthesize _menuTableView;

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
    
    if (_zurichVC == nil)
    {
		_zurichVC = [[ZurichViewController alloc] init];
	}
    _zurichVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_technikumVC == nil)
    {
		_technikumVC = [[TechnikumViewController alloc] init];
	}
    _technikumVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveBackToMenuOverview:(id)sender
{
   [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)moveToZurichMap:(id)sender
{
    [self presentModalViewController:_zurichVC animated:YES];
}

- (IBAction)moveToTechnikumMap:(id)sender
{
    [self presentModalViewController:_technikumVC animated:YES];
}

- (void)viewDidUnload
{
    _titleLabel = nil;
    _technikumVC = nil;
    _zurichVC = nil;
    _menuTableView = nil;
    [super viewDidUnload];
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
        [self presentModalViewController:_technikumVC animated:YES];
    }
    else
    {
        [self presentModalViewController:_zurichVC animated:YES];
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
        cell.textLabel.text = @"Winterthur, Technikum";
    }
    else
    {
        cell.textLabel.text = @"Zürich, Lagerstrasse";
    }
    return cell;
}


@end

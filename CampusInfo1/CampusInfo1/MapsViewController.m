//
//  MapsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import "MapsViewController.h"
#import "ColorSelection.h"

@interface MapsViewController ()

@end

@implementation MapsViewController


@synthesize _technikumVC;
@synthesize _zurichVC;

@synthesize _menuTableView;

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
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
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
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"Standorte";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveBackToMenuOverview:(id)sender
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
    _technikumVC = nil;
    _zurichVC = nil;
    
    _menuTableView = nil;
    
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    
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

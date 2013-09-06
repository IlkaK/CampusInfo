//
//  MapsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import "MapsViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface MapsViewController ()

@end

@implementation MapsViewController

@synthesize _technikumVC;

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
    
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];

    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = MapsVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];

    
    // view controller
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

- (void)moveBackToMenuOverview:(id)sender
{
   [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    _technikumVC = nil;
    
    _menuTableView = nil;
    
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    
    [super viewDidUnload];
}


//---------- Handling of menu table -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;    
    
    if (_cellSelection == 0)
    {
        _technikumVC._description   = TechnikumVCTitle;
        _technikumVC._fileName      = TechnikumVCFileName;
        _technikumVC._fileFormat    = TechnikumVCFileFormat;
        [self presentModalViewController:_technikumVC animated:YES];
    }
    
    if (_cellSelection == 1)
    {
        _technikumVC._description   = ZurichVCTitle;
        _technikumVC._fileName      = ZurichVCFileName;
        _technikumVC._fileFormat    = ZurichVCFileFormat;
        [self presentModalViewController:_technikumVC animated:YES];
    }
    
    if (_cellSelection == 2)
    {
        _technikumVC._description   = ToessfeldVCTitle;
        _technikumVC._fileName      = ToessfeldVCFileName;
        _technikumVC._fileFormat    = ToessfeldVCFileFormat;
        [self presentModalViewController:_technikumVC animated:YES];
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellSelection = indexPath.section; 
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }    
    if (_cellSelection == 0)
    {
        cell.textLabel.text = MapsVCTechnikum;
    }
    if (_cellSelection == 1)
    {
        cell.textLabel.text = MapsVCZurich;
    }
    if (_cellSelection == 2)
    {
        cell.textLabel.text = MapsVCToessfeld;
    }

    return cell;
}


@end

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
@synthesize _technikumButton;
@synthesize _technikumVC;
@synthesize _zurichButton;
@synthesize _zurichVC;

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
    
    [_zurichButton useAlertStyle];
    [_technikumButton useAlertStyle];
    
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

- (void)viewDidUnload {
    _technikumButton = nil;
    _zurichButton = nil;
    _titleLabel = nil;
    _technikumVC = nil;
    _zurichVC = nil;
    [super viewDidUnload];
}

@end

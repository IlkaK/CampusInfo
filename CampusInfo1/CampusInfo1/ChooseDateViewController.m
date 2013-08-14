//
//  ChooseDateViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import "ChooseDateViewController.h"

@interface ChooseDateViewController ()

@end

@implementation ChooseDateViewController

@synthesize _titleLabel;

@synthesize _cancelButton;
@synthesize _todayButton;
@synthesize _doneButton;

@synthesize _actualDate;
@synthesize _datePicker;

@synthesize _chooseDateViewDelegate;

@synthesize _waitForChangeActivityIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}


- (IBAction)cancelDateChoice:(id)sender
{
        [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)acceptDateChoice:(id)sender
{
    if([self._chooseDateViewDelegate respondsToSelector:@selector(setActualDate:)])
    {
        [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
        
        [self._chooseDateViewDelegate setActualDate:_datePicker.date];
        
        [_waitForChangeActivityIndicator stopAnimating];
        _waitForChangeActivityIndicator.hidden = YES;
        
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)setPickerToToday:(id)sender
{
    [_datePicker setDate:[NSDate date]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_todayButton useAlertStyle];
    [_cancelButton useAlertStyle];
    [_doneButton useAlertStyle];
    
    if (_actualDate == nil)
    {
        [_datePicker setDate:[NSDate date]];
    }
    else
    {
        [_datePicker setDate:_actualDate];
    }
    
    // set default values for spinner/activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    _datePicker = nil;
    _todayButton = nil;
    _titleLabel = nil;
    _cancelButton = nil;
    _doneButton = nil;
    _waitForChangeActivityIndicator = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_datePicker setDate:_actualDate];    
}

@end

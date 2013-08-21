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

@synthesize _actualDate;
@synthesize _datePicker;

@synthesize _chooseDateViewDelegate;

@synthesize _waitForChangeActivityIndicator;
@synthesize _chooseDateSegmentedControl;


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

- (IBAction)moveToChooseDateSegmentedControl:(id)sender
{
    // cancel
    if(_chooseDateSegmentedControl.selectedSegmentIndex == 0)
    {
        [_chooseDateSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
        [self dismissModalViewControllerAnimated:YES];
    }
    // today
    if(_chooseDateSegmentedControl.selectedSegmentIndex == 1)
    {
         [_datePicker setDate:[NSDate date]];
    }
    // done
    if(_chooseDateSegmentedControl.selectedSegmentIndex == 2)
    {
        if([self._chooseDateViewDelegate respondsToSelector:@selector(setActualDate:)])
        {
            [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
            
            [self._chooseDateViewDelegate setActualDate:_datePicker.date];
            
            [_waitForChangeActivityIndicator stopAnimating];
            _waitForChangeActivityIndicator.hidden = YES;
            
            [_chooseDateSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
            
            
            [self dismissModalViewControllerAnimated:YES];
        }
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
    _titleLabel = nil;
    _waitForChangeActivityIndicator = nil;
    _chooseDateSegmentedControl = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_datePicker setDate:_actualDate];    
}


@end

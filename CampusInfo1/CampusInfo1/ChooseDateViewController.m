//
//  ChooseDateViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import "ChooseDateViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface ChooseDateViewController ()

@end

@implementation ChooseDateViewController

@synthesize _actualDate;
@synthesize _datePicker;

@synthesize _chooseDateViewDelegate;

@synthesize _waitForChangeActivityIndicator;
@synthesize _chooseDateSegmentedControl;

@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationBar;


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


- (void)moveBackToTimeTable:(id)sender
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

- (IBAction)datePickerChanged:(id)sender
{
     [_chooseDateSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

- (IBAction)setPickerToToday:(id)sender
{
    [_datePicker setDate:[NSDate date]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    // set title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToTimeTable:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"Datum wählen";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];

    
    // set activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
    
    // segmented controls
    [_chooseDateSegmentedControl setTintColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_chooseDateSegmentedControl];
    
    // set date picker
    if (_actualDate == nil)
    {
        [_datePicker setDate:[NSDate date]];
    }
    else
    {
        [_datePicker setDate:_actualDate];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    _datePicker = nil;
    _waitForChangeActivityIndicator = nil;
    _chooseDateSegmentedControl = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_datePicker setDate:_actualDate];    
}


@end

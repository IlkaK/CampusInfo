/*
 ChooseDateViewDelegate.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ChooseDateViewDelegate.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of ChooseDateViewDelegate.xib, which shows the date picker to choose a date. </li>
 *      <li> Handling date change. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called either from TimeTableOverviewController or MensaDetailViewController. They both pass the actual chosen date and receive the new date back from it. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends the chosen date back via function setActualDate. </li>
 *      <li> The delegate is passed back to TimeTableOverviewController or MensaDetailViewController depending on the caller. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

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
@synthesize _segmentedControlNavigationBAr;

@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationBar;

/*!
 * @function initWithNibName
 * Initializiation of class.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

/*!
 * @function threadWaitForLoadingActivityIndicator
 * Thread is called to start the activity indicator while waiting for data to be downloaded.
 */
- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}

/*!
 @function cancelDateChoice
 Triggered, when the chosen date is canceled.
 @param sender
 */
- (IBAction)cancelDateChoice:(id)sender
{
        [self dismissModalViewControllerAnimated:YES];
}

/*!
 @function moveBackToTimeTable
 Function is called, when back button on navigation bar is hit, to move back to caller view.
 @param sender
 */
- (void)moveBackToTimeTable:(id)sender
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

/*!
 @function acceptDateChoice
 Triggered, when the chosen date is accepted.
 @param sender
 */
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

/*!
 @function moveToChooseDateSegmentedControl
 Controls the segmented control buttons to cancel or confirm the date or move to actual date (today).
 @param sender
 */
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

/*!
 @function datePickerChanged
 Triggered, when the date in picker is changed by the user.
 @param sender
 */
- (IBAction)datePickerChanged:(id)sender
{
     [_chooseDateSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

/*!
 @function setPickerToToday
 Moves date to actual date (today).
 @param sender
 */
- (IBAction)setPickerToToday:(id)sender
{
    [_datePicker setDate:[NSDate date]];
    
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    // set title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToTimeTable:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = ChooseDateVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];

    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    // set activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    //[_waitForChangeActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
    
    // segmented controls
    [_chooseDateSegmentedControl setTintColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_chooseDateSegmentedControl];
    [_segmentedControlNavigationBAr setTintColor:_zhawColor._zhawDarkerBlue];
    
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

/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidUnload
{
    _datePicker = nil;
    _waitForChangeActivityIndicator = nil;
    _chooseDateSegmentedControl = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _segmentedControlNavigationBAr = nil;
    [super viewDidUnload];
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [_datePicker setDate:_actualDate];    
}

@end

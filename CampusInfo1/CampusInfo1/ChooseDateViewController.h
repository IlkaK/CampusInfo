/*
 ChooseDateViewDelegate.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ChooseDateViewDelegate.h
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

#import <UIKit/UIKit.h>

@protocol ChooseDateViewDelegate <NSObject>

-(void) setActualDate:(NSDate *)newDate;
@end

@interface ChooseDateViewController : UIViewController
{
    /*! @var _actualDate Holds the actual chosen date */
    NSDate                              *_actualDate;
    /*! @var _datePicker Shows and chooses the possible dates */
    IBOutlet UIDatePicker               *_datePicker;
    
    /*! @var _chooseDateViewDelegate Holds the id of the view delegate */
    id                                  _chooseDateViewDelegate;
    
    /*! @var _chooseDateSegmentedControl Has three buttons to confirm or cancel the chosen date or to switch back to the actual day */
    IBOutlet UISegmentedControl         *_chooseDateSegmentedControl;
    /*! @var _segmentedControlNavigationBAr Used as background for the segmented control */
    IBOutlet UINavigationBar            *_segmentedControlNavigationBAr;
    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;

    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to TimeTableOverviewController or MensaDetailViewController */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel                    *_titleNavigationLabel;
}


@property (nonatomic, retain) IBOutlet UINavigationBar          *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem         *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                  *_titleNavigationLabel;

@property (nonatomic, retain) NSDate                            *_actualDate;
@property (nonatomic, retain) IBOutlet UIDatePicker             *_datePicker;

@property (nonatomic, retain) id<ChooseDateViewDelegate>        _chooseDateViewDelegate;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *_waitForChangeActivityIndicator;
@property (nonatomic, retain) IBOutlet UISegmentedControl       *_chooseDateSegmentedControl;
@property (nonatomic, retain) IBOutlet UINavigationBar          *_segmentedControlNavigationBAr;

/*!
 @function setPickerToToday
 Moves date to actual date (today).
 @param sender
 */
- (IBAction)setPickerToToday:(id)sender;

/*!
 @function cancelDateChoice
 Triggered, when the chosen date is canceled.
 @param sender
 */
- (IBAction)cancelDateChoice:(id)sender;

/*!
 @function acceptDateChoice
 Triggered, when the chosen date is accepted.
 @param sender
 */
- (IBAction)acceptDateChoice:(id)sender;

/*!
 @function moveToChooseDateSegmentedControl
 Controls the segmented control buttons to cancel or confirm the date or move to actual date (today).
 @param sender
 */
- (IBAction)moveToChooseDateSegmentedControl:(id)sender;

/*!
 @function datePickerChanged
 Triggered, when the date in picker is changed by the user.
 @param sender
 */
- (IBAction)datePickerChanged:(id)sender;

@end

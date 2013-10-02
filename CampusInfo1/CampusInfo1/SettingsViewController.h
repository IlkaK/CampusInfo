/*
 SettingsViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SettingsViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of SettingsViewController.xib, which shows the setting view, where an acronym for the time table can be stored. </li>
 *      <li> Handling storage of a consistent acronym for the time table functionality. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called either form MenuOverviewController or TimeTableOverviewController. But none passes any data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It stores the chosen acronym in NSNotificationCenter. </li>
 *      <li> The delegate is passed back to TimeTableOverviewController or MenuOverviewController depending on the caller. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "Autocomplete.h"
#import "LanguageTranslation.h"
#import "StudentsDto.h"
#import "LecturersDto.h"
#import "ColorSelection.h"

@protocol SettingsViewDelegate <NSObject>

@end

@interface SettingsViewController : UIViewController<UITextFieldDelegate>
{
    /*! @var _acronymTextField Shows and stores the searched acronym */
    IBOutlet UITextField                    *_acronymTextField;
    /*! @var _acronymAutocompleteTableView Shows all suggestions for given text in _acronymTextField */
    IBOutlet UITableView                    *_acronymAutocompleteTableView;
    
    /*! @var _timetableSettingsTitle Shows the settings time table title */
    IBOutlet UILabel                        *_timetableSettingsTitle;
    /*! @var _timetableSettingsDescriptionLabel Shows the settings time table description */
    IBOutlet UILabel                        *_timetableSettingsDescriptionLabel;
    
    /*!  @var _suggestions Holds all actual suggestions for acronyms, which are displayed in _acronymAutocompleteTableView */
    NSMutableArray                          *_suggestions;
    /*! @var _autocomplete Handling the autocomplete functionality */
    Autocomplete                            *_autocomplete;
    /*! @var _students Handling the connection to class StudentsDto, which is used to get all student acronyms */
    StudentsDto                             *_students;
    /*! @var _lecturers Handling the connection to class LecturersDto, which is used to get all lecturer acronyms */
    LecturersDto                            *_lecturers;
    
    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar                *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to MenuOverviewController or TimeTableOverviewController */
    IBOutlet UINavigationItem               *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel                        *_titleNavigationLabel;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                          *_zhawColor;
}


@property (nonatomic, retain) IBOutlet UITextField                  *_acronymTextField;
@property (nonatomic, retain) IBOutlet UITableView                  *_acronymAutocompleteTableView;
@property (nonatomic, retain) IBOutlet UILabel                      *_timetableSettingsTitle;
@property (nonatomic, retain) IBOutlet UILabel                      *_timetableSettingsDescriptionLabel;

@property (strong, nonatomic) NSMutableArray                        *_suggestions;
@property (strong, nonatomic) Autocomplete                          *_autocomplete;
@property (nonatomic, retain) StudentsDto                           *_students;
@property (nonatomic, retain) LecturersDto                          *_lecturers;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) ColorSelection                        *_zhawColor;

/*!
 @function acronymTextFieldChanged
 Triggered, when the text in _acronymTextField is changed by the user. Then the table for suggestions needs to be updated accordingly.
 @param sender
 */
- (IBAction)acronymTextFieldChanged:(id)sender;
/*!
 @function moveBackToMenuOverview
 Returns the delegate back to TimeTableOverviewController or MenuOverviewController depending on the caller.
 @param sender
 */
- (IBAction)moveBackToMenuOverview:(id)sender;

@end

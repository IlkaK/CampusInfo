/*	
    SearchViewController.h
    ZHAW Engineering CampusInfo
 */

/*!
 * @header SearchViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul> 
 *      <li> Control of SearchView.xib, which shows the search view for the time table </li>
 *      <li> Triggering and handling search for acronym of students, lecturers, courses, rooms, classes </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>  
 *      <li> This class is called from TimeTableOverviewController, which does not send any data to SearchViewController. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data (when the back button is hit):
 *   <ul>
 *      <li> the searched acronym and acronym type are stored in NSNotificationCenter </li>
 *      <li> the delegate is passed back to TimeTableOverviewController, which then can access the NSNotificationCenter to get the data. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */


#import <UIKit/UIKit.h>
#import "Autocomplete.h"
#import "TimeTableAsyncRequest.h"
#import "DBCachingForAutocomplete.h"

#import "StudentsDto.h"
#import "LecturersDto.h"
#import "CoursesDto.h"
#import "RoomsDto.h"
#import "ClassesDto.h"

#import "ColorSelection.h"



@interface SearchViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    /*! @var _searchTextField Shows and stores the searched acronym */
    IBOutlet UITextField            *_searchTextField;

    /*! @var _chooseSearchType Shows and chooses the acronym types */
    IBOutlet UIPickerView           *_chooseSearchType;
    /*! @var _searchTypeArray Stores all possible acronym types */
    NSArray                         *_searchTypeArray;
    /*! @var _searchType Stores the acronym type, which is chosen in the picker view */
    NSString                        *_searchType;
    
    /*! @var _acronymAutocompleteTableView Shows all suggestions for given text in _searchTextField */
    IBOutlet UITableView            *_acronymAutocompleteTableView;
    
    /*! @var _searchSegmentedControl Has two buttons to confirm or cancel the chosen acronym */
    IBOutlet UISegmentedControl     *_searchSegmentedControl;
    /*! @var _segmentedControlNavigationBar Used as background for the segmented control */
    IBOutlet UINavigationBar        *_segmentedControlNavigationBar;
    
    /*!  @var _suggestions Holds all actual suggestions for acronyms, which are displayed in _acronymAutocompleteTableView */
    NSMutableArray                  *_suggestions;
    /*! @var _autocomplete Handling the autocomplete functionality */
    Autocomplete                    *_autocomplete;
    
    /*! @var _students Handling the connection to class StudentsDto, which is used to get all student acronyms */
    StudentsDto                     *_students;
    /*! @var _lecturers Handling the connection to class LecturersDto, which is used to get all lecturer acronyms */
    LecturersDto                    *_lecturers;
    /*! @var _courses Handling the connection to class CoursesDto, which is used to get all course acronyms */
    CoursesDto                      *_courses;
    /*! @var _rooms Handling the connection to class RoomsDto, which is used to get all room acronyms */
    RoomsDto                        *_rooms;
    /*! @var _classes Handling the connection to class ClassesDto, which is used to get all class acronyms */
    ClassesDto                      *_classes;
    
    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar        *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to TimeTableOverviewController */
    IBOutlet UINavigationItem       *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel                *_titleNavigationLabel;

    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView *_waitForChangeActivityIndicator;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                   *_zhawColor;
}

@property (nonatomic, retain) IBOutlet UITextField                  *_searchTextField;
@property (nonatomic, retain) IBOutlet UIPickerView                 *_chooseSearchType;
@property (nonatomic, retain) IBOutlet UITableView                  *_acronymAutocompleteTableView;

@property (nonatomic, retain) IBOutlet UISegmentedControl           *_searchSegmentedControl;
@property (nonatomic, retain) IBOutlet UINavigationBar              *_segmentedControlNavigationBar;

@property (nonatomic, retain) NSString                              *_searchType;
@property (strong, nonatomic) NSArray                               *_searchTypeArray;

@property (strong, nonatomic) NSMutableArray                        *_suggestions;
@property (strong, nonatomic) Autocomplete                          *_autocomplete;

@property (strong, nonatomic) StudentsDto                           *_students;
@property (strong, nonatomic) LecturersDto                          *_lecturers;
@property (strong, nonatomic) CoursesDto                            *_courses;
@property (strong, nonatomic) RoomsDto                              *_rooms;
@property (strong, nonatomic) ClassesDto                            *_classes;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForChangeActivityIndicator;

@property (strong, nonatomic) ColorSelection                        *_zhawColor;


/*!
 @function searchTextFieldChanged
 Triggered, when the text in _searchTextField is changed by the user. Then the table for suggestions needs to be updated accordingly.
 @param sender
 */
- (IBAction)searchTextFieldChanged:(id)sender;

/*!
 @function moveToSearchSegmentedControl
 Controls the segmented control buttons to cancel or confirm the searched acronym.
 @param sender
 */
- (IBAction)moveToSearchSegmentedControl:(id)sender;

@end

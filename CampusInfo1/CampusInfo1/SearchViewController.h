//
//  SecondViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Autocomplete.h>
#import <TimeTableAsyncRequest.h>
#import <DBCachingForAutocomplete.h>

#import <StudentsDto.h>
#import <LecturersDto.h>
#import <CoursesDto.h>
#import <RoomsDto.h>
#import <ClassesDto.h>


@interface SearchViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    
    IBOutlet UITextField            *_searchTextField;

    IBOutlet UIPickerView           *_chooseSearchType;
    NSArray                         *_searchTypeArray;
    NSString                        *_searchType;
    
    IBOutlet UITableView            *_acronymAutocompleteTableView;
    
    IBOutlet UISegmentedControl     *_searchSegmentedControl;
    IBOutlet UINavigationBar        *_segmentedControlNavigationBar;
    
    NSMutableArray                  *_suggestions;
    Autocomplete                    *_autocomplete;
    
    StudentsDto                     *_students;
    LecturersDto                    *_lecturers;
    CoursesDto                      *_courses;
    RoomsDto                        *_rooms;
    ClassesDto                      *_classes;
    
    IBOutlet UINavigationBar        *_titleNavigationBar;
    IBOutlet UINavigationItem       *_titleNavigationItem;
    IBOutlet UILabel                *_titleNavigationLabel;
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


- (IBAction)searchTextFieldChanged:(id)sender;

- (IBAction)moveToSearchSegmentedControl:(id)sender;

@end

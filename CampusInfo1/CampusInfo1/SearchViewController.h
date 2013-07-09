//
//  SecondViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>
#import <Autocomplete.h>
#import <TimeTableAsyncRequest.h>
#import <DBCachingForAutocomplete.h>
#import <LanguageTranslation.h>

@interface SearchViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,TimeTableAsyncRequestDelegate>{
    
    IBOutlet UITextField  *_searchTextField;

    IBOutlet UIPickerView *_chooseSearchType;
    NSArray               *_searchTypeArray;
    NSString              *_searchType;
    
    IBOutlet GradientButton *_searchButton;
    
    IBOutlet UITableView    *_acronymAutocompleteTableView;
    
    NSMutableArray  *_suggestions;
    Autocomplete	*_autocomplete;
    
    NSMutableArray *_lecturerArray;
    NSMutableArray *_lecturerArrayFromDB;
    NSMutableArray *_roomArray;
    NSMutableArray *_roomArrayFromDB;
    NSMutableArray *_classArray;
    NSMutableArray *_classArrayFromDB;
    NSMutableArray *_courseArray;
    NSMutableArray *_courseArrayFromDB;
    NSMutableArray *_studentArray;
    NSMutableArray *_studentArrayFromDB;
    
    NSDictionary *_generalDictionary;
    
    // gain timetable data from url
    TimeTableAsyncRequest *_asyncTimeTableRequest;
    
    // holding data gained from url
    NSData                *_dataFromUrl;
    
    NSString              *_errorMessage;
    
    int _connectionTrials;

    DBCachingForAutocomplete *_dbCachingForAutocomplete;
    
    LanguageTranslation *_translator;
}

@property (nonatomic, retain) IBOutlet UITextField *_searchTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *_chooseSearchType;
@property (nonatomic, retain) IBOutlet GradientButton *_searchButton;
@property (nonatomic, retain) IBOutlet UITableView *_acronymAutocompleteTableView;

@property (nonatomic, retain) NSString *_searchType;
@property (strong, nonatomic) NSArray *_searchTypeArray;

@property (strong, nonatomic) NSMutableArray *_suggestions;
@property (strong, nonatomic) Autocomplete *_autocomplete;

@property (strong, nonatomic) NSMutableArray *_lecturerArray;
@property (strong, nonatomic) NSMutableArray *_lecturerArrayFromDB;
@property (strong, nonatomic) NSMutableArray *_roomArray;
@property (strong, nonatomic) NSMutableArray *_roomArrayFromDB;
@property (strong, nonatomic) NSMutableArray *_classArray;
@property (strong, nonatomic) NSMutableArray *_classArrayFromDB;
@property (strong, nonatomic) NSMutableArray *_courseArray;
@property (strong, nonatomic) NSMutableArray *_courseArrayFromDB;
@property (strong, nonatomic) NSMutableArray *_studentArray;
@property (strong, nonatomic) NSMutableArray *_studentArrayFromDB;


@property (strong, nonatomic) NSDictionary *_generalDictionary;

@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                         *_dataFromUrl;

@property (nonatomic, retain) NSString                       *_errorMessage;

@property (nonatomic, assign) int                             _connectionTrials;

@property (nonatomic, retain) DBCachingForAutocomplete *_dbCachingForAutocomplete;

@property (nonatomic, retain) LanguageTranslation            *_translator;


// Button to start searching
- (IBAction)_startSearch:(id)sender;
- (IBAction)searchTextFieldChanged:(id)sender;

@end

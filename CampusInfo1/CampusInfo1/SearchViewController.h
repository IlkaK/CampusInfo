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

@interface SearchViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,TimeTableAsyncRequestDelegate> {
    
    IBOutlet UITextField  *_searchTextField;

    IBOutlet UIPickerView *_chooseSearchType;
    NSArray               *_searchTypeArray;
    NSString              *_searchType;
    
    IBOutlet GradientButton *_searchButton;
    
    IBOutlet UITableView    *_acronymAutocompleteTableView;
    
    NSMutableArray  *_suggestions;
    Autocomplete	*_autocomplete;
    
    NSMutableArray *_courseArray;
    NSMutableArray *_lecturerArray;
    NSMutableArray *_studentArray;  
    NSMutableArray *_roomArray;
    NSMutableArray *_classArray;
    
    // gain timetable data from url
    TimeTableAsyncRequest *_asyncTimeTableRequest;
    
    // holding data gained from url
    NSData                *_dataFromUrl;
    
    NSString              *_errorMessage;
    
    int _connectionTrials;
}

@property (nonatomic, retain) IBOutlet UITextField *_searchTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *_chooseSearchType;
@property (nonatomic, retain) IBOutlet GradientButton *_searchButton;
@property (nonatomic, retain) IBOutlet UITableView *_acronymAutocompleteTableView;

@property (nonatomic, retain) NSString *_searchType;
@property (strong, nonatomic) NSArray *_searchTypeArray;

@property (strong, nonatomic) NSMutableArray *_suggestions;
@property (strong, nonatomic) Autocomplete *_autocomplete;

@property (strong, nonatomic) NSMutableArray *_courseArray;
@property (strong, nonatomic) NSMutableArray *_lecturerArray;
@property (strong, nonatomic) NSMutableArray *_studentArray; 
@property (strong, nonatomic) NSMutableArray *_roomArray;
@property (strong, nonatomic) NSMutableArray *_classArray;

@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                         *_dataFromUrl;

@property (nonatomic, retain) NSString                       *_errorMessage;

@property (nonatomic, assign) int                             _connectionTrials;

// Button to start searching
- (IBAction)_startSearch:(id)sender;
- (IBAction)searchTextFieldChanged:(id)sender;

@end

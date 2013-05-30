//
//  SecondViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>

@interface SearchViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate> {
    
    IBOutlet UITextField *_searchTextField;

    IBOutlet UIPickerView *_chooseSearchType;
    NSArray               *_searchTypeArray;
    NSString              *_searchType;
    
    IBOutlet GradientButton *_searchButton;
}

@property (nonatomic, retain) IBOutlet UITextField *_searchTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *_chooseSearchType;
@property (nonatomic, retain) IBOutlet GradientButton *_searchButton;

@property (nonatomic, retain) NSString *_searchType;
@property (strong, nonatomic) NSArray *_searchTypeArray;


// Button to start searching
- (IBAction)_startSearch:(id)sender;

@end

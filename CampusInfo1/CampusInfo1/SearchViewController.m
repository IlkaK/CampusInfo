//
//  SearchViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"


@implementation SearchViewController

@synthesize _chooseSearchType;
@synthesize _searchTextField;
@synthesize _searchTypeArray;
@synthesize _searchType;
@synthesize _searchButton;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];    
    self._searchTypeArray = [[NSArray alloc] initWithObjects:
                         @"Kurs", @"Dozent", @"Student",
                         @"Raum", @"Klasse", nil];
    _searchType = @"Dozent";
    [_chooseSearchType selectRow:1 inComponent:0 animated:NO];
    self._searchTextField.delegate = self;
    [_searchButton useAlertStyle];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    _searchTextField = nil;
    _chooseSearchType = nil;
    _searchButton = nil;
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



// methods for Picker for types
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  // course, room, class, teacher, student
    return 1;
}

- (NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // course, room, class, teacher, student
    return [_searchTypeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self._searchTypeArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    //NSLog(@"%@",[_searchTypeArray objectAtIndex:row]);
    _searchType = [_searchTypeArray objectAtIndex:row];
}


// handling the search button
- (IBAction)_startSearch:(id)sender
{
    if (_searchTextField.text == nil || [_searchTextField.text length] == 0)
    {
        UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                          initWithTitle:@"Suche"
                                          message:@"Bitte ein Kürzel eingeben."
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
        
        [_acronymAlertView show];
    }
    else
    {

        // trim space in front of and after the string
        NSString *_stringWithoutSpaces = [_searchTextField.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchType" object:_searchType];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchText" object:_stringWithoutSpaces];
    
        self.tabBarController.selectedIndex = 0;
        [self dismissModalViewControllerAnimated:YES];
    }
}


@end

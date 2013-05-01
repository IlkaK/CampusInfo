//
//  AcronymViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AcronymViewController.h"


@implementation AcronymViewController
@synthesize _acronymTextField;
@synthesize _acronymViewDelegate;
@synthesize _acronymNavigationItem;
@synthesize _warningLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (NSString *)getAcronymType:(NSString *)_newAcronym
{
    // student : 8 digits, only letters and numbers
    // lecturer: 3-5 digits, only letters
    
    NSString       *_localType = @"empty";
    NSCharacterSet * alphabecticalSet          = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
    NSCharacterSet * alphabecticalAndNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890"] invertedSet];
    
    if ([_newAcronym length] == 8)
    {
        if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalAndNumberSet] isEqualToString: _newAcronym])
        {
            _localType = @"student";
        }      
        
    }    
    else 
    {
        if ([_newAcronym length] >= 3 && [_newAcronym length] <= 5)
        {
            
            if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalSet] isEqualToString: _newAcronym])
            {
                _localType = @"lecturer";
            }      
        }
    }
    return _localType;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}



- (void) backToTimeTableOverview:(id)sender 
{
    NSString *_localAcronym = _acronymTextField.text;
    NSString *_localType    = [self getAcronymType:_localAcronym];
   
    if ([_localType compare: @"empty" ] != NSOrderedSame)
    {
        _warningLabel.text = @"";
        if([self._acronymViewDelegate respondsToSelector:@selector(setAcronymLabel:)])
        {
            [self._acronymViewDelegate setAcronymLabel:_acronymTextField.text];
        }
        [self dismissModalViewControllerAnimated:YES];
    }
    else 
    {
        _warningLabel.text = @"Nur Kürzel von Studenten und Dozenten sind möglich.";
    }
}






#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    _acronymTextField.text                = [_acronymUserDefaults stringForKey:@"TimeTableAcronym"];    
    
    
    UIImage         *_leftButtonImage = [UIImage imageNamed:@"arrowLeft_small.png"];
    UIBarButtonItem *_leftButton      = [[UIBarButtonItem alloc] initWithImage: _leftButtonImage
                                                                         style:UIBarButtonItemStylePlain 
                                                                        target:self 
                                                                        action:@selector(backToTimeTableOverview:)];  
    
    [_acronymNavigationItem setLeftBarButtonItem :_leftButton animated :true];    

    _warningLabel.text = @"";
}


- (void)viewDidUnload
{
    [self set_acronymTextField:nil];
    _acronymNavigationItem = nil;
    _warningLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

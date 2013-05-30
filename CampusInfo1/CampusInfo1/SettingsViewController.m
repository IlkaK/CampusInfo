//
//  SettingsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize _acronymTextField;
@synthesize _warningLabel;
@synthesize _backToScheduleButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self._acronymTextField.delegate = self;
    
    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    _acronymTextField.text                = [_acronymUserDefaults stringForKey:@"TimeTableAcronym"];
    [_backToScheduleButton useAlertStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self set_acronymTextField:nil];
    _acronymTextField = nil;
    _warningLabel = nil;
    _backToScheduleButton = nil;
    [super viewDidUnload];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
            _localType = @"Student";
        }
        
    }
    else
    {
        if ([_newAcronym length] >= 3 && [_newAcronym length] <= 5)
        {
            
            if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalSet] isEqualToString: _newAcronym])
            {
                _localType = @"Dozent";
            }
        }
    }
    return _localType;
}


// handling the search button
- (IBAction)moveToTimeTable:(id)sender
{
    NSString *_localAcronym = _acronymTextField.text;
    NSString *_localType    = [self getAcronymType:_localAcronym];
    
    if ([_localType compare: @"empty" ] != NSOrderedSame)
    {
        _warningLabel.text = @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchType" object:_localType];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchText" object:_localAcronym];
        
        NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
        [_acronymUserDefaults setObject:_localAcronym forKey:@"TimeTableAcronym"];
        [_acronymUserDefaults synchronize];
        
        self.tabBarController.selectedIndex = 0;
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        if (_acronymTextField.text == nil || [_acronymTextField.text length] == 0)
        {
            _warningLabel.text = @"Bitte ein Kürzel eingeben.";
        }
        else
        {
            _warningLabel.text = @"Nur Kürzel von Studenten und Dozenten sind möglich.";
        }
    }
}


@end

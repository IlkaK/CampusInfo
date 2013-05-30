//
//  SettingsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import <UIKit/UIKit.h>
#import <GradientButton.h>

@interface SettingsViewController : UIViewController<UITextFieldDelegate>
{


    IBOutlet UITextField *_acronymTextField;
    IBOutlet UILabel     *_warningLabel;
    IBOutlet GradientButton *_backToScheduleButton;
}


@property (nonatomic, retain) IBOutlet UITextField        *_acronymTextField;
@property (nonatomic, retain) IBOutlet UILabel            *_warningLabel;
@property (nonatomic, retain) IBOutlet GradientButton            *_backToScheduleButton;

- (IBAction)moveToTimeTable:(id)sender;

@end

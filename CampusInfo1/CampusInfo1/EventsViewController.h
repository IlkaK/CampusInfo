//
//  EventsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController
{

    IBOutlet UILabel *_titleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;

- (IBAction)moveBackToMenuOverview:(id)sender;

@end

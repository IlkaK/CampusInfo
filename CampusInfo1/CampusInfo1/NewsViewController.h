//
//  NewsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import <SomethingDto.h>


@interface NewsViewController : UIViewController
{
    SomethingDto *_someThing;

    IBOutlet UILabel *_titleLabel;
}

@property (strong, nonatomic) SomethingDto                          *_someThing;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;

- (IBAction)_startNews:(id)sender;

- (IBAction)moveBackToMenuOverview:(id)sender;

@end

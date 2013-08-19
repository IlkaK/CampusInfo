//
//  ZurichViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import <UIKit/UIKit.h>

@interface ZurichViewController : UIViewController
{
    IBOutlet UILabel            *_titleLabel;
    IBOutlet UIWebView          *_zurichWebView;
}

@property (nonatomic, retain) IBOutlet UIWebView                      *_zurichWebView;
@property (nonatomic, retain) IBOutlet UILabel                        *_titleLabel;

- (IBAction)moveBackToMaps:(id)sender;

@end

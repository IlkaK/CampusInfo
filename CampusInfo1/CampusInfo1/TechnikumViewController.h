//
//  TechnikumViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import <UIKit/UIKit.h>

@interface TechnikumViewController : UIViewController
{
    IBOutlet UILabel        *_titleLabel;
    IBOutlet UIWebView      *_technikumWebView;

}

@property (nonatomic, retain) IBOutlet UIWebView                      *_technikumWebView;
@property (nonatomic, retain) IBOutlet UILabel                        *_titleLabel;

- (IBAction)moveBackToMaps:(id)sender;

@end

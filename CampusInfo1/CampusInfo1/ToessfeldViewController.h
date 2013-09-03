//
//  ToessfeldViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 30.08.13.
//
//

#import <UIKit/UIKit.h>

@interface ToessfeldViewController : UIViewController
{

    IBOutlet UINavigationBar        *_titleNavigationBar;
    IBOutlet UINavigationItem       *_titleNavigationItem;
    IBOutlet UILabel                *_titleNavigationLabel;
    
    IBOutlet UIWebView              *_toessfeldWebView;

}

@property (nonatomic, retain) IBOutlet UIWebView                      *_toessfeldWebView;

@property (nonatomic, retain) IBOutlet UINavigationBar                *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem               *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                        *_titleNavigationLabel;

@end

/*
 CampusInfo1AppDelegate.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CampusInfo1AppDelegate.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MainWindow.xib, which is the start of the application </li>
 *      <li> MainWindow.xib defines the tab bar.  </li>
 *  </ul>
 * </li>
 * </ul>
 */

#import <UIKit/UIKit.h>


@interface CampusInfo1AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
    
}

@property (nonatomic, retain) IBOutlet UIWindow           *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

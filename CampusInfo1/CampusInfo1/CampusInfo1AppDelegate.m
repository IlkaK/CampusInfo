/*
 CampusInfo1AppDelegate.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CampusInfo1AppDelegate.m
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

#import "CampusInfo1AppDelegate.h"

@implementation CampusInfo1AppDelegate


@synthesize window           =_window;
@synthesize tabBarController =_tabBarController;



/*!
 * @function didFinishLaunchingWithOptions
   Override point for customization after application launch.
   Add the tab bar controller's current view as a subview of the window.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // those two lines are needed for shaking 
    application.applicationSupportsShakeToEdit = YES;
     [self.window setRootViewController:self.tabBarController];

    // always start with menu overview
    [self.tabBarController setSelectedIndex: 0];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

/*!
 * @function applicationWillResignActive
 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
 */
- (void)applicationWillResignActive:(UIApplication *)application
{
}

/*!
 * @function applicationDidEnterBackground
 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

/*!
 * @function applicationWillEnterForeground
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

/*!
 * @function applicationDidBecomeActive
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

/*!
 * @function applicationWillTerminate
     Called when the application is about to terminate.
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end

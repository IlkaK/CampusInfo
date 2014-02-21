/*
 StartpageViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header StartpageViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of StartpageViewController.xib, which works as backup view. </li>
 *  </ul>
 * </li>
 * </ul>
 */

#import "StartpageViewController.h"

@interface StartpageViewController ()

@end

@implementation StartpageViewController

/*!
 * @function initWithNibName
 * Initializiation of class.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * It is called first time, the view is started for initialization.
 * It is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload
{
    [super viewDidUnload];
}

/*!
 @function shouldAutorotateToInterfaceOrientation
 * Supports autorotation.
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

/*
 URLConstantStrings.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header URLConstantStrings.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Stores all URL constants which are needed to get data from server. </li>
 *      <li> There is no logic implemented, the class only holds the constants. </li>
 *  </ul>
 * </li> *
 * </ul>
 */

#import "URLConstantStrings.h"

@implementation URLConstantStrings


/*! @var URLTimeTable Holds the url used in scheduleDto to get time table data */
NSString * const URLTimeTable = @"https://api.apps.engineering.zhaw.ch/v1/schedules/%@/%@?startingAt=%@&days=7";

/*! @var URLGastroArray Holds the url used in gastronomicFacilityArrayDto to get gastronomic facility data */
NSString * const URLGastroArray = @"https://api.apps.engineering.zhaw.ch/v1/catering/facilities";
/*! @var URLMenuPlanArray Holds the url used in menuPlanArrayDto to get menu plan data */
NSString * const URLMenuPlanArray = @"https://api.apps.engineering.zhaw.ch/v1/catering/menuplans/years/%i/weeks/%i/";

/*! @var URLStudents Holds the url used in studentsDto to get student acronyms */
NSString * const URLStudents = @"https://api.apps.engineering.zhaw.ch/v1/schedules/students/";
/*! @var URLLecturers Holds the url used in lecturersDto to get lecturer acronyms */
NSString * const URLLecturers = @"https://api.apps.engineering.zhaw.ch/v1/schedules/lecturers/";
/*! @var URLCourses Holds the url used in coursesDto to get course acronyms */
NSString * const URLCourses = @"https://api.apps.engineering.zhaw.ch/v1/schedules/courses/";
/*! @var URLRooms Holds the url used in roomsDto to get room acronyms */
NSString * const URLRooms = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/rooms/";
/*! @var URLClasses Holds the url used in classesDto to get class acronyms */
NSString * const URLClasses = @"https://api.apps.engineering.zhaw.ch/v1/schedules/classes/";

/*! @var URLNewsFeed Holds the url used in newsChannelDto to get news data */
NSString * const URLNewsFeed = @"https://api.apps.engineering.zhaw.ch/v1/feeds/soe-news/feed";
/*! @var URLEventsFeed Holds the url used in newsChannelDto to get events data */
NSString * const URLEventsFeed = @"https://api.apps.engineering.zhaw.ch/v1/feeds/soe-events/feed";

/*! @var URLTransportConnections Holds the url used in connectionArrayDto to get public transportation connection data */
NSString * const URLTransportConnections = @"https://api.apps.engineering.zhaw.ch/transport/web/api.php/v1/connections?from=%@&to=%@";
/*! @var URLStations Holds the url used in stationArrayDto to get station suggestions */
NSString * const URLStations = @"https://api.apps.engineering.zhaw.ch/transport/web/api.php/v1/locations?query=%@";

/*! @var URLFacebookApp Holds the url used in socialMediaViewController to show a link to the facebook app */
NSString * const URLFacebookApp = @"fb://profile/108051929285833";
/*! @var URLFacebookWeb Holds the url used in socialMediaViewController to show a link to the facebook web page */
NSString * const URLFacebookWeb = @"https://www.facebook.com/engineering.zhaw";
/*! @var URLYoutubeWeb Holds the url used in socialMediaViewController to show a link to the youtube web page */
NSString * const URLYoutubeWeb = @"http://www.youtube.com/engineeringzhaw";
/*! @var URLTwitterApp Holds the url used in socialMediaViewController to show a link to the twitter app */
NSString * const URLTwitterApp = @"twitter://user?screen_name=engineeringzhaw";
/*! @var URLTwitterWeb Holds the url used in socialMediaViewController to show a link to the twitter web page */
NSString * const URLTwitterWeb = @"https://twitter.com/engineeringzhaw";
/*! @var URLIssuuWeb Holds the url used in socialMediaViewController to show a link to the issuu web page */
NSString * const URLIssuuWeb = @"http://issuu.com/engineeringzhaw";
/*! @var URLXingWeb Holds the url used in socialMediaViewController to show a link to the xing web page */
NSString * const URLXingWeb = @"https://www.xing.com/companies/zhawschoolofengineering";

/*! @var URLEngineeringApp Holds the url display in InformationViewController */
NSString * const URLEngineeringApp = @"http://apps.engineering.zhaw.ch";

@end

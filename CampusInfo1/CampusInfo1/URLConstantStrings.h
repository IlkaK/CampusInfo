/*
 URLConstantStrings.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header URLConstantStrings.h
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

#import <Foundation/Foundation.h>

@interface URLConstantStrings : NSObject

/*! @var URLTimeTable Holds the url used in scheduleDto to get time table data */
extern NSString * const URLTimeTable;

/*! @var URLGastroArray Holds the url used in gastronomicFacilityArrayDto to get gastronomic facility data */
extern NSString * const URLGastroArray;
/*! @var URLMenuPlanArray Holds the url used in menuPlanArrayDto to get menu plan data */
extern NSString * const URLMenuPlanArray;

/*! @var URLStudents Holds the url used in studentsDto to get student acronyms */
extern NSString * const URLStudents;
/*! @var URLLecturers Holds the url used in lecturersDto to get lecturer acronyms */
extern NSString * const URLLecturers;
/*! @var URLCourses Holds the url used in coursesDto to get course acronyms */
extern NSString * const URLCourses;
/*! @var URLRooms Holds the url used in roomsDto to get room acronyms */
extern NSString * const URLRooms;
/*! @var URLClasses Holds the url used in classesDto to get class acronyms */
extern NSString * const URLClasses;

/*! @var URLNewsFeed Holds the url used in newsChannelDto to get news data */
extern NSString * const URLNewsFeed;
/*! @var URLEventsFeed Holds the url used in newsChannelDto to get events data */
extern NSString * const URLEventsFeed;

/*! @var URLTransportConnections Holds the url used in connectionArrayDto to get public transportation connection data */
extern NSString * const URLTransportConnections;
/*! @var URLStations Holds the url used in stationArrayDto to get station suggestions */
extern NSString * const URLStations;

/*! @var URLFacebookApp Holds the url used in socialMediaViewController to show a link to the facebook app */
extern NSString * const URLFacebookApp;
/*! @var URLFacebookWeb Holds the url used in socialMediaViewController to show a link to the facebook web page */
extern NSString * const URLFacebookWeb;
/*! @var URLYoutubeWeb Holds the url used in socialMediaViewController to show a link to the youtube web page */
extern NSString * const URLYoutubeWeb;
/*! @var URLTwitterApp Holds the url used in socialMediaViewController to show a link to the twitter app */
extern NSString * const URLTwitterApp;
/*! @var URLTwitterWeb Holds the url used in socialMediaViewController to show a link to the twitter web page */
extern NSString * const URLTwitterWeb;
/*! @var URLIssuuWeb Holds the url used in socialMediaViewController to show a link to the issuu web page */
extern NSString * const URLIssuuWeb;
/*! @var URLXingWeb Holds the url used in socialMediaViewController to show a link to the xing web page */
extern NSString * const URLXingWeb;

/*! @var URLEngineeringApp Holds the url display in InformationViewController */
extern NSString * const URLEngineeringApp;

@end

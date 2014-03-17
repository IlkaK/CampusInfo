/*
 UIConstantStrings.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header UIConstantStrings.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Stores all constants which are used in the application. </li>
 *      <li> There is no logic implemented, the class only holds the constants. </li>
 *  </ul>
 * </li> *
 * </ul>
 */

#import "UIConstantStrings.h"

@implementation UIConstantStrings

// arrows for navigation bars and back buttons
NSString * const LeftArrowSymbol  = @"\U000025C0\U0000FE0E";
//NSString * const LeftArrowSymbol  = @"\U000025C1\U0000FE0E";
NSString * const RightArrowSymbol = @"\U000025B6\U0000FE0E";

// background for navigation bars
NSString * const NavigationBarBackground = @"NavigationBarBackground.png";
// title for navigation bars
NSString * const NavigationBarFont = @"HelveticaNeue";
NSString * const BoldFont = @"HelveticaNeue-Bold";

float const NavigationBarTitleSize = 17.0;
float const NavigationBarDescriptionSize = 14.0;
NSString * const SegmentedControlBackground = @"segmentedcontrol.png";
NSString * const DateButtonBackground = @"dateButton.png";
NSString * const NoConnectionButtonBackground = @"noConnectionButton";




// strings for settings/ time table details
NSString * const TimeTableTypeStudent       = @"Student";
NSString * const TimeTableTypeDozent        = @"Dozent";
NSString * const TimeTableTypeDozentPlural  = @"Dozenten";
NSString * const TimeTableTypeKurs          = @"Kurs";
NSString * const TimeTableTypeRaum          = @"Raum";
NSString * const TimeTableTypeKlasse        = @"Klasse";
NSString * const TimeTableTypeKlassePlural  = @"Klassen:";

NSString * const TimeTableTypeStudentEnglish            = @"student";
NSString * const TimeTableTypeStudentEnglishPlural      = @"students";
NSString * const TimeTableTypeLecturerEnglishPlural     = @"lecturers";
NSString * const TimeTableTypeLecturerEnglish           = @"lecturer";
NSString * const TimeTableTypeCourseEnglishPlural       = @"courses";
NSString * const TimeTableTypeCourseEnglish             = @"course";
NSString * const TimeTableTypeRoomEnglish               = @"room";
NSString * const TimeTableTypeRoomEnglishPlural         = @"rooms";
NSString * const TimeTableTypeClassEnglishPlural        = @"classes";
NSString * const TimeTableTypeClassEnglish              = @"class";

NSString * const TimeTableDescription = @"Beschreibung";


NSString * const SettingsVCTitle      = @"Einstellungen";
NSString * const SettingsVCSearchType = @"SearchType";
NSString * const SettingsVCSearchText = @"SearchText";

NSString * const SearchVCTitle        = @"Stundenplan Suche";
NSString * const SearchVCHint         = @"Bitte ein Kürzel eingeben.";

// store acronym for own time table
NSString * const TimeTableAcronym     = @"TimeTableAcronym";



// strings for contacts secretary
NSString * const ContactsVCRealEmailEngineering                 = @"info-sg.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailEngineering              = @"info-sg.engineering(at)zhaw.ch";
NSString * const ContactsVCRealEmailZurichEngineering           = @"info-sg.zh.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailZurichEngineering        = @"info-sg.zh.engineering(at)zhaw.ch";

NSString * const ContactsVCDisplayPhoneAviatik                   = @"Tel. +41 58 934 75 60";
NSString * const ContactsVCRealPhoneAviatik                      = @"0041589347560";
NSString * const ContactsVCResponsibleAviatik                    = @"Gianna Scherrer";

NSString * const ContactsVCDisplayPhoneElectricalEngineering     = @"Tel. +41 58 934 73 66";
NSString * const ContactsVCRealPhoneElectricalEngineering        = @"0041589347366";
NSString * const ContactsVCResponsibleElectricalEngineering      = @"Eliane Roth";

NSString * const ContactsVCDisplayPhoneEnvironmentEngineering    = @"Tel. +41 58 934 75 63";
NSString * const ContactsVCRealPhoneEnvironmentEngineering       = @"0041589347563";
NSString * const ContactsVCResponsibleEnvironmentEngineering     = @"Jennifer Hohl";

NSString * const ContactsVCDisplayPhoneComputerScienceWinterthur = @"Tel. +41 58 934 75 63";
NSString * const ContactsVCRealPhoneComputerScienceWinterthur    = @"0041589347563";
NSString * const ContactsVCResponsibleComputerScienceWinterthur  = @"Jennifer Hohl";

NSString * const ContactsVCDisplayPhoneComputerScienceZurich     = @"Tel. +41 58 934 82 42";
NSString * const ContactsVCRealPhoneComputerScienceZurich        = @"0041589348242";
NSString * const ContactsVCResponsibleComputerScienceZurich      = @"Zita Fejér";

NSString * const ContactsVCDisplayPhoneMechanicalEngineering     = @"Tel. +41 58 934 74 14";
NSString * const ContactsVCRealPhoneMechanicalEngineering        = @"0041589347414";
NSString * const ContactsVCResponsibleMechanicalEngineering      = @"Béatrice Schaffner";

NSString * const ContactsVCDisplayPhoneChemicalEngineering       = @"Tel. +41 58 934 74 14";
NSString * const ContactsVCRealPhoneChemicalEngineering          = @"0041589347414";
NSString * const ContactsVCResponsibleChemicalEngineering        = @"Béatrice Schaffner";

NSString * const ContactsVCDisplayPhoneSystemEngineering         = @"Tel. +41 58 934 73 66";
NSString * const ContactsVCRealPhoneSystemEngineering            = @"0041589347366";
NSString * const ContactsVCResponsibleSystemEngineering          = @"Eliane Roth";

NSString * const ContactsVCDisplayPhoneTrafficEngineering        = @"Tel. +41 58 934 73 66";
NSString * const ContactsVCRealPhoneTrafficEngineering           = @"0041589347366";
NSString * const ContactsVCResponsibleTrafficEngineering         = @"Eliane Roth";

NSString * const ContactsVCDisplayPhoneBusinessEngineering       = @"Tel. +41 58 934 75 60";
NSString * const ContactsVCRealPhoneBusinessEngineering          = @"0041589347560";
NSString * const ContactsVCResponsibleBusinessEngineering        = @"Gianna Scherrer";

NSString * const ContactsVCDisplayPhoneMaster                    = @"Tel. +41 58 934 75 63";
NSString * const ContactsVCRealPhoneMaster                       = @"0041589347563";
NSString * const ContactsVCResponsibleMaster                     = @"Jennifer Hohl";
NSString * const ContactsVCRealEmailMaster                       = @"mse.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailMaster                    = @"mse.engineering(at)zhaw.ch";

NSString * const ContactsVCRealEmailContinuedEducation           = @"weiterbildung.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailContinuedEducation        = @"weiterbildung.engineering(at)zhaw.ch";

NSString * const ContactsVCDisplayPhone0ContinuedEducation        = @"Tel. +41 58 934 74 28";
NSString * const ContactsVCRealPhone0ContinuedEducation           = @"0041589347428";
NSString * const ContactsVCResponsible0ContinuedEducation         = @"Mirjam Holenstein";

NSString * const ContactsVCDisplayPhone1ContinuedEducation        = @"Tel. +41 58 934 74 28";
NSString * const ContactsVCRealPhone1ContinuedEducation           = @"0041589347428";
NSString * const ContactsVCResponsible1ContinuedEducation         = @"Silvia Cetti";

NSString * const ContactsVCDisplayPhone2ContinuedEducation        = @"Tel. +41 58 934 82 44";
NSString * const ContactsVCRealPhone2ContinuedEducation           = @"0041589348244";
NSString * const ContactsVCResponsible2ContinuedEducation         = @"Erika Wentsch";




NSString * const EmergencyVCDisplayPhonePolice          = @"117";
NSString * const EmergencyVCRealPhonePolice             = @"117";

NSString * const EmergencyVCDisplayPhoneFire          = @"118";
NSString * const EmergencyVCRealPhoneFire             = @"118";

NSString * const EmergencyVCDisplayPhoneSanitary      = @"144";
NSString * const EmergencyVCRealPhoneSanitary         = @"144";

NSString * const EmergencyVCDisplayPhoneToxCentre     = @"145";
NSString * const EmergencyVCRealPhoneToxCentre        = @"145";

NSString * const EmergencyVCDisplayPhoneRega          = @"1414";
NSString * const EmergencyVCRealPhoneRega             = @"1414";

NSString * const EmergencyVCDisplayPhoneZHAWEmergency = @"+41 58 934 70 70";
NSString * const EmergencyVCRealPhoneZHAWEmergency    = @"0589347070";

NSString * const ServiceDeskVCRealPhone         = @"0041589346677";
NSString * const ServiceDeskVCDisplayPhone      = @"+41 58 934 66 77";
NSString * const ServiceDeskVCRealEmail         = @"servicedesk@zhaw.ch";
NSString * const ServiceDeskVCDisplayEmail      = @"servicedesk(at)zhaw.ch";

NSString * const InformationVCDisplayEmail      = @"app.engineering(at)zhaw.ch";
NSString * const InformationVCRealEmail         = @"app.engineering@zhaw.ch";





// news and events
NSString * const NewsWebViewHtml    = @"<html> \n"
"<head> \n"
"<style type=\"text/css\"> \n"
"body {font-family: \"%@\";font-size: 13;}\n"
"</style> \n"
"</head> \n"
"<body>%@</body> \n"
"</html>";
NSString * const NewsWebViewFont   = @"helvetica";


// constants needed to compare start and stop station in
// PublicTransportViewController and PublicStopViewController
NSString * const PublicTransportVCFromEnglish = @"from";
NSString * const PublicTransportVCToEnglish   = @"to";



// time table
NSString * const TimeTableOverVCTitle = @"Stundenplan";

// mensa
NSString * const MensaVCTitle = @"Mensa";
NSString * const MensaClosed  = @"geschlossen";

// choose date
NSString * const ChooseDateVCTitle = @"Datum wählen";

// language translation
NSString * const MondayEnglish = @"monday";
NSString * const MondayGerman  = @"Montag";
NSString * const TuesdayEnglish = @"tuesday";
NSString * const TuesdayGerman  = @"Dienstag";
NSString * const WednesdayEnglish = @"wednesday";
NSString * const WednesdayGerman  = @"Mittwoch";
NSString * const ThursdayEnglish = @"thursday";
NSString * const ThursdayGerman  = @"Donnerstag";
NSString * const FridayEnglish = @"friday";
NSString * const FridayGerman  = @"Freitag";
NSString * const SaturdayEnglish = @"saturday";
NSString * const SaturdayGerman  = @"Samstag";
NSString * const SundayEnglish = @"sunday";
NSString * const SundayGerman  = @"Sonntag";

// menu overview png
NSString * const AppIconTimeTable                   = @"AppIconsSchriftStundenplan.png";
NSString * const AppIconTimeTableFeedback           = @"AppIconsSchriftStundenplanFeedback.png";
NSString * const AppIconMensa                       = @"AppIconsSchriftMensa.png";
NSString * const AppIconMensaFeedback               = @"AppIconsSchriftMensaFeedback.png";
NSString * const AppIconPublicTransport             = @"AppIconsSchriftFahrplan.png";
NSString * const AppIconPublicTransportFeedback     = @"AppIconsSchriftFahrplanFeedback.png";
NSString * const AppIconContacts                    = @"AppIconsSchriftKontakte.png";
NSString * const AppIconContactsFeedback            = @"AppIconsSchriftKontakteFeedback.png";
NSString * const AppIconMaps                        = @"AppIconsSchriftStandorte.png";
NSString * const AppIconMapsFeedback                = @"AppIconsSchriftStandorteFeedback.png";
NSString * const AppIconSocialMedia                 = @"AppIconsSchriftSocialMedia.png";
NSString * const AppIconSocialMediaFeedback         = @"AppIconsSchriftSocialMediaFeedback.png";
NSString * const AppIconSettings                    = @"AppIconsSchriftEinstellungen.png";
NSString * const AppIconSettingsFeedback            = @"AppIconsEinstellungenFeedback.png";
NSString * const AppIconNews                        = @"AppIconsSchriftNews.png";
NSString * const AppIconNewsFeedback                = @"AppIconsSchriftNewsFeedback.png";
NSString * const AppIconEvents                      = @"AppIconsSchriftEvents.png";
NSString * const AppIconEventsFeedback              = @"AppIconsSchriftEventsFeedback.png";


@end

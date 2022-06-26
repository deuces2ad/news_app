//
//  DashBoardView.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import UIKit // TODO: Remove UIKit

//TODO: Update this class name to NewsDateFormatter?
class DateParser: NSObject { // TODO: Remove NSObject
    
    //TODO: Delete all the functions which are not required
    //TODO: add spaces on the return type
    
    //TODO: rename the function to something meaningful
    static func parseToFormattedData(_ dateString : String) -> String? {
        guard dateString.isEmpty == false else {
            return nil
        }
        guard let date = stringToDate(dateString)
            else{
                return nil
        }
        
        guard let formattedDateString = dateToString(date)
            else{
                return nil
        }
        
        return formattedDateString
    }
    
    
    static func stringToDate(_ dateString : String)->Date?{
        let defaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        return stringToDate(dateString, dateFormat: defaultFormat)
    }
    
    static func dateToString(_ date : Date)->String?{
        let defaultFormat = "MMM d, yyyy" // TODO: Please move this to constant
        return dateToString(date, requiredFormat : defaultFormat)
    }
    
    static func dateToStringInServerFormat(_ date : Date?)->String?{
        
        guard let dateUW = date // TODO: rename the variable name to add value
            else{
                return ""
        }
        let defaultFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let defaultTimeZone = TimeZone.autoupdatingCurrent
        return dateToString(dateUW, requiredFormat : defaultFormat, timeZone: defaultTimeZone)
    }
    
    static func stringToDate(_ dateString : String, dateFormat : String)->Date?{
        let defaultTimeZone = TimeZone.autoupdatingCurrent
        return stringToDate(dateString, dateFormat: dateFormat, timeZone: defaultTimeZone)
    }
    
    static func dateToString(_ date : Date?, requiredFormat : String)->String?{
        let defaultTimeZone = TimeZone.autoupdatingCurrent
        return dateToString(date, requiredFormat: requiredFormat, timeZone: defaultTimeZone)
    }
    
    private getDateFormatter(timeZone: TimeZone) -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier : "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        
        return dateFormatter
    }
    
    static func stringToDate(_ dateString : String, dateFormat : String, timeZone : TimeZone)->Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier : "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: dateString)
    }
    
    static func UTCStringToDate(_ dateString : String)->Date?{
        
        let defaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        let UTCTimeZone = TimeZone(abbreviation : "UTC") ?? TimeZone.current
        if stringToDate(dateString, dateFormat: defaultFormat, timeZone: UTCTimeZone) != nil {
            return stringToDate(dateString, dateFormat: defaultFormat, timeZone: UTCTimeZone)
        }
        return stringToDate(dateString, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", timeZone: UTCTimeZone)
    }
    
    static func dateToString(_ date : Date?, requiredFormat : String, timeZone : TimeZone)->String?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier : "en_US_POSIX")
        dateFormatter.dateFormat = requiredFormat
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: date ?? Date())
    }
    
    static func getDateComponentsFromDate(_ date : Date?)->DateComponents{
        let calendar = Calendar.current
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .month, .year, .weekday]
        return (calendar as NSCalendar).components(unitFlags, from: date ?? Date())
    }
    
    static func getCurrentDateTimeInStringWithWebFormat(date:Date?,format:String?)->String?{
        
        //For Start Date
        
        guard let getDate = date else {
            return ""
        }
        guard let getFormat = format else {
            return ""
        }
        
        var calendar = Calendar.current
        let requiredTimeZone = TimeZone(abbreviation: "UTC")!
        calendar.timeZone = requiredTimeZone
        calendar.locale = Locale(identifier : "en_US_POSIX")
        let dateTime = dateToString(Date(), requiredFormat : getFormat, timeZone : requiredTimeZone)
        
        return dateTime
    }

    static func getCurrentDateInUTC()->Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier : "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        let str = dateFormatter.string(from: Date())
        let date = dateFormatter.date(from: str)
        return date
    }
}

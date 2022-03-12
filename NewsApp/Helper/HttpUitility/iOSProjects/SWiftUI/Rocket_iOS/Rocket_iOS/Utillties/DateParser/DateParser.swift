//
//  DateParser.swift
//  ICS
//
//  Created by Abhishek Dhiman on 13/12/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import UIKit

class DateParser: NSObject {
    
    static func parseToFormattedData(_ dateString : String)->String?{
        guard let date = stringToDate(dateString)
            else{
                return ""
        }
        
        guard let formattedDateString = dateToString(date)
            else{
                return ""
        }
        
        return formattedDateString
    }
    
    static func stringToDate(_ dateString : String)->Date?{
        let defaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        return stringToDate(dateString, dateFormat: defaultFormat)
    }
    
    static func dateToString(_ date : Date)->String?{
        let defaultFormat = "MMM d, yyyy"
        return dateToString(date, requiredFormat : defaultFormat)
    }
    
    static func dateToStringInServerFormat(_ date : Date?)->String?{
        
        guard let dateUW = date
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
        
        Log.echo(key: "yud", text: "Force Conversion to new date format is \(stringToDate(dateString, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", timeZone: UTCTimeZone))")
        
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
    
    
    static func getMidNightDateTimeInString(date:Date?,format:String?)->String?{
        
        //For Start Date
        guard let getDate = date else {
            return ""
        }
        guard let getFormat = format else {
            return ""
        }
        
        var calendar = Calendar.current
        let requiredTimeZone = TimeZone(abbreviation: "UTC")!
        let defaultTimeZone = TimeZone.autoupdatingCurrent
        calendar.timeZone = defaultTimeZone
        calendar.locale = Locale(identifier : "en_US_POSIX")
        let dateAtMidnight = calendar.startOfDay(for: Date())
        let dateTime = dateToString(dateAtMidnight, requiredFormat : getFormat, timeZone : requiredTimeZone)
        
        return dateTime
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
    
    
    static func convertDateToDesiredFormat(date:String?,ItsDateFormat:String?,requiredDateFormat:String?)->String?{
        
        guard let dateNeedToModify = date else{
            return nil
        }
        guard let dateFormat = ItsDateFormat else{
            return nil
        }
        guard let requiredFormat =  requiredDateFormat else {
            return nil
        }
        Log.echo(key: "yud", text: "CD is \(dateNeedToModify)")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier : "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        if let getDate = dateFormatter.date(from: "\(dateNeedToModify)"){
            dateFormatter.dateFormat = requiredFormat
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.string(from: getDate)
        }
        return nil
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
    
    
    static func getDateTimeInUTCFromWeb(dateInString:String?,dateFormat:String?)->Date?{
        
        guard let currentDate = dateInString else{
            return nil
        }
        guard let dateFormat = dateFormat else{
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier : "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        return dateFormatter.date(from: "\(currentDate)")
    }
    
    static func convertTimeStampToDesiredDateFormat( _ timeStamp : Int)-> String{
        let timeStamp = timeStamp
        let unixTimeStamp: Double = Double(timeStamp)
        let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "E, MMM dd yyyy"
        dateFormatt.timeZone = TimeZone(abbreviation:"UTC")
        dateFormatt.locale = Locale(identifier : "en_US_POSIX")
        print(dateFormatt.string(from: exactDate as Date))
        let date = dateFormatt.string(from: exactDate as Date)
        Log.echo(key: "formatedDate", text: timeStamp)
        Log.echo(key: "formatedDate", text: date)
        return date
    }
}

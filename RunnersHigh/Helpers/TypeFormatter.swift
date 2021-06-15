//
//  TypeFormatter.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import Foundation

class TypeFormatter {
    
    static func FormatDateToTimeOfDayAsString(date: Date) -> String{
        let newDate = date + 60 * 60 // Adds 1 hour
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "h:00 a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: newDate)
    }
    
    static func FormatDateToTimeOfDayAsStringToStoreInModel(date: Date) -> String{
        let newDate = date + 60 * 60 // Adds 1 hour
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd h:00 a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: newDate)
    }
}

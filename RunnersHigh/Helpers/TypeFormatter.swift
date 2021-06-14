//
//  TypeFormatter.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import Foundation

class TypeFormatter {
    
    static func FormatDateToTimeOfDayAsString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "HH:mmZZ"
        return formatter.string(from: date)
    }
}

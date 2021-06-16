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
        formatter.dateFormat = "h:00 a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
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
    
    static func FormatMeasurementAsKilometers(distance: Measurement<UnitLength>) -> String{
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "en_CA")
        formatter.numberFormatter.minimumFractionDigits = 2
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter.string(from: distance)
    }
    
    static func FormatePaceInMinutesPerKilometer(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? distance.value / Double(seconds) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
}

extension UnitSpeed {
    class var minutesPerKilometer: UnitSpeed {
        return UnitSpeed(symbol: "min/km", converter: UnitConverterPace(coefficient: 60.0 / 1000.0))
      }
}

//
//  main.swift
//  timecalc_cmdline
//
//  Created by Robert Dodson on 2/29/24.
//

import Foundation
import Time

print("timecalc")

while true
{
    let template = "yyyyMMdd-HH:mm:ss"
    print(template,separator:" ",terminator:"> ")
    if let str = readLine(strippingNewline:true)
    {
        do
        {
            let parts = str.split(separator: " ")
            if parts.count == 2
            {
                let startDate = try Fixed<Second>(stringValue: String(parts[0]), rawFormat: template, region: Region.current)
                let endDate = try Fixed<Second>(stringValue: String(parts[1]), rawFormat: template, region: Region.current)
                
                let diffyears   = startDate.differenceInWholeYears(to: endDate)
                let diffmonths  = startDate.differenceInWholeMonths(to: endDate)
                let diffdays    = startDate.differenceInWholeDays(to: endDate)
                let diffhours   = startDate.differenceInWholeHours(to: endDate)
                let diffminutes = startDate.differenceInWholeMinutes(to: endDate)
                let diffseconds = startDate.differenceInWholeSeconds(to: endDate)
                
                print("From: \(startDate)")
                print("To:   \(endDate)")
                print("Is: \(diffyears.years) years \(diffmonths.months % 12) months")
                print("    \(diffmonths.months) months \(endDate.dayOfMonth) days")
                print("    \(diffdays.days) days \(diffhours.hours % 24) hours")
                print("    \(diffhours.hours) hours \(diffminutes.minutes % 60) minutes")
                print("    \(diffminutes.minutes) minutes \(diffseconds.seconds % 60) seconds")
                print("    \(diffseconds.seconds) seconds")
            }
        }
        catch
        {
            print("error: \(error)")
        }
    }
}

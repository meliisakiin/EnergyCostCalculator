//
//  RegEx.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import Foundation

enum RegEx: String {
    case alphanumericStringWithSpace = "^(?! )[A-Za-z0-9 ]*(?<! )$"
    case currentReadingString = "^0*[1-9]"
}

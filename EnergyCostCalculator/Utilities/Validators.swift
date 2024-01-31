//
//  Validators.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import Foundation

class ValidationError : Error {
    var message : String
    
    init(_ message : String) {
        self.message = message
    }
}

protocol ValidatorConvertable {
    func validate(_ value : String) throws -> String
}

enum ValidatorType{
    case alphanumeric
    case positiveNumber
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertable {
        switch type {
        case .alphanumeric : return alphanumericValidator()
        case .positiveNumber : return positiveNumberValidator()
        }
    }
}

struct alphanumericValidator: ValidatorConvertable {
    func validate(_ value: String) throws -> String {
        do {
           if Validation.shared.isValidRegEx(value, .alphanumericStringWithSpace) != true{
                 throw ValidationError(Messages.invalidAlphanumeric.localized())
             }
        } catch  {
            throw ValidationError(Messages.invalidAlphanumeric.localized())
        }
        return value
    }
}

struct positiveNumberValidator: ValidatorConvertable {
    func validate(_ value: String) throws -> String {
        do {
            let number = value.isInt ? (Int(value) ?? 0) : 0
           if number < 1 {
                 throw ValidationError(Messages.currentReading.localized())
             }
        } catch  {
            throw ValidationError(Messages.currentReading.localized())
        }
        return value
    }
}

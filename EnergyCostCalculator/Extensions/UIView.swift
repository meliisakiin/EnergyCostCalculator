//
//  UIView.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//


import UIKit
import Foundation

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIFont {
     
    static func scriptFont(size: CGFloat,weight:UIFont.Weight) -> UIFont {
        
        if weight == .bold {
            guard let customFont = UIFont(name: "Montserrat-Bold", size: size) else {
              return UIFont.systemFont(ofSize: size)
            }
            return customFont
        }else if weight == .semibold {
            guard let customFont = UIFont(name: "Montserrat-SemiBold", size: size) else {
              return UIFont.systemFont(ofSize: size)
            }
            return customFont
        }else if weight == .medium {
            guard let customFont = UIFont(name: "Montserrat-Medium", size: size) else {
              return UIFont.systemFont(ofSize: size)
            }
            return customFont
        }else  {
            guard let customFont = UIFont(name: "Montserrat-Regular", size: size) else {
              return UIFont.systemFont(ofSize: size)
            }
            return customFont
        }
     
    }
}

extension String {
    
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validate(self)
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
}

//
//  SCLAlertView.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import Foundation
import SCLAlertView

public extension SCLAlertView {
    
   class func getAlert() -> SCLAlertView {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: .scriptFont(size: 20, weight: .semibold),
            kTextFont: .scriptFont(size: 14, weight: .medium),
            kButtonFont: .scriptFont(size: 14, weight: .regular),
            showCloseButton: false,
            contentViewCornerRadius: 12,
            buttonCornerRadius: 12
        )
        
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Tamam", action: {})
        return alert
    }
    

    
}

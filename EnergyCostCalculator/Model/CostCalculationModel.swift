//
//  CostCalculationModel.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import Foundation

struct CostCalculationModel : Codable {
    let serialNumber : String
    let value : Int
}

struct HistoryModel : Codable {
    let serialNumber : String
    let units : Int
    let cost : Int
}

struct HandleUIErrorModel : Codable {
    let key : String
    let value : String
}

//
//  CostCalculationViewModel.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import Foundation
protocol CostCalculationViewModel {
    func requireSuccess()
    func validationSuccess(serialNumber : String, currentReading: String)
    func success()
    func failure(error: Error)
    func handleSerialNumber(value : String)
    func handleCurrentReading(value : String)
    func handle(errorFields: [HandleUIErrorModel])
    func showBillWithBreakdown(billBreakDown: [CostCalculationModel])
    func showHistory(historyValues: [HistoryModel])
}

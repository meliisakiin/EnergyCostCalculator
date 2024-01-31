//
//  ViewController.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import UIKit
import MaterialComponents
import SCLAlertView

class ViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var amountTxt: UITextField!
    
    @IBOutlet weak var calculateV: UIView!
    @IBOutlet weak var customerHV: UIView!
    @IBOutlet weak var openV: UIView!
    
    @IBOutlet weak var serviceNumberTxt: MDCOutlinedTextField!
    @IBOutlet weak var currentMeterTxt: MDCOutlinedTextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var costCalculator: CostCalculationService?
    var values = [HistoryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setUpBtn()
        setUpTextField()
        setupView()
        clear()
        costCalculator = CostCalculationServiceDelegate(delegate: self)
        tableView.delegate = self
        tableView.dataSource = self

    }

    func setUpBtn(){
        submitBtn.layer.cornerRadius = 8
        saveBtn.layer.cornerRadius = 8
    }
    
    func setUpTextField(){
        serviceNumberTxt.delegate = self
        currentMeterTxt.delegate = self
        serviceNumberTxt.label.text = "Service Number of the customer"
        currentMeterTxt.label.text = "Current meter"
    }
    
    func setupView(){
        shadowround(view: calculateV)
        shadowround(view: customerHV)
        shadowround(view: openV)
    }
    
    func shadowround(view: UIView) {
        // corner radius
        view.layer.cornerRadius = 8
        // border
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        // shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
    }
    
    
    func clear(){
        submitBtn.isHidden = false
        calculateV.isHidden = true
        customerHV.isHidden = true
        serviceNumberTxt.text = ""
        currentMeterTxt.text = ""
    }
    
  
    func showError(value : String){
        SCLAlertView.getAlert().showWarning("Warning!", subTitle: value)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        self.view.endEditing(true)
        costCalculator?.requiredValidation(serialNumberTxt: self.serviceNumberTxt.text ?? "", currentReadingTxt: self.currentMeterTxt.text ?? "")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.view.endEditing(true)
        costCalculator?.saveData(serialNumber: self.serviceNumberTxt.text ?? "", currentReading: self.currentMeterTxt.text ?? "0")

    }
    
    func dataValidation(){
        self.costCalculator?.dataValidation(serialNumber: self.serviceNumberTxt.text ?? "", currentReading: self.currentMeterTxt.text ?? "")
    }
    

}


extension ViewController: CostCalculationViewModel{
    func requireSuccess() {
        self.dataValidation()
    }
    
    func validationSuccess(serialNumber: String, currentReading: String) {
        let calculationModel = CostCalculationModel(serialNumber: serialNumber, value: Int(currentReading) ?? 0)
        self.costCalculator?.billCalculator(calculationModel: calculationModel)
    }
    
    func success() {
        self.clear()
        SCLAlertView.getAlert().showSuccess("Success", subTitle: "Data saved successfully.")
    }
    
    func failure(error: Error) {
        SCLAlertView.getAlert().showSuccess("Failure", subTitle: "An error occurred while saving data.")
    }
    
    func handleSerialNumber(value: String) {
        self.showError(value: value)
    }
    
    func handleCurrentReading(value: String) {
        self.showError(value: value)

    }
    
    func handle(errorFields: [HandleUIErrorModel]) {
        for field in errorFields {
            if field.key == "SerialNumber"{
                self.showError(value: field.value)
            }
            if field.key == "CurrentReading"{
                self.showError(value: field.value)
            }
        }
    }
    
    func showBillWithBreakdown(billBreakDown: [CostCalculationModel]) {
        print(billBreakDown[billBreakDown.count - 1].value)
        print(billBreakDown[billBreakDown.count - 1].serialNumber)
        self.calculateV.isHidden = false
        amountTxt.text = String(billBreakDown[billBreakDown.count - 1].value) + " $"
    }
    
    func showHistory(historyValues: [HistoryModel]) {
        if !historyValues.isEmpty{
            self.values = historyValues
            self.tableView.reloadData()
            customerHV.isHidden = false
        }else{
            self.values = []
            customerHV.isHidden = true
        }
       
    }    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricalReadTableViewCell") as! HistoricalReadTableViewCell
        let item = values[indexPath.row]
        cell.currentIndexLbl.text = String(item.units)
        cell.amountLbl.text = String(item.cost) + " $"
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        if textField == serviceNumberTxt {
            let allowedCharacters = CharacterSet.alphanumerics
            let characterSet = CharacterSet(charactersIn: string)
            
            if let text = textField.text, let range = Range(range, in: text) {
                let proposedText = text.replacingCharacters(in: range, with: string)
                guard proposedText.count <= 10 else {
                   
                    if string.count > 1 {
                     
                        self.showError(value: Messages.serialNumberCopyPaste.localized())
                    }
                    return false
                }
            }
            return allowedCharacters.isSuperset(of: characterSet)
        }else if(textField == currentMeterTxt){
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else{
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == serviceNumberTxt {
            self.costCalculator?.dataValidation(serialNumber: self.serviceNumberTxt.text ?? "")
        }else if(textField == self.currentMeterTxt){
            if(textField.text == ""){
                self.calculateV.isHidden = true
            }
        }
    }
}

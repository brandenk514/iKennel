//
//  EditClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditClientViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var cellNumTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let bannedChars = CharacterSet(charactersIn: "0123456789./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    let bannedAddressChars = CharacterSet(charactersIn: "./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    let bannedPhoneChars = CharacterSet.letters
    
    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())

    var selected_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    let limitLenght = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        cellNumTF.delegate = self
        emailTF.delegate = self
        streetTF.delegate = self
        cityTF.delegate = self
        stateTF.delegate = self
        zipCodeTF.delegate = self
        
        // Do any additional setup after loading the view.
        firstNameTF.text = cur_client.fName
        lastNameTF.text = cur_client.lName
        streetTF.text = cur_client.address
        emailTF.text = cur_client.email
        cellNumTF.text = cur_client.cellNum
    
        streetTF.text = splitAddress(address: cur_client.address)[0]
        cityTF.text = splitAddress(address: cur_client.address)[1]
        stateTF.text = getState(stateAndZip: splitAddress(address: cur_client.address)[2])
        zipCodeTF.text = getZipCode(stateAndZip: splitAddress(address: cur_client.address)[2])
        if (streetTF.text?.isEmpty)! {
            streetTF.placeholder = "Street"
        }
        if (cityTF.text?.isEmpty)! {
            cityTF.placeholder = "City"
        }
        if (stateTF.text?.isEmpty)! {
            stateTF.placeholder = "State"
        }
        if (zipCodeTF.text?.isEmpty)! {
            zipCodeTF.placeholder = "Zip Code"
        }
        
        errorLabel.text = ""
        
        if lastNameTF.text == "" || firstNameTF.text == "" || cellNumTF.text == "" {
            saveButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firstNameDidChange(_ sender: UITextField) {
        if firstNameTF.text! != cur_client.fName {
            cur_client.fName = firstNameTF.text!
        }
    }
    
    @IBAction func lastNameDidChange(_ sender: UITextField) {
        if lastNameTF.text! != cur_client.lName {
            cur_client.lName = lastNameTF.text!
        }
    }
    
    @IBAction func cellNumDidChange(_ sender: UITextField) {
        if cellNumTF.text! != cur_client.cellNum {
            cur_client.cellNum = cellNumTF.text!
        }
    }
    
    @IBAction func emailDidChange(_ sender: UITextField) {
        if emailTF.text! != cur_client.email {
            cur_client.email = emailTF.text!
        }
    }
    
    @IBAction func checkfirstNameField(_ sender: UITextField) {
        if firstNameTF.text != "" {
            if ((firstNameTF.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers and symbols are not allowed in firstname field"
                firstNameTF.textColor = UIColor.red
                saveButton.isEnabled = false
            } else {
                firstNameTF.textColor = UIColor.black
                errorLabel.text = ""
                saveButton.isEnabled = true
            }
        } else {
            errorLabel.text = "A firstname is required"
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func checkLastNameField(_ sender: UITextField) {
        if lastNameTF.text != "" {
            if ((lastNameTF.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers and symbols are not allowed in lastname field"
                lastNameTF.textColor = UIColor.red
                saveButton.isEnabled = false
            } else {
                errorLabel.text = "^"
                saveButton.isEnabled = true
                lastNameTF.textColor = UIColor.black
            }
        } else {
            errorLabel.text = "A lastname is required"
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func checkCellNumField(_ sender: UITextField) {
        if cellNumTF.text != "" {
            if ((cellNumTF.text?.rangeOfCharacter(from: bannedPhoneChars)) != nil) {
                errorLabel.text = "Letters not allowed in Cell Number field"
                saveButton.isEnabled = false
                cellNumTF.textColor = UIColor.red
            } else {
                errorLabel.text = ""
                saveButton.isEnabled = true
                cellNumTF.textColor = UIColor.black
            }
        } else {
            errorLabel.text = "A cell number is required"
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func checkEmailField(_ sender: UITextField) {
        if (emailTF.text != "") {
            if !isValidEmail(email: emailTF.text!) {
                errorLabel.text = "Email is not valid"
                saveButton.isEnabled = false
                emailTF.textColor = UIColor.red
            } else {
                errorLabel.text = ""
                saveButton.isEnabled = true
                emailTF.textColor = UIColor.black
            }
        } else {
            errorLabel.text = "An email is required"
            saveButton.isEnabled = false
        }
        
    }
    
    @IBAction func checkAddressField(_ sender: UITextField) {
        if ((sender.text?.rangeOfCharacter(from: bannedAddressChars)) != nil) {
            errorLabel.text = "Symbols are not allowed in address field"
            saveButton.isEnabled = false
            sender.textColor = UIColor.red
        } else {
            errorLabel.text = ""
            saveButton.isEnabled = true
            sender.textColor = UIColor.black
        }
    }
    
    @IBAction func checkZip(_ sender: UITextField) {
        if (sender.text!.characters.count > limitLenght) {
            sender.deleteBackward()
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func splitAddress(address: String) -> [String] {
        return address.components(separatedBy: ", ")
    }
    
    func getState(stateAndZip: String) -> String {
        let zipcodeArray = stateAndZip.components(separatedBy: CharacterSet.decimalDigits)
        let state = zipcodeArray[0].components(separatedBy: " ")
        if state[1].isEmpty {
            return state[0]
        } else {
           return state[0] + " " + state[1]
        }
    }
    
    func getZipCode(stateAndZip: String) -> String {
        let zipcodeArray = stateAndZip.components(separatedBy: CharacterSet.letters)
        let zipcode = zipcodeArray[zipcodeArray.count - 1].components(separatedBy: " ")
        return zipcode[zipcode.count - 1]
    }
    
    func makeAddress() -> String  {
        let cityAddress = streetTF.text! + ", " + cityTF.text! + ", "
        let stateAddress =  cityAddress + stateTF.text! + " "
        return stateAddress + zipCodeTF.text!
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "newAnimal" {
            
        } else if segue.identifier == "saveEdit" {
            let curClientVC = segue.destination as! CurrentClientViewController
            cur_client.address = makeAddress()
            curClientVC.cur_client = cur_client
        }
    }


}

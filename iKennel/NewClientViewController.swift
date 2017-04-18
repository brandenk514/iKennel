//
//  NewClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/13/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController{
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cellnum: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var addAnimalButtons: [UIButton]!
    
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    
    var newAnimal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var animalTag = 0

    var animalArray = [Animal]()
    
    let bannedChars = CharacterSet(charactersIn: "0123456789./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    let bannedAddressChars = CharacterSet(charactersIn: "./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    let bannedPhoneChars = CharacterSet.letters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstname.delegate = self as? UITextFieldDelegate
        lastname.delegate = self as? UITextFieldDelegate
        email.delegate = self as? UITextFieldDelegate
        cellnum.delegate = self as? UITextFieldDelegate
        streetField.delegate = self as? UITextFieldDelegate
        cityField.delegate = self as? UITextFieldDelegate
        stateField.delegate = self as? UITextFieldDelegate
        zipCodeField.delegate = self as? UITextFieldDelegate
        
        errorLabel.text = ""
        if lastname.text == "" || firstname.text == "" || cellnum.text == "" {
            saveButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelNewClientAddAnimal(segue:UIStoryboardSegue) { }
    
    @IBAction func saveNewClientAddAnimal(segue:UIStoryboardSegue) {
        animalArray.append(newAnimal)
        for b in addAnimalButtons {
            if animalTag == b.tag {
                b.setTitle(newAnimal.name, for: .normal)
                b.isEnabled = false
            }
        }
    }

    @IBAction func addAnimalPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addAnimal", sender: sender)
        animalTag = sender.tag
    }
    
    
    @IBAction func checkNameField(_ sender: UITextField) {
        if sender.text != "" {
            if ((sender.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers not allowed in field"
                sender.textColor = UIColor.red
                saveButton.isEnabled = false
            } else {
                sender.textColor = UIColor.black
                errorLabel.text = ""
                saveButton.isEnabled = true
            }
        } else {
            errorLabel.text = "A firstname is required"
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func checkCellNumField(_ sender: UITextField) {
        if cellnum.text != "" {
            if ((cellnum.text?.rangeOfCharacter(from: bannedPhoneChars)) != nil) {
                errorLabel.text = "Letters not allowed in Cell Number field"
                saveButton.isEnabled = false
                cellnum.textColor = UIColor.red
            } else {
                errorLabel.text = ""
                saveButton.isEnabled = true
                cellnum.textColor = UIColor.black
            }
        } else {
            errorLabel.text = "A cell number is required"
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func checkEmailField(_ sender: UITextField) {
        if !isValidEmail(email: email.text!) {
            errorLabel.text = "Email is not valid"
            saveButton.isEnabled = false
            email.textColor = UIColor.red
        } else {
            errorLabel.text = ""
            saveButton.isEnabled = true
            email.textColor = UIColor.black
        }
    }
    
    @IBAction func checkAddressField(_ sender: UITextField) {
        if ((sender.text?.rangeOfCharacter(from: bannedAddressChars)) != nil) {
            errorLabel.text = "Symbols are not allowed in address field"
            sender.isEnabled = false
            sender.textColor = UIColor.red
        } else {
            errorLabel.text = ""
            saveButton.isEnabled = true
            sender.textColor = UIColor.black
        }
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
    }
    
    func makeAddress() -> String  {
        let cityAddress = streetField.text! + ", " + cityField.text! + ", "
        let stateAddress =  cityAddress + stateField.text! + " "
        return stateAddress + zipCodeField.text!
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "unwindToClientTable": break
        case "addAnimal": break
        case "unwindSaveToClientTable":
            let clientTableVC = segue.destination as! ClientTableViewController
            clientTableVC.cFirst = firstname.text!
            clientTableVC.cLast = lastname.text!
            clientTableVC.cAddress = makeAddress()
            clientTableVC.cEmail = email.text!
            clientTableVC.cCellNum = cellnum.text!
            clientTableVC.animalArray = animalArray
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
        
    }
    
}

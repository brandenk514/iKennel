//
//  NewClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/13/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController {
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cellnum: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var addAnimalButtons: [UIButton]!
    
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
        address.delegate = self as? UITextFieldDelegate
        email.delegate = self as? UITextFieldDelegate
        cellnum.delegate = self as? UITextFieldDelegate
        
        errorLabel.text = ""
        if lastname.text == "" || firstname.text == "" || cellnum.text == "" {
            saveButton.isEnabled = false
        }
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func checkfirstNameField(_ sender: UITextField) {
        if firstname.text != "" {
            if ((firstname.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers not allowed in firstname field"
                firstname.textColor = UIColor.red
                saveButton.isEnabled = false
            } else {
                firstname.textColor = UIColor.black
                errorLabel.text = ""
                saveButton.isEnabled = true
            }
        } else {
            errorLabel.text = "A firstname is required"
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func checkLastNameField(_ sender: UITextField) {
        if lastname.text != "" {
            if ((lastname.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers not allowed in lastname field"
                lastname.textColor = UIColor.red
                saveButton.isEnabled = false
            } else {
                errorLabel.text = ""
                saveButton.isEnabled = true
                lastname.textColor = UIColor.black
            }
        } else {
            errorLabel.text = "A lastname is required"
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
        if ((address.text?.rangeOfCharacter(from: bannedAddressChars)) != nil) {
            errorLabel.text = "Symbols are not allowed in address field"
            saveButton.isEnabled = false
            address.textColor = UIColor.red
        } else {
            errorLabel.text = ""
            saveButton.isEnabled = true
            address.textColor = UIColor.black
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
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
            clientTableVC.cAddress = address.text!
            clientTableVC.cEmail = email.text!
            clientTableVC.cCellNum = cellnum.text!
            clientTableVC.animalArray = animalArray
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
        
    }
    
}

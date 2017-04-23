//
//  EditAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/7/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditAnimalViewController: UIViewController, UITextFieldDelegate {

    var sel_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: nil, notes: "")

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var sexSelector: UISegmentedControl!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var dateIn = Date()
    var dateOut = Date()
    
    var dateTag = 0
    
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"
    
    let bannedChars = CharacterSet(charactersIn: "0123456789./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.text = sel_animal.name
        if nameField.text!.isEmpty { nameField.placeholder = "Name" }
        
        typeSelector.selectedSegmentIndex = sel_animal.setTypeSelectorIndex()
        breedField.text = sel_animal.breed
        
        if breedField.text!.isEmpty { breedField.placeholder = "Breed" }
        
        sexSelector.selectedSegmentIndex = sel_animal.setSexSelectorIndex()
        socialSwitch.isOn = sel_animal.social
        
        notesField.text = sel_animal.notes
        if notesField.text!.isEmpty { notesField.placeholder = "Notes" }
        
        dateInButton.setTitle(sel_animal.getDMY_time(d: sel_animal.getReservation().dateIn), for: .normal)
        dateOutButton.setTitle(sel_animal.getDMY_time(d: sel_animal.getReservation().dateOut), for: .normal)
        checkedInSwitch.isOn = sel_animal.getReservation().checkedIn        
        dateIn = (sel_animal.reservation?.dateIn)!
        dateOut = (sel_animal.reservation?.dateOut)!
        
        errorLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didNameChange(_ sender: UITextField) {
        if nameField.text != sel_animal.name {
            sel_animal.name = nameField.text!
        }
    }
    
    @IBAction func didTypeChange(_ sender: UISegmentedControl) {
        if typeSelector.titleForSegment(at: sender.selectedSegmentIndex) != sel_animal.type {
            sel_animal.type = typeSelector.titleForSegment(at: sender.selectedSegmentIndex)!
        }
    }
    
    @IBAction func didBreedChange(_ sender: UITextField) {
        if breedField.text != sel_animal.breed {
            sel_animal.breed = breedField.text!
        }
    }
    
    @IBAction func didSexChange(_ sender: UISegmentedControl) {
        if sexSelector.titleForSegment(at: sexSelector.selectedSegmentIndex) != sel_animal.sex {
            sel_animal.sex = sexSelector.titleForSegment(at: sexSelector.selectedSegmentIndex)!
        }
    }
    
    @IBAction func didSocialChange(_ sender: UISwitch) {
        if socialSwitch.isOn != sel_animal.social {
            sel_animal.social = socialSwitch.isOn
        }
    }
    
    @IBAction func didNotesChange(_ sender: UITextField) {
        if notesField.text != sel_animal.notes {
            sel_animal.notes = notesField.text!
        }
    }
    
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        dateTag = sender.tag
        performSegue(withIdentifier: "editDatePicker", sender: sender)
    }
    
    @IBAction func didCheckInChange(_ sender: UISwitch) {
        if checkedInSwitch.isOn != sel_animal.getReservation().checkedIn {
            sel_animal.reservation?.checkedIn = checkedInSwitch.isOn
        }
    }

    @IBAction func cancelEditAnimalDatePicker(segue:UIStoryboardSegue) { }
    
    @IBAction func addEditAnimalDatePicker(segue:UIStoryboardSegue) {
        if dateTag == 1 {
            sel_animal.reservation?.dateIn = dateIn
            dateInButton.setTitle(dateIn_string, for: .normal)
        } else if dateTag == 2 {
           sel_animal.reservation?.dateOut = dateOut
           dateOutButton.setTitle(dateOut_string, for: .normal)
        }
        checkDates()
    }
    
    
    @IBAction func checkNameField(_ sender: UITextField) {
        if sender.text != "" {
            if ((sender.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers or symbols not allowed in field"
                sender.textColor = UIColor.red
                saveButton.isEnabled = false
            } else {
                sender.textColor = UIColor.black
                errorLabel.text = ""
                saveButton.isEnabled = true
            }
        } else {
            errorLabel.text = "Field required"
            sender.textColor = UIColor.red
            saveButton.isEnabled = false
        }
    }
    
    func checkDates() {
        if dateIn >= dateOut {
            errorLabel.text = "The 'Date in' can not be after the 'Date out'"
            saveButton.isEnabled = false
        } else {
            errorLabel.text = ""
            saveButton.isEnabled = true
        }
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "cancelEditAnimal": break
        case "editDatePicker":
            guard let editDatePickerVC = segue.destination as? EditAnimalDatePickerViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            editDatePickerVC.dateTag = dateTag
            editDatePickerVC.editDatePickerdateIn = dateIn
            editDatePickerVC.editDatePickerdateOut = dateOut
        case "unwindToShowAnimal":
            guard let currentAnimalVC = segue.destination as? CurrentAnimalViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            currentAnimalVC.selected_animal = sel_animal
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
            
        }
    }
}

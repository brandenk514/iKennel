//
//  EditAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/7/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditAnimalViewController: UIViewController {

    var sel_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var sexSelector: UISegmentedControl!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    
    var dateIn = Date()
    var dateOut = Date()
    
    var dateTag = 0
    
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self as? UITextFieldDelegate
        breedField.delegate = self as? UITextFieldDelegate
        notesField.delegate = self as? UITextFieldDelegate

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
        sel_animal.reservation?.dateIn = dateIn
        sel_animal.reservation?.dateOut = dateOut
        
        checkedInSwitch.isOn = sel_animal.getReservation().checkedIn
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
        } else {
           sel_animal.reservation?.dateOut = dateOut
           dateOutButton.setTitle(dateOut_string, for: .normal)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "unwindToShowAnimal":
                guard let currentAnimalVC = segue.destination as? CurrentAnimalViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                currentAnimalVC.selected_animal = sel_animal
            case "cancelEditAnimal": break
            case "editDatePicker":
                guard let editDatePickerVC = segue.destination as? EditAnimalDatePickerViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                editDatePickerVC.dateTag = dateTag
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
            
        }
    }
    

}

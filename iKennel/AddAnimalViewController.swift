//
//  AddAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class AddAnimalViewController: UIViewController {
    
    @IBOutlet weak var animalName: UITextField!
    @IBOutlet weak var animalType: UISegmentedControl!
    @IBOutlet weak var animalBreed: UITextField!
    @IBOutlet weak var animalNotes: UITextView!
    @IBOutlet weak var animalSex: UISegmentedControl!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"
    
    var dateIn = Date()
    var dateOut = Date()
    
    var dateTag = 0
    let bannedChars = CharacterSet(charactersIn: "0123456789./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelDatePicker(segue:UIStoryboardSegue) { }
    
    @IBAction func addDatePicker(segue:UIStoryboardSegue) {
        dateInButton.setTitle(dateIn_string, for: .normal)
        dateOutButton.setTitle(dateOut_string, for: .normal)
    }

    @IBAction func dateButtonPressed(_ sender: UIButton) {
        dateTag = sender.tag
        performSegue(withIdentifier: "pickDate", sender: sender)
    }
    
    @IBAction func checkField(_ sender: UITextField) {
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
    
    func createAnimal() -> Animal {
        return Animal(name: animalName.text!, type: animalType.titleForSegment(at: animalType.selectedSegmentIndex)!, sex: animalSex.titleForSegment(at: animalSex.selectedSegmentIndex)!, breed: animalBreed.text!, social: socialSwitch.isOn, reservation: Reservation(dateIn: dateIn, dateOut: dateOut, checkedIn: checkedInSwitch.isOn), notes: animalNotes.text!)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "pickDate":
            guard let datePickerVC = segue.destination as? NewAnimalDatePickerViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            datePickerVC.dateTag = dateTag
        case "unwindToCurrentClient": break
        case "unwindSaveToCurrentClient":
            let currentClientVC = segue.destination as! CurrentClientViewController
            currentClientVC.add_animal = createAnimal()
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
 
}
